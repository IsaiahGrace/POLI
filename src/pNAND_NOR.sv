module pNAND_NOR(

   input logic A, B, Vxx, Vyy
   output logic X
);

assign X = (Vxx && ~Vyy)?:~(A && B):~(A || B);

endmodule
