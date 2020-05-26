LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY UART IS
	PORT(
		start, rx, clk, nrst: IN std_logic;
        data_in, baud   	: IN std_logic_vector(7 DOWNTO 0);
        data_ready, tx  	: OUT std_logic;
		data_out        	: OUT std_logic_vector(7 DOWNTO 0)
	);
END UART;

ARCHITECTURE behavioral OF UART IS
	type state_type is (idle, send_Zero, send_num, send_xor, wait_state, get_res);
BEGIN
	Get: PROCESS(clk)
		variable state: state_type:= idle;
		variable next_state: state_type;
		variable baud_counter, bit_counter: integer RANGE 0 TO 8 := 0;
		variable res_flag: boolean := false;
	BEGIN
		IF clk = '1' THEN 
			state := next_state;
			tx <= '1';

			CASE state IS 
				WHEN idle => 
					IF start = '1' THEN 
						next_state := send_zero;
					END IF;
				WHEN send_zero =>
					IF baud_counter < to_integer(unsigned(baud)) THEN 
						baud_counter := baud_counter + 1;
						tx <= '0';
					ELSE
						next_state := send_num;
						baud_counter := 0;
					END IF;
				WHEN send_num => 
					IF baud_counter < to_integer(unsigned(baud)) and bit_counter <= 7 THEN
						tx <= data_in(bit_counter);
						baud_counter := baud_counter + 1;
					ELSIF baud_counter = to_integer(unsigned(baud)) THEN 
						baud_counter := 0;
						bit_counter := bit_counter + 1;
					ELSE
						next_state := send_xor;
						bit_counter := 0;
						baud_counter := 0;
					END IF;
				WHEN send_xor => 
					IF baud_counter < to_integer(unsigned(baud)) THEN
						tx <= data_in(0) XOR data_in(1) XOR data_in(2) XOR data_in(3) XOR data_in(4) XOR data_in(5) XOR data_in(6) XOR data_in(7);
						baud_counter := baud_counter + 1;
					ELSE 
						baud_counter := 0;
						next_state := wait_state;
					END IF;
				WHEN wait_state => 
					IF baud_counter < to_integer(unsigned(baud)) THEN 
						baud_counter := baud_counter + 1;
					ELSE 
						baud_counter := 0;
						next_state := get_res;
					END IF;
				WHEN get_res => 
					IF baud_counter < to_integer(unsigned(baud)) THEN
						IF rx = '0' THEN 
							res_flag := true;
						END IF;
						baud_counter := baud_counter + 1;
					ELSE 
						IF res_flag = true THEN 
							next_state := send_num;
						ELSE 
							next_state := idle;
						END IF;
						res_flag := false;
					END IF;
			end case;
		END IF;
	END PROCESS Get;
END behavioral;
