onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPU/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/syif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/pcif/address
add wave -noupdate /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate /system_tb/DUT/CPU/DP/rtype.opcode
add wave -noupdate /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -divider ALU
add wave -noupdate -expand -group ALU -color {Medium Blue} /system_tb/DUT/CPU/DP/aluif/opcode
add wave -noupdate -expand -group ALU -color {Medium Blue} /system_tb/DUT/CPU/DP/alu/aluif/a
add wave -noupdate -expand -group ALU -color {Medium Blue} /system_tb/DUT/CPU/DP/alu/aluif/b
add wave -noupdate -expand -group ALU -color {Medium Blue} /system_tb/DUT/CPU/DP/alu/aluif/out
add wave -noupdate -divider Register
add wave -noupdate -group Register /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group Register /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group Register /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group Register /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group Register /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group Register /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group Register /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -group Register /system_tb/DUT/CPU/DP/register/register
add wave -noupdate -divider {Hazard Unit}
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/pcpause
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/fdif_nop
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/fdif_pause
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/deif_nop
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/deif_pause
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/emif_nop
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/emif_pause
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/mwif_nop
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/mwif_pause
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazard/waiting_for_instruction
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazard/waiting_for_data
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazard/use_after_load_hzd
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazard/jump_or_branch
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazard/valid_lw_in_ex
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazard/lw_affects_rs_and_cares
add wave -noupdate -expand -group {Hazard Unit} /system_tb/DUT/CPU/DP/hazard/lw_affects_rt_and_cares
add wave -noupdate -divider RAM
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -divider {Memory Controller}
add wave -noupdate -group {Memory Controller} {/system_tb/DUT/CPU/CC/ccif/iwait[0]}
add wave -noupdate -group {Memory Controller} {/system_tb/DUT/CPU/CC/ccif/dwait[0]}
add wave -noupdate -group {Memory Controller} {/system_tb/DUT/CPU/CC/ccif/iREN[0]}
add wave -noupdate -group {Memory Controller} {/system_tb/DUT/CPU/CC/ccif/dREN[0]}
add wave -noupdate -group {Memory Controller} {/system_tb/DUT/CPU/CC/ccif/dWEN[0]}
add wave -noupdate -group {Memory Controller} {/system_tb/DUT/CPU/CC/ccif/iload[0]}
add wave -noupdate -group {Memory Controller} {/system_tb/DUT/CPU/CC/ccif/dload[0]}
add wave -noupdate -group {Memory Controller} {/system_tb/DUT/CPU/CC/ccif/dstore[0]}
add wave -noupdate -group {Memory Controller} {/system_tb/DUT/CPU/CC/ccif/iaddr[0]}
add wave -noupdate -group {Memory Controller} {/system_tb/DUT/CPU/CC/ccif/daddr[0]}
add wave -noupdate -group {Memory Controller} /system_tb/DUT/CPU/CC/ccif/ramWEN
add wave -noupdate -group {Memory Controller} /system_tb/DUT/CPU/CC/ccif/ramREN
add wave -noupdate -group {Memory Controller} /system_tb/DUT/CPU/CC/ccif/ramstate
add wave -noupdate -group {Memory Controller} /system_tb/DUT/CPU/CC/ccif/ramaddr
add wave -noupdate -group {Memory Controller} /system_tb/DUT/CPU/CC/ccif/ramstore
add wave -noupdate -divider {Control Unit}
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/instruction
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/regdest
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/memread
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/memwrite
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/jal
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/regwrite
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/lui
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/alusrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/bne
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/memtoreg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/branch
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/jump
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/extendtype
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/shift
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/aluop
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/fuif/forward_a
add wave -noupdate -group {Forwarding Unit} /system_tb/DUT/CPU/DP/fuif/forward_b
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {453680 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 97
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
