onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider constants
add wave -noupdate -radix decimal /universalcountertb/data_w
add wave -noupdate -divider clock
add wave -noupdate /universalcountertb/clk_t
add wave -noupdate -divider inputs
add wave -noupdate /universalcountertb/nrst_t
add wave -noupdate /universalcountertb/din_t
add wave -noupdate /universalcountertb/op_t
add wave -noupdate -divider outputs
add wave -noupdate /universalcountertb/dout_t
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {71 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 212
configure wave -valuecolwidth 91
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
WaveRestoreZoom {0 ns} {106 ns}
