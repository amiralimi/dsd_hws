vcom -work work -2008 -explicit -vopt -stats=none C:/Users/AmirAli/Desktop/dsd_hws/hw5/ALU.vhd
vsim -gui -novopt work.bit_slice_alu_tb
do wave.do
run 160
