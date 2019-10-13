/*
 Isaiah Grace
 igrace@purdue.edu
 
 This is the top level file connecting all submodules in the POLI design together
 
 */

// Includes
`include "POLI_types_pkg.vh"
`include "apb_slave_if.vh"
`include "control_register_if.vh"
`include "crc_generator_if.vh"


module POLI_top_level 
  (
   input logic 			CLK, nRST,
   input logic [WORD_SIZE-1:0] 	PWDATA,
   input logic [WORD_SIZE-1:0] 	PADDR,
   input logic 			PWRITE, PSEL, PENABLE,
   output logic [WORD_SIZE-1:0] PRDATA,
   output logic 		PREADY
   );

   // Import types
   import POLI_types_pkg::*;

   // Local interface declerations
   apb_slave_if apbif ();
   control_register_if crif ();
   crc_generator_if crcif ();
   
   // Connect interfaces together
   
   // POLI_top_level <-> apb_slave
   assign apbif.PWDATA = PWDATA;
   assign apbif.PADDR = PADDR;
   assign apbif.PWRITE = PWRITE;
   assign apbif.PSEL = PSEL;
   assign apbif.PENABLE = PENABLE;
   assign PRDATA = apbif.PRDATA;
   assign PREADY = apbif.PREADY;

   // apb_slave <-> control_register
   assign apbif.write_data = crif.write_data;
   assign apbif.write_enable = crif.write_enable;
   assign apbif.register_select = crif.register_select;
   assign crif.read_data = apbif.read_data;

   // control_register <-> crc_generator
   assign crcif.crc_data_in = crif.crc_data_in;
   assign crcif.crc_reset = crif.crc_reset;
   assign crcif.crc_start = crif.crc_start;
   assign crcif.crc_orient = crif.crc_orient;
   assign crif.crc_data_out = crcif.crc_data_out;
   assign crif.crc_ready = crcif.crc_ready;
   
   // Submodule declerations
   apb_slave apb_slave (CLK, nRST, apbif);
   control_register control_register (CLK, nRST, crif);
   crc_generator crc_generator (CLK, nRST, crcif);

   // Individual NAND/NOR gate
   sim_wrapper_NAND_NOR (.A (crif.NAND_NOR_a),
			 .B (crif.NAND_NOR_b),
			 .orient (crif.NAND_NOR_orient),
			 .X (crif.NAND_NOR_out)
			 );
      
   // Individual XOR/BUF gate
   sim_wrapper_XOR_BUF (.A (crif.XOR_BUF_a),
			.B (crif.XOR_BUF_b),
			.orient (crif.XOR_BUF_orient),
			.X (crif.XOR_BUF_out)
			);
      
endmodule // POLI_top_level
