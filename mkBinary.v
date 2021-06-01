//
// Generated by Bluespec Compiler (build 00185f79)
//
// On Mon May 31 20:42:59 IST 2021
//
//
// Ports:
// Name                         I/O  size props
// RDY_a                          O     1 const
// RDY_b                          O     1 const
// RDY__L0In                      O     1 const
// c                              O    16 reg
// RDY_c                          O     1 const
// _L0                            O    32 reg
// RDY__L0                        O     1 const
// RDY_operation                  O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// a__a                           I    16 reg
// b__b                           I    16 reg
// _L0In__l0                      I    16 reg
// _L0In__l1                      I    16 reg
// operation__ox                  I     4 unused
// EN_a                           I     1
// EN_b                           I     1
// EN__L0In                       I     1
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

		a__a,
		EN_a,
		RDY_a,

		b__b,
		EN_b,
		RDY_b,

		_L0In__l0,
		_L0In__l1,
		EN__L0In,
		RDY__L0In,

		c,
		RDY_c,

		_L0,
		RDY__L0,

		operation__ox,
		EN_operation,
		RDY_operation);
  input  CLK;
  input  RST_N;

  // action method a
  input  [15 : 0] a__a;
  input  EN_a;
  output RDY_a;

  // action method b
  input  [15 : 0] b__b;
  input  EN_b;
  output RDY_b;

  // action method _L0In
  input  [15 : 0] _L0In__l0;
  input  [15 : 0] _L0In__l1;
  input  EN__L0In;
  output RDY__L0In;

  // value method c
  output [15 : 0] c;
  output RDY_c;

  // value method _L0
  output [31 : 0] _L0;
  output RDY__L0;

  // action method operation
  input  [3 : 0] operation__ox;
  input  EN_operation;
  output RDY_operation;

  // signals for module outputs
  wire [31 : 0] _L0;
  wire [15 : 0] c;
  wire RDY__L0, RDY__L0In, RDY_a, RDY_b, RDY_c, RDY_operation;

  // register _unnamed_
  reg [15 : 0] _unnamed_;
  wire [15 : 0] _unnamed_$D_IN;
  wire _unnamed_$EN;

  // register _unnamed__1
  reg [15 : 0] _unnamed__1;
  wire [15 : 0] _unnamed__1$D_IN;
  wire _unnamed__1$EN;

  // register _unnamed__1_1
  reg [31 : 0] _unnamed__1_1;
  wire [31 : 0] _unnamed__1_1$D_IN;
  wire _unnamed__1_1$EN;

  // register _unnamed__2
  reg [31 : 0] _unnamed__2;
  wire [31 : 0] _unnamed__2$D_IN;
  wire _unnamed__2$EN;

  // register _unnamed__2_1
  reg [31 : 0] _unnamed__2_1;
  wire [31 : 0] _unnamed__2_1$D_IN;
  wire _unnamed__2_1$EN;

  // register _unnamed__3
  reg [15 : 0] _unnamed__3;
  wire [15 : 0] _unnamed__3$D_IN;
  wire _unnamed__3$EN;

  // register _unnamed__4
  reg [15 : 0] _unnamed__4;
  wire [15 : 0] _unnamed__4$D_IN;
  wire _unnamed__4$EN;

  // register _unnamed__5
  reg [15 : 0] _unnamed__5;
  wire [15 : 0] _unnamed__5$D_IN;
  wire _unnamed__5$EN;

  // register l2
  reg [31 : 0] l2;
  wire [31 : 0] l2$D_IN;
  wire l2$EN;

  // ports of submodule dut
  wire [15 : 0] dut$a, dut$b;
  wire dut$ce;

  // remaining internal signals
  wire [16 : 0] x__h399;
  wire [15 : 0] in1_i__h407, in2_i__h420;
  wire [14 : 0] unnamed_BITS_15_TO_1__q1, unnamed__1_BITS_15_TO_1__q2;

  // action method a
  assign RDY_a = 1'd1 ;

  // action method b
  assign RDY_b = 1'd1 ;

  // action method _L0In
  assign RDY__L0In = 1'd1 ;

  // value method c
  assign c = _unnamed__5 ;
  assign RDY_c = 1'd1 ;

  // value method _L0
  assign _L0 = _unnamed__2_1 ;
  assign RDY__L0 = 1'd1 ;

  // action method operation
  assign RDY_operation = 1'd1 ;

  // submodule dut
  mkmultfinal dut(.clk(CLK), .a(dut$a), .b(dut$b), .ce(dut$ce), .p());

  // register _unnamed_
  assign _unnamed_$D_IN = a__a ;
  assign _unnamed_$EN = EN_a ;

  // register _unnamed__1
  assign _unnamed__1$D_IN = b__b ;
  assign _unnamed__1$EN = EN_b ;

  // register _unnamed__1_1
  assign _unnamed__1_1$D_IN = _unnamed__2 ;
  assign _unnamed__1_1$EN = 1'd1 ;

  // register _unnamed__2
  assign _unnamed__2$D_IN = { _L0In__l1, _L0In__l0 } ;
  assign _unnamed__2$EN = EN__L0In ;

  // register _unnamed__2_1
  assign _unnamed__2_1$D_IN = l2 ;
  assign _unnamed__2_1$EN = 1'd1 ;

  // register _unnamed__3
  assign _unnamed__3$D_IN = x__h399[15:0] ;
  assign _unnamed__3$EN = 1'd1 ;

  // register _unnamed__4
  assign _unnamed__4$D_IN = _unnamed__3 ;
  assign _unnamed__4$EN = 1'd1 ;

  // register _unnamed__5
  assign _unnamed__5$D_IN = _unnamed__4 ;
  assign _unnamed__5$EN = 1'd1 ;

  // register l2
  assign l2$D_IN = _unnamed__1_1 ;
  assign l2$EN = 1'd1 ;

  // submodule dut
  assign dut$a = 16'h0 ;
  assign dut$b = 16'h0 ;
  assign dut$ce = 1'b0 ;

  // remaining internal signals
  assign in1_i__h407 =
	     { unnamed_BITS_15_TO_1__q1[14], unnamed_BITS_15_TO_1__q1 } ;
  assign in2_i__h420 =
	     { unnamed__1_BITS_15_TO_1__q2[14],
	       unnamed__1_BITS_15_TO_1__q2 } ;
  assign unnamed_BITS_15_TO_1__q1 = _unnamed_[15:1] ;
  assign unnamed__1_BITS_15_TO_1__q2 = _unnamed__1[15:1] ;
  assign x__h399 =
	     { in1_i__h407, _unnamed_[0] } + { in2_i__h420, _unnamed__1[0] } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        _unnamed_ <= `BSV_ASSIGNMENT_DELAY 16'd0;
	_unnamed__1 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	_unnamed__3 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	_unnamed__4 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	_unnamed__5 <= `BSV_ASSIGNMENT_DELAY 16'd0;
      end
    else
      begin
        if (_unnamed_$EN) _unnamed_ <= `BSV_ASSIGNMENT_DELAY _unnamed_$D_IN;
	if (_unnamed__1$EN)
	  _unnamed__1 <= `BSV_ASSIGNMENT_DELAY _unnamed__1$D_IN;
	if (_unnamed__3$EN)
	  _unnamed__3 <= `BSV_ASSIGNMENT_DELAY _unnamed__3$D_IN;
	if (_unnamed__4$EN)
	  _unnamed__4 <= `BSV_ASSIGNMENT_DELAY _unnamed__4$D_IN;
	if (_unnamed__5$EN)
	  _unnamed__5 <= `BSV_ASSIGNMENT_DELAY _unnamed__5$D_IN;
      end
    if (_unnamed__1_1$EN)
      _unnamed__1_1 <= `BSV_ASSIGNMENT_DELAY _unnamed__1_1$D_IN;
    if (_unnamed__2$EN) _unnamed__2 <= `BSV_ASSIGNMENT_DELAY _unnamed__2$D_IN;
    if (_unnamed__2_1$EN)
      _unnamed__2_1 <= `BSV_ASSIGNMENT_DELAY _unnamed__2_1$D_IN;
    if (l2$EN) l2 <= `BSV_ASSIGNMENT_DELAY l2$D_IN;
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    _unnamed_ = 16'hAAAA;
    _unnamed__1 = 16'hAAAA;
    _unnamed__1_1 = 32'hAAAAAAAA;
    _unnamed__2 = 32'hAAAAAAAA;
    _unnamed__2_1 = 32'hAAAAAAAA;
    _unnamed__3 = 16'hAAAA;
    _unnamed__4 = 16'hAAAA;
    _unnamed__5 = 16'hAAAA;
    l2 = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkBinary

