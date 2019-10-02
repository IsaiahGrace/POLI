/*
 Isaiah Grace
 Igrace@purdue.edu
 
 This testbench is designed to demonstrate the functionality of the apb_slave module
 */

// Interface
`include "apb_slave_if.vh"

// Data types
`include "POLI_types_pkg.vh"
import POLI_types_pkg::*;

`timescale 1 ns / 1 ns

module apb_slave_tb;
   // clock period
   parameter PERIOD = 20; //TODO: find the clock period of AXT-05 and set appropriately
   
   // signals
   logic CLK = 1, nRST;
   
   // clock
   always #(PERIOD/2) CLK++;
   
   // interface
   apb_salve_if apbif ();
   
   // test program
   test PROG (CLK, nRST, huif);

   // dut
`ifndef MAPPED
   apb_slave DUT (apbif);
`else // !`ifndef MAPPED
   apb_slave DUT ( 
		   ./PWDATA (huif.PWDATA),
		   ./PADDR (huif.PADDR),
		   ./PWRITE (huif.PWRITE),
		   ./PSEL (huif.PSEL),
		   ./PENABLE (huif.PENABLE),
		   ./PREADY (huif.PREADY),
		   ./PRDATA (huif.PRDATA),
		   ./read_data (huif.read_data),
		   ./write_data (huif.write_data),
		   ./register_select (huif.register_select)
		   );
`endif // !`ifndef MAPPED
   
endmodule // apb_slave_tb

program test
  (
   input logic 	CLK,
   output logic nRST,
   apb_slave_if apbif
   );

   // test signals
   int 		test_case;
   string 	test_name;

   task reset_DUT;
      begin
	 nRST = 1'b1;
	 #(2)
	 nRST = 1'b0;
	 @(negedge CLK);
	 @(negedge CLK);
	 nRST = 1'b1;
	 @(posedge CLK);
      end
   endtask // reset_DUT

   
endprogram // test
   
   
		     
