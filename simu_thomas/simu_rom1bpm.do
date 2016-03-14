vsim -t us work.rom1bpm 
# Loading std.standard
# Loading ieee.std_logic_1164(body)
# Loading work.rom1bpm(syn)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading std.textio(body)
# Loading altera_mf.altera_common_conversion(body)
# Loading altera_mf.altera_device_families(body)
# Loading altera_mf.altsyncram(translated)
add wave sim:/rom1bpm/*

force -freeze sim:/rom1bpm/clock 1 0, 0 {5 us} -r 10
force -deposit sim:/rom1bpm/address 0110101001 0
run 100us
force -deposit sim:/rom1bpm/address 1000000000 0
run 100us
force -deposit sim:/rom1bpm/address 1111101000 0
run 100us
force -deposit sim:/rom1bpm/address 0010000000 0
run 100us