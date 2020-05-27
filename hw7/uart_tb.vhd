ENTITY UART_Tb IS END UART_Tb;

LIBRARY ieee;
USE  ieee.std_logic_1164.all;

ARCHITECTURE tb OF UART_Tb IS 
    COMPONENT UART IS 
        PORT(
            start, rx, clk, nrst: IN std_logic;
            data_in, baud   	: IN std_logic_vector(7 DOWNTO 0);
            data_ready, tx  	: OUT std_logic;
            data_out        	: OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL start_t_1, rx_t_1, nrst_t: std_logic;
    SIGNAL clk_t                : std_logic:= '1';
    SIGNAL data_in_t_1, baud_t   	: std_logic_vector(7 DOWNTO 0);
    SIGNAL data_ready_t_1, tx_t_1  	: std_logic;
    SIGNAL data_out_t_1        	: std_logic_vector(7 DOWNTO 0);
    SIGNAL start_t_2, rx_t_2: std_logic;
    SIGNAL data_in_t_2 : std_logic_vector(7 DOWNTO 0);
    SIGNAL data_ready_t_2, tx_t_2  	: std_logic;
    SIGNAL data_out_t_2        	: std_logic_vector(7 DOWNTO 0);
BEGIN 
    clk_t <= NOT clk_t AFTER 5 ns;
    uatt1: UART 
        PORT MAP (
            start => start_t_1,
            rx => rx_t_1,
            clk => clk_t,
            nrst => nrst_t,
            data_in => data_in_t_1,
            baud => baud_t,
            data_ready => data_ready_t_1,
            tx => tx_t_1,
            data_out => data_out_t_1
        );
	uatt2: UART 
        PORT MAP (
            start => start_t_2,
            rx => rx_t_2,
            clk => clk_t,
            nrst => nrst_t,
            data_in => data_in_t_2,
            baud => baud_t,
            data_ready => data_ready_t_2,
            tx => tx_t_2,
            data_out => data_out_t_2
        );
    rx_t_1 <= tx_t_2;
    rx_t_2 <= tx_t_1;

    nrst_t <= '0', '1' AFTER 15 ns;
    start_t_1 <= '0', '1' AFTER 25 ns, '0' AFTER 35 ns;
    start_t_2 <= '0';
    data_in_t_1 <= (OTHERS => '0'), "10101010" AFTER 15 ns;
    baud_t <= (OTHERS => '0'), "00000010" AFTER 15 ns;
END tb;
