//
// Generated by Bluespec Compiler (build 00185f79)
//
// On Mon Jun  7 19:52:16 IST 2021
//
//
// Ports:
// Name                         I/O  size props
// RDY_putFmap                    O     1 reg
// get                            O   512 reg
// RDY_get                        O     1 reg
// RDY_reset                      O     1 const
// RDY_clean                      O     1 const
// RDY_loadShift                  O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// putFmap_datas                  I    16 reg
// reset_imageSize                I     9 reg
// loadShift_inx                  I    16 unused
// EN_putFmap                     I     1
// EN_reset                       I     1
// EN_clean                       I     1
// EN_loadShift                   I     1 unused
// EN_get                         I     1
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

module mkLine3(CLK,
	       RST_N,

	       putFmap_datas,
	       EN_putFmap,
	       RDY_putFmap,

	       EN_get,
	       get,
	       RDY_get,

	       reset_imageSize,
	       EN_reset,
	       RDY_reset,

	       EN_clean,
	       RDY_clean,

	       loadShift_inx,
	       EN_loadShift,
	       RDY_loadShift);
  input  CLK;
  input  RST_N;

  // action method putFmap
  input  [15 : 0] putFmap_datas;
  input  EN_putFmap;
  output RDY_putFmap;

  // actionvalue method get
  input  EN_get;
  output [511 : 0] get;
  output RDY_get;

  // action method reset
  input  [8 : 0] reset_imageSize;
  input  EN_reset;
  output RDY_reset;

  // action method clean
  input  EN_clean;
  output RDY_clean;

  // action method loadShift
  input  [15 : 0] loadShift_inx;
  input  EN_loadShift;
  output RDY_loadShift;

  // signals for module outputs
  wire [511 : 0] get;
  wire RDY_clean, RDY_get, RDY_loadShift, RDY_putFmap, RDY_reset;

  // register alpha
  reg [8 : 0] alpha;
  wire [8 : 0] alpha$D_IN;
  wire alpha$EN;

  // register c1
  reg [8 : 0] c1;
  reg [8 : 0] c1$D_IN;
  wire c1$EN;

  // register c2
  reg [8 : 0] c2;
  wire [8 : 0] c2$D_IN;
  wire c2$EN;

  // register collectWindow
  reg collectWindow;
  wire collectWindow$D_IN, collectWindow$EN;

  // register img
  reg [8 : 0] img;
  wire [8 : 0] img$D_IN;
  wire img$EN;

  // register r1
  reg [8 : 0] r1;
  wire [8 : 0] r1$D_IN;
  wire r1$EN;

  // ports of submodule _unnamed_
  wire [127 : 0] _unnamed_$enQdeQ;
  wire [15 : 0] _unnamed_$enQdeQ_a, _unnamed_$enq_a;
  wire _unnamed_$EN_clean,
       _unnamed_$EN_dummy,
       _unnamed_$EN_enQdeQ,
       _unnamed_$EN_enq,
       _unnamed_$RDY_enQdeQ,
       _unnamed_$RDY_enq;

  // ports of submodule _unnamed__1
  wire [127 : 0] _unnamed__1$enQdeQ;
  wire [15 : 0] _unnamed__1$enQdeQ_a, _unnamed__1$enq_a, _unnamed__1$read;
  wire _unnamed__1$EN_clean,
       _unnamed__1$EN_dummy,
       _unnamed__1$EN_enQdeQ,
       _unnamed__1$EN_enq,
       _unnamed__1$RDY_enQdeQ,
       _unnamed__1$RDY_enq;

  // ports of submodule _unnamed__2
  wire [127 : 0] _unnamed__2$enQdeQ;
  wire [15 : 0] _unnamed__2$enQdeQ_a, _unnamed__2$enq_a, _unnamed__2$read;
  wire _unnamed__2$EN_clean,
       _unnamed__2$EN_dummy,
       _unnamed__2$EN_enQdeQ,
       _unnamed__2$EN_enq,
       _unnamed__2$RDY_enQdeQ,
       _unnamed__2$RDY_enq;

  // ports of submodule _unnamed__3
  wire [15 : 0] _unnamed__3$enQdeQ_a, _unnamed__3$enq_a, _unnamed__3$read;
  wire _unnamed__3$EN_clean,
       _unnamed__3$EN_dummy,
       _unnamed__3$EN_enQdeQ,
       _unnamed__3$EN_enq,
       _unnamed__3$RDY_enQdeQ,
       _unnamed__3$RDY_enq;

  // ports of submodule _unnamed__4
  wire [15 : 0] _unnamed__4$enQdeQ_a, _unnamed__4$enq_a, _unnamed__4$read;
  wire _unnamed__4$EN_clean,
       _unnamed__4$EN_dummy,
       _unnamed__4$EN_enQdeQ,
       _unnamed__4$EN_enq,
       _unnamed__4$RDY_enQdeQ,
       _unnamed__4$RDY_enq;

  // ports of submodule _unnamed__5
  wire [15 : 0] _unnamed__5$enQdeQ_a, _unnamed__5$enq_a, _unnamed__5$read;
  wire _unnamed__5$EN_clean,
       _unnamed__5$EN_dummy,
       _unnamed__5$EN_enQdeQ,
       _unnamed__5$EN_enq,
       _unnamed__5$RDY_enQdeQ,
       _unnamed__5$RDY_enq;

  // ports of submodule _unnamed__6
  wire [15 : 0] _unnamed__6$enQdeQ_a, _unnamed__6$enq_a, _unnamed__6$read;
  wire _unnamed__6$EN_clean,
       _unnamed__6$EN_dummy,
       _unnamed__6$EN_enQdeQ,
       _unnamed__6$EN_enq,
       _unnamed__6$RDY_enQdeQ,
       _unnamed__6$RDY_enq;

  // ports of submodule _unnamed__7
  wire [15 : 0] _unnamed__7$enQdeQ_a, _unnamed__7$enq_a, _unnamed__7$read;
  wire _unnamed__7$EN_clean,
       _unnamed__7$EN_dummy,
       _unnamed__7$EN_enQdeQ,
       _unnamed__7$EN_enq,
       _unnamed__7$RDY_enQdeQ,
       _unnamed__7$RDY_enq;

  // ports of submodule instream
  wire [15 : 0] instream$D_IN, instream$D_OUT;
  wire instream$CLR,
       instream$DEQ,
       instream$EMPTY_N,
       instream$ENQ,
       instream$FULL_N;

  // ports of submodule outQ
  wire [1023 : 0] outQ$D_IN, outQ$D_OUT;
  wire outQ$CLR, outQ$DEQ, outQ$EMPTY_N, outQ$ENQ, outQ$FULL_N;

  // rule scheduling signals
  wire WILL_FIRE_RL__putDataInLB0, WILL_FIRE_RL__serialShiftLeft;

  // inputs to muxes for submodule ports
  wire [8 : 0] MUX_c1$write_1__VAL_2, MUX_r1$write_1__VAL_2;

  // remaining internal signals
  wire c1_1_EQ_img_2_MINUS_1_3___d24,
       r1_7_ULT_7___d28,
       unnamed__1_RDY_enq_AND_unnamed__2_RDY_enq_AND__ETC___d15,
       unnamed__3_RDY_enQdeQ__5_AND_unnamed__4_RDY_en_ETC___d56;

  // action method putFmap
  assign RDY_putFmap = instream$FULL_N ;

  // actionvalue method get
  assign get = outQ$D_OUT[511:0] ;
  assign RDY_get = outQ$EMPTY_N ;

  // action method reset
  assign RDY_reset = 1'd1 ;

  // action method clean
  assign RDY_clean = 1'd1 ;

  // action method loadShift
  assign RDY_loadShift = 1'd1 ;

  // submodule _unnamed_
  mkCacheFIFOF _unnamed_(.CLK(CLK),
			 .RST_N(RST_N),
			 .enQdeQ_a(_unnamed_$enQdeQ_a),
			 .enq_a(_unnamed_$enq_a),
			 .EN_enq(_unnamed_$EN_enq),
			 .EN_enQdeQ(_unnamed_$EN_enQdeQ),
			 .EN_clean(_unnamed_$EN_clean),
			 .EN_dummy(_unnamed_$EN_dummy),
			 .RDY_enq(_unnamed_$RDY_enq),
			 .enQdeQ(_unnamed_$enQdeQ),
			 .RDY_enQdeQ(_unnamed_$RDY_enQdeQ),
			 .read(),
			 .RDY_read(),
			 .RDY_clean(),
			 .RDY_dummy());

  // submodule _unnamed__1
  mkCacheFIFOF _unnamed__1(.CLK(CLK),
			   .RST_N(RST_N),
			   .enQdeQ_a(_unnamed__1$enQdeQ_a),
			   .enq_a(_unnamed__1$enq_a),
			   .EN_enq(_unnamed__1$EN_enq),
			   .EN_enQdeQ(_unnamed__1$EN_enQdeQ),
			   .EN_clean(_unnamed__1$EN_clean),
			   .EN_dummy(_unnamed__1$EN_dummy),
			   .RDY_enq(_unnamed__1$RDY_enq),
			   .enQdeQ(_unnamed__1$enQdeQ),
			   .RDY_enQdeQ(_unnamed__1$RDY_enQdeQ),
			   .read(_unnamed__1$read),
			   .RDY_read(),
			   .RDY_clean(),
			   .RDY_dummy());

  // submodule _unnamed__2
  mkCacheFIFOF _unnamed__2(.CLK(CLK),
			   .RST_N(RST_N),
			   .enQdeQ_a(_unnamed__2$enQdeQ_a),
			   .enq_a(_unnamed__2$enq_a),
			   .EN_enq(_unnamed__2$EN_enq),
			   .EN_enQdeQ(_unnamed__2$EN_enQdeQ),
			   .EN_clean(_unnamed__2$EN_clean),
			   .EN_dummy(_unnamed__2$EN_dummy),
			   .RDY_enq(_unnamed__2$RDY_enq),
			   .enQdeQ(_unnamed__2$enQdeQ),
			   .RDY_enQdeQ(_unnamed__2$RDY_enQdeQ),
			   .read(_unnamed__2$read),
			   .RDY_read(),
			   .RDY_clean(),
			   .RDY_dummy());

  // submodule _unnamed__3
  mkCacheFIFOF _unnamed__3(.CLK(CLK),
			   .RST_N(RST_N),
			   .enQdeQ_a(_unnamed__3$enQdeQ_a),
			   .enq_a(_unnamed__3$enq_a),
			   .EN_enq(_unnamed__3$EN_enq),
			   .EN_enQdeQ(_unnamed__3$EN_enQdeQ),
			   .EN_clean(_unnamed__3$EN_clean),
			   .EN_dummy(_unnamed__3$EN_dummy),
			   .RDY_enq(_unnamed__3$RDY_enq),
			   .enQdeQ(),
			   .RDY_enQdeQ(_unnamed__3$RDY_enQdeQ),
			   .read(_unnamed__3$read),
			   .RDY_read(),
			   .RDY_clean(),
			   .RDY_dummy());

  // submodule _unnamed__4
  mkCacheFIFOF _unnamed__4(.CLK(CLK),
			   .RST_N(RST_N),
			   .enQdeQ_a(_unnamed__4$enQdeQ_a),
			   .enq_a(_unnamed__4$enq_a),
			   .EN_enq(_unnamed__4$EN_enq),
			   .EN_enQdeQ(_unnamed__4$EN_enQdeQ),
			   .EN_clean(_unnamed__4$EN_clean),
			   .EN_dummy(_unnamed__4$EN_dummy),
			   .RDY_enq(_unnamed__4$RDY_enq),
			   .enQdeQ(),
			   .RDY_enQdeQ(_unnamed__4$RDY_enQdeQ),
			   .read(_unnamed__4$read),
			   .RDY_read(),
			   .RDY_clean(),
			   .RDY_dummy());

  // submodule _unnamed__5
  mkCacheFIFOF _unnamed__5(.CLK(CLK),
			   .RST_N(RST_N),
			   .enQdeQ_a(_unnamed__5$enQdeQ_a),
			   .enq_a(_unnamed__5$enq_a),
			   .EN_enq(_unnamed__5$EN_enq),
			   .EN_enQdeQ(_unnamed__5$EN_enQdeQ),
			   .EN_clean(_unnamed__5$EN_clean),
			   .EN_dummy(_unnamed__5$EN_dummy),
			   .RDY_enq(_unnamed__5$RDY_enq),
			   .enQdeQ(),
			   .RDY_enQdeQ(_unnamed__5$RDY_enQdeQ),
			   .read(_unnamed__5$read),
			   .RDY_read(),
			   .RDY_clean(),
			   .RDY_dummy());

  // submodule _unnamed__6
  mkCacheFIFOF _unnamed__6(.CLK(CLK),
			   .RST_N(RST_N),
			   .enQdeQ_a(_unnamed__6$enQdeQ_a),
			   .enq_a(_unnamed__6$enq_a),
			   .EN_enq(_unnamed__6$EN_enq),
			   .EN_enQdeQ(_unnamed__6$EN_enQdeQ),
			   .EN_clean(_unnamed__6$EN_clean),
			   .EN_dummy(_unnamed__6$EN_dummy),
			   .RDY_enq(_unnamed__6$RDY_enq),
			   .enQdeQ(),
			   .RDY_enQdeQ(_unnamed__6$RDY_enQdeQ),
			   .read(_unnamed__6$read),
			   .RDY_read(),
			   .RDY_clean(),
			   .RDY_dummy());

  // submodule _unnamed__7
  mkCacheFIFOF _unnamed__7(.CLK(CLK),
			   .RST_N(RST_N),
			   .enQdeQ_a(_unnamed__7$enQdeQ_a),
			   .enq_a(_unnamed__7$enq_a),
			   .EN_enq(_unnamed__7$EN_enq),
			   .EN_enQdeQ(_unnamed__7$EN_enQdeQ),
			   .EN_clean(_unnamed__7$EN_clean),
			   .EN_dummy(_unnamed__7$EN_dummy),
			   .RDY_enq(_unnamed__7$RDY_enq),
			   .enQdeQ(),
			   .RDY_enQdeQ(_unnamed__7$RDY_enQdeQ),
			   .read(_unnamed__7$read),
			   .RDY_read(),
			   .RDY_clean(),
			   .RDY_dummy());

  // submodule instream
  FIFO2 #(.width(32'd16), .guarded(1'd1)) instream(.RST(RST_N),
						   .CLK(CLK),
						   .D_IN(instream$D_IN),
						   .ENQ(instream$ENQ),
						   .DEQ(instream$DEQ),
						   .CLR(instream$CLR),
						   .D_OUT(instream$D_OUT),
						   .FULL_N(instream$FULL_N),
						   .EMPTY_N(instream$EMPTY_N));

  // submodule outQ
  FIFO2 #(.width(32'd1024), .guarded(1'd1)) outQ(.RST(RST_N),
						 .CLK(CLK),
						 .D_IN(outQ$D_IN),
						 .ENQ(outQ$ENQ),
						 .DEQ(outQ$DEQ),
						 .CLR(outQ$CLR),
						 .D_OUT(outQ$D_OUT),
						 .FULL_N(outQ$FULL_N),
						 .EMPTY_N(outQ$EMPTY_N));

  // rule RL__putDataInLB0
  assign WILL_FIRE_RL__putDataInLB0 =
	     instream$EMPTY_N && _unnamed_$RDY_enq &&
	     unnamed__1_RDY_enq_AND_unnamed__2_RDY_enq_AND__ETC___d15 &&
	     !collectWindow ;

  // rule RL__serialShiftLeft
  assign WILL_FIRE_RL__serialShiftLeft =
	     _unnamed_$RDY_enQdeQ && _unnamed__1$RDY_enQdeQ &&
	     _unnamed__2$RDY_enQdeQ &&
	     unnamed__3_RDY_enQdeQ__5_AND_unnamed__4_RDY_en_ETC___d56 &&
	     collectWindow ;

  // inputs to muxes for submodule ports
  assign MUX_c1$write_1__VAL_2 =
	     c1_1_EQ_img_2_MINUS_1_3___d24 ? 9'd0 : c1 + 9'd1 ;
  assign MUX_r1$write_1__VAL_2 = r1 + 9'd1 ;

  // register alpha
  assign alpha$D_IN = 9'h0 ;
  assign alpha$EN = 1'b0 ;

  // register c1
  always@(EN_clean or
	  WILL_FIRE_RL__serialShiftLeft or
	  MUX_c1$write_1__VAL_2 or WILL_FIRE_RL__putDataInLB0)
  case (1'b1)
    EN_clean: c1$D_IN = 9'd0;
    WILL_FIRE_RL__serialShiftLeft: c1$D_IN = MUX_c1$write_1__VAL_2;
    WILL_FIRE_RL__putDataInLB0: c1$D_IN = MUX_c1$write_1__VAL_2;
    default: c1$D_IN = 9'b010101010 /* unspecified value */ ;
  endcase
  assign c1$EN =
	     WILL_FIRE_RL__serialShiftLeft || WILL_FIRE_RL__putDataInLB0 ||
	     EN_clean ;

  // register c2
  assign c2$D_IN = 9'd0 ;
  assign c2$EN = EN_clean ;

  // register collectWindow
  assign collectWindow$D_IN = !EN_clean ;
  assign collectWindow$EN =
	     WILL_FIRE_RL__putDataInLB0 && c1_1_EQ_img_2_MINUS_1_3___d24 &&
	     !r1_7_ULT_7___d28 ||
	     EN_clean ;

  // register img
  assign img$D_IN = reset_imageSize ;
  assign img$EN = EN_reset ;

  // register r1
  assign r1$D_IN = EN_clean ? 9'd0 : MUX_r1$write_1__VAL_2 ;
  assign r1$EN =
	     WILL_FIRE_RL__putDataInLB0 && c1_1_EQ_img_2_MINUS_1_3___d24 &&
	     r1_7_ULT_7___d28 ||
	     EN_clean ;

  // submodule _unnamed_
  assign _unnamed_$enQdeQ_a =
	     (r1 == 9'd0) ? instream$D_OUT : _unnamed__1$read ;
  assign _unnamed_$enq_a = instream$D_OUT ;
  assign _unnamed_$EN_enq = WILL_FIRE_RL__putDataInLB0 && r1 == 9'd0 ;
  assign _unnamed_$EN_enQdeQ = WILL_FIRE_RL__serialShiftLeft ;
  assign _unnamed_$EN_clean = EN_clean ;
  assign _unnamed_$EN_dummy = 1'b0 ;

  // submodule _unnamed__1
  assign _unnamed__1$enQdeQ_a =
	     (r1 == 9'd1) ? instream$D_OUT : _unnamed__2$read ;
  assign _unnamed__1$enq_a = instream$D_OUT ;
  assign _unnamed__1$EN_enq = WILL_FIRE_RL__putDataInLB0 && r1 == 9'd1 ;
  assign _unnamed__1$EN_enQdeQ = WILL_FIRE_RL__serialShiftLeft ;
  assign _unnamed__1$EN_clean = EN_clean ;
  assign _unnamed__1$EN_dummy = 1'b0 ;

  // submodule _unnamed__2
  assign _unnamed__2$enQdeQ_a =
	     (r1 == 9'd2) ? instream$D_OUT : _unnamed__3$read ;
  assign _unnamed__2$enq_a = instream$D_OUT ;
  assign _unnamed__2$EN_enq = WILL_FIRE_RL__putDataInLB0 && r1 == 9'd2 ;
  assign _unnamed__2$EN_enQdeQ = WILL_FIRE_RL__serialShiftLeft ;
  assign _unnamed__2$EN_clean = EN_clean ;
  assign _unnamed__2$EN_dummy = 1'b0 ;

  // submodule _unnamed__3
  assign _unnamed__3$enQdeQ_a =
	     (r1 == 9'd3) ? instream$D_OUT : _unnamed__4$read ;
  assign _unnamed__3$enq_a = instream$D_OUT ;
  assign _unnamed__3$EN_enq = WILL_FIRE_RL__putDataInLB0 && r1 == 9'd3 ;
  assign _unnamed__3$EN_enQdeQ = WILL_FIRE_RL__serialShiftLeft ;
  assign _unnamed__3$EN_clean = EN_clean ;
  assign _unnamed__3$EN_dummy = 1'b0 ;

  // submodule _unnamed__4
  assign _unnamed__4$enQdeQ_a =
	     (r1 == 9'd4) ? instream$D_OUT : _unnamed__5$read ;
  assign _unnamed__4$enq_a = instream$D_OUT ;
  assign _unnamed__4$EN_enq = WILL_FIRE_RL__putDataInLB0 && r1 == 9'd4 ;
  assign _unnamed__4$EN_enQdeQ = WILL_FIRE_RL__serialShiftLeft ;
  assign _unnamed__4$EN_clean = EN_clean ;
  assign _unnamed__4$EN_dummy = 1'b0 ;

  // submodule _unnamed__5
  assign _unnamed__5$enQdeQ_a =
	     (r1 == 9'd5) ? instream$D_OUT : _unnamed__6$read ;
  assign _unnamed__5$enq_a = instream$D_OUT ;
  assign _unnamed__5$EN_enq = WILL_FIRE_RL__putDataInLB0 && r1 == 9'd5 ;
  assign _unnamed__5$EN_enQdeQ = WILL_FIRE_RL__serialShiftLeft ;
  assign _unnamed__5$EN_clean = EN_clean ;
  assign _unnamed__5$EN_dummy = 1'b0 ;

  // submodule _unnamed__6
  assign _unnamed__6$enQdeQ_a =
	     (r1 == 9'd6) ? instream$D_OUT : _unnamed__7$read ;
  assign _unnamed__6$enq_a = instream$D_OUT ;
  assign _unnamed__6$EN_enq = WILL_FIRE_RL__putDataInLB0 && r1 == 9'd6 ;
  assign _unnamed__6$EN_enQdeQ = WILL_FIRE_RL__serialShiftLeft ;
  assign _unnamed__6$EN_clean = EN_clean ;
  assign _unnamed__6$EN_dummy = 1'b0 ;

  // submodule _unnamed__7
  assign _unnamed__7$enQdeQ_a =
	     { (r1 == 9'd7) ? instream$D_OUT[15:1] : 15'd0,
	       r1 == 9'd7 && instream$D_OUT[0] } ;
  assign _unnamed__7$enq_a = instream$D_OUT ;
  assign _unnamed__7$EN_enq = WILL_FIRE_RL__putDataInLB0 && r1 == 9'd7 ;
  assign _unnamed__7$EN_enQdeQ = WILL_FIRE_RL__serialShiftLeft ;
  assign _unnamed__7$EN_clean = EN_clean ;
  assign _unnamed__7$EN_dummy = 1'b0 ;

  // submodule instream
  assign instream$D_IN = putFmap_datas ;
  assign instream$ENQ = EN_putFmap ;
  assign instream$DEQ =
	     WILL_FIRE_RL__serialShiftLeft || WILL_FIRE_RL__putDataInLB0 ;
  assign instream$CLR = EN_clean ;

  // submodule outQ
  assign outQ$D_IN =
	     { 800'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
	       _unnamed__2$enQdeQ,
	       _unnamed__1$enQdeQ[47:0],
	       _unnamed_$enQdeQ[47:0] } ;
  assign outQ$ENQ =
	     WILL_FIRE_RL__serialShiftLeft && c1 < img - (alpha - 9'd1) ;
  assign outQ$DEQ = EN_get ;
  assign outQ$CLR = EN_clean ;

  // remaining internal signals
  assign c1_1_EQ_img_2_MINUS_1_3___d24 = c1 == img - 9'd1 ;
  assign r1_7_ULT_7___d28 = r1 < 9'd7 ;
  assign unnamed__1_RDY_enq_AND_unnamed__2_RDY_enq_AND__ETC___d15 =
	     _unnamed__1$RDY_enq && _unnamed__2$RDY_enq &&
	     _unnamed__3$RDY_enq &&
	     _unnamed__4$RDY_enq &&
	     _unnamed__5$RDY_enq &&
	     _unnamed__6$RDY_enq &&
	     _unnamed__7$RDY_enq ;
  assign unnamed__3_RDY_enQdeQ__5_AND_unnamed__4_RDY_en_ETC___d56 =
	     _unnamed__3$RDY_enQdeQ && _unnamed__4$RDY_enQdeQ &&
	     _unnamed__5$RDY_enQdeQ &&
	     _unnamed__6$RDY_enQdeQ &&
	     _unnamed__7$RDY_enQdeQ &&
	     instream$EMPTY_N &&
	     outQ$FULL_N ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        alpha <= `BSV_ASSIGNMENT_DELAY 9'd8;
	c1 <= `BSV_ASSIGNMENT_DELAY 9'd0;
	c2 <= `BSV_ASSIGNMENT_DELAY 9'd0;
	collectWindow <= `BSV_ASSIGNMENT_DELAY 1'd0;
	img <= `BSV_ASSIGNMENT_DELAY 9'd21;
	r1 <= `BSV_ASSIGNMENT_DELAY 9'd0;
      end
    else
      begin
        if (alpha$EN) alpha <= `BSV_ASSIGNMENT_DELAY alpha$D_IN;
	if (c1$EN) c1 <= `BSV_ASSIGNMENT_DELAY c1$D_IN;
	if (c2$EN) c2 <= `BSV_ASSIGNMENT_DELAY c2$D_IN;
	if (collectWindow$EN)
	  collectWindow <= `BSV_ASSIGNMENT_DELAY collectWindow$D_IN;
	if (img$EN) img <= `BSV_ASSIGNMENT_DELAY img$D_IN;
	if (r1$EN) r1 <= `BSV_ASSIGNMENT_DELAY r1$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    alpha = 9'h0AA;
    c1 = 9'h0AA;
    c2 = 9'h0AA;
    collectWindow = 1'h0;
    img = 9'h0AA;
    r1 = 9'h0AA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkLine3

