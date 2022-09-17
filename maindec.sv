module maindec(
		input logic [10:0] Op,
		input logic reset,
		output logic Reg2Loc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ERet,
		output logic [1:0] ALUSrc, ALUOp,
		output logic [3:0] EStatus
	);

	always_comb begin
		if (reset) begin
			Reg2Loc <= 1'b0;
			MemtoReg <= 1'b0;
			RegWrite <= 1'b0;
			MemRead <= 1'b0;
			MemWrite <= 1'b0;
			Branch <= 1'b0;
			ERet <= 1'b0;
			ALUSrc <= 2'b00;
			ALUOp <= 2'b00;
			EStatus <= 4'b0000;
		end
		else begin
			casez(Op)
			11'b111_1100_0010: begin // LDUR
					Reg2Loc <= 1'b0;
					MemtoReg <= 1'b1;
					RegWrite <= 1'b1;
					MemRead <= 1'b1;
					MemWrite <= 1'b0;
					Branch <= 1'b0;
					ERet <= 1'b0;
					ALUSrc <= 2'b01;
					ALUOp <= 2'b00;
					EStatus <= 4'b0000;
				end
			11'b111_1100_0000: begin  // STUR
					Reg2Loc <= 1'b1;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b1;
					Branch <= 1'b0;
					ERet <= 1'b0;
					ALUSrc <= 2'b01;
					ALUOp <= 2'b00;
					EStatus <= 4'b0000;
				end
			11'b101_1010_0???: begin  // CBZ
					Reg2Loc <= 1'b1;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					Branch <= 1'b1;
					ERet <= 1'b0;
					ALUSrc <= 2'b00;
					ALUOp <= 2'b01;
					EStatus <= 4'b0000;
				end
			11'b100_0101_1000, 11'b110_0101_1000, 11'b100_0101_0000, 11'b101_0101_0000: begin // ADD, SUB, AND, ORR (tipo R)
					Reg2Loc <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b1;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					Branch <= 1'b0;
					ERet <= 1'b0;
					ALUSrc <= 2'b00;
					ALUOp <= 2'b10;
					EStatus <= 4'b0000;
				end
			11'b110_1011_0100: begin  // ERET
					Reg2Loc <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					Branch <= 1'b1;
					ERet <= 1'b1;
					ALUSrc <= 2'b00;
					ALUOp <= 2'b01;
					EStatus <= 4'b0000;
				end
			11'b110_1010_1001: begin  // MRS
					Reg2Loc <= 1'b1;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b1;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					Branch <= 1'b0;
					ERet <= 1'b0;
					ALUSrc <= 2'b10;
					ALUOp <= 2'b01;
					EStatus <= 4'b0000;
				end
			default: begin
					Reg2Loc <= 1'b0;
					MemtoReg <= 1'b0;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					Branch <= 1'b0;
					ERet <= 1'b0;
					ALUSrc <= 2'b00;
					ALUOp <= 2'b00;
					EStatus <= 4'b0010;
				end
			endcase
		end
	end


endmodule
