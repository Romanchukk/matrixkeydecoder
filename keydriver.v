module keydriver(i_clk, i_coder, o_decoder, o_data);

input i_clk;
input [3:0] i_coder;

output [2:0] o_decoder;
output [5:0] o_data;

reg [5:0] key_adress;
reg [1:0] adress;
reg [2:0] adress_decoder;

assign o_decoder = adress_decoder;
assign o_data = key_adress;

/* ----------------------------------
		   Counter realization
   ---------------------------------- */
always @(posedge i_clk) begin
	adress <= adress + 1'b1;

	case (adress)
		2'b01: adress_decoder 	<= 3'b110;
		2'b10: adress_decoder 	<= 3'b101;
		2'b11: adress_decoder 	<= 3'b011;
		default: adress_decoder <= 3'b111;
	endcase

end

/* ----------------------------------
		   Decoder realization
   ---------------------------------- */
always @(negedge i_coder) begin
	if(~i_coder[0]) 
		key_adress <= {adress, 4'b0001};
	else if(~i_coder[1])
		key_adress <= {adress, 4'b0010};
	else if(~i_coder[2])
		key_adress <= {adress, 4'b0100};
	else if(~i_coder[3])
		key_adress <= {adress, 4'b1000};
end 

endmodule
