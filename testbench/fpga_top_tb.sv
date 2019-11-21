/*
 Isaiah Grace
 igrace@purdue.edu
 
 Testbench for the fpga wrapper for POLI apb peripheral
 */

`timescale 1 ns / 1 ns

module fpga_top_tb;
   // clock period
   parameter PERIOD = 20;

   // signals
   logic CLK = 1, nRST;

   // clock generation
   always #(PERIOD/2) CLK++;

   // FPGA inputs and outputs
   logic [3:0] SW;
   logic [7:0] LED;

   // Test program
   test PROG (.CLK(CLK),
	      .nRST(nRST),
	      .SW(SW),
	      .LED(LED)
	      );

   // DUT
   fpga_top DUT (.CLK(CLK),
		 .nRST(nRST),
		 .SW(SW),
		 .LED(LED)
		 );

endmodule // fpga_top_tb

program test
  (
   input logic CLK,
   output logic nRST,
   output logic [3:0] SW,
   input logic [7:0] LED
   );

   // Test signals
   int 		     test_case;
   string 	     test_name;

   task reset_DUT;
      begin
	 nRST = 1'b1;
	 #(2)
	 nRST = 1'b0;
	 SW = 4'b0;
	 @(negedge CLK);
	 @(negedge CLK);
	 nRST = 1'b1;
      end
   endtask // reset_DUT

   task wait_cycles;
      input int cycles;
      begin
	 int i;
	 for (i = 0; i < cycles; i++)
	   @(posedge CLK);
      end
   endtask // wait_cycles
   
   // Main test sequence
   initial
     begin
	// reset DUT
	test_case = 0;
	test_name = "";
	reset_DUT();

	// GATE mode
	test_case++;
	test_name = "GATE mode";
	
	SW = 4'b1000;

	for (int i = 0; i < 8; i++)
	  begin
	     @(posedge CLK);
	     SW[2:0] = SW[2:0] + 1;
	     wait_cycles(.cycles(50));
	  end

	// CRC mode
	@(posedge CLK);
	test_case++;
	test_name = "CRC mode";
	
	SW = 4'b0;

	wait_cycles(.cycles(10000));

     end // initial begin
endprogram // test
   
