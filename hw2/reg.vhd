LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY reg IS 
   PORT ( nrst  : IN  std_logic;
          clk   : IN  std_logic;
          en    : IN  std_logic;
          din   : IN  std_logic_vector(31 DOWNTO 0);
          dout  : OUT std_logic_vector(31 DOWNTO 0)
        );
END reg;
ARCHITECTURE test OF reg IS
BEGIN
   PROCESS(clk)
   BEGIN
      IF clk = '1' THEN
          IF nrst = '0' THEN
            dout <= (OTHERS =>'0');
          ELSIF en = '1' THEN
            dout <= din;
          END IF;
      END IF;
   END PROCESS;      
END test;