module alu_tb(); // 🛠

	logic [63:0] as [2:0] = {
		55, -68, 59
	};
	logic [63:0] bs [2:0] = {
		23, -63, -36
	};

	logic [63:0] [2:0] expected_results_and = {
		as[2] & bs[2], as[1] & bs[1], as[0] & bs[0]
	};
	logic [63:0] [2:0] expected_results_or = {
		as[2] | bs[2], as[1] | bs[1], as[0] | bs[0]
	};
	logic [63:0] [2:0] expected_results_mas = {
		as[2] + bs[2], as[1] + bs[1], as[0] + bs[0]
	};
	logic [63:0] [2:0] expected_results_menos = {
		as[2] - bs[2], as[1] - bs[1], as[0] - bs[0]
	};
	logic [63:0] [2:0] expected_results_pass_b = {
		bs[2], bs[1], bs[0]
	};


	logic [3:0] control_inputs [4:0] = {
		4'b0000,
		4'b0001,
		4'b0010,
		4'b0110,
		4'b0111
	};

	logic [63:0] [2:0] [4:0] expected_results = {
		expected_results_and,
		expected_results_or,
		expected_results_mas,
		expected_results_menos,
		expected_results_pass_b
	};

	logic [63:0] a, b;
	logic [3:0] ALUControl;
	logic [63:0] result;
	logic zero;

	alu dut(a, b, ALUControl, result, zero);

	logic [31:0] errors;
	always begin
		$display("%p", expected_results);
		errors = 0;

		for (int i=0; i<3; ++i) begin
			a = as[i];
			b = bs[i];

			for (int j=0; j<5; ++j) begin
				ALUControl = control_inputs[j];

				#1ns;

				if (result !== expected_results[j*3 + i]) begin
					errors = errors + 1;
					$display("i=%d, j=%d, a=%d, b=%d\n, result = %d, expected_results[j*3 + i] = %d\n", i, j, a, b, result, expected_results[j*3 + i]);
				end
			end
		end
		$display("Total errors: %d", errors);
		$stop;
	end


endmodule
