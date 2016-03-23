vsim -t us work.cmd_ledpouls
# vsim -t us work.cmd_ledpouls 
# Loading std.standard
# Loading ieee.std_logic_1164(body)
# Loading work.cmd_ledpouls(beh)
add wave sim:/cmd_ledpouls/*
# Can't move the Now cursor.
# Can't move the Now cursor.
force -freeze sim:/cmd_ledpouls/clk 1 0, 0 {5 us} -r 10
force -deposit sim:/cmd_ledpouls/rst 0 0
force -deposit sim:/cmd_ledpouls/top_alum 0 0
run
run
run
force -deposit sim:/cmd_ledpouls/rst 1 0
run
run
run
run
run
run
force -deposit sim:/cmd_ledpouls/top_alum 1 0
run 20us
force -deposit sim:/cmd_ledpouls/top_alum 0 0
run
run
run
run
run
run 100ms
run
run
force -deposit sim:/cmd_ledpouls/top_alum 1 0
run
run
force -deposit sim:/cmd_ledpouls/top_alum 0 0
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