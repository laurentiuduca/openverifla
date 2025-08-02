# gw_sh run.tcl
set_device -name GW2AR-18C GW2AR-LV18QN88C8/I7

add_file examples/counters.v
add_file verifla/baud_of_verifla.v
add_file verifla/inc_of_verifla.v
add_file verifla/send_capture_of_verifla.v
add_file verifla/uart_of_verifla.v            
add_file verifla/common_internal_verifla.v
add_file verifla/memory_of_verifla.v
add_file verifla/single_pulse_of_verifla.v
add_file verifla/u_rec_of_verifla.v
add_file verifla/computer_input_of_verifla.v
add_file verifla/monitor_of_verifla.v
add_file verifla/top_of_verifla.v
add_file verifla/u_xmit_of_verifla.v

add_file rlsoc.cst

set_option -top_module counters
set_option -use_mspi_as_gpio 1
set_option -use_sspi_as_gpio 1
set_option -use_ready_as_gpio 1
set_option -use_done_as_gpio 1
set_option -rw_check_on_ram 1

run all

