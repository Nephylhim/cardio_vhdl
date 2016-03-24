vsim -t us work.anti_rebond
# vsim -t us work.anti_rebond 
# Loading std.standard
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.anti_rebond(beh)
force -freeze sim:/anti_rebond/clk 1 0, 0 {5 us} -r 10
force -deposit sim:/anti_rebond/rst 0 0
force -deposit sim:/anti_rebond/bp_reg 1 0
add wave sim:/anti_rebond/*
run
run
force -deposit sim:/anti_rebond/bp_reg 0 0
run
force -deposit sim:/anti_rebond/bp_reg 1 0
run
run
force -deposit sim:/anti_rebond/rst 1 0
run
force -deposit sim:/anti_rebond/bp_reg 1 0
run
force -deposit sim:/anti_rebond/bp_reg 0 0
run
force -deposit sim:/anti_rebond/bp_reg 1 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
force -deposit sim:/anti_rebond/bp_reg 0 0
run
run
run
run
run
run
force -deposit sim:/anti_rebond/bp_reg 1 0
run
run
run
run
run
run
run
run
run
force -deposit sim:/anti_rebond/bp_reg 0 0
run
run
run
run 95 ms
run 3 ms
run 1 ms
run 1 ms
force -deposit sim:/anti_rebond/bp_reg 1 0
run 95 ms
run 5 ms