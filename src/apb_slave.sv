/*
 Isaiah Grace
 Igrace@purdue.edu
 
  This module is the APB slave that arbitrates bus operations and translates them to the register control module
 
 */

// Inlcude data types and interfaces
include "POLI_types_pkg.vh"
include "apb_slave_if.vh"

module apb_slave (
		  input CLK,
		  input nRST,
		  apb_slave_if apbif
		  );
   // Import types
   import POLI_types_pkg::*;

   // Local signals and registers
   logic [WORD_SIZE-1:0] data_buff;
   logic [WORD_SIZE-1:0] nxt_data_buff;
   
   // PRDATA can always be the data in the output buffer, It doesn't matter if it's garbage when PSEL is LOW
   assign apbif.PRDATA = apbif.data_buff;

   // write_data can be wired to PWDATA all the time, we will only assert the control signals when appropriate
   assign apbif.write_data = apbif.PWDATA;
   
   always_comb
     begin
	// Default outputs
	apbif.PREADY = 1'b0;
	apbif.write_enable = 1'b0;

	// Register select logic
	// Maps the APB bus addresses to the regsel_t type to pass on to control register
	casez (PADDR)
	  NAND_NOR_CONTROL_ADDR: apbif.register_select = NAND_NOR_CONTROL;
	  NAND_NOT_INPUT_ADDR:   apbif.register_select = NAND_NOR_INPUT;
	  NAND_NOT_OUTPUT_ADDR:  apbif.register_select = NAND_NOR_OUTPUT;
	  
	  XOR_BUF_CONTROL_ADDR:  apbif.register_select = XOR_BUF_CONTROL;
	  XOR_BUF_INPUT_ADDR:    apbif.register_select = XOR_BUF_INPUT;
	  XOR_BUF_OUTPUT_ADDR:   apbif.register_select = XOR_BUF_OUTPUT;

	  CRC_CONTROL_ADDR:      apbif.register_select = CRC_CONTROL;
	  CRC_STATUS_ADDR:       apbif.register_select = CRC_STATUS;
	  CRC_INPUT_ADDR:        apbif.register_select = CRC_INPUT;
	  CRC_OUTPUT_ADDR:       apbif.register_select = CRC_OUTPUT;
	  default:               apbif.register_select = regsel_t'('0);
	endcase // casez (PADDR)
     end // always_comb

   
   always_ff @(posedge CLK, negedge nRST)
     begin
	if (nRST == 1'b0)
	  begin
	     data_buff <= 0;
	  end
	else
	  begin
	     data_buff <= nxt_data_buff;
	  end
     end // always_ff @ (posedge CLK, negedge nRST)
endmodule // apb_slave

