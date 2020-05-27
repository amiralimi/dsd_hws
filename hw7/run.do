vcom -work work -2008 -explicit -vopt -stats=none C:/Users/AmirAli/Desktop/dsd_hws/hw7/uart.vhd
vcom -work work -2008 -explicit -vopt -stats=none C:/Users/AmirAli/Desktop/dsd_hws/hw7/uart_tb.vhd
vsim -gui work.uart_tb -novopt
do wave.do 
run 430