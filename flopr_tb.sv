module flopr_tb();

	parameter N = 64;

	logic clk, reset;
	logic [N-1:0] d;
	logic [N-1:0] q;

	flopr #(N) dut(clk, reset, d, q);
	
	logic [N-1:0] ds [9:0];
	
	logic [31:0] i, errors;

	always begin
		clk = 1; #5ns; clk = 0; #5ns;
	end

	initial begin
		i = 0;
		errors = 0;
		ds = '{
			$random,
			$random,
			$random,
			$random,
			$random,
			$random,
			$random,
			$random,
			$random,
			$random
		};

		reset = '1; #50ns;
		reset = '0;
	end


	always @(posedge clk) begin
		d = ds[i];

		#1ns;

	end

	always @(negedge clk) begin

		if (reset === '1) begin
			if (q !== 0) begin
				$display("Error: q !== '0");
				errors = errors + 1;
			end
		end
		if (reset === '0) begin
			if (q !== ds[i-1]) begin
				$display("Error: q !== ds[i-1]");
				errors = errors + 1;
			end
		end

		if (d === 'x) begin // Cuando ds se indexo fuera de rango
			$display("Total errors: %d", errors);
			$stop;
		end

		i = i+1;
		$display("i = %d", i);
	end
endmodule
