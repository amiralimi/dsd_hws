vcom -work work -2002 -explicit -vopt -stats=none C:/Users/AmirAli/Desktop/dsd_hws/hw6/mini_core.vhd
vcom -work work -2002 -explicit -vopt -stats=none C:/Users/AmirAli/Desktop/dsd_hws/hw6/mini_core_tb.vhd
vsim -gui work.mini_core_tb(test)
do wave.do
run 190