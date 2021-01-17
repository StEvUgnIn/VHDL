set_property PACKAGE_PIN K19 [get_ports clk];                  set_property IOSTANDARD LVCMOS33 [get_ports clk];  set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {clk}]
set_property PACKAGE_PIN T18 [get_ports reset_n];              set_property IOSTANDARD LVCMOS33 [get_ports reset_n]

set_property PACKAGE_PIN V20   [get_ports left];  set_property IOSTANDARD LVCMOS33 [get_ports left]
set_property PACKAGE_PIN W20   [get_ports haz];   set_property IOSTANDARD LVCMOS33 [get_ports haz]
set_property PACKAGE_PIN U20   [get_ports right]; set_property IOSTANDARD LVCMOS33 [get_ports right]

set_property PACKAGE_PIN A18   [get_ports l[1]];  set_property IOSTANDARD LVCMOS33 [get_ports l[1]]
set_property PACKAGE_PIN B20   [get_ports l[2]];  set_property IOSTANDARD LVCMOS33 [get_ports l[2]]
set_property PACKAGE_PIN A20   [get_ports l[3]];  set_property IOSTANDARD LVCMOS33 [get_ports l[3]]

set_property PACKAGE_PIN B16   [get_ports r[1]];  set_property IOSTANDARD LVCMOS33 [get_ports r[1]]
set_property PACKAGE_PIN B18   [get_ports r[2]];  set_property IOSTANDARD LVCMOS33 [get_ports r[2]]
set_property PACKAGE_PIN A19   [get_ports r[3]];  set_property IOSTANDARD LVCMOS33 [get_ports r[3]]
