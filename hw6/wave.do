onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider inputs
add wave -noupdate /mini_core_tb/clk_t
add wave -noupdate /mini_core_tb/nrst_t
add wave -noupdate /mini_core_tb/opcode_t
add wave -noupdate -divider {inner signals}
add wave -noupdate -divider registers
add wave -noupdate /mini_core_tb/u1/r1
add wave -noupdate /mini_core_tb/u1/r2
add wave -noupdate /mini_core_tb/u1/dr
add wave -noupdate /mini_core_tb/u1/ac
add wave -noupdate -divider {register ens}
add wave -noupdate /mini_core_tb/u1/r1_en
add wave -noupdate /mini_core_tb/u1/r2_en
add wave -noupdate /mini_core_tb/u1/dr_en
add wave -noupdate /mini_core_tb/u1/ac_en
add wave -noupdate -divider bus
add wave -noupdate /mini_core_tb/u1/bus_sel
add wave -noupdate /mini_core_tb/u1/bus_out
add wave -noupdate -divider alu
add wave -noupdate /mini_core_tb/u1/alu_func
add wave -noupdate /mini_core_tb/u1/alu_out
add wave -noupdate -divider counter
add wave -noupdate /mini_core_tb/u1/cc
add wave -noupdate /mini_core_tb/u1/cc_rst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 242
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
WaveRestoreZoom {0 ns} {162 ns}
