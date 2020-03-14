vcom -reportprogress 300 -work work D:/VirtualUniversity/DSD/examples/reg.vhd
vsim work.reg(test) 
do wave.do
force nrst  '0' 0ns, '1' 23 ns
force -freeze sim:/reg/clk 1 0, 0 {10 ns} -r 20
force din "0000000000000000" 0ns,  "0000000000000001" 57 ns, "0000000000000011" 67 ns
run 100ns
