LIBRARY ieee;
USE  ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY UniversalCounter IS 
    Generic (data_width: integer := 32);
    PORT(clk, nrst: IN std_logic;
         din:       IN std_logic_vector(data_width - 1 DOWNTO 0);
         op:        IN BIT_vector(2 DOWNTO 0);
         dout:      OUT std_logic_vector(data_width - 1 DOWNTO 0));
END UniversalCounter;

ARCHITECTURE UC OF UniversalCounter IS 
    SIGNAL current_state: std_logic_vector(data_width - 1 DOWNTO 0);
    SIGNAL next_state: std_logic_vector(data_width - 1 DOWNTO 0);
BEGIN 
    process(clk, nrst)
    BEGIN 
        IF nrst = '0' THEN
            next_state <= (OTHERS => '0');
        ELSIF clk = '1' THEN 
            CASE op IS 
                WHEN "000" => next_state <= current_state;
                WHEN "001" => next_state <= din;
                WHEN "010" => next_state <= std_logic_vector(unsigned(current_state) + 1);
                WHEN "011" => next_state <= std_logic_vector(unsigned(current_state) - 1);
                WHEN "100" => next_state <= std_logic_vector(unsigned(current_state) srl 1);
                WHEN "101" => next_state <= std_logic_vector(unsigned(current_state) sll 1);
                WHEN "110" => next_state <= std_logic_vector(unsigned(current_state) ror 1);
                WHEN "111" => next_state <= std_logic_vector(unsigned(current_state) rol 1);
            END CASE;
        END IF;
    END PROCESS;
    current_state <= next_state;
    dout <= next_state;
END UC;

ENTITY UniversalCounterTb IS END UniversalCounterTb;

LIBRARY ieee;
USE  ieee.std_logic_1164.all;

ARCHITECTURE tb OF UniversalCounterTb IS 
    CONSTANT data_w: integer := 32;
    COMPONENT UniversalCounter IS 
        Generic (data_width: integer := 32);
        PORT(clk, nrst: IN std_logic;
             din:       IN std_logic_vector(data_width - 1 DOWNTO 0);
             op:        IN BIT_vector(2 DOWNTO 0);
             dout:      OUT std_logic_vector(data_width - 1 DOWNTO 0));
    END COMPONENT;
    SIGNAL clk_t: std_logic := '1';
    SIGNAL nrst_t: std_logic;
    SIGNAL din_t, dout_t: std_logic_vector(data_w - 1 DOWNTO 0);
    SIGNAL op_t: bit_vector(2 DOWNTO 0);
BEGIN 
    clk_t <= NOT clk_t AFTER 5 ns;
    U1: UniversalCounter 
        GENERIC MAP(data_width => data_w) 
        PORT MAP (
            clk => clk_t, 
            nrst => nrst_t, 
            din => din_t, 
            dout => dout_t, 
            op => op_t
        );
    nrst_t <= '1' ,'0' AFTER 10 ns , '1' AFTER 15 ns;
    din_t <= X"A20100B1";
    op_t <= "000" AFTER 20 ns, "001" AFTER 30 ns,"010" AFTER 40 ns, 
            "011" AFTER 50 ns, "100" AFTER 60 ns, "101" AFTER 70 ns, 
            "110" AFTER 80 ns, "111" AFTER 90 ns;
END tb;
