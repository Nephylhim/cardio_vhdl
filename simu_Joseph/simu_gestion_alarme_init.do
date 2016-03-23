vsim -t us work.gestion_alarme
# vsim -t us work.gestion_alarme 
# Loading std.standard
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.gestion_alarme(beh)
force -deposit sim:/gestion_alarme/rst 0 0
force -freeze sim:/gestion_alarme/clk 1 0, 0 {5 us} -r 10
force -deposit sim:/gestion_alarme/bp_reg 1 0
force -deposit sim:/gestion_alarme/sw 11 0
add wave \
{sim:/gestion_alarme/bp_reg } 
add wave sim:/gestion_alarme/*
force -deposit sim:/gestion_alarme/bpm 0100101000 0
run 20 us
force -deposit sim:/gestion_alarme/rst 1 0
run 20 us
force -deposit sim:/gestion_alarme/bpm 0100000000 0
run 20 us
force -deposit sim:/gestion_alarme/bpm 0010000000 0
run 20 us
force -deposit sim:/gestion_alarme/bpm 0000010000 0
run 20 us
force -deposit sim:/gestion_alarme/bpm 0010000000 0
run 20 us
force -deposit sim:/gestion_alarme/sw 01 0
run
run
force -deposit sim:/gestion_alarme/bp_reg 0 0
run
run
run
force -deposit sim:/gestion_alarme/bp_reg 1 0
run
force -deposit sim:/gestion_alarme/sw 00 0
run
force -deposit sim:/gestion_alarme/sw 01 0
run
force -deposit sim:/gestion_alarme/sw 00 0
run
force -deposit sim:/gestion_alarme/bp_reg 0 0
run
run
run
force -deposit sim:/gestion_alarme/bp_reg 1 0
run
run
force -deposit sim:/gestion_alarme/s_sbd 6 0
force -deposit sim:/gestion_alarme/s_sbu 0 0
run
force -deposit sim:/gestion_alarme/bp_reg 0 0
run
run
run
force -deposit sim:/gestion_alarme/sw 01 0
run
force -deposit sim:/gestion_alarme/bp_reg 1 0
run
run
run
force -deposit sim:/gestion_alarme/s_shc 1 0
force -deposit sim:/gestion_alarme/s_shd 0 0
run
force -deposit sim:/gestion_alarme/bp_reg 0 0
run
run