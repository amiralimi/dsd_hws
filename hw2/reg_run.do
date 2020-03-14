vcom -reportprogress 300 -work work C:/Users/AmirAli/Desktop/dsd_hws/hw2/reg.vhd
vsim work.reg(test) 
do wave.do
force nrst  '0' 0ns, '1' 23 ns, '0' 110ns
force en '0' 0ns, '1' 20 ns, '0' 95ns
force -freeze sim:/reg/clk 1 0, 0 {10 ns} -r 20
force din "00000000000000000000000000000000" 0ns, "00000000000000000000000000000001" 57 ns, "00000000000000000000000000000011" 67 ns, "00000000000000000000000000000111" 95ns
run 140ns
