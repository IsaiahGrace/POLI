/*
 John Martinuk
 jmartinu@purdue.edu
 
 Isaiah Grace
 igrace@purdue.edu
 */

`include "crc_generator_if.vh"

`timescale 1 ns / 1 ns

module crc32_tb;
   parameter PERIOD = 20;
   logic CLK = 0, nRST;

   //clock
   always #(PERIOD/2) CLK++;
   
   // CRC interface
   crc_generator_if crcif();

   // main test program
   crc_test PROG(CLK, nRST, crcif);

   // DUT
   crc32 DUT(CLK, nRST, crcif);

endmodule // crc32_tb


program crc_test (
		  input logic  CLK,
		  output logic nRST,
		  crc_generator_if crcif
		  );
   
   // Test signals
   int 			       test_case;
   string 		       test_name;
   int 			       timeout; // We will not wait for ready forever
   
   task reset_DUT;
      begin
	 nRST = 1'b1;
	 #(2)
	 nRST = 1'b0;
	 crcif.crc_data_in = '0;
	 crcif.crc_reset = '0;
	 crcif.crc_start = '0;
	 crcif.crc_orient = '0;
	 @(negedge CLK);
	 @(negedge CLK);
	 nRST = 1'b1;
	 //@(posedge CLK);
      end
   endtask // reset_DUT

   initial
     begin
	// RESET DUT
	test_case = 0;
	test_name = "nRST";
	reset_DUT();

	// Reset should load data_in into data_out
	@(posedge CLK);
	test_case++;
	test_name = "Reset";
	crcif.crc_data_in = 32'hFF;
	@(negedge CLK);
	crcif.crc_reset = 1'b1;
	@(negedge CLK);
	crcif.crc_reset = 1'b0;
	@(posedge CLK);
	assert (crcif.crc_data_out == 32'hFF)
	  else $error("data_in was not loaded into data_out on crc reset");
	

	// Start should lower ready bit
	@(posedge CLK);
	test_case++;
	test_name = "Start";
	crcif.crc_start = 1'b1;
	@(posedge CLK);
	#(2)
	assert (crcif.crc_ready == 1'b0)
	  else $error("Ready flag was not lowered after start");
	reset_DUT();
	
	// Two start pulses should not adversly effect operations
	@(posedge CLK);
	test_case++;
	test_name = "Double start";
	crcif.crc_data_in = 32'hAA;
	@(posedge CLK);
	crcif.crc_start = 1'b1;
	@(posedge CLK);
	crcif.crc_start = 1'b0;
	@(posedge CLK);
	crcif.crc_start = 1'b1;
	@(posedge CLK);
	crcif.crc_start = 1'b0;
	// Wait for ready flag
	timeout = 0;
	while (crcif.crc_ready != 1'b1)
	  begin
	     @(posedge CLK);
	     timeout++;
	     assert (timeout < 40)
	       else $fatal("Timout exeeded 40 cycles while waiting for ready flag");
	  end
	@(posedge CLK);
	assert (crcif.crc_data_out == 32'hAA)
	  else $error("Double start corrupted crc state");
	reset_DUT();
		
	// Setting a new polynomial during opperation does not currupt operation in progress
	@(posedge CLK);
	test_case++;
	test_name = "Polynomial change after start";
	crcif.crc_data_in = 32'h124721AB;
	@(negedge CLK);
	crcif.crc_reset = 1'b1;
	@(negedge CLK);
	crcif.crc_reset = 1'b0;
	@(posedge CLK);	
	crcif.crc_data_in = 32'hF0AA0055;
	crcif.crc_orient = 32'h82608EDB;
	// From Matlab crc32 documentation
	//   100000 1    001      1 000001   0001      1      1    01     1    01     1    01   1
	//z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1
	@(posedge CLK);
	crcif.crc_start = 1'b1;
	@(posedge CLK);
	crcif.crc_start = 1'b0;
	//crcif.crc_orient
	// Wait for ready flag
	timeout = 0;
	while (crcif.crc_ready != 1'b1)
	  begin
	     @(posedge CLK);
	     timeout++;
	     if (timeout > 12)
	       crcif.crc_orient = 32'h00000000;
	     assert (timeout < 40)
	       else $fatal("Timout exeeded 40 cycles while waiting for ready flag");
	  end
	@(posedge CLK);
	assert (crcif.crc_data_out == 32'h940D4516)
	  else $error("Polynomial write corrupted crc state");
	reset_DUT();
	
	// Changeing data during opperation does not currupt operation in progress
	@(posedge CLK);
	test_case++;
	test_name = "Data change after start";
	crcif.crc_data_in = 32'h124721AB;
	@(negedge CLK);
	crcif.crc_reset = 1'b1;
	@(negedge CLK);
	crcif.crc_reset = 1'b0;
	@(posedge CLK);	
	crcif.crc_data_in = 32'hF0AA0055;
	crcif.crc_orient = 32'h82608EDB;
	@(posedge CLK);
	crcif.crc_start = 1'b1;
	@(posedge CLK);
	crcif.crc_start = 1'b0;
	//crcif.crc_orient
	// Wait for ready flag
	timeout = 0;
	while (crcif.crc_ready != 1'b1)
	  begin
	     @(posedge CLK);
	     timeout++;
	     if (timeout > 12)
	       crcif.crc_data_in = 32'hFFFFFFFF;
	     assert (timeout < 40)
	       else $fatal("Timout exeeded 40 cycles while waiting for ready flag");
	  end
	@(posedge CLK);
	assert (crcif.crc_data_out == 32'h940D4516)
	  else $error("Data write corrupted crc state");
	reset_DUT();
	
	// TOGGLE COVERAGE
     end // initial begin
   
endprogram // crc_test
