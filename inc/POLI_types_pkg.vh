/*
 Isaiah Grace
 igrace@purdue.edu
 
 This file describes the data types used in the project
 */

`ifndef POLI_TYPES_PKG_VH
 `define POLI_TYPES_PKG_VH

package POLI_types_pkg;
   
   // Parameters
   parameter WORD_SIZE = 32;
     
   // register select type.
   // This enumerates the registers used in the control register module.
   typedef enum logic {
		       NAND_NOR_CONTROL,
		       NAND_NOR_INPUT,
		       NAND_NOR_OUTPUT,
		       
		       XOR_BUF_CONTROL,
		       XOR_BUF_INPUT,
		       XOR_BUF_OUTPUT,
		       
		       CRC_CONTROL,
		       CRC_STATUS,
		       CRC_INPUT,
		       CRC_OUTPUT
		       } regsel_t;
   
endpackage // POLI_types_pkg
   
`endif //  `ifndef POLI_TYPES_PKG_VH
   
