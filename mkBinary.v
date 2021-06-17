//
// Generated by Bluespec Compiler (build 00185f79)
//
// On Thu Jun 17 12:38:01 IST 2021
//
//
// Ports:
// Name                         I/O  size props
// RDY_a_b                        O     1 const
// c                              O    16
// RDY_c                          O     1 const
// RDY_set_operation              O     1 const
// get_operation                  O     4 reg
// RDY_get_operation              O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// a_b__a                         I    16
// a_b__b                         I    16
// set_operation__ox              I     4 reg
// EN_a_b                         I     1
// EN_set_operation               I     1
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

		set_operation__ox,
		EN_set_operation,
		RDY_set_operation,

		get_operation,
		RDY_get_operation);
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

  // action method set_operation
  input  [3 : 0] set_operation__ox;
  input  EN_set_operation;
  output RDY_set_operation;

  // value method get_operation
  output [3 : 0] get_operation;
  output RDY_get_operation;

  // signals for module outputs
  wire [15 : 0] c;
  wire [3 : 0] get_operation;
  wire RDY_a_b, RDY_c, RDY_get_operation, RDY_set_operation;

  // register cOut
  reg [15 : 0] cOut;
  reg [15 : 0] cOut$D_IN;
  wire cOut$EN;

  // register op
  reg [3 : 0] op;
  wire [3 : 0] op$D_IN;
  wire op$EN;

  // ports of submodule dut
  wire [31 : 0] dut$p;
  wire [15 : 0] dut$a, dut$b;
  wire dut$ce;

  // remaining internal signals
  wire [16 : 0] x__h262;
  wire [15 : 0] in1_i__h270, in2_i__h285;
  wire [14 : 0] a_b__a_BITS_15_TO_1__q1, a_b__b_BITS_15_TO_1__q2;
  wire a_b__a_SLE_a_b__b___d22;

  // action method a_b
  assign RDY_a_b = 1'd1 ;

  // value method c
  assign c = (op == 4'd2) ? dut$p[16:1] : cOut ;
  assign RDY_c = 1'd1 ;

  // action method set_operation
  assign RDY_set_operation = 1'd1 ;

  // value method get_operation
  assign get_operation = op ;
  assign RDY_get_operation = 1'd1 ;

  // submodule dut
  mkmultfinal dut(.clk(CLK), .a(dut$a), .b(dut$b), .ce(dut$ce), .p(dut$p));

  // register cOut
  always@(op or x__h262 or a_b__a_SLE_a_b__b___d22 or a_b__b or a_b__a)
  begin
    case (op)
      4'd1: cOut$D_IN = x__h262[15:0];
      4'd3: cOut$D_IN = a_b__a_SLE_a_b__b___d22 ? a_b__b : a_b__a;
      4'd4: cOut$D_IN = a_b__a_SLE_a_b__b___d22 ? a_b__a : a_b__b;
      default: cOut$D_IN = 16'd0;
    endcase
  end
  assign cOut$EN =
	     EN_a_b &&
	     (op == 4'd1 || op == 4'd3 || op == 4'd4 || op == 4'd0) ;

  // register op
  assign op$D_IN = set_operation__ox ;
  assign op$EN = EN_set_operation ;

  // submodule dut
  assign dut$a = a_b__a ;
  assign dut$b = a_b__b ;
  assign dut$ce = EN_a_b && op == 4'd2 ;

  // remaining internal signals
  assign a_b__a_BITS_15_TO_1__q1 = a_b__a[15:1] ;
  assign a_b__a_SLE_a_b__b___d22 =
	     (a_b__a ^ 16'h8000) <= (a_b__b ^ 16'h8000) ;
  assign a_b__b_BITS_15_TO_1__q2 = a_b__b[15:1] ;
  assign in1_i__h270 =
	     { a_b__a_BITS_15_TO_1__q1[14], a_b__a_BITS_15_TO_1__q1 } ;
  assign in2_i__h285 =
	     { a_b__b_BITS_15_TO_1__q2[14], a_b__b_BITS_15_TO_1__q2 } ;
  assign x__h262 = { in1_i__h270, a_b__a[0] } + { in2_i__h285, a_b__b[0] } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        cOut <= `BSV_ASSIGNMENT_DELAY 16'd0;
	op <= `BSV_ASSIGNMENT_DELAY 4'd0;
      end
    else
      begin
        if (cOut$EN) cOut <= `BSV_ASSIGNMENT_DELAY cOut$D_IN;
	if (op$EN) op <= `BSV_ASSIGNMENT_DELAY op$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    cOut = 16'hAAAA;
    op = 4'hA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkBinary
