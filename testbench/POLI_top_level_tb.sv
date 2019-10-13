/*
 Isaiah Grace
 igrace@purdue.edu
 
 This testbench demonstrates functionality of the POLI APB peripheral
 */

// Data types
`include "POLI_types_pkg.vh"

`timescale 1 ns / 1 ns

module POLI_top_level_tb;
   // clock period
   parameter PERIOD = 20;

   // signals
   logic CLK = 1, nRST;

   // clock
   always #(PERIOD/2) CLK++;

   // APB interface wires
   logic [WORD_SIZE-1:0] PWDATA, PADDR, PRDATA;
   logic 		 PWRITE, PSEL, PENABLE, PREADY;

   // Test program
   test PROG (.CLK (CLK),
	      .nRST (nRST),
	      .PWDATA (PWDATA),
	      .PADDR (PADDR),
	      .PRDATA (PRDATA),
	      .PWRITE (PWRITE),
	      .PSEL (PSEL),
	      .PENABLE (PENABLE),
	      .PREADY (PREADY)
	      );
      
   // DUT
   POLI_top_level DUT (.CLK (CLK),
		       .nRST (nRST),
		       .PWDATA (PWDATA),
		       .PADDR (PADDR),
		       .PRDATA (PRDATA),
		       .PWRITE (PWRITE),
		       .PSEL (PSEL),
		       .PENABLE (PENABLE),
		       .PREADY (PREADY)
		       );

endmodule // POLI_top_level_tb

program test
  (
   input logic CLK,
   output logic nRST,
   input logic [WORD_SIZE-1:0] PRDATA,
   input logic PREADY,
   output logic [WORD_SIZE-1:0] PWDATA, PADDR,
   output logic PWRITE, PSEL, PENABLE
   );

   // Test signals
   int 		test_case;
   string 	test_name;

   task reset_DUT;
      begin
	 nRST = 1'b1;
	 #(2)
	 nRST = 1'b0;
	 PWDATA    = '0;
	 PADDR     = '0;
	 PWRITE    = '0;
	 PSEL      = '0;
	 PENABLE   = '0;
	 @(negedge CLK);
	 @(negedge CLK);
	 nRST = 1'b1;
	 @(posedge CLK);
      end
   endtask // reset_DUT

   // APB write data task

   // APB read data task
   
   
   
  
