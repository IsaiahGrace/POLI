onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Gold /fpga_top_tb/CLK
add wave -noupdate -color Gold /fpga_top_tb/nRST
add wave -noupdate -color Gold -radix unsigned /fpga_top_tb/PROG/test_case
add wave -noupdate -color Gold /fpga_top_tb/PROG/test_name
add wave -noupdate -color Magenta -radix binary /fpga_top_tb/SW
add wave -noupdate -color Magenta -radix binary /fpga_top_tb/LED
add wave -noupdate -color Orchid -radix unsigned /fpga_top_tb/DUT/count
add wave -noupdate -color Orchid /fpga_top_tb/DUT/state
add wave -noupdate -expand -group APB -color {Cadet Blue} /fpga_top_tb/DUT/POLI/PSEL
add wave -noupdate -expand -group APB -color {Cadet Blue} /fpga_top_tb/DUT/POLI/PWRITE
add wave -noupdate -expand -group APB -color {Cadet Blue} /fpga_top_tb/DUT/POLI/PWDATA
add wave -noupdate -expand -group APB -color {Cadet Blue} /fpga_top_tb/DUT/POLI/PADDR
add wave -noupdate -expand -group APB -color {Cadet Blue} /fpga_top_tb/DUT/POLI/PRDATA
add wave -noupdate -expand -group APB -color {Cadet Blue} /fpga_top_tb/DUT/POLI/PENABLE
add wave -noupdate -expand -group APB -color {Cadet Blue} /fpga_top_tb/DUT/POLI/PREADY
add wave -noupdate -expand -group {NAND NOR} -color Coral /fpga_top_tb/DUT/POLI/NAND_NOR/A
add wave -noupdate -expand -group {NAND NOR} -color Coral /fpga_top_tb/DUT/POLI/NAND_NOR/B
add wave -noupdate -expand -group {NAND NOR} -color Coral /fpga_top_tb/DUT/POLI/NAND_NOR/orient
add wave -noupdate -expand -group {NAND NOR} -color Coral /fpga_top_tb/DUT/POLI/NAND_NOR/X
add wave -noupdate -expand -group XOR_BUF -color Goldenrod /fpga_top_tb/DUT/POLI/XOR_BUF/A
add wave -noupdate -expand -group XOR_BUF -color Goldenrod /fpga_top_tb/DUT/POLI/XOR_BUF/B
add wave -noupdate -expand -group XOR_BUF -color Goldenrod /fpga_top_tb/DUT/POLI/XOR_BUF/orient
add wave -noupdate -expand -group XOR_BUF -color Goldenrod /fpga_top_tb/DUT/POLI/XOR_BUF/X
add wave -noupdate -expand -group CRCIF -color {Medium Violet Red} /fpga_top_tb/DUT/POLI/crcif/crc_data_in
add wave -noupdate -expand -group CRCIF -color {Medium Violet Red} /fpga_top_tb/DUT/POLI/crcif/crc_reset
add wave -noupdate -expand -group CRCIF -color {Medium Violet Red} /fpga_top_tb/DUT/POLI/crcif/crc_start
add wave -noupdate -expand -group CRCIF -color {Medium Violet Red} /fpga_top_tb/DUT/POLI/crcif/crc_orient
add wave -noupdate -expand -group CRCIF -color {Medium Violet Red} /fpga_top_tb/DUT/POLI/crcif/crc_data_out
add wave -noupdate -expand -group CRCIF -color {Medium Violet Red} /fpga_top_tb/DUT/POLI/crcif/crc_ready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {94 ns} 0}
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
WaveRestoreZoom {131490 ns} {131746 ns}
