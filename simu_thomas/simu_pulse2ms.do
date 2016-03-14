vsim -t us work.pulse2ms 
add wave sim:/pulse2ms/*

force -freeze sim:/pulse2ms/clk 1 0, 0 {5 us} -r 10
force -deposit sim:/pulse2ms/rst 0 0
force -deposit sim:/pulse2ms/rst 1 20
run 100us
force -deposit sim:/pulse2ms/s_cpt 195 0
run 200us
