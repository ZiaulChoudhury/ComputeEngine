//
// Generated by Bluespec Compiler (build 00185f79)
//
// On Thu Jun 17 12:38:01 IST 2021
//
//
// Ports:
// Name                         I/O  size props
// deq                            O   512 reg
// RDY_deq                        O     1 reg
// RDY_enq0                       O     1 reg
// RDY_enq1                       O     1 reg
// RDY_enq2                       O     1 reg
// RDY_enq3                       O     1 reg
// RDY_reset                      O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// enq0_a                         I   512 reg
// enq1_a                         I   512 reg
// enq2_a                         I   512 reg
// enq3_a                         I   512 reg
// reset_scans                    I    32 reg
// EN_enq0                        I     1
// EN_enq1                        I     1
// EN_enq2                        I     1
// EN_enq3                        I     1
// EN_reset                       I     1
// EN_deq                         I     1
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

module mkDrain(CLK,
	       RST_N,

	       EN_deq,
	       deq,
	       RDY_deq,

	       enq0_a,
	       EN_enq0,
	       RDY_enq0,

	       enq1_a,
	       EN_enq1,
	       RDY_enq1,

	       enq2_a,
	       EN_enq2,
	       RDY_enq2,

	       enq3_a,
	       EN_enq3,
	       RDY_enq3,

	       reset_scans,
	       EN_reset,
	       RDY_reset);
  input  CLK;
  input  RST_N;

  // actionvalue method deq
  input  EN_deq;
  output [511 : 0] deq;
  output RDY_deq;

  // action method enq0
  input  [511 : 0] enq0_a;
  input  EN_enq0;
  output RDY_enq0;

  // action method enq1
  input  [511 : 0] enq1_a;
  input  EN_enq1;
  output RDY_enq1;

  // action method enq2
  input  [511 : 0] enq2_a;
  input  EN_enq2;
  output RDY_enq2;

  // action method enq3
  input  [511 : 0] enq3_a;
  input  EN_enq3;
  output RDY_enq3;

  // action method reset
  input  [31 : 0] reset_scans;
  input  EN_reset;
  output RDY_reset;

  // signals for module outputs
  wire [511 : 0] deq;
  wire RDY_deq, RDY_enq0, RDY_enq1, RDY_enq2, RDY_enq3, RDY_reset;

  // inlined wires
  wire [1 : 0] p0_rv$port1__read,
	       p0_rv$port2__read,
	       p1_rv$port1__read,
	       p1_rv$port2__read;
  wire p0_rv$EN_port0__write,
       p0_rv$EN_port1__write,
       p1_rv$EN_port0__write,
       p1_rv$EN_port1__write;

  // register p0_rv
  reg [1 : 0] p0_rv;
  wire [1 : 0] p0_rv$D_IN;
  wire p0_rv$EN;

  // register p1_rv
  reg [1 : 0] p1_rv;
  wire [1 : 0] p1_rv$D_IN;
  wire p1_rv$EN;

  // register shifts_0
  reg [7 : 0] shifts_0;
  wire [7 : 0] shifts_0$D_IN;
  wire shifts_0$EN;

  // register shifts_1
  reg [7 : 0] shifts_1;
  wire [7 : 0] shifts_1$D_IN;
  wire shifts_1$EN;

  // register shifts_2
  reg [7 : 0] shifts_2;
  wire [7 : 0] shifts_2$D_IN;
  wire shifts_2$EN;

  // register shifts_3
  reg [7 : 0] shifts_3;
  wire [7 : 0] shifts_3$D_IN;
  wire shifts_3$EN;

  // register tempF0_0
  reg [511 : 0] tempF0_0;
  wire [511 : 0] tempF0_0$D_IN;
  wire tempF0_0$EN;

  // register tempF0_1
  reg [511 : 0] tempF0_1;
  wire [511 : 0] tempF0_1$D_IN;
  wire tempF0_1$EN;

  // register tempF0_2
  reg [511 : 0] tempF0_2;
  wire [511 : 0] tempF0_2$D_IN;
  wire tempF0_2$EN;

  // register tempF0_3
  reg [511 : 0] tempF0_3;
  wire [511 : 0] tempF0_3$D_IN;
  wire tempF0_3$EN;

  // register tempF1_0
  reg [511 : 0] tempF1_0;
  wire [511 : 0] tempF1_0$D_IN;
  wire tempF1_0$EN;

  // register tempF1_1
  reg [511 : 0] tempF1_1;
  wire [511 : 0] tempF1_1$D_IN;
  wire tempF1_1$EN;

  // ports of submodule inQ_0
  wire [511 : 0] inQ_0$D_IN, inQ_0$D_OUT;
  wire inQ_0$CLR, inQ_0$DEQ, inQ_0$EMPTY_N, inQ_0$ENQ, inQ_0$FULL_N;

  // ports of submodule inQ_1
  wire [511 : 0] inQ_1$D_IN, inQ_1$D_OUT;
  wire inQ_1$CLR, inQ_1$DEQ, inQ_1$EMPTY_N, inQ_1$ENQ, inQ_1$FULL_N;

  // ports of submodule inQ_2
  wire [511 : 0] inQ_2$D_IN, inQ_2$D_OUT;
  wire inQ_2$CLR, inQ_2$DEQ, inQ_2$EMPTY_N, inQ_2$ENQ, inQ_2$FULL_N;

  // ports of submodule inQ_3
  wire [511 : 0] inQ_3$D_IN, inQ_3$D_OUT;
  wire inQ_3$CLR, inQ_3$DEQ, inQ_3$EMPTY_N, inQ_3$ENQ, inQ_3$FULL_N;

  // ports of submodule outQ
  wire [511 : 0] outQ$D_IN, outQ$D_OUT;
  wire outQ$CLR, outQ$DEQ, outQ$EMPTY_N, outQ$ENQ, outQ$FULL_N;

  // remaining internal signals
  wire [15 : 0] x__h2357, x__h2514, x__h2671, x__h2828;

  // actionvalue method deq
  assign deq = outQ$D_OUT ;
  assign RDY_deq = outQ$EMPTY_N ;

  // action method enq0
  assign RDY_enq0 = inQ_0$FULL_N ;

  // action method enq1
  assign RDY_enq1 = inQ_1$FULL_N ;

  // action method enq2
  assign RDY_enq2 = inQ_2$FULL_N ;

  // action method enq3
  assign RDY_enq3 = inQ_3$FULL_N ;

  // action method reset
  assign RDY_reset = 1'd1 ;

  // submodule inQ_0
  FIFO2 #(.width(32'd512), .guarded(1'd1)) inQ_0(.RST(RST_N),
						 .CLK(CLK),
						 .D_IN(inQ_0$D_IN),
						 .ENQ(inQ_0$ENQ),
						 .DEQ(inQ_0$DEQ),
						 .CLR(inQ_0$CLR),
						 .D_OUT(inQ_0$D_OUT),
						 .FULL_N(inQ_0$FULL_N),
						 .EMPTY_N(inQ_0$EMPTY_N));

  // submodule inQ_1
  FIFO2 #(.width(32'd512), .guarded(1'd1)) inQ_1(.RST(RST_N),
						 .CLK(CLK),
						 .D_IN(inQ_1$D_IN),
						 .ENQ(inQ_1$ENQ),
						 .DEQ(inQ_1$DEQ),
						 .CLR(inQ_1$CLR),
						 .D_OUT(inQ_1$D_OUT),
						 .FULL_N(inQ_1$FULL_N),
						 .EMPTY_N(inQ_1$EMPTY_N));

  // submodule inQ_2
  FIFO2 #(.width(32'd512), .guarded(1'd1)) inQ_2(.RST(RST_N),
						 .CLK(CLK),
						 .D_IN(inQ_2$D_IN),
						 .ENQ(inQ_2$ENQ),
						 .DEQ(inQ_2$DEQ),
						 .CLR(inQ_2$CLR),
						 .D_OUT(inQ_2$D_OUT),
						 .FULL_N(inQ_2$FULL_N),
						 .EMPTY_N(inQ_2$EMPTY_N));

  // submodule inQ_3
  FIFO2 #(.width(32'd512), .guarded(1'd1)) inQ_3(.RST(RST_N),
						 .CLK(CLK),
						 .D_IN(inQ_3$D_IN),
						 .ENQ(inQ_3$ENQ),
						 .DEQ(inQ_3$DEQ),
						 .CLR(inQ_3$CLR),
						 .D_OUT(inQ_3$D_OUT),
						 .FULL_N(inQ_3$FULL_N),
						 .EMPTY_N(inQ_3$EMPTY_N));

  // submodule outQ
  FIFO2 #(.width(32'd512), .guarded(1'd1)) outQ(.RST(RST_N),
						.CLK(CLK),
						.D_IN(outQ$D_IN),
						.ENQ(outQ$ENQ),
						.DEQ(outQ$DEQ),
						.CLR(outQ$CLR),
						.D_OUT(outQ$D_OUT),
						.FULL_N(outQ$FULL_N),
						.EMPTY_N(outQ$EMPTY_N));

  // inlined wires
  assign p0_rv$EN_port0__write = p0_rv[1] && !p1_rv$port1__read[1] ;
  assign p0_rv$port1__read = p0_rv$EN_port0__write ? 2'd0 : p0_rv ;
  assign p0_rv$EN_port1__write =
	     !p0_rv$port1__read[1] &&
	     (inQ_0$EMPTY_N || inQ_1$EMPTY_N || inQ_2$EMPTY_N ||
	      inQ_3$EMPTY_N) ;
  assign p0_rv$port2__read =
	     p0_rv$EN_port1__write ? 2'd3 : p0_rv$port1__read ;
  assign p1_rv$EN_port0__write = p1_rv[1] && outQ$FULL_N ;
  assign p1_rv$port1__read = p1_rv$EN_port0__write ? 2'd0 : p1_rv ;
  assign p1_rv$EN_port1__write = p0_rv[1] && !p1_rv$port1__read[1] ;
  assign p1_rv$port2__read =
	     p1_rv$EN_port1__write ? 2'd3 : p1_rv$port1__read ;

  // register p0_rv
  assign p0_rv$D_IN = p0_rv$port2__read ;
  assign p0_rv$EN = 1'b1 ;

  // register p1_rv
  assign p1_rv$D_IN = p1_rv$port2__read ;
  assign p1_rv$EN = 1'b1 ;

  // register shifts_0
  assign shifts_0$D_IN = reset_scans[7:0] ;
  assign shifts_0$EN = EN_reset ;

  // register shifts_1
  assign shifts_1$D_IN = reset_scans[15:8] ;
  assign shifts_1$EN = EN_reset ;

  // register shifts_2
  assign shifts_2$D_IN = reset_scans[23:16] ;
  assign shifts_2$EN = EN_reset ;

  // register shifts_3
  assign shifts_3$D_IN = reset_scans[31:24] ;
  assign shifts_3$EN = EN_reset ;

  // register tempF0_0
  assign tempF0_0$D_IN = inQ_0$D_OUT << x__h2357 ;
  assign tempF0_0$EN = inQ_0$EMPTY_N ;

  // register tempF0_1
  assign tempF0_1$D_IN = inQ_1$D_OUT << x__h2514 ;
  assign tempF0_1$EN = inQ_1$EMPTY_N ;

  // register tempF0_2
  assign tempF0_2$D_IN = inQ_2$D_OUT << x__h2671 ;
  assign tempF0_2$EN = inQ_2$EMPTY_N ;

  // register tempF0_3
  assign tempF0_3$D_IN = inQ_3$D_OUT << x__h2828 ;
  assign tempF0_3$EN = inQ_3$EMPTY_N ;

  // register tempF1_0
  assign tempF1_0$D_IN = tempF0_0 | tempF0_1 ;
  assign tempF1_0$EN = p0_rv[1] && !p1_rv$port1__read[1] ;

  // register tempF1_1
  assign tempF1_1$D_IN = tempF0_2 | tempF0_3 ;
  assign tempF1_1$EN = p0_rv[1] && !p1_rv$port1__read[1] ;

  // submodule inQ_0
  assign inQ_0$D_IN = enq0_a ;
  assign inQ_0$ENQ = EN_enq0 ;
  assign inQ_0$DEQ = inQ_0$EMPTY_N ;
  assign inQ_0$CLR = 1'b0 ;

  // submodule inQ_1
  assign inQ_1$D_IN = enq1_a ;
  assign inQ_1$ENQ = EN_enq1 ;
  assign inQ_1$DEQ = inQ_1$EMPTY_N ;
  assign inQ_1$CLR = 1'b0 ;

  // submodule inQ_2
  assign inQ_2$D_IN = enq2_a ;
  assign inQ_2$ENQ = EN_enq2 ;
  assign inQ_2$DEQ = inQ_2$EMPTY_N ;
  assign inQ_2$CLR = 1'b0 ;

  // submodule inQ_3
  assign inQ_3$D_IN = enq3_a ;
  assign inQ_3$ENQ = EN_enq3 ;
  assign inQ_3$DEQ = inQ_3$EMPTY_N ;
  assign inQ_3$CLR = 1'b0 ;

  // submodule outQ
  assign outQ$D_IN = tempF1_0 | tempF1_1 ;
  assign outQ$ENQ = p1_rv[1] && outQ$FULL_N ;
  assign outQ$DEQ = EN_deq ;
  assign outQ$CLR = 1'b0 ;

  // remaining internal signals
  assign x__h2357 = { 4'd0, shifts_0, 4'd0 } ;
  assign x__h2514 = { 4'd0, shifts_1, 4'd0 } ;
  assign x__h2671 = { 4'd0, shifts_2, 4'd0 } ;
  assign x__h2828 = { 4'd0, shifts_3, 4'd0 } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        p0_rv <= `BSV_ASSIGNMENT_DELAY 2'd0;
	p1_rv <= `BSV_ASSIGNMENT_DELAY 2'd0;
	shifts_0 <= `BSV_ASSIGNMENT_DELAY 8'd0;
	shifts_1 <= `BSV_ASSIGNMENT_DELAY 8'd0;
	shifts_2 <= `BSV_ASSIGNMENT_DELAY 8'd0;
	shifts_3 <= `BSV_ASSIGNMENT_DELAY 8'd0;
	tempF0_0 <= `BSV_ASSIGNMENT_DELAY 512'd0;
	tempF0_1 <= `BSV_ASSIGNMENT_DELAY 512'd0;
	tempF0_2 <= `BSV_ASSIGNMENT_DELAY 512'd0;
	tempF0_3 <= `BSV_ASSIGNMENT_DELAY 512'd0;
	tempF1_0 <= `BSV_ASSIGNMENT_DELAY 512'd0;
	tempF1_1 <= `BSV_ASSIGNMENT_DELAY 512'd0;
      end
    else
      begin
        if (p0_rv$EN) p0_rv <= `BSV_ASSIGNMENT_DELAY p0_rv$D_IN;
	if (p1_rv$EN) p1_rv <= `BSV_ASSIGNMENT_DELAY p1_rv$D_IN;
	if (shifts_0$EN) shifts_0 <= `BSV_ASSIGNMENT_DELAY shifts_0$D_IN;
	if (shifts_1$EN) shifts_1 <= `BSV_ASSIGNMENT_DELAY shifts_1$D_IN;
	if (shifts_2$EN) shifts_2 <= `BSV_ASSIGNMENT_DELAY shifts_2$D_IN;
	if (shifts_3$EN) shifts_3 <= `BSV_ASSIGNMENT_DELAY shifts_3$D_IN;
	if (tempF0_0$EN) tempF0_0 <= `BSV_ASSIGNMENT_DELAY tempF0_0$D_IN;
	if (tempF0_1$EN) tempF0_1 <= `BSV_ASSIGNMENT_DELAY tempF0_1$D_IN;
	if (tempF0_2$EN) tempF0_2 <= `BSV_ASSIGNMENT_DELAY tempF0_2$D_IN;
	if (tempF0_3$EN) tempF0_3 <= `BSV_ASSIGNMENT_DELAY tempF0_3$D_IN;
	if (tempF1_0$EN) tempF1_0 <= `BSV_ASSIGNMENT_DELAY tempF1_0$D_IN;
	if (tempF1_1$EN) tempF1_1 <= `BSV_ASSIGNMENT_DELAY tempF1_1$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    p0_rv = 2'h2;
    p1_rv = 2'h2;
    shifts_0 = 8'hAA;
    shifts_1 = 8'hAA;
    shifts_2 = 8'hAA;
    shifts_3 = 8'hAA;
    tempF0_0 =
	512'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    tempF0_1 =
	512'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    tempF0_2 =
	512'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    tempF0_3 =
	512'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    tempF1_0 =
	512'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    tempF1_1 =
	512'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkDrain

