onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Gold /POLI_top_level_tb/CLK
add wave -noupdate -color Gold /POLI_top_level_tb/nRST
add wave -noupdate -color Gold -radix unsigned /POLI_top_level_tb/PROG/test_case
add wave -noupdate -color Gold /POLI_top_level_tb/PROG/test_name
add wave -noupdate -color Gold /POLI_top_level_tb/PROG/transfer_phase
add wave -noupdate -expand -group APB -color {Violet Red} /POLI_top_level_tb/PWDATA
add wave -noupdate -expand -group APB -color {Violet Red} /POLI_top_level_tb/PADDR
add wave -noupdate -expand -group APB -color {Violet Red} /POLI_top_level_tb/PRDATA
add wave -noupdate -expand -group APB -color {Violet Red} /POLI_top_level_tb/PWRITE
add wave -noupdate -expand -group APB -color {Violet Red} /POLI_top_level_tb/PSEL
add wave -noupdate -expand -group APB -color {Violet Red} /POLI_top_level_tb/PENABLE
add wave -noupdate -expand -group APB -color {Violet Red} /POLI_top_level_tb/PREADY
add wave -noupdate -expand -group CRIF -color {Lime Green} /POLI_top_level_tb/DUT/crif/read_data
add wave -noupdate -expand -group CRIF -color {Lime Green} /POLI_top_level_tb/DUT/crif/write_data
add wave -noupdate -expand -group CRIF -color {Lime Green} /POLI_top_level_tb/DUT/crif/write_enable
add wave -noupdate -expand -group CRIF -color {Lime Green} /POLI_top_level_tb/DUT/crif/register_select
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} /POLI_top_level_tb/DUT/crcif/crc_data_in
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} /POLI_top_level_tb/DUT/crcif/crc_reset
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} /POLI_top_level_tb/DUT/crcif/crc_start
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} /POLI_top_level_tb/DUT/crcif/crc_orient
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} /POLI_top_level_tb/DUT/crcif/crc_data_out
add wave -noupdate -expand -group CRCIF -color {Cadet Blue} /POLI_top_level_tb/DUT/crcif/crc_ready
add wave -noupdate -group NAND_NOR -color {Cornflower Blue} /POLI_top_level_tb/DUT/NAND_NOR/A
add wave -noupdate -group NAND_NOR -color {Cornflower Blue} /POLI_top_level_tb/DUT/NAND_NOR/B
add wave -noupdate -group NAND_NOR -color {Cornflower Blue} /POLI_top_level_tb/DUT/NAND_NOR/orient
add wave -noupdate -group NAND_NOR -color {Cornflower Blue} /POLI_top_level_tb/DUT/NAND_NOR/X
add wave -noupdate -group XOR_BUF -color {Dark Orchid} /POLI_top_level_tb/DUT/XOR_BUF/A
add wave -noupdate -group XOR_BUF -color {Dark Orchid} /POLI_top_level_tb/DUT/XOR_BUF/B
add wave -noupdate -group XOR_BUF -color {Dark Orchid} /POLI_top_level_tb/DUT/XOR_BUF/orient
add wave -noupdate -group XOR_BUF -color {Dark Orchid} /POLI_top_level_tb/DUT/XOR_BUF/X
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4580 ns} 0}
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
WaveRestoreZoom {0 ns} {5429 ns}
