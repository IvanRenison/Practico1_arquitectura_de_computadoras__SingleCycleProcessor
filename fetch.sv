module fetch(
		input logic PCSrc_F, clk, reset,
		input logic [63:0] PCBranch_F,
		output logic [63:0] imem_addr_F
	);

	logic [63:0] temp1;
	logic [63:0] temp2;

	mux2 #(64) mux(temp1, PCBranch_F, PCSrc_F, temp2);
	flopr #(64) pc(clk, reset, temp2, imem_addr_F);
	adder #(64) add(imem_addr_F, 64'd4, temp1);

endmodule
