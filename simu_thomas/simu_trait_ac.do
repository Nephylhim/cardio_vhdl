                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    vsim -t us work.trait_ac
vsim -t us work.trait_ac 
add wave sim:/trait_ac/*

force -freeze sim:/trait_ac/clk 1 0, 0 {5 us} -r 10
force -deposit sim:/trait_ac/rst 0 0
force -deposit sim:/trait_ac/rst 1 20
force -deposit sim:/trait_ac/modop 1 0
force -deposit sim:/trait_ac/echac_acq 0 0
force -deposit sim:/trait_ac/ech_ac 000000000000 0
run 100us

run 100us
force -deposit sim:/trait_ac/echac_acq 1 0
run 100us
# force -deposit sim:/trait_ac/s_cpt 150 0

force -deposit sim:/trait_ac/ech_ac 100010011000 20
run 100us
force -deposit sim:/trait_ac/ech_ac 000010011000 5

run 40us
force -deposit sim:/trait_ac/s_cpt 600 0
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 80us
force -deposit sim:/trait_ac/s_cpt 700 0
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 100us

force -deposit sim:/trait_ac/s_cpt 500 0
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 100us

force -deposit sim:/trait_ac/s_cpt 425 0
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 100us

force -deposit sim:/trait_ac/s_cpt 300 0
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 100us

force -deposit sim:/trait_ac/s_cpt 300 0
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 100us

force -deposit sim:/trait_ac/s_cpt 300 0
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 100us

force -deposit sim:/trait_ac/s_cpt 425 0
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 100us

force -deposit sim:/trait_ac/s_cpt 995 0
run 100us
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 100us

force -deposit sim:/trait_ac/s_cpt 425 0
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 100us

force -deposit sim:/trait_ac/modop 0 0
force -deposit sim:/trait_ac/s_cpt 425 0
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 100us

force -deposit sim:/trait_ac/modop 1 0
force -deposit sim:/trait_ac/s_cpt 425 0
force -deposit sim:/trait_ac/ech_ac 100010011000 20
force -deposit sim:/trait_ac/ech_ac 000010011000 60
run 100us