vsim -t us work.acq_echantillons
# vsim -t us work.acq_echantillons 
# Loading std.standard
# Loading ieee.std_logic_1164(body)
# Loading work.acq_echantillons(beh)
add wave sim:/acq_echantillons/*
force -freeze sim:/acq_echantillons/clk 1 0, 0 {10 us} -r 20
force -deposit sim:/acq_echantillons/rst 0 0
force -deposit sim:/acq_echantillons/modop 1 0
force -deposit sim:/acq_echantillons/ena2ms 0 0
force -deposit sim:/acq_echantillons/dout_adc 0 0
run
run
force -deposit sim:/acq_echantillons/rst 1 0
run
force -deposit sim:/acq_echantillons/ena2ms 1 0
run
run
run
force -deposit sim:/acq_echantillons/ena2ms 0 0
force -deposit sim:/acq_echantillons/modop 0 0
run
run
run
force -deposit sim:/acq_echantillons/modop 1 0
run
force -deposit sim:/acq_echantillons/ena2ms 1 0
run
run
run
run
run
run
run
run
force -deposit sim:/acq_echantillons/ena2ms 0 0
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
force -deposit sim:/acq_echantillons/dout_adc 1 0
run
run
