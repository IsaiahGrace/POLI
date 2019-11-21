onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Gold -height 24 /POLI_top_level_tb/CLK
add wave -noupdate -color Gold -height 24 /POLI_top_level_tb/nRST
add wave -noupdate -color Gold -height 24 -radix unsigned -childformat {{{/POLI_top_level_tb/PROG/test_case[31]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[30]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[29]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[28]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[27]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[26]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[25]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[24]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[23]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[22]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[21]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[20]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[19]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[18]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[17]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[16]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[15]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[14]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[13]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[12]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[11]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[10]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[9]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[8]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[7]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[6]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[5]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[4]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[3]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[2]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[1]} -radix unsigned} {{/POLI_top_level_tb/PROG/test_case[0]} -radix unsigned}} -subitemconfig {{/POLI_top_level_tb/PROG/test_case[31]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[30]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[29]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[28]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[27]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[26]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[25]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[24]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[23]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[22]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[21]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[20]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[19]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[18]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[17]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[16]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[15]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[14]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[13]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[12]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[11]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[10]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[9]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[8]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[7]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[6]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[5]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[4]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[3]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[2]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[1]} {-color Gold -radix unsigned} {/POLI_top_level_tb/PROG/test_case[0]} {-color Gold -radix unsigned}} /POLI_top_level_tb/PROG/test_case
add wave -noupdate -color Gold -height 24 /POLI_top_level_tb/PROG/test_name
add wave -noupdate -color Gold -height 24 /POLI_top_level_tb/PROG/transfer_phase
add wave -noupdate -expand -group APB -color {Violet Red} -height 24 /POLI_top_level_tb/PWDATA
add wave -noupdate -expand -group APB -color {Violet Red} -height 24 /POLI_top_level_tb/PADDR
add wave -noupdate -expand -group APB -color {Violet Red} -height 24 /POLI_top_level_tb/PRDATA
add wave -noupdate -expand -group APB -color {Violet Red} -height 24 /POLI_top_level_tb/PWRITE
add wave -noupdate -expand -group APB -color {Violet Red} -height 24 /POLI_top_level_tb/PSEL
add wave -noupdate -expand -group APB -color {Violet Red} -height 24 /POLI_top_level_tb/PENABLE
add wave -noupdate -expand -group APB -color {Violet Red} -height 24 /POLI_top_level_tb/PREADY
add wave -noupdate -expand -group CRIF -color {Lime Green} -height 24 /POLI_top_level_tb/DUT/crif/read_data
add wave -noupdate -expand -group CRIF -color {Lime Green} -height 24 /POLI_top_level_tb/DUT/crif/write_data
add wave -noupdate -expand -group CRIF -color {Lime Green} -height 24 /POLI_top_level_tb/DUT/crif/write_enable
add wave -noupdate -expand -group CRIF -color {Lime Green} -height 24 /POLI_top_level_tb/DUT/crif/register_select
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} -height 24 /POLI_top_level_tb/DUT/crcif/crc_data_in
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} -height 24 /POLI_top_level_tb/DUT/crcif/crc_reset
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} -height 24 /POLI_top_level_tb/DUT/crcif/crc_start
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} -height 24 /POLI_top_level_tb/DUT/crcif/crc_orient
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} -height 24 /POLI_top_level_tb/DUT/crcif/crc_data_out
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} -height 24 /POLI_top_level_tb/DUT/crcif/crc_ready
add wave -noupdate -expand -group NAND_NOR -color Violet -height 24 /POLI_top_level_tb/DUT/NAND_NOR/A
add wave -noupdate -expand -group NAND_NOR -color Violet -height 24 /POLI_top_level_tb/DUT/NAND_NOR/B
add wave -noupdate -expand -group NAND_NOR -color Violet -height 24 /POLI_top_level_tb/DUT/NAND_NOR/orient
add wave -noupdate -expand -group NAND_NOR -color Violet -height 24 /POLI_top_level_tb/DUT/NAND_NOR/X
add wave -noupdate -expand -group XOR_BUF -color {Slate Blue} -height 24 /POLI_top_level_tb/DUT/XOR_BUF/A
add wave -noupdate -expand -group XOR_BUF -color {Slate Blue} -height 24 /POLI_top_level_tb/DUT/XOR_BUF/B
add wave -noupdate -expand -group XOR_BUF -color {Slate Blue} -height 24 /POLI_top_level_tb/DUT/XOR_BUF/orient
add wave -noupdate -expand -group XOR_BUF -color {Slate Blue} -height 24 /POLI_top_level_tb/DUT/XOR_BUF/X
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4535 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 175
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
WaveRestoreZoom {0 ns} {10984 ns}
