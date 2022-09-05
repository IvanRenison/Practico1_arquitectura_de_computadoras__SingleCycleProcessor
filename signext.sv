module signext(input logic [31:0] a, output logic [63:0] y);
	always_comb
		casez(a[31:21])
			11'b111_1100_0010, // LDUR
				11'b111_1100_0000: // STUR
					y = {{55{a[20]}}, a[20:12]};
			11'b101_1010_0???: // CBZ
					y = {{45{a[23]}}, a[23:5]};
			default: y = 0;
		endcase
endmodule
