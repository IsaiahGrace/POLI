/*
 John Martinuk
 */

module sim_NAND_NOR (
		     input logic  A, B, Vxx, Vyy,
		     output logic X
		     );

   assign X = (Vxx & ~Vyy) ? ~(A & B): ~(A | B);

endmodule // sim_NAND_NOR

