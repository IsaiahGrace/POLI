/*
 Isaiah Grace
 igrace@purdue.edu
 
 This testbench demonstrates functionality of the POLI APB peripheral
 */

// Data types
`include "POLI_types_pkg.vh"

// Import types
import POLI_types_pkg::*;

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
   string 	transfer_phase;
   

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
   task apb_write;
      input [WORD_SIZE-1:0] write_data;
      input [WORD_SIZE-1:0] address;
      input 		    select;   
      begin
	 // Expected signals
	 logic exp_PREADY;

	 @(posedge CLK);
	 #(0.5)
	 // Setup phase of transfer
	 PADDR = address;
	 PWRITE = 1'b1;
	 PSEL = select;
	 PENABLE = 1'b0;
	 PWDATA = write_data;
	 transfer_phase = select ? "Setup" : "NO SEL";
	 	 
	 @(negedge CLK);
	 // Calculate setup expected outputs
	 exp_PREADY = 1'b0;

	 // Check apb_slave outputs during Setup
	 assert (PREADY == exp_PREADY)
	   else $error("PREADY != %d during: %s", exp_PREADY, test_name);

	 @(posedge CLK);
	 #(0.5)
	 // Access phase of transfer
	 PADDR = address;
	 PWRITE = 1'b1;
	 PSEL = select;
	 PENABLE = 1'b1;
	 PWDATA = write_data;
	 transfer_phase = select ? "Access" : "NO SEL";
	 
	 @(negedge CLK);
	 // Calculate access expected outputs
	 exp_PREADY = select;
	 
	 // Check apb_slave outputs during Access
	 assert (PREADY == exp_PREADY)
	   else $error("PREADY != %d during: %s", exp_PREADY, test_name);
      end      
   endtask // apb_write

   
   // APB read and check data task
   task apb_read;
      input [WORD_SIZE-1:0] exp_data;
      input [WORD_SIZE-1:0] address;
      input 		    select;
      begin
	 // Expected signals from apb_slave
	 logic 		       exp_PREADY;
	 logic [WORD_SIZE-1:0] exp_PRDATA;

	 @(posedge CLK);
	 #(0.5)
	 // Setup phase of transfer
	 PADDR = address;
	 PWRITE = 1'b0;
	 PSEL = select;
	 PENABLE = 1'b0;
	 transfer_phase = select ? "Setup" : "NO SEL";
	 	 
	 @(negedge CLK);
	 // Calculate setup expected outputs
	 exp_PREADY = 1'b0;

	 // Check apb_slave outputs during Setup
	 assert (PREADY == exp_PREADY)
	   else $error("PREADY != %d during: %s", exp_PREADY, test_name);

	 @(posedge CLK);
	 #(0.5)
	 // Access phase of transfer
	 PADDR = address;
	 PWRITE = 1'b0;
	 PSEL = select;
	 PENABLE = 1'b1;
	 transfer_phase = select ? "Access" : "NO SEL";

	 @(negedge CLK);
	 // Calculate access expected outputs
	 exp_PREADY = select;
	 
	 // Check apb_slave outputs during Access
	 assert (PREADY == exp_PREADY)
	   else $error("PREADY != %d during: %s", exp_PREADY, test_name);
	 assert (PRDATA == exp_data)
	   else $error("PRDATA != %h during: %s", exp_data, test_name);
      end
   endtask // apb_read
   

   logic [3:0] 		       NAND_NOR_table [7:0];
   logic [3:0] 		       XOR_BUF_table [7:0];
   
   //                            OBAX
   assign NAND_NOR_table[0] = 4'b0001;
   assign NAND_NOR_table[1] = 4'b0010;
   assign NAND_NOR_table[2] = 4'b0100;
   assign NAND_NOR_table[3] = 4'b0110;
   assign NAND_NOR_table[4] = 4'b1001;
   assign NAND_NOR_table[5] = 4'b1011;
   assign NAND_NOR_table[6] = 4'b1101;
   assign NAND_NOR_table[7] = 4'b1110;
   
   //                           OBAX
   assign XOR_BUF_table[0] = 4'b0000;
   assign XOR_BUF_table[1] = 4'b0011;
   assign XOR_BUF_table[2] = 4'b0100;
   assign XOR_BUF_table[3] = 4'b0111;
   assign XOR_BUF_table[4] = 4'b1000;
   assign XOR_BUF_table[5] = 4'b1011;
   assign XOR_BUF_table[6] = 4'b1101;
   assign XOR_BUF_table[7] = 4'b1110;

   // Main Test sequence
   initial
     begin
	// RESET DUT
	reset_DUT();

	// Demonstrate NAND_NOR Truth Table
	test_case++;
	test_name = "NAND_NOR Truth Table";
		
	for (int i = 0; i < 8; i++)
	  begin
	     apb_write(.write_data(NAND_NOR_table[i][3]),
		       .address(NAND_NOR_CONTROL_ADDR),
		       .select(1'b1));
	     apb_write(.write_data(NAND_NOR_table[i][2:1]),
		       .address(NAND_NOR_INPUT_ADDR),
		       .select(1'b1));
	     apb_read(.exp_data(NAND_NOR_table[i][0]),
		      .address(NAND_NOR_OUTPUT_ADDR),
		      .select(1'b1));
	  end // for (int i = 0; i < 8; i++)

	
	// Demonstrate XOR_BUF Truth Table
	test_case++;
	test_name = "XOR_BUF Truth Table";
	
	for (int i = 0; i < 8; i++)
	  begin
	     apb_write(.write_data(XOR_BUF_table[i][3]),
		       .address(XOR_BUF_CONTROL_ADDR),
		       .select(1'b1));
	     apb_write(.write_data(XOR_BUF_table[i][2:1]),
		       .address(XOR_BUF_INPUT_ADDR),
		       .select(1'b1));
	     apb_read(.exp_data(XOR_BUF_table[i][0]),
		      .address(XOR_BUF_OUTPUT_ADDR),
		      .select(1'b1));
	  end // for (int i = 0; i < 8; i++)

	 
     end // initial begin
      
endprogram // test
