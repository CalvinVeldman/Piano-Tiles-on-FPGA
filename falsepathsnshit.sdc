## Generated SDC file "lab6.sdc"

## Copyright (C) 2018  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

## DATE    "Tue Mar 08 16:26:26 2022"

##
## DEVICE  "10M50DAF484C7G"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {MAX10_CLK1_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {MAX10_CLK1_50}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {m_lab61_soc|altpll_0|sd1|pll7|clk[0]} -source [get_pins {m_lab61_soc|altpll_0|sd1|pll7|inclk[0]}] -duty_cycle 50/1 -multiply_by 1 -master_clock {MAX10_CLK1_50} [get_pins {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] 
create_generated_clock -name {m_lab61_soc|altpll_0|sd1|pll7|clk[1]} -source [get_pins {m_lab61_soc|altpll_0|sd1|pll7|inclk[0]}] -duty_cycle 50/1 -multiply_by 1 -master_clock {MAX10_CLK1_50} [get_pins {m_lab61_soc|altpll_0|sd1|pll7|clk[1]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {MAX10_CLK1_50}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {MAX10_CLK1_50}] -hold 0.070  
set_clock_uncertainty -rise_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {MAX10_CLK1_50}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {MAX10_CLK1_50}] -hold 0.070  
set_clock_uncertainty -fall_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {MAX10_CLK1_50}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {MAX10_CLK1_50}] -hold 0.070  
set_clock_uncertainty -fall_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {MAX10_CLK1_50}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {MAX10_CLK1_50}] -hold 0.070  
set_clock_uncertainty -rise_from [get_clocks {MAX10_CLK1_50}] -rise_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {MAX10_CLK1_50}] -rise_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -rise_from [get_clocks {MAX10_CLK1_50}] -fall_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -setup 0.070  
set_clock_uncertainty -rise_from [get_clocks {MAX10_CLK1_50}] -fall_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -rise_from [get_clocks {MAX10_CLK1_50}] -rise_to [get_clocks {MAX10_CLK1_50}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {MAX10_CLK1_50}] -fall_to [get_clocks {MAX10_CLK1_50}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {MAX10_CLK1_50}] -rise_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {MAX10_CLK1_50}] -rise_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -fall_from [get_clocks {MAX10_CLK1_50}] -fall_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -setup 0.070  
set_clock_uncertainty -fall_from [get_clocks {MAX10_CLK1_50}] -fall_to [get_clocks {m_lab61_soc|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -fall_from [get_clocks {MAX10_CLK1_50}] -rise_to [get_clocks {MAX10_CLK1_50}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {MAX10_CLK1_50}] -fall_to [get_clocks {MAX10_CLK1_50}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_ports SW*] -to *
set_false_path -from [get_ports DRAM_DQ*] -to *
set_false_path -from [get_ports KEY*] -to *
set_false_path -from [get_ports altera_reserved_tdi] -to *
set_false_path -from [get_ports altera_reserved_tms] -to *

set_false_path -from * -to [get_ports DRAM_ADDR*]
set_false_path -from * -to [get_ports DRAM_BA*]
set_false_path -from * -to [get_ports DRAM_CAS_N]
set_false_path -from * -to [get_ports DRAM_CLK]
set_false_path -from * -to [get_ports DRAM_CS_N]
set_false_path -from * -to [get_ports DRAM_DQ*]
set_false_path -from * -to [get_ports DRAM_UDQM]
set_false_path -from * -to [get_ports DRAM_LDQM]
set_false_path -from * -to [get_ports DRAM_RAS_N]
set_false_path -from * -to [get_ports DRAM_WE_N]
set_false_path -from * -to [get_ports LEDR*]
set_false_path -from * -to [get_ports altera_reserved_tdo]

#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************

set_max_delay -from [get_registers {*altera_avalon_st_clock_crosser:*|in_data_buffer*}] -to [get_registers {*altera_avalon_st_clock_crosser:*|out_data_buffer*}] 100.000
set_max_delay -from [get_registers *] -to [get_registers {*altera_avalon_st_clock_crosser:*|altera_std_synchronizer_nocut:*|din_s1}] 100.000


#**************************************************************
# Set Minimum Delay
#**************************************************************

set_min_delay -from [get_registers {*altera_avalon_st_clock_crosser:*|in_data_buffer*}] -to [get_registers {*altera_avalon_st_clock_crosser:*|out_data_buffer*}] -100.000
set_min_delay -from [get_registers *] -to [get_registers {*altera_avalon_st_clock_crosser:*|altera_std_synchronizer_nocut:*|din_s1}] -100.000


#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Net Delay
#**************************************************************

set_net_delay -max 2.000 -from [get_registers {*altera_avalon_st_clock_crosser:*|in_data_buffer*}] -to [get_registers {*altera_avalon_st_clock_crosser:*|out_data_buffer*}]
set_net_delay -max 2.000 -from [get_registers *] -to [get_registers {*altera_avalon_st_clock_crosser:*|altera_std_synchronizer_nocut:*|din_s1}]
