//
// Generated by Bluespec Compiler (build 00185f79)
//
// On Sun Jun  6 17:16:44 IST 2021
//
//
// Ports:
// Name                         I/O  size props
// RDY_a_b                        O     1 const
// c                              O    16 reg
// RDY_c                          O     1 const
// RDY_operation                  O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// a_b__a                         I    16
// a_b__b                         I    16
// operation__ox                  I     4 unused
// EN_a_b                         I     1
// EN_operation                   I     1 unused
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkBinary(CLK,
		RST_N,

		a_b__a,
		a_b__b,
		EN_a_b,
		RDY_a_b,

		c,
		RDY_c,

		operation__ox,
		EN_operation,
		RDY_operation);
  input  CLK;
  input  RST_N;

  // action method a_b
  input  [15 : 0] a_b__a;
  input  [15 : 0] a_b__b;
  input  EN_a_b;
  output RDY_a_b;

  // value method c
  output [15 : 0] c;
  output RDY_c;

  // action method operation
  input  [3 : 0] operation__ox;
  input  EN_operation;
  output RDY_operation;

  // signals for module outputs
  wire [15 : 0] c;
  wire RDY_a_b, RDY_c, RDY_operation;

  // register cOut
  reg [15 : 0] cOut;
  wire [15 : 0] cOut$D_IN;
  wire cOut$EN;

  // remaining internal signals
  wire [16 : 0] x__h106;
  wire [15 : 0] in1_i__h114, in2_i__h129;
  wire [14 : 0] a_b__a_BITS_15_TO_1__q1, a_b__b_BITS_15_TO_1__q2;

  // action method a_b
  assign RDY_a_b = 1'd1 ;

  // value method c
  assign c = cOut ;
  assign RDY_c = 1'd1 ;

  // action method operation
  assign RDY_operation = 1'd1 ;

  // register cOut
  assign cOut$D_IN = x__h106[15:0] ;
  assign cOut$EN = EN_a_b ;

  // remaining internal signals
  assign a_b__a_BITS_15_TO_1__q1 = a_b__a[15:1] ;
  assign a_b__b_BITS_15_TO_1__q2 = a_b__b[15:1] ;
  assign in1_i__h114 =
	     { a_b__a_BITS_15_TO_1__q1[14], a_b__a_BITS_15_TO_1__q1 } ;
  assign in2_i__h129 =
	     { a_b__b_BITS_15_TO_1__q2[14], a_b__b_BITS_15_TO_1__q2 } ;
  assign x__h106 = { in1_i__h114, a_b__a[0] } + { in2_i__h129, a_b__b[0] } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        cOut <= `BSV_ASSIGNMENT_DELAY 16'd0;
      end
    else
      begin
        if (cOut$EN) cOut <= `BSV_ASSIGNMENT_DELAY cOut$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    cOut = 16'hAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkBinary

