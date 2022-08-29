`define armarLDUR(inmediato_9) {11'b111_1100_0010, inmediato_9, 12'b00_01001_10110}
`define armarLDUR_res(inmediato_9) {{55{inmediato_9[8]}}, inmediato_9}

`define armarSTUR(inmediato_9) {11'b111_1100_0000, inmediato_9, 12'b00_01001_10110}
`define armarSTUR_res(inmediato_9) {{55{inmediato_9[8]}}, inmediato_9}

`define armarCBZ(inmediato_19) {8'b101_1010_0, inmediato_19, 5'b10110}
`define armarCBZ_res(inmediato_19) {{45{inmediato_19[18]}}, inmediato_19}

module signext_tb();

	logic [8:0] pos_inmediato_9 = 9'b0_1110_0011;
	logic [8:0] neg_inmediato_9 = 9'b1_1110_0011;
	logic [18:0] pos_inmediato_19 = 19'b001_1110_0011_1111_1010;
	logic [18:0] neg_inmediato_19 = 19'b101_1110_0011_1111_1010;


/* 	logic LDUR_pos [31:0] = armarLDUR(pos_inmediato_9);
	logic LDUR_pos_res [63:0] = armarLDUR_res(pos_inmediato_9);

	logic LDUR_neg [31:0] = armarLDUR(neg_inmediato_9);
	logic LDUR_neg_res [63:0] = armarLDUR_res(neg_inmediato_9);

	logic STUR_pos [31:0] = armarSTUR(pos_inmediato_9);
	logic STUR_pos_res [63:0] = armarSTUR_res(pos_inmediato_9);

	logic STUR_neg [31:0] = armarSTUR(neg_inmediato_9);
	logic STUR_neg_res [63:0] = armarSTUR_res(neg_inmediato_9);

	logic CBZ_pos [31:0] = armarCBZ(pos_inmediato_19);
	logic CBZ_pos_res [31:0] = armarCBZ_res(pos_inmediato_19);

	logic CBZ_neg [31:0] = armarCBZ(neg_inmediato_19);
	logic CBZ_neg_res [31:0] = armarCBZ_res(neg_inmediato_19);
*/

	logic [31:0] inputs [5:0] = {
		`armarLDUR(pos_inmediato_9), `armarLDUR(neg_inmediato_9),
		`armarSTUR(pos_inmediato_9), `armarSTUR(neg_inmediato_9),
		`armarCBZ(pos_inmediato_19), `armarCBZ(neg_inmediato_19)
	};

	logic [63:0] expected_outputs [5:0] = {
		`armarLDUR_res(pos_inmediato_9), `armarLDUR_res(neg_inmediato_9),
		`armarSTUR_res(pos_inmediato_9), `armarSTUR_res(neg_inmediato_9),
		`armarCBZ_res(pos_inmediato_19), `armarCBZ_res(neg_inmediato_19)
	};

	logic [31:0] in;
	logic [63:0] out;

	signext dut(in, out);

	logic [31:0] errors;
	always begin
		errors = 0;

		for (int i=0; i<6; ++i) begin
			
			in = inputs[i];
			#1ns;
			if (out !== expected_outputs[i]) begin
				errors = errors + 1;
				$display("ERROR:\n  expected = %d, got = %d\n  in=%b", expected_outputs[i], out, in);
			end
		end
		$display("Total errors: %d", errors);
		$stop;
	end


endmodule
