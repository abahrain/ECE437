onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPU/DP/CLK
add wave -noupdate /system_tb/DUT/CPU/DP/nRST
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/pcpause
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/nopmode
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/addr_top_four_i
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/pcplus4_i
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/instruction_i
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/addr_top_four_o
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/pcplus4_o
add wave -noupdate -expand -group Fetch/Decode /system_tb/DUT/CPU/DP/fdif/instruction_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/halt_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/pcpause
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/nopmode
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/regwrite_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/memtoreg_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/jump_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/branch_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/bne_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/memread_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/memwrite_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/alusrc_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/aluop_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/regdest_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/jal_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/shift_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/care_about_rs_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/care_about_rt_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/instruction_top_25_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/addr_top_four_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/pcplus4_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/rdat1_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/rdat2_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/rs_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/rt_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/rd_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/swizzler_output_i
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/regwrite_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/halt_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/memtoreg_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/jump_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/branch_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/bne_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/memread_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/memwrite_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/alusrc_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/aluop_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/regdest_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/jal_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/shift_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/care_about_rs_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/care_about_rt_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/instruction_top_25_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/addr_top_four_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/pcplus4_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/rdat1_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/rdat2_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/swizzler_output_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/rs_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/rt_o
add wave -noupdate -expand -group Decode/Execute /system_tb/DUT/CPU/DP/deif/rd_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/pcpause
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/halt_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/regwrite_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/memtoreg_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/memwrite_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/jump_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/branch_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/bne_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/memread_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/jumpaddr_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/branchaddr_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/rdat1_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/zero_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/aluoutput_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/rdat2_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/rd_i
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/regwrite_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/halt_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/memtoreg_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/jump_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/branch_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/bne_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/memread_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/memwrite_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/jumpaddr_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/branchaddr_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/rdat1_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/zero_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/aluoutput_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/rdat2_o
add wave -noupdate -expand -group Execute/Mem /system_tb/DUT/CPU/DP/emif/rd_o
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/pcpause
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/halt_i
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/regwrite_i
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/memtoreg_i
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/dmemload_i
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/aluoutput_i
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/rd_i
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/regwrite_o
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/halt_o
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/memtoreg_o
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/dmemload_o
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/aluoutput_o
add wave -noupdate -expand -group Mem/Writeback /system_tb/DUT/CPU/DP/mwif/rd_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {412436 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2701456 ps}
