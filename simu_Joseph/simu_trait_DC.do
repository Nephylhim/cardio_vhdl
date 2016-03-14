vsim -t us work.trait_dc
# vsim -t us work.trait_dc 
# Loading std.standard
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.trait_dc(beh)
add wave sim:/trait_dc/*
force -freeze sim:/trait_dc/clk 1 0, 0 {10 us} -r 20
force -deposit sim:/trait_dc/rst 0 0
force -deposit sim:/trait_dc/echdc_acq 0 0
force -deposit sim:/trait_dc/echdc 000000000000 0
run 20us
run 20us
force -deposit sim:/trait_dc/echdc 000000000001 0
run 20us
force -deposit sim:/trait_dc/rst 0 0
force -deposit sim:/trait_dc/rst 1 0
run 20us
force -deposit sim:/trait_dc/echdc_acq 1 0
run 20us
force -deposit sim:/trait_dc/echdc 000000000010 0
run 20us
force -deposit sim:/trait_dc/echdc_acq 0 0
run 20us
force -deposit sim:/trait_dc/echdc 000000000100 0
force -deposit sim:/trait_dc/echdc_acq 1 0
run 20us
force -freeze sim:/trait_dc/echdc 000000001000 0
run 20us
force -deposit sim:/trait_dc/echdc 000000010000 0
run 20us
force -deposit sim:/trait_dc/echdc 000000100000 0
run 20us
force -freeze sim:/trait_dc/echdc 000001000000 0
run 20us
force -deposit sim:/trait_dc/echdc 000010000000 0
run 20us
force -deposit sim:/trait_dc/echdc_acq 0 0
run
run
run
run
force -freeze sim:/trait_dc/echdc 000100000000 0
force -deposit sim:/trait_dc/echdc_acq 1 0
run
force -deposit sim:/trait_dc/echdc 001000000000 0
run
force -freeze sim:/trait_dc/echdc 010000000000 0
run
force -freeze sim:/trait_dc/echdc 100000000000 0
run
force -deposit sim:/trait_dc/echdc_acq 0 0
run
run
run
run
