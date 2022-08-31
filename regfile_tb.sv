module regfile_tb(); // 🤔 Por que los warings?

	logic clk, we3;
	logic [4:0] ra1, ra2, wa3;
	logic [63:0] wd3;
	logic [63:0] rd1, rd2;

	regfile dut(clk, we3, ra1, ra2, wa3, wd3, rd1, rd2);

	// Reloj
	always begin
		clk = 1; #5ns; clk = 0; #5ns;
	end


	int errors;

	initial begin
		// Inizializaciones
		errors = 0;

		we3 = 1'b0;
		ra1 = 5'b0;
		ra2 = 5'b0;
		wd3 = 64'b0;

		// Testeos de lectura
		for (logic [4:0] i = 5'b0; i<31; ++i) begin
			// Posedge
			ra1 = i;
			ra2 = i;

			#5ns;
			// Negedge
			if (rd1 !== i || rd2 !== i) begin
				$display("ERROR: rd1 !== i || rd2 !== i. i = %d, rd1 = %d, rd2 = %d", i, rd1, rd2);
				errors++;
			end
			#5ns;
		end

		// Testeos de escritura
		we3 = 1;
		for (logic [4:0] i = 5'b0; i<31; ++i) begin
			// Posedge
			wd3 = $random;
			wa3 = i;
			ra1 = i;
			ra2 = i;

			#5ns;
			// Negedge
			if (rd1 !== wd3 || rd2 !== wd3) begin
				$display("ERROR: rd1 !== wd3 || rd2 !== wd3. i = %d, wd3 = %d, rd1 = %d, rd2 = %d", i, wd3, rd1, rd2);
				errors++;
			end

			#5ns;
		end

		$display("Total errors = %d", errors);
		$stop;
	end



endmodule
