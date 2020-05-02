onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider inputs
add wave -noupdate -radix binary /bit_slice_alu_tb/a_t
add wave -noupdate -radix binary /bit_slice_alu_tb/b_t
add wave -noupdate -radix unsigned /bit_slice_alu_tb/func_t
add wave -noupdate /bit_slice_alu_tb/cin_t
add wave -noupdate /bit_slice_alu_tb/sin_t
add wave -noupdate -divider outputs
add wave -noupdate -radix binary /bit_slice_alu_tb/z_t
add wave -noupdate /bit_slice_alu_tb/ov_t
add wave -noupdate /bit_slice_alu_tb/sout_t
add wave -noupdate /bit_slice_alu_tb/cout_t
add wave -noupdate -divider {main alu inner signals}
add wave -noupdate -divider outputs
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/z_out
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/z_bool
add wave -noupdate -divider {inupts of inner alus}
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/slice_sin
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/slice_cin
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/eq_in
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/lt_in
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/gt_in
add wave -noupdate -divider {outputs of inner alus}
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/slice_sout
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/slice_cout
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/eq_out
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/lt_out
add wave -noupdate -radix binary /bit_slice_alu_tb/T1/gt_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {88 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 244
configure wave -valuecolwidth 59
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
WaveRestoreZoom {41 ns} {167 ns}
