onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {UART 1}
add wave -noupdate -divider inputs
add wave -noupdate /uart_tb/uatt1/start
add wave -noupdate /uart_tb/uatt1/rx
add wave -noupdate /uart_tb/uatt1/clk
add wave -noupdate /uart_tb/uatt1/nrst
add wave -noupdate /uart_tb/uatt1/data_in
add wave -noupdate /uart_tb/uatt1/baud
add wave -noupdate -divider outputs
add wave -noupdate /uart_tb/uatt1/data_ready
add wave -noupdate /uart_tb/uatt1/tx
add wave -noupdate /uart_tb/uatt1/data_out
add wave -noupdate -divider {inner counters}
add wave -noupdate -divider get
add wave -noupdate /uart_tb/uatt1/line__20/state
add wave -noupdate /uart_tb/uatt1/line__20/next_state
add wave -noupdate /uart_tb/uatt1/line__20/baud_counter
add wave -noupdate /uart_tb/uatt1/line__20/bit_counter
add wave -noupdate /uart_tb/uatt1/line__20/parity
add wave -noupdate -divider send
add wave -noupdate /uart_tb/uatt1/line__20/state_s
add wave -noupdate /uart_tb/uatt1/line__20/next_state_s
add wave -noupdate /uart_tb/uatt1/line__20/baud_counter_s
add wave -noupdate /uart_tb/uatt1/line__20/bit_counter_s
add wave -noupdate /uart_tb/uatt1/line__20/res_flag
add wave -noupdate -divider {UART 2}
add wave -noupdate -divider inputs
add wave -noupdate /uart_tb/uatt2/clk
add wave -noupdate /uart_tb/uatt2/start
add wave -noupdate /uart_tb/uatt2/rx
add wave -noupdate /uart_tb/uatt2/nrst
add wave -noupdate /uart_tb/uatt2/data_in
add wave -noupdate /uart_tb/uatt2/baud
add wave -noupdate -divider outputs
add wave -noupdate /uart_tb/uatt2/tx
add wave -noupdate /uart_tb/uatt2/data_ready
add wave -noupdate /uart_tb/uatt2/data_out
add wave -noupdate -divider {inner counters}
add wave -noupdate -divider GET
add wave -noupdate /uart_tb/uatt2/line__20/state
add wave -noupdate /uart_tb/uatt2/line__20/next_state
add wave -noupdate /uart_tb/uatt2/line__20/baud_counter
add wave -noupdate /uart_tb/uatt2/line__20/bit_counter
add wave -noupdate /uart_tb/uatt2/line__20/parity
add wave -noupdate -divider SEND
add wave -noupdate /uart_tb/uatt2/line__20/state_s
add wave -noupdate /uart_tb/uatt2/line__20/next_state_s
add wave -noupdate /uart_tb/uatt2/line__20/baud_counter_s
add wave -noupdate /uart_tb/uatt2/line__20/bit_counter_s
add wave -noupdate /uart_tb/uatt2/line__20/res_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {70 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 292
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
WaveRestoreZoom {0 ns} {206 ns}
