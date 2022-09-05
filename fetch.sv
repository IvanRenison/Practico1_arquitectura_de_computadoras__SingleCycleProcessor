module fetch #(parameter N = 64) (
		input logic PCSrc_F, clk, reset,
		input logic [N-1:0] PCBranch_F,
		output logic [N-1:0] imem_addr_F
	);

	logic [N-1:0] temp1;
	logic [N-1:0] temp2;

	mux2 #(N) mux(temp1, PCBranch_F, PCSrc_F, temp2);
	flopr #(N) pc(clk, reset, temp2, imem_addr_F);
	adder #(N) add(imem_addr_F, N'('d4), temp1);

endmodule
