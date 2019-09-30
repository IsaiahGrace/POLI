/*
 John Martinuk
 */

module sim_wrapper_NAND_NOR (
			     input logic  A, B, orient
			     output logic X
			     );
   
   sim_NAND_NOR A1 (
		    .A(A),
		    .B(B),
		    .Vxx(orient),
		    .Vyy(~orient),
		    .X(X)
		    );

endmodule // sim_wrapper_NAND_NOR



