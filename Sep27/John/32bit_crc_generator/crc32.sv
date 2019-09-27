module crc32(
// Inputs from Control Register
input logic data_in[31:0],
input logic crc_reset,
input logic crc_start,
// Inputs from Power Rail Control
input logic orient[31:0],

// Outputs to Control Register
output logic crc_out[31:0]
output logic crc_ready

);

logic count[4:0];
logic n_count[4:0];
logic crc[31:0];
logic n_crc[31:0];
logic crc_enable;

assign crc_enable = (crc_start || (count != 5'd0 && count != 5'd31))


//Counter
alwayfs_ff(posedge CLK, negedge nRST) begin
  if(!nRST) begin
    count <= '0;
  end
  else begin
    count <= n_count;
  end
end

always_comb begin
  n_count = count;



  if(count != 5'd0 && count != 5'd31) begin
    n_count = count + 1;
  end

  else if(crc_start && count == 5'd0) begin
    n_count = 5'd1;
  end

  else if(count == 5'd31) begin
    n_count = 0;
  end

end



always_begin



endmodule
