vsim -t ns work.div_freq
# vsim -t ns work.div_freq 
# Loading std.standard
# Loading ieee.std_logic_1164(body)
# Loading work.div_freq(beh)
add wave sim:/div_freq/*
force -freeze sim:/div_freq/clk 1 0, 0 {25 ns} -r 50
force -deposit sim:/div_freq/rst 0 0
run
force -deposit sim:/div_freq/rst 1 0
run
run
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns
run 1000ns