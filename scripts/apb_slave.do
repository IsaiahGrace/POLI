onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Gold /apb_slave_tb/CLK
add wave -noupdate -color Gold /apb_slave_tb/nRST
add wave -noupdate -color Gold -radix unsigned /apb_slave_tb/PROG/test_case
add wave -noupdate -color Gold /apb_slave_tb/PROG/test_name
add wave -noupdate -color Gold /apb_slave_tb/PROG/transfer_phase
add wave -noupdate -expand -group APB -color Magenta /apb_slave_tb/apbif/PWDATA
add wave -noupdate -expand -group APB -color Magenta /apb_slave_tb/apbif/PADDR
add wave -noupdate -expand -group APB -color Magenta /apb_slave_tb/apbif/PWRITE
add wave -noupdate -expand -group APB -color Magenta /apb_slave_tb/apbif/PSEL
add wave -noupdate -expand -group APB -color Magenta /apb_slave_tb/apbif/PENABLE
add wave -noupdate -expand -group APB -color {Blue Violet} /apb_slave_tb/apbif/PREADY
add wave -noupdate -expand -group APB -color {Blue Violet} /apb_slave_tb/apbif/PRDATA
add wave -noupdate -expand -group {Control Register} -color Coral /apb_slave_tb/apbif/read_data
add wave -noupdate -expand -group {Control Register} -color {Violet Red} /apb_slave_tb/apbif/write_data
add wave -noupdate -expand -group {Control Register} -color {Violet Red} /apb_slave_tb/apbif/write_enable
add wave -noupdate -expand -group {Control Register} -color {Violet Red} /apb_slave_tb/apbif/register_select
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40 ns} 0}
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
WaveRestoreZoom {0 ns} {96 ns}
