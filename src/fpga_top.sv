// Isaiah Grace

// Includes
`include "POLI_types_pkg.vh"
import POLI_types_pkg::*;


// Type defines
typedef enum logic [3:0] {
			  START,

			  NN_CONTROL,
			  NN_INPUT,
			  NN_OUTPUT,
			  XB_CONTROL,
			  XB_INPUT,
			  XB_OUTPUT,

			  CRC_CONFIG,
			  CRC_INPUT,
			  CRC_CONTROL,
			  CRC_STATUS,
			  CRC_OUTPUT,
			  WAIT
			  } state_t;

	     
module fpga_top
  (
   input logic 	      CLK, nRST,
   input logic [3:0]  SW,
   // Add input for user pushbutton to reset
   output logic [7:0] LED
   );

   localparam Polynomial = 32'hDEADBEEF;
   localparam Threshold = 32'd50; // 50Mhz clock frequency means set threshold to 50,000,000 for one new CRC/s
   
   
   state_t state;
   state_t nxt_state;
   logic [7:0] 	      nxt_LED;
   logic [31:0]       count;
   logic [31:0]       nxt_count;
   

   // submodule signals
   logic [WORD_SIZE-1:0] PWDATA;
   logic [WORD_SIZE-1:0] PADDR;
   logic 		 PWRITE, PSEL, PENABLE;
   logic [WORD_SIZE-1:0] PRDATA;
   logic 		 PREADY;

   // POLI top level instance
   POLI_top_level POLI(.CLK(CLK),
		       .nRST(nRST),
		       .PWDATA(PWDATA),
		       .PADDR(PADDR),
		       .PWRITE(PWRITE),
		       .PSEL(PSEL),
		       .PENABLE(PENABLE),
		       .PRDATA(PRDATA),
		       .PREADY(PREADY));
   

   // Next state logic
   always_comb
     begin
	case(state)
	  START: nxt_state = SW[3] ? NN_CONTROL : CRC_CONFIG;
	  
	  NN_CONTROL: nxt_state = PREADY ? NN_INPUT   : NN_CONTROL;
	  NN_INPUT:   nxt_state = PREADY ? NN_OUTPUT  : NN_INPUT;
	  NN_OUTPUT:  nxt_state = PREADY ? XB_CONTROL : NN_OUTPUT;
	  XB_CONTROL: nxt_state = PREADY ? XB_INPUT   : XB_CONTROL;
	  XB_INPUT:   nxt_state = PREADY ? XB_OUTPUT  : XB_INPUT;
	  XB_OUTPUT:  nxt_state = PREADY ? START      : XB_OUTPUT;
	  
	  CRC_CONFIG:  nxt_state = PREADY ? CRC_INPUT   : CRC_CONFIG;
	  CRC_INPUT:   nxt_state = PREADY ? CRC_CONTROL : CRC_INPUT;
	  CRC_CONTROL: nxt_state = PREADY ? CRC_STATUS  : CRC_CONTROL;
	  CRC_STATUS:  nxt_state = PREADY & PRDATA[0]   ? CRC_OUTPUT : CRC_STATUS;
	  CRC_OUTPUT:  nxt_state = PREADY ? WAIT        : CRC_OUTPUT;
	  WAIT: nxt_state = count == Threshold ? START : WAIT;
	endcase // case (state)
     end // always_comb

   // Output logic
   always_comb
     begin
	// Default outputs
	PWDATA = '0;
	PADDR = '0;
	PWRITE = '0;
	PSEL = '0;
	PENABLE = PREADY;
	nxt_LED = LED;
	
	case (state)
	  NN_CONTROL:
	    begin
	       PSEL = 1'b1;
	       PWRITE = 1'b1;
	       PADDR = NAND_NOR_CONTROL_ADDR;
	       PWDATA = SW[2];
	       nxt_LED[7] = PREADY ? SW[2] : LED[7];
	    end
	  NN_INPUT:
	    begin
	       PSEL = 1'b1;
	       PWRITE = 1'b1;
	       PADDR = NAND_NOR_INPUT_ADDR;
	       PWDATA = SW[1:0];
	       nxt_LED[6:5] = PREADY ? SW[1:0] : LED[6:5];
	    end
	  NN_OUTPUT:
	    begin
	       PSEL = 1'b1;
	       PADDR = NAND_NOR_OUTPUT_ADDR;
	       nxt_LED[4] = PREADY ? PRDATA[0] : LED[4];
	    end
	  XB_CONTROL:
	    begin
	       PSEL = 1'b1;
	       PWRITE = 1'b1;
	       PADDR = XOR_BUF_CONTROL_ADDR;
	       PWDATA = SW[2];
	       nxt_LED[3] = PREADY ? SW[2] : LED[3];
	    end
	  XB_INPUT:
	    begin
	       PSEL = 1'b1;
	       PWRITE = 1'b1;
	       PADDR = XOR_BUF_INPUT_ADDR;
	       PWDATA = SW[1:0];
	       nxt_LED[2:1] = PREADY ? SW[1:0] : LED[2:1];
	    end
	  XB_OUTPUT:
	    begin
	       PSEL = 1'b1;
	       PADDR = XOR_BUF_OUTPUT_ADDR;
	       nxt_LED[0] = PREADY ? PRDATA[0] : LED[0];
	    end
	  CRC_CONFIG:
	    begin
	       PSEL = 1'b1;
	       PWRITE = 1'b1;
	       PADDR = CRC_CONFIG_ADDR;
	       PWDATA = Polynomial;
	    end
	  CRC_INPUT:
	    begin
	       PSEL = 1'b1;
	       PWRITE = 1'b1;
	       PADDR = CRC_INPUT_ADDR;
	       PWDATA = LED;
	    end
	  CRC_CONTROL:
	    begin
	       PSEL = 1'b1;
	       PWRITE = 1'b1;
	       PADDR = CRC_CONTROL_ADDR;
	       PWDATA = 1'b1;
	    end
	  CRC_STATUS:
	    begin
	       PSEL = 1'b1;
	       PADDR = CRC_STATUS_ADDR;
	       // PRDATA is read by the next state logic
	       // We will just stay here until PRDATA is non-zero
	    end
	  CRC_OUTPUT:
	    begin
	       PSEL = 1'b1;
	       PADDR = CRC_OUTPUT_ADDR;
	       nxt_LED = PREADY ? PRDATA[7:0] : LED[7:0];
	    end
	endcase // case (state)
     end // always_comb
   
   // Counter logic
   assign nxt_count = state == WAIT ? count + 1 : '0;
   
   always_ff @(posedge CLK, negedge nRST)
     begin
	if (!nRST)
	  begin
	     state <= START;
	     LED <= '0;
	     count <= '0;
	  end
	else
	  begin
	     state <= nxt_state;
	     LED <= nxt_LED;
	     count <= nxt_count;
	  end
     end // always_ff @ (posedge CLK, negedge nRST)
   
endmodule // fpga_top
