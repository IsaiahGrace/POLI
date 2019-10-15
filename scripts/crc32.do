onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Gold /crc32_tb/CLK
add wave -noupdate -color Gold /crc32_tb/nRST
add wave -noupdate -color Gold /crc32_tb/PROG/test_case
add wave -noupdate -color Gold /crc32_tb/PROG/test_name
add wave -noupdate -expand -group crcif -color {Dark Orchid} /crc32_tb/crcif/crc_data_in
add wave -noupdate -expand -group crcif -color {Dark Orchid} /crc32_tb/crcif/crc_data_out
add wave -noupdate -expand -group crcif -color {Dark Orchid} /crc32_tb/crcif/crc_orient
add wave -noupdate -expand -group crcif -color {Dark Orchid} /crc32_tb/crcif/crc_start
add wave -noupdate -expand -group crcif -color {Dark Orchid} /crc32_tb/crcif/crc_reset
add wave -noupdate -expand -group crcif -color {Dark Orchid} /crc32_tb/crcif/crc_ready
add wave -noupdate -color Coral -radix unsigned /crc32_tb/PROG/timeout
add wave -noupdate -expand -group {crc32 internal} -radix unsigned /crc32_tb/DUT/count
add wave -noupdate -expand -group {crc32 internal} -radix unsigned /crc32_tb/DUT/n_count
add wave -noupdate -expand -group {crc32 internal} /crc32_tb/DUT/n_crc_data_out
add wave -noupdate -expand -group {crc32 internal} /crc32_tb/DUT/curr_data
add wave -noupdate -expand -group {crc32 internal} /crc32_tb/DUT/n_curr_data
add wave -noupdate -expand -group {crc32 internal} /crc32_tb/DUT/crc_enable
add wave -noupdate -expand -group {crc32 internal} /crc32_tb/DUT/curr_orient
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {170 ns} 0}
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
WaveRestoreZoom {762 ns} {1718 ns}
