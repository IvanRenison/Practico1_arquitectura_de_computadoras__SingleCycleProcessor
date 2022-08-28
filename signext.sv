module signext(input logic [31:0] a, output logic [63:0] b);
	always_comb
		case(a[31:21])
			11'b111_1100_0010, // LDUR
				11'b111_1100_0000: // STUR
					b = {{55{a[21]}}, a[20:12]};
			11'b101_1010_0???: // CBZ
					b = {{45{a[23]}}, a[23:5]};
			default: b = 0;
		endcase
endmodule
