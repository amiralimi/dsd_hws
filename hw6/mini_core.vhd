LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY mini_core IS
	PORT(
		clk 	: IN std_logic;
		nrst 	: IN std_logic;
		opcode 	: IN std_logic_vector(2 DOWNTO 0)
	);
END mini_core;
ARCHITECTURE behavioral OF mini_core IS
	-- REG signals
	SIGNAL r1, r2, dr, ac				: std_logic_vector(15 DOWNTO 0);
	SIGNAL r1_en, r2_en, dr_en, ac_en	: std_logic;
	-- BUS signals
	SIGNAL bus_sel 			: std_logic_vector(1 DOWNTO 0);
	SIGNAL bus_out 			: std_logic_vector(15 DOWNTO 0);
	-- ALU signals
	SIGNAL alu_func			: std_logic_vector(1 DOWNTO 0);
	SIGNAL alu_out			: std_logic_vector(15 DOWNTO 0);
	-- Cycle Counter signals
	SIGNAL cc		: integer;
	SIGNAL cc_rst	: std_logic;

BEGIN
	-------------------------------
	-- DATA PATH
	-------------------------------

	-- Registers
	registers: PROCESS(clk)
	BEGIN
		IF clk = '1' THEN
			IF nrst = '0' THEN
				r1 <= X"000a";
				r2 <= (OTHERS => '0');
				dr <= (OTHERS => '0');
				ac <= (OTHERS => '0');
			ELSE
				IF r1_en = '1' THEN
					r1 <= bus_out;
				END IF;
				IF r2_en = '1' THEN
					r2 <= bus_out;
				END IF;
				IF dr_en = '1' THEN
					dr <= bus_out;
				END IF;
				IF ac_en = '1' THEN
					ac <= alu_out;
				END IF;
			END IF;
		END IF;
	END PROCESS registers;

	-- Bus
	-- 00: Bus owner = R1
	-- 01: Bus owner = R2
	-- 10: Bus owner = AC
	bussing: PROCESS(r1, r2, ac, bus_sel)
	BEGIN
		IF bus_sel = "00" THEN 
			bus_out <= r1;
		ELSIF bus_sel = "01" THEN	
			bus_out <= r2;
		ELSE	
			bus_out <= ac;
		END IF;
	END PROCESS bussing;

	-- ALU
	alu: PROCESS(dr, ac, alu_func)
	BEGIN
		IF alu_func = "00" THEN
			alu_out <= dr;
		ELSIF alu_func = "01" THEN
			alu_out <= ac;
		ELSIF alu_func = "10" THEN
			alu_out <= dr + ac;
		ELSE
			alu_out <= dr - ac;
		END IF;
	END PROCESS alu;

	-------------------------------
	-- CONTROL PATH
	-------------------------------
	-- Sequential
	cp_seq: PROCESS(clk)
	BEGIN
		IF clk = '1' THEN
			IF cc_rst = '1' OR nrst = '0' THEN
				cc <= 0;			
			ELSE
				cc <= cc + 1;
			END IF;
		END IF;
	END PROCESS cp_seq;
	
	-- Combinational
	cp_com: PROCESS(cc, opcode)
	BEGIN
		r1_en <= '0'; r2_en <= '0'; dr_en <= '0'; ac_en <= '0'; cc_rst <= '0';
		IF cc = 0 THEN   -- Cycle 0
			-- r1 <= r2
			IF opcode = "000" THEN 
				bus_sel <= "01";
				r1_en <= '1';
				cc_rst <= '1';
			-- r2 <= r1
			ELSIF opcode = "001" THEN 
				bus_sel <= "00";
				r2_en <= '1';
				cc_rst <= '1';
			-- dr <= r1
			ELSIF opcode = "010" THEN 
				bus_sel <= "00";
				dr_en <= '1';
				cc_rst <= '1';
			-- ac <= r1
			ELSIF opcode = "011" THEN 
				bus_sel <= "00";
				dr_en <= '1';			
			-- ac <= r1 + r2 and r1 <= r1 + r2 (first two steps are similar)
			ELSIF opcode = "100" OR opcode = "101" THEN 
				-- first put r1 on dr 
				bus_sel <= "00";
				dr_en <= '1';
			-- dr <= ac + dr
			ELSIF opcode = "110" THEN
				alu_func <= "10";
				ac_en <= '1';
			-- r1 <= r1 - r2
			ELSIF opcode = "111" THEN
				bus_sel <= "01";
				dr_en <= '1';
			ELSE
				-- if the opcode is invalid reset the counter
				cc_rst <= '1';
			END IF;
		ELSIF cc = 1 THEN -- Cycle 1
			IF opcode = "011" THEN
				alu_func <= "00";
				ac_en <= '1';
				cc_rst <= '1';
			ELSIF opcode = "100" OR opcode = "101" THEN
				-- then put r2 on bus and put the value of r1 on ac
				bus_sel <= "01";
				dr_en <= '1';
				alu_func <= "00";
				ac_en <= '1';
			ELSIF opcode = "110" THEN
				-- put the result of dr + ac that is on ac on dr
				bus_sel <= "10";
				dr_en <= '1';
				cc_rst <= '1';
			ELSIF opcode = "111" THEN
				-- put r2 on ac and r1 on dr
				alu_func <= "00";
				ac_en <= '1';
				bus_sel <= "00";
				dr_en <= '1';
			ELSE
				-- if the opcode is invalid reset the counter
				cc_rst <= '1';
			END IF;
		ELSIF cc = 2 THEN
			IF opcode = "100" THEN
				-- add the value of r1 that is on ac to value of r2 that is on dr and put it on ac
				alu_func <= "10";
				ac_en <= '1';
				cc_rst <= '1';
			ELSIF opcode = "101" THEN 
				-- add the value of r1 that is on ac to value of r2 that is on dr and put it on ac
				alu_func <= "10";
				ac_en <= '1';
			ELSIF opcode = "111" THEN
				-- subtract r1 that is on dr and r2 that is on ac and put the result on ac
				alu_func <= "11";
				ac_en <= '1';
			ELSE
				-- if the opcode is invalid reset the counter
				cc_rst <= '1';
			END IF;
		ELSIF cc = 3 THEN
			IF opcode = "101" THEN
				-- put the addition result that is on ac on r1
				bus_sel <= "10";
				r1_en <= '1';
				cc_rst <= '1';
			ELSIF opcode = "111" THEN
				-- put the subtraction that is on ac on r1
				bus_sel <= "10";
				r1_en <= '1';
				cc_rst <= '1';
			ELSE
				-- if the opcode is invalid reset the counter
				cc_rst <= '1';
			END IF;
		ELSE
			-- if the opcode is invalid reset the counter
			cc_rst <= '1';
		END IF;
	END PROCESS cp_com;
END behavioral;