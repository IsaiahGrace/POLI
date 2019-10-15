/*
 John Martinuk
 jmartinu@purdue.edu

 */
`include "crc_generator_if.vh"

module crc32 (input CLK, nRST, crc_generator_if.crc_generator crc);

   logic 		   [4:0]count;
   logic 		   [4:0]n_count;
   //logic 		   crc[31:0];
   logic 		   [31:0]n_crc;
   logic       [31:0]curr_data;
   logic     [31:0]n_data;
   logic 		   crc_enable;
   logic     [31:0] curr_orient;

   assign crc_enable = (crc.crc_start || (count != 5'd0));
   assign crc.crc_ready = (count == '0) ? 1'b1 : 1'b0;

     //Counter always_ff @(posedge CLK, negedge nRST)
     always_ff @(posedge CLK, negedge nRST)
       begin
	  if(!nRST)
	    begin
	       count <= '0;
	    end
	  else
	    begin
	       count <= n_count;
	    end
       end // always_ff @ (posedge CLK, negedge nRST)


     //Data and CRC data
     always_ff @(posedge CLK, negedge nRST)
       begin
	  if(!nRST)
	    begin
	       crc.crc_data_out <= '0;
         curr_data <= '0;
	    end
	  else
	    begin
         crc.crc_data_out <= crc.crc_data_out;
         curr_data <= curr_data;
         curr_orient <= curr_orient;

            if (count == '0) begin
              curr_orient <= crc.crc_orient;
            end
            if (crc_enable) begin
	          crc.crc_data_out <= n_crc;
            curr_data <= n_data;
            end
            else if (crc.crc_reset && count == '0) begin
            crc.crc_data_out <= crc.crc_data_in;
            curr_data <= crc.crc_data_in;
            end
	    end
       end // always_ff @ (posedge CLK, negedge nRST)


//next data logic
always_comb
begin
  n_data = {curr_data[30:0], 1'b0};
  if (count == '0) begin
    n_data = crc.crc_data_in;
  end
end



// next count logic
always_comb
begin
	n_count = count;
	if(count != 5'd0 && count != 5'd31)
	  begin
	     n_count = count + 1;
	  end
	else if(crc.crc_start && count == 5'd0)
	  begin
	     n_count = 5'd1;
	  end
	else if(count == 5'd31)
	  begin
	     n_count = '0;
	  end
end

sim_wrapper_XOR_BUF A0 (
		   .A(curr_data[0]),
		   .B(crc.crc_data_out[31]),
		   .orient(curr_orient[0]),
		   .X(n_crc[0])
);

genvar i;
generate
    for (i=1; i<=31; i=i+1) begin: some_identifier
    sim_wrapper_XOR_BUF A (
        .A(crc.crc_data_out[i - 1]),
        .B(crc.crc_data_out[31]),
        .orient(curr_orient[i]),
        .X(n_crc[i])
    );
end
endgenerate





endmodule // crc32

