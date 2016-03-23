create_clock -name clk -period 50.000 [get_ports {clk}]
create_generated_clock -name clk100K -source [get_ports {clk}] -divide_by 200 -duty_cycle 50 [get_nets {clk100|s_clk}]