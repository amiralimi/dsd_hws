onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider inputs
add wave -noupdate /uart_tb/clk_t
add wave -noupdate /uart_tb/start_t
add wave -noupdate /uart_tb/rx_t
add wave -noupdate /uart_tb/nrst_t
add wave -noupdate /uart_tb/data_in_t
add wave -noupdate /uart_tb/baud_t
add wave -noupdate /uart_tb/data_ready_t
add wave -noupdate -divider outputs
add wave -noupdate /uart_tb/tx_t
add wave -noupdate /uart_tb/data_out_t
add wave -noupdate -divider {inner counters}
add wave -noupdate /uart_tb/uatt/Get/next_state
add wave -noupdate /uart_tb/uatt/Get/state
add wave -noupdate /uart_tb/uatt/Get/baud_counter
add wave -noupdate /uart_tb/uatt/Get/bit_counter
add wave -noupdate /uart_tb/uatt/Get/res_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {310 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 212
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {191 ns} {411 ns}
