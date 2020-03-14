onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /reg/nrst
add wave -noupdate -format Logic /reg/clk
add wave -noupdate -format Literal -radix hexadecimal /reg/din
add wave -noupdate -format Literal -radix hexadecimal /reg/dout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20 ns} 0}
configure wave -namecolwidth 150
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
update
WaveRestoreZoom {0 ns} {64 ns}
