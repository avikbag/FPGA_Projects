# 
# Synthesis run script generated by Vivado
# 

set_param gui.test TreeTableDev
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

create_project -in_memory -part xc7a35tcpg236-1
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/parallels/Documents/ECEC302/project_1/project_1.cache/wt [current_project]
set_property parent.project_path /home/parallels/Documents/ECEC302/project_1/project_1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
add_files -quiet /home/parallels/Documents/ECEC302/project_1/project_1.runs/fifo_generator_0_synth_1/fifo_generator_0.dcp
set_property used_in_implementation false [get_files /home/parallels/Documents/ECEC302/project_1/project_1.runs/fifo_generator_0_synth_1/fifo_generator_0.dcp]
read_vhdl -library xil_defaultlib /home/parallels/Documents/ECEC302/project_1/project_1.srcs/sources_1/new/fifo_4x16.vhd
read_xdc /home/parallels/Documents/ECEC302/project_1/project_1.srcs/constrs_1/new/const.xdc
set_property used_in_implementation false [get_files /home/parallels/Documents/ECEC302/project_1/project_1.srcs/constrs_1/new/const.xdc]

catch { write_hwdef -file fifo_4x16.hwdef }
synth_design -top fifo_4x16 -part xc7a35tcpg236-1
write_checkpoint -noxdef fifo_4x16.dcp
catch { report_utilization -file fifo_4x16_utilization_synth.rpt -pb fifo_4x16_utilization_synth.pb }
