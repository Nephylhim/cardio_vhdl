vsim -t ns work.pwm_led_capteur
# vsim -t ns work.pwm_led_capteur 
# Loading std.standard
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.pwm_led_capteur(beh)
add wave sim:/pwm_led_capteur/*
# Can't move the Now cursor.
force -deposit sim:/pwm_led_capteur/modop 1 0
force -deposit sim:/pwm_led_capteur/reg_auto 0 0
force -deposit sim:/pwm_led_capteur/rst 0 0
force -freeze sim:/pwm_led_capteur/clk 1 0, 0 {25 ns} -r 50
run 50
force -deposit sim:/pwm_led_capteur/dc_moy 101000000000 0
run
force -deposit sim:/pwm_led_capteur/rst 1 0
run
run
run 50 ns
run 50 ns
run 1000ns
run 1000ns
run 1000ns

run 1000ns
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
run
run
run
run
run
run
run
run
run
force -deposit sim:/pwm_led_capteur/dc_moy 111100000000 0
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
run
run
run
force -deposit sim:/pwm_led_capteur/dc_moy 000000000000 0
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
run
run