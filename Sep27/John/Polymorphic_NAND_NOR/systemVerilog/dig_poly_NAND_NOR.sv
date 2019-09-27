module dig_poly_NAND_NOR(

   input logic A, B, orient
   output logic X
);


pNAND_NOR A1(
     .A(A),
     .B(B),
     .Vxx(orient),
     .Vyy(~orient),
     .X(X)
);


endmodule
