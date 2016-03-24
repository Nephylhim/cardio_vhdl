vsim -t us work.choix_aff
add wave sim:/choix_aff/*

force -deposit sim:/choix_aff/bp_reg 0 0
force -deposit sim:/choix_aff/sw 00 0
force -deposit sim:/choix_aff/moy_dc 111111111111 0
force -deposit sim:/choix_aff/bpm 1010101010 0
force -deposit sim:/choix_aff/salh 1100110011 0
force -deposit sim:/choix_aff/salb 0001110001 0

force -deposit sim:/choix_aff/salb 1110001110 20
run 40us
force -deposit sim:/choix_aff/bp_reg 1 0
force -deposit sim:/choix_aff/sw 01 20
force -deposit sim:/choix_aff/salh 0010011001 40

force -deposit sim:/choix_aff/bp_reg 0 60
force -deposit sim:/choix_aff/sw 11 80
force -deposit sim:/choix_aff/moy_dc 000000000000 100

force -deposit sim:/choix_aff/bp_reg 1 120
force -deposit sim:/choix_aff/bpm 0101010101 140

run 160us
force -deposit sim:/choix_aff/sw 10 0
force -deposit sim:/choix_aff/bp_reg 0 20
run 40us


force -deposit sim:/choix_aff/moy_dc 110110110110 0
run 20 us
force -deposit sim:/choix_aff/bp_reg 1 0
force -deposit sim:/choix_aff/bp_reg 0 20
run 40us
force -deposit sim:/choix_aff/bpm 0000000000 0
force -deposit sim:/choix_aff/bp_reg 1 20
force -deposit sim:/choix_aff/bpm 1001001001 40
run 60 us
