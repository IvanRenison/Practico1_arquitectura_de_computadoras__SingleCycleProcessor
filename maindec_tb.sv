module maindec_tb();

	logic [10:0] opcode;
	logic reset;

	logic Reg2Loc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ERet;
	logic [1:0] ALUOp, ALUSrc;
	logic [3:0] EStatus;

	maindec dut(
		.Op(opcode),
		.reset(reset),
		.Reg2Loc(Reg2Loc), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite),
		.MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp), .ERet(ERet),
		.EStatus(EStatus)
	);

	logic expected_Reg2Loc, expected_MemtoReg, expected_RegWrite, expected_MemRead, expected_MemWrite, expected_Branch, expected_ERet;
	logic [1:0] expected_ALUOp, expected_ALUSrc;
	logic [3:0] expected_EStatus;


	logic [25:0] inputs_and_expected_outputs [0:6] = '{
	//   opcode             r2l   ALUs   mtr   rw    mr    mw    br    Eret  ALUo   EStatus
		{11'b111_1100_0010, 1'b0, 2'b01, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 2'b00, 4'b0000}, // LDUR
		{11'b111_1100_0000, 1'b1, 2'b01, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 2'b00, 4'b0000}, // STUR
		{11'b101_1010_0000, 1'b1, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 2'b01, 4'b0000}, // CBZ
		{11'b100_0101_1000, 1'b0, 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b10, 4'b0000}, // ADD
		{11'b110_0101_1000, 1'b0, 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b10, 4'b0000}, // SUB
		{11'b100_0101_0000, 1'b0, 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b10, 4'b0000}, // AND
		{11'b101_0101_0000, 1'b0, 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 2'b10, 4'b0000}  // ORR
	};

	int errors;
	initial begin
		reset = 0;
		errors = 0;

		for (int i = 0; i < 7; ++i) begin
			#1ns;
			{opcode, expected_Reg2Loc, expected_ALUSrc, expected_MemtoReg, expected_RegWrite, expected_MemRead, expected_MemWrite, expected_Branch, expected_ERet, expected_ALUOp, expected_EStatus} =
				inputs_and_expected_outputs[i];
			
			#1ns;

			if ({Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ERet, ALUOp, EStatus}
					!= {expected_Reg2Loc, expected_ALUSrc, expected_MemtoReg, expected_RegWrite, expected_MemRead, expected_MemWrite, expected_Branch, expected_ERet, expected_ALUOp, expected_EStatus}
			) begin
				errors++;
				$display("ERROR: i = %d", i);
			end
		end

		$display("Total errors = %d", errors);
	end

endmodule
