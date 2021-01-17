set_property PACKAGE_PIN K19   [get_ports clk];       set_property IOSTANDARD LVCMOS33 [get_ports clk];  set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {clk}]

set_property PACKAGE_PIN T18   [get_ports reset_n];   set_property IOSTANDARD LVCMOS33 [get_ports reset_n]
set_property PACKAGE_PIN U21   [get_ports capteur];   set_property IOSTANDARD LVCMOS33 [get_ports capteur]
set_property PACKAGE_PIN V20   [get_ports timer];     set_property IOSTANDARD LVCMOS33 [get_ports timer]

set_property PACKAGE_PIN A18   [get_ports feuxP1[1]]; set_property IOSTANDARD LVCMOS33 [get_ports feuxP1[1]]
set_property PACKAGE_PIN B20   [get_ports feuxP2[1]]; set_property IOSTANDARD LVCMOS33 [get_ports feuxP2[1]]

set_property PACKAGE_PIN B21   [get_ports feuxS[1]];  set_property IOSTANDARD LVCMOS33 [get_ports feuxS[1]]
set_property PACKAGE_PIN B16   [get_ports feuxP1[0]]; set_property IOSTANDARD LVCMOS33 [get_ports feuxP1[0]]
set_property PACKAGE_PIN B18   [get_ports feuxP2[0]]; set_property IOSTANDARD LVCMOS33 [get_ports feuxP2[0]]

set_property PACKAGE_PIN A21   [get_ports feuxS[0]];  set_property IOSTANDARD LVCMOS33 [get_ports feuxS[0]]
