#boutons pressoirs
set_property PACKAGE_PIN W19   [get_ports in1];    set_property IOSTANDARD LVCMOS33 [get_ports in1]
set_property PACKAGE_PIN T17   [get_ports in2];    set_property IOSTANDARD LVCMOS33 [get_ports in2]
set_property PACKAGE_PIN T18   [get_ports in3];    set_property IOSTANDARD LVCMOS33 [get_ports in3]
set_property PACKAGE_PIN U18   [get_ports sel];    set_property IOSTANDARD LVCMOS33 [get_ports sel]

#LED 1 rouge
set_property PACKAGE_PIN U16   [get_ports selout]; set_property IOSTANDARD LVCMOS33 [get_ports selout]


#LED 1 verte
set_property PACKAGE_PIN L1    [get_ports out1];   set_property IOSTANDARD LVCMOS33 [get_ports out1]
