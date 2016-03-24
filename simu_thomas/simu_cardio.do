vsim -t us work.cardio
# vsim -t us work.cardio 
# Loading std.standard
# Loading ieee.std_logic_1164(body)
# Loading work.cardio(struct)
# Loading work.div_freq(beh)
# Loading work.pulse2ms(beh)
# Loading work.acq_echantillons(beh)
# Loading ieee.numeric_std(body)
# Loading work.trait_dc(beh)
# Loading work.trait_ac(beh)
# Loading work.rom1bpm(syn)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading std.textio(body)
# Loading altera_mf.altera_common_conversion(body)
# Loading altera_mf.altera_device_families(body)
# Loading altera_mf.altsyncram(translated)
# Loading work.choix_aff(beh)
# Loading work.trans_7seg(beh)
# Loading work.adc(beh)
add wave \
{sim:/cardio/s_clk_100k } \
{sim:/cardio/rst } \
{sim:/cardio/bp_reg } \
{sim:/cardio/sw } \
{sim:/cardio/led_pou } \
{sim:/cardio/led_al } \
{sim:/cardio/led_bf } \
{sim:/cardio/s_bpm } \
{sim:/cardio/ch_aff/aff } \
{sim:/cardio/affu } \
{sim:/cardio/affd } \
{sim:/cardio/affc } \
{sim:/cardio/tac/s_cpt } \
{sim:/cardio/acq_ech/echac_acq } \
{sim:/cardio/acq_ech/echdc_acq } \
{sim:/cardio/acq_ech/echantillon } \
{sim:/cardio/s_ech } \
{sim:/cardio/tac/echac } 

force -freeze sim:/cardio/s_clk_100k 1 0, 0 {5 us} -r 10
force -deposit sim:/cardio/rst 0 0
force -deposit sim:/cardio/rst 1 15
force -deposit sim:/cardio/bp_reg 1 0
force -deposit sim:/cardio/sw 11 0

run 2250ms

force -deposit sim:/cardio/bp_reg 0 5
force -deposit sim:/cardio/bp_reg 1 25
force -deposit sim:/cardio/sw 10 45
force -deposit sim:/cardio/bp_reg 0 65
force -deposit sim:/cardio/sw 00 85
force -deposit sim:/cardio/bp_reg 1 105
force -deposit sim:/cardio/sw 01 125
force -deposit sim:/cardio/bp_reg 0 145

run 160us
