/*
 Isaiah Grace
 igrace@purdue.edu
 */

module POLI_standalone 
  (
   input logic 	output_select, A, B, Vxx, Vyy,
   output logic X
   );
   
   logic 	NAND_NOR_X;
   logic 	XOR_BUF_X;
   
   assign X = output_select ? XOR_BUF_X : NAND_NOR_X;
   
   sim_NAND_NOR NAND_NOR_standalone (.A (A),
				     .B (B),
				     .Vxx (Vxx),
				     .Vyy (Vxx),
				     .X (NAND_NOR_X));
   
   sim_XOR_BUF XOR_BUF_standalone (.A (A),
				   .B (B),
				   .Vxx (Vxx),
				   .Vyy (Vyy),
				   .X (XOR_BUF_X));
   
endmodule // POLI_standalone
