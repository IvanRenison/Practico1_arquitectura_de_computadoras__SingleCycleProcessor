module fetch(
		input logic PCSrc_F, clk, reset,
		input logic [63:0] PCBranch_F,
		output logic [63:0] imem_addr_F
	);

	logic [63:0] temp;
	logic [63:0] four = 4;

	mux2 #(64) mux(temp, PCBranch_F, PCSrc_F, imem_addr_F);
	flopr pc(clk, reset, imem_addr_F);
	adder #(64) add(imem_addr_F, four, temp);
	

endmodule
