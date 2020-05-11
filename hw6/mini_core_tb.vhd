LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY mini_core_tb IS END mini_core_tb;
ARCHITECTURE test OF mini_core_tb IS
	COMPONENT mini_core IS	
		PORT(
			clk 	: IN std_logic;
			nrst 	: IN std_logic;
			opcode 	: IN std_logic_vector(2 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL clk_t 	: std_logic := '1';
	SIGNAL nrst_t 	: std_logic;
	SIGNAL opcode_t 		: std_logic_vector(2 DOWNTO 0);
BEGIN
	u1 : mini_core PORT MAP (clk_t, nrst_t, opcode_t);
	clk_t <= NOT clk_t AFTER 5 ns;
	nrst_t <= '0', '1' AFTER 12 ns;
	opcode_t <= "000", "001" AFTER 15 ns, "010" AFTER 25 ns, "011" AFTER 35 ns, 
				"100" AFTER 55 ns, "101" AFTER 85 ns, "110" AFTER 125 ns, "111" AFTER 145 ns;
END test;
