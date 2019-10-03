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
   apb_slave_if apbif ();
   
   // test program
   test PROG (CLK, nRST, apbif);

   // dut
`ifndef MAPPED
   apb_slave DUT (CLK, nRST, apbif);
`else // !`ifndef MAPPED
   apb_slave DUT ( .\CLK (CLK),
		   .\nRST (nRST),
		   .\PWDATA (apbif.PWDATA),
		   .\PADDR (apbif.PADDR),
		   .\PWRITE (apbif.PWRITE),
		   .\PSEL (apbif.PSEL),
		   .\PENABLE (apbif.PENABLE),
		   .\PREADY (apbif.PREADY),
		   .\PRDATA (apbif.PRDATA),
		   .\read_data (apbif.read_data),
		   .\write_data (apbif.write_data),
		   .\register_select (apbif.register_select)
		   );
`endif // !`ifndef MAPPED
   
endmodule // apb_slave_tb

function regsel_t calculate_rs (input [WORD_SIZE-1:0] PADDR);
   regsel_t register_select;
   
   casez (PADDR)
     NAND_NOR_CONTROL_ADDR: register_select = NAND_NOR_CONTROL;
     NAND_NOR_INPUT_ADDR:   register_select = NAND_NOR_INPUT;
     NAND_NOR_OUTPUT_ADDR:  register_select = NAND_NOR_OUTPUT;
     
     XOR_BUF_CONTROL_ADDR:  register_select = XOR_BUF_CONTROL;
     XOR_BUF_INPUT_ADDR:    register_select = XOR_BUF_INPUT;
     XOR_BUF_OUTPUT_ADDR:   register_select = XOR_BUF_OUTPUT;
     
     CRC_CONTROL_ADDR:      register_select = CRC_CONTROL;
     CRC_STATUS_ADDR:       register_select = CRC_STATUS;
     CRC_INPUT_ADDR:        register_select = CRC_INPUT;
     CRC_OUTPUT_ADDR:       register_select = CRC_OUTPUT;
     
     default:               register_select = BAD_ADDR;
   endcase // casez (PADDR)
   
   return register_select;
endfunction // calculate_rs

program test
  (
   input logic 	CLK,
   output logic nRST,
   apb_slave_if apbif
   );

   // test signals
   int 		test_case;
   string 	test_name;
   string 	transfer_phase;

   task reset_DUT;
      begin
	 nRST = 1'b1;
	 #(2)
	 nRST = 1'b0;
	 apbif.PWDATA    = '0;
	 apbif.PADDR     = '0;
	 apbif.PWRITE    = '0;
	 apbif.PSEL      = '0;
	 apbif.PENABLE   = '0;
	 apbif.read_data = '0;
	 transfer_phase  = "NO SEL";
	 @(negedge CLK);
	 @(negedge CLK);
	 nRST = 1'b1;
	 @(posedge CLK);
      end
   endtask // reset_DUT

   task apb_write_transfer;
      input [WORD_SIZE-1:0] PWDATA;
      input [WORD_SIZE-1:0] PADDR;
      input 		    PSEL;
      
      begin
	 // Expected signals from apb_slave
	 logic [WORD_SIZE-1:0] exp_write_data;
	 logic 		       exp_write_enable;
	 logic 		       exp_PREADY;
	 regsel_t              exp_register_select;

	 @(posedge CLK);
	 #(0.5)
	 // Setup phase of transfer
	 apbif.PADDR = PADDR;
	 apbif.PWRITE = 1'b1;
	 apbif.PSEL = PSEL;
	 apbif.PENABLE = 1'b0;
	 apbif.PWDATA = PWDATA;
	 transfer_phase = PSEL ? "Setup" : "NO SEL";
	 	 
	 @(negedge CLK);
	 // Calculate setup expected outputs
	 exp_write_enable = 1'b0;
	 exp_PREADY = 1'b0;

	 // Check apb_slave outputs during Setup
	 assert (apbif.PREADY == exp_PREADY)
	   else $error("PREADY != %d during: %s", exp_PREADY, test_name);
	 assert (apbif.write_enable == exp_write_enable)
	   else $error("write_enable != %d during: $s", exp_write_enable, test_name);

	 @(posedge CLK);
	 #(0.5)
	 // Access phase of transfer
	 apbif.PADDR = PADDR;
	 apbif.PWRITE = 1'b1;
	 apbif.PSEL = PSEL;
	 apbif.PENABLE = 1'b1;
	 apbif.PWDATA = PWDATA;
	 transfer_phase = PSEL ? "Access" : "NO SEL";
	 
	 @(negedge CLK);
	 // Calculate access expected outputs
	 exp_write_data = PWDATA;
	 exp_write_enable = PSEL; // We will only write if PSEL is high
	 exp_PREADY = 1'b1;
	 exp_register_select = calculate_rs(PADDR);
	 
	 // Check apb_slave outputs during Access
	 assert (apbif.write_data == exp_write_data)
	   else $error("write_data != %d during: %s", exp_write_data, test_name);
	 assert (apbif.write_enable == exp_write_enable)
	   else $error("write_enable != %d during: %s", exp_write_enable, test_name);
	 assert (apbif.PREADY == exp_PREADY)
	   else $error("PREADY != %d during: %s", exp_PREADY, test_name);
	 assert (apbif.register_select == exp_register_select)
	   else $error("register_select != %d during: $s", int'(exp_register_select), test_name);
      end      
   endtask // apb_write_transfer

   
   task apb_read_transfer;
      input [WORD_SIZE-1:0] read_data;
      input [WORD_SIZE-1:0] PADDR;
      input 		    PSEL;
      begin
	 // Expected signals from apb_slave
	 logic 		       exp_PREADY;
	 logic [WORD_SIZE-1:0] exp_PRDATA;
	 logic [WORD_SIZE-1:0] exp_read_data;
	 logic 		       exp_write_enable;
	 regsel_t              exp_register_select;

	 @(posedge CLK);
	 #(0.5)
	 // Setup phase of transfer
	 apbif.PADDR = PADDR;
	 apbif.PWRITE = 1'b0;
	 apbif.PSEL = PSEL;
	 apbif.PENABLE = 1'b0;
	 transfer_phase = PSEL ? "Setup" : "NO SEL";
	 	 
	 @(negedge CLK);
	 // Calculate setup expected outputs
	 exp_write_enable = 1'b0;
	 exp_PREADY = 1'b0;

	 // Check apb_slave outputs during Setup
	 assert (apbif.PREADY == exp_PREADY)
	   else $error("PREADY != %d during: %s", exp_PREADY, test_name);
	 assert (apbif.write_enable == exp_write_enable)
	   else $error("write_enable != %d during: $s", exp_write_enable, test_name);

	 @(posedge CLK);
	 #(0.5)
	 // Access phase of transfer
	 apbif.PADDR = PADDR;
	 apbif.PWRITE = 1'b0;
	 apbif.PSEL = PSEL;
	 apbif.PENABLE = 1'b1;
	 apbif.read_data = read_data;
	 transfer_phase = PSEL ? "Access" : "NO SEL";
	 
	 @(negedge CLK);
	 // Calculate access expected outputs
	 exp_write_enable = 1'b0; // write_enable should never be high, we are reading
	 exp_PREADY = 1'b1;
	 exp_register_select = calculate_rs(PADDR);
	 
	 // Check apb_slave outputs during Access
	 assert (apbif.PREADY == exp_PREADY)
	   else $error("PREADY != %d during: %s", exp_PREADY, test_name);
	 assert (apbif.PRDATA == read_data)

	 assert (apbif.write_data == exp_write_data)
	   else $error("write_data != %d during: %s", exp_write_data, test_name);
	 assert (apbif.write_enable == exp_write_enable)
	   else $error("write_enable != %d during: %s", exp_write_enable, test_name);
	 assert (apbif.register_select == exp_register_select)
	   else $error("register_select != %d during: $s", int'(exp_register_select), test_name);
      end
   endtask // apb_read_transfer

   
   initial 
     begin
	// Test case: RESET
	test_case = 0;
	test_name = "RESET";
	reset_DUT();
	
	// Test case: write to NAND_NOR regs
	test_case++;
	test_name = "write to NAND_NOR regs";
	apb_write_transfer (
			    .\PWDATA (32'h1),
			    .\PADDR (NAND_NOR_CONTROL_ADDR),
			    .\PSEL (1'b1)
			    );
	apb_write_transfer (
			    .\PWDATA (32'h2),
			    .\PADDR (NAND_NOR_INPUT_ADDR),
			    .\PSEL (1'b1)
			    );
	// NOTE: This is an error, the control register will NOT update the NAND_NOR_OUTPUT value
	// However we don't use PSLVERR signal, we just don't do anything...
	apb_write_transfer (
			    .\PWDATA (32'h3),
			    .\PADDR (NAND_NOR_OUTPUT_ADDR),
			    .\PSEL (1'b1)
			    );

	// Test case: write to XOR_BUF regs
	test_case++;
	test_name = "write to XOR_BUF regs";
	apb_write_transfer (
			    .\PWDATA (32'haa55aa55),
			    .\PADDR (XOR_BUF_CONTROL_ADDR),
			    .\PSEL (1'b1)
			    );
	apb_write_transfer (
			    .\PWDATA (32'h55aa55aa),
			    .\PADDR (XOR_BUF_INPUT_ADDR),
			    .\PSEL (1'b1)
			    );
	// NOTE: This is an error, the control register will NOT update the XOR_BUF_OUTPUT value
	// However we don't use PSLVERR signal, we just don't do anything...
	apb_write_transfer (
			    .\PWDATA (32'hbadbeef),
			    .\PADDR (XOR_BUF_OUTPUT_ADDR),
			    .\PSEL (1'b1)
			    );

	// Test case: write to CRC regs
	test_case++;
	test_name = "write to CRC regs";
	apb_write_transfer (
			    .\PWDATA (32'h1),
			    .\PADDR (CRC_CONTROL_ADDR),
			    .\PSEL (1'b1)
			    );
	apb_write_transfer (
			    .\PWDATA (32'h2),
			    .\PADDR (CRC_STATUS_ADDR),
			    .\PSEL (1'b1)
			    );
	apb_write_transfer (
			    .\PWDATA (32'h3),
			    .\PADDR (CRC_INPUT_ADDR),
			    .\PSEL (1'b1)
			    );
	// NOTE: This is an error, the control register will NOT update the CRC_OUTPUT value
	// However we don't use PSLVERR signal, we just don't do anything...
	apb_write_transfer (
			    .\PWDATA (32'h5),
			    .\PADDR (CRC_OUTPUT_ADDR),
			    .\PSEL (1'b1)
			    );
	
	
	// Just wait a few cycles before ending the simulation...
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);
	
     end // initial begin
      
endprogram // test
   
   
		     
