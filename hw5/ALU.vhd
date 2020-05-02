-----------------------------
-----------1-BIT ALU---------
-----------------------------
LIBRARY ieee;
USE  ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY OneBitALU IS 
    PORT(
        a, b, cin, sin:			IN std_logic;
		func:					IN std_logic_vector(3 DOWNTO 0);
		lt_in, gt_in, eq_in:	IN std_logic;
		sout, cout, ov:     	OUT std_logic;
		lt_out, gt_out, eq_out: OUT std_logic;
        z:                  	OUT std_logic
    );
END OneBitALU; 

ARCHITECTURE Behavioral OF OneBitALU IS 
BEGIN 
    process(a, b, cin, sin, func, lt_in, gt_in, eq_in)
    BEGIN 
        CASE func IS 
            WHEN "0000" => -- -b
                z <= NOT b;
            WHEN "0001" => -- a + b
                z <= a XOR b XOR cin;
                cout <= (a AND b) OR (a AND cin) OR (b AND cin);
            WHEN "0010" => -- a + b + cin
                z <= a XOR b XOR cin;
                cout <= (a AND b) OR (a AND cin) OR (b AND cin);
            WHEN "0011" => -- a - b
                z <= a XOR b;
                cout <= (NOT(a)) AND b;
            WHEN "0100" => -- -b 2's comp
                z <= (NOT b) XOR cin;
                cout <= (NOT b) AND cin;
            WHEN "0101" => -- ~b
                z <= NOT b;
            WHEN "0110" => -- a & b
                z <= a AND b;
            WHEN "0111" => -- a | b
                z <= a OR b;
            WHEN "1000" => -- a ^ b
                z <= a XOR b;
            WHEN "1001" => -- a << 1
                z <= cin;
                cout <= a;
            WHEN "1010" => -- a >> 1 
                z <= sin;
                sout <= a;
            WHEN "1011" => -- a << 1 circ
                z <= cin;
                cout <= a;
            WHEN "1100" => -- a >> 1 circt
                z <= sin;
                sout <= a;
            WHEN "1101" | "1110" | "1111" => -- a > b, a < b, a = b
				IF eq_in = '1' THEN
					IF a = '1' AND b = '0' THEN
						gt_out <= '1';
						eq_out <= '0';
						lt_out <= '0';
					ELSIF a = b THEN
						gt_out <= '0';
						eq_out <= '1';
						lt_out <= '0';
					ELSE 
						gt_out <= '0';
						eq_out <= '0';
						lt_out <= '1';
					END IF;
				ELSE
					gt_out <= gt_in;
					eq_out <= eq_in;
					lt_out <= lt_in;
				END IF;
            WHEN OTHERS => NULL;
        END CASE;
    END PROCESS;
END Behavioral;

-----------------------------
------------MAIN ALU---------
-----------------------------
LIBRARY  ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY bit_slice_alu IS
	GENERIC(n: integer := 32);
	PORT(
		a, b: 			IN std_logic_vector(n - 1 DOWNTO 0);
		cin, sin: 		IN std_logic;
		func:			IN std_logic_vector(3 DOWNTO 0);
		sout, cout, ov: OUT std_logic;
		z:				OUT std_logic_vector(n - 1 DOWNTO 0)	
	);
END bit_slice_alu;

ARCHITECTURE sequential of bit_slice_alu IS
	COMPONENT OneBitALU IS
		PORT(   
			a, b, cin, sin:			IN std_logic;
			func:					IN std_logic_vector(3 DOWNTO 0);
			lt_in, gt_in, eq_in:	IN std_logic;
			sout, cout, ov:     	OUT std_logic;
			lt_out, gt_out, eq_out: OUT std_logic;
			z:                  	OUT std_logic
		);
	END COMPONENT;

	SIGNAL slice_sin : std_logic_vector(n - 1 DOWNTO 0);
	SIGNAL slice_sout : std_logic_vector(n - 1 DOWNTO 0);
	SIGNAL slice_cin : std_logic_vector(n - 1 DOWNTO 0);
	SIGNAL slice_cout : std_logic_vector(n - 1 DOWNTO 0);
	SIGNAL z_out : std_logic_vector(n - 1 DOWNTO 0);
	SIGNAL z_bool : std_logic_vector(n - 1 DOWNTO 0);
	SIGNAL eq_in: std_logic_vector(n - 1 DOWNTO 0);
	SIGNAL eq_out: std_logic_vector(n - 1 DOWNTO 0);
	SIGNAL lt_in: std_logic_vector(n - 1 DOWNTO 0);
	SIGNAL lt_out: std_logic_vector(n - 1 DOWNTO 0);
	SIGNAL gt_in: std_logic_vector(n - 1 DOWNTO 0);
	SIGNAL gt_out: std_logic_vector(n - 1 DOWNTO 0);
BEGIN
	-- cout and sout and overflow output.
	cout <= slice_cout(n - 1);
	sout <= slice_sout(n - 1);
	ov <= slice_cout(n - 1) XOR slice_cin(n - 1);
	
	-- connect ports between inner alus
	loop1: FOR i IN 1 TO n - 1 GENERATE
		slice_cin(i) <= slice_cout(i-1);
	END GENERATE loop1;

	loop2: FOR i IN n - 1 DOWNTO 1 GENERATE
		slice_sin(i-1) <= slice_sout(i);
		eq_in(i-1) <= eq_out(i);
		lt_in(i-1) <= lt_out(i);
		gt_in(i-1) <= gt_out(i);
	END GENERATE loop2;

	-- input values for start of each function.
	PROCESS(a , b , func , sin , cin)
	BEGIN
		CASE func IS
			WHEN "0001" => slice_cin(0) <='0';
			WHEN "0010" => slice_cin(0) <= sin;
			WHEN "0011" => slice_cin(0) <= '0';
			WHEN "0100" => slice_cin(0) <= '1';
			WHEN "1001" => slice_cin(0) <= '0';
			WHEN "1010" => slice_sin(n - 1) <= '0';
			WHEN "1011" => slice_cin(0) <= slice_cout(n - 1);
			WHEN "1100" => slice_sin(n - 1) <= slice_sout(0);
			WHEN "1101" | "1110" | "1111" => 
				eq_in(n - 1) <= '1';
				lt_in(n - 1) <= '0';
				gt_in(n - 1) <= '0';
			WHEN OTHERS=> NULL;
		END CASE;
	END PROCESS;

	-- calculate output for compare functions. 
	-- func is in sens list because the inputs might not change but the output needs to change 
	-- because the function changes.
	PROCESS (eq_out(0), gt_out(0), lt_out(0), func)
	BEGIN
		CASE func is 
			WHEN "1101" => 
				IF gt_out(0) = '1' THEN
					z_bool <= std_logic_vector(to_unsigned(1, z_bool'length));
				ELSE 
					z_bool <= std_logic_vector(to_unsigned(0, z_bool'length));
				END IF;
			WHEN "1110" =>
				IF lt_out(0) = '1' THEN
					z_bool <= std_logic_vector(to_unsigned(1, z_bool'length));
				ELSE 
					z_bool <= std_logic_vector(to_unsigned(0, z_bool'length));
				END IF;
			WHEN "1111" =>
				IF eq_out(0) = '1' THEN
					z_bool <= std_logic_vector(to_unsigned(1, z_bool'length));
				ELSE 
					z_bool <= std_logic_vector(to_unsigned(0, z_bool'length));
				END IF;
			WHEN OTHERS => NULL;
		END CASE;
	END PROCESS;

	-- set output values.
	PROCESS (z_bool, z_out)
	BEGIN 
		CASE func IS 
			WHEN "1101" | "1110" | "1111" => z <= z_bool;
			WHEN OTHERS => z <= z_out;
		END CASE;
	END PROCESS;

	-- make the inner alus.
	f1: FOR i in 0 to n - 1 GENERATE
		U1: OneBitALU
			PORT MAP ( 
				a => a(i), 
				b => b(i), 
				sin => slice_sin(i), 
				cin => slice_cin(i), 
				func => func, 
				sout => slice_sout(i), 
				cout => slice_cout(i), 
				z => z_out(i), 
				ov => open,
				lt_in => lt_in(i), 
				lt_out => lt_out(i), 
				eq_in => eq_in(i), 
				eq_out => eq_out(i), 
				gt_in => gt_in(i), 
				gt_out => gt_out(i)
			);
	END GENERATE f1;
END sequential ;

----------------------------------
-------------testbench------------
----------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bit_slice_alu_tb IS END bit_slice_alu_tb;

ARCHITECTURE tb OF bit_slice_alu_tb IS
	CONSTANT data_width : integer := 4;

	COMPONENT bit_slice_alu IS 
		GENERIC( n : integer := 5);
		PORT(  
			a, b: 			IN std_logic_vector(n - 1 DOWNTO 0);
			cin, sin : 		IN std_logic;
			func:			IN std_logic_vector(3 DOWNTO 0);
			sout, cout, ov:	OUT std_logic;
			z: 				OUT std_logic_vector(n - 1 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL a_t, b_t, z_t: std_logic_vector(data_width-1 DOWNTO 0);
	SIGNAL func_t: std_logic_vector(3 DOWNTO 0);
	SIGNAL sin_t, cin_t, cout_t, sout_t, ov_t: std_logic;
BEGIN
	T1: bit_slice_alu
		GENERIC MAP(n => data_width)
		PORT MAP(  
			a => a_t, 
			b => b_t, 
			cin => cin_t, 
			sin => sin_t, 
			func => func_t, 
			z => z_t, 
			ov => ov_t, 
			sout => sout_t, 
			cout => cout_t
		);
		a_t<="1000";
		b_t<="1111";
		func_t <= "0000", "0001" after 10ns, "0010" AFTER 20ns, "0011" AFTER 30ns,
				"0100" AFTER 40ns, "0101" AFTER 50ns, "0110" AFTER 60ns, "0111" AFTER 70ns, 
				"1000" AFTER 80ns, "1001" AFTER 90ns, "1010" AFTER 100ns, "1011" AFTER 110ns, 
				"1100" AFTER 120ns, "1101" AFTER 130ns, "1110" AFTER 140ns, "1111" AFTER 150ns;
		sin_t <= '1';
END tb;
