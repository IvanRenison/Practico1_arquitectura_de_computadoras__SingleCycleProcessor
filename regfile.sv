module regfile( // Hay warnings
		input logic clk, we3,
		input logic [4:0] ra1, ra2, wa3,
		input logic [63:0] wd3,
		output logic [63:0] rd1, rd2
	);



	logic [63:0] registros [30:0];

	// Inicialización
	initial begin
		for (logic [4:0] i = 5'b00000; i<31; ++i) begin
			registros[i] = i;
		end
	end



	// Leer registros
	always_comb begin
		rd1 = ra1 != 5'b1111 ? registros[ra1] : 64'b0;
		rd2 = ra2 != 5'b1111 ? registros[ra2] : 64'b0;
	end


	// Escribir registros
	always_ff @(posedge clk) begin
		if (we3 == 1'b1 && wa3 !=  5'b1111) begin
			registros[wa3] = wd3;
		end
	end


endmodule