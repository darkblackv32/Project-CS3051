## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Switches
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports a[0]]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports a[1]]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports a[2]]
set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports a[3]]
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports a[4]]
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports a[5]]
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports a[6]]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports a[7]]

set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33 } [get_ports b[0]]
set_property -dict { PACKAGE_PIN T3    IOSTANDARD LVCMOS33 } [get_ports b[1]]
set_property -dict { PACKAGE_PIN T2    IOSTANDARD LVCMOS33 } [get_ports b[2]]
set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports b[3]]
set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports b[4]]
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33 } [get_ports b[5]]
set_property -dict { PACKAGE_PIN T1    IOSTANDARD LVCMOS33 } [get_ports b[6]]
set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports b[7]]

## LEDs
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports ALUFlags[0]]
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports ALUFlags[1]]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports ALUFlags[2]]
set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports ALUFlags[3]]

## Buttons operaciones
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports ALUControl[0]] 
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports ALUControl[1]]
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports ALUControl[2]]

## Resultado final
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports Result[0]]
set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports Result[1]]
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports Result[2]]
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports Result[3]]
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports Result[4]]
set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports Result[5]]
set_property -dict { PACKAGE_PIN W3    IOSTANDARD LVCMOS33 } [get_ports Result[6]]
set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports Result[7]]