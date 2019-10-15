`include "crc_generator_if.vh"

import cpu_types_pkg::*;


`timescale 1 ns / 1 ns

module crc32_tb;
   parameter PERIOD = 10;
   logic CLK = 0, nRST;

   //clock
   always #(PERIOD/2) CLK++;
   //cache if
   crc_generator_if crcif();

   //
   crc_test PROG(CLK, nRST, crc_if);

   //data cache
   crc32 DUT(CLK, nRST, crc_if.crc);



endmodule // memory_control_tb

program crc_test(
					input logic CLK,
					output logic nRST,
					crc_if crc
	);
	parameter PERIOD = 10;
	word_t caseNum;
	initial
	 	begin

	 		caseNum = 0;
      crc.crc_data_in = '0;
      crc.crc_reset = 1'b0;
      crc.crc_start = 1'b0;
      crc.crc_orient = '0;

	 		nRST = 1'b0;
	 		@(posedge CLK);
	 		nRST = 1'b1;
	 		@(posedge CLK);

			assert (crc.crc_data_out == '0 && crc.crc_ready == 1'b1) $display("Test: %d at %t: Correct Reset Values",  caseNum, $time);
 			else $display("Test: %d at  %t: Incorrect Reset Values", caseNum, $time);


      caseNum = 1



			$finish;
		end

endprogram

