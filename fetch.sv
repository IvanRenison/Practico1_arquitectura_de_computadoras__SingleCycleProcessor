module fetch #(parameter N = 64) (
		input logic PCSrc_F, clk, reset, EProc_F,
		input logic [N-1:0] PCBranch_F, EVAddr_F,
		output logic [N-1:0] imem_addr_F, NextPC_F
	);

	logic [N-1:0] add_out;
	logic [N-1:0] mux2__out;

	mux2 #(N) mux(add_out, PCBranch_F, PCSrc_F, NextPC_F);
	flopr #(N) pc(clk, reset, mux2__out, imem_addr_F);
	adder #(N) add(imem_addr_F, N'('d4), add_out);
	mux2 #(N) mux_(NextPC_F, EVAddr_F, EProc_F, mux2__out);

endmodule
