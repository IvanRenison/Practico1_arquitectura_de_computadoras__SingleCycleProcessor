module execute(
		input logic AluSrc,
		input logic [3:0] AluControl,
		input logic [63:0] PC_E, signImm_E, readData1_E, readData2_E,
		output logic [63:0] PCBranch_E, aluResult_E, writeData_E,
		output logic zero_E
	);

	logic [63:0] MUX_out;
	logic [63:0] sl2_out;

	mux2 #(64) MUX(signImm_E, readData2_E, AluSrc, MUX_out);
	sl2 #(64) sl2(signImm_E, sl2_out);
	adder #(64) adder(PC_E, sl2_out, PCBranch_E);
	alu alu(readData1_E, MUX_out, AluControl, aluResult_E, zero_E);

	assign writeData_E = readData2_E;

endmodule
