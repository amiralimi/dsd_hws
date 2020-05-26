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
    SIGNAL start_t, rx_t, nrst_t: std_logic;
    SIGNAL clk_t                : std_logic:= '1';
    SIGNAL data_in_t, baud_t   	: std_logic_vector(7 DOWNTO 0);
    SIGNAL data_ready_t, tx_t  	: std_logic;
    SIGNAL data_out_t        	: std_logic_vector(7 DOWNTO 0);
BEGIN 
    clk_t <= NOT clk_t AFTER 5 ns;
    uatt: UART 
        PORT MAP (
            start => start_t,
            rx => rx_t,
            clk => clk_t,
            nrst => nrst_t,
            data_in => data_in_t,
            baud => baud_t,
            data_ready => data_ready_t,
            tx => tx_t,
            data_out => data_out_t
        );
    start_t <= '0', '1' AFTER 15 ns, '0' AFTER 25 ns;
    data_in_t <= (OTHERS => '0'), "10101010" AFTER 15 ns;
    baud_t <= (OTHERS => '0'), "00000010" AFTER 15 ns;
    rx_t <= '0', '0' AFTER 365 ns, '1' AFTER 685 ns;
END tb;
