//
// Generated by Bluespec Compiler (build 00185f79)
//
// On Sun Jun 20 02:24:21 IST 2021
//
//
// Ports:
// Name                         I/O  size props
// RDY_put                        O     1 const
// RDY_setIndex                   O     1 const
// get                            O    16 reg
// RDY_get                        O     1 const
// CLK                            I     1 clock
// RST_N                          I     1 reset
// put_inR                        I  1024 reg
// setIndex_inx                   I     6 reg
// EN_put                         I     1
// EN_setIndex                    I     1
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

module mkPermute(CLK,
		 RST_N,

		 put_inR,
		 EN_put,
		 RDY_put,

		 setIndex_inx,
		 EN_setIndex,
		 RDY_setIndex,

		 EN_get,
		 get,
		 RDY_get);
  input  CLK;
  input  RST_N;

  // action method put
  input  [1023 : 0] put_inR;
  input  EN_put;
  output RDY_put;

  // action method setIndex
  input  [5 : 0] setIndex_inx;
  input  EN_setIndex;
  output RDY_setIndex;

  // actionvalue method get
  input  EN_get;
  output [15 : 0] get;
  output RDY_get;

  // signals for module outputs
  wire [15 : 0] get;
  wire RDY_get, RDY_put, RDY_setIndex;

  // register i0
  reg [1023 : 0] i0;
  wire [1023 : 0] i0$D_IN;
  wire i0$EN;

  // register i1
  reg [511 : 0] i1;
  wire [511 : 0] i1$D_IN;
  wire i1$EN;

  // register i2
  reg [255 : 0] i2;
  wire [255 : 0] i2$D_IN;
  wire i2$EN;

  // register i3
  reg [127 : 0] i3;
  wire [127 : 0] i3$D_IN;
  wire i3$EN;

  // register outR
  reg [15 : 0] outR;
  wire [15 : 0] outR$D_IN;
  wire outR$EN;

  // register p0_rv
  reg [1 : 0] p0_rv;
  wire [1 : 0] p0_rv$D_IN;
  wire p0_rv$EN;

  // register p1_rv
  reg [1 : 0] p1_rv;
  wire [1 : 0] p1_rv$D_IN;
  wire p1_rv$EN;

  // register p2_rv
  reg [1 : 0] p2_rv;
  wire [1 : 0] p2_rv$D_IN;
  wire p2_rv$EN;

  // register p3_rv
  reg [1 : 0] p3_rv;
  wire [1 : 0] p3_rv$D_IN;
  wire p3_rv$EN;

  // register p4_rv
  reg [1 : 0] p4_rv;
  wire [1 : 0] p4_rv$D_IN;
  wire p4_rv$EN;

  // register probe
  reg [5 : 0] probe;
  wire [5 : 0] probe$D_IN;
  wire probe$EN;

  // register sft
  reg [6 : 0] sft;
  wire [6 : 0] sft$D_IN;
  wire sft$EN;

  // register stripIndex
  reg [1 : 0] stripIndex;
  wire [1 : 0] stripIndex$D_IN;
  wire stripIndex$EN;

  // remaining internal signals
  wire [127 : 0] x__h30255;
  wire [6 : 0] x__h31329;

  // action method put
  assign RDY_put = 1'd1 ;

  // action method setIndex
  assign RDY_setIndex = 1'd1 ;

  // actionvalue method get
  assign get = outR ;
  assign RDY_get = 1'd1 ;

  // register i0
  assign i0$D_IN = put_inR ;
  assign i0$EN = EN_put ;

  // register i1
  assign i1$D_IN = probe[5] ? i0[1023:512] : i0[511:0] ;
  assign i1$EN = 1'd1 ;

  // register i2
  assign i2$D_IN = probe[4] ? i1[511:256] : i1[255:0] ;
  assign i2$EN = 1'd1 ;

  // register i3
  assign i3$D_IN = probe[3] ? i2[255:128] : i2[127:0] ;
  assign i3$EN = 1'd1 ;

  // register outR
  assign outR$D_IN = x__h30255[15:0] ;
  assign outR$EN = 1'd1 ;

  // register p0_rv
  assign p0_rv$D_IN = p0_rv ;
  assign p0_rv$EN = 1'b1 ;

  // register p1_rv
  assign p1_rv$D_IN = p1_rv ;
  assign p1_rv$EN = 1'b1 ;

  // register p2_rv
  assign p2_rv$D_IN = p2_rv ;
  assign p2_rv$EN = 1'b1 ;

  // register p3_rv
  assign p3_rv$D_IN = p3_rv ;
  assign p3_rv$EN = 1'b1 ;

  // register p4_rv
  assign p4_rv$D_IN = p4_rv ;
  assign p4_rv$EN = 1'b1 ;

  // register probe
  assign probe$D_IN = setIndex_inx ;
  assign probe$EN = EN_setIndex ;

  // register sft
  assign sft$D_IN = { 4'd0, setIndex_inx[2:0] } ;
  assign sft$EN = EN_setIndex ;

  // register stripIndex
  assign stripIndex$D_IN = 2'd0 ;
  assign stripIndex$EN = EN_get ;

  // remaining internal signals
  assign x__h30255 = i3 >> x__h31329 ;
  assign x__h31329 = { sft[2:0], 4'd0 } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        outR <= `BSV_ASSIGNMENT_DELAY 16'd0;
	p0_rv <= `BSV_ASSIGNMENT_DELAY 2'd0;
	p1_rv <= `BSV_ASSIGNMENT_DELAY 2'd0;
	p2_rv <= `BSV_ASSIGNMENT_DELAY 2'd0;
	p3_rv <= `BSV_ASSIGNMENT_DELAY 2'd0;
	p4_rv <= `BSV_ASSIGNMENT_DELAY 2'd0;
	probe <= `BSV_ASSIGNMENT_DELAY 6'd0;
	sft <= `BSV_ASSIGNMENT_DELAY 7'd0;
	stripIndex <= `BSV_ASSIGNMENT_DELAY 2'd0;
      end
    else
      begin
        if (outR$EN) outR <= `BSV_ASSIGNMENT_DELAY outR$D_IN;
	if (p0_rv$EN) p0_rv <= `BSV_ASSIGNMENT_DELAY p0_rv$D_IN;
	if (p1_rv$EN) p1_rv <= `BSV_ASSIGNMENT_DELAY p1_rv$D_IN;
	if (p2_rv$EN) p2_rv <= `BSV_ASSIGNMENT_DELAY p2_rv$D_IN;
	if (p3_rv$EN) p3_rv <= `BSV_ASSIGNMENT_DELAY p3_rv$D_IN;
	if (p4_rv$EN) p4_rv <= `BSV_ASSIGNMENT_DELAY p4_rv$D_IN;
	if (probe$EN) probe <= `BSV_ASSIGNMENT_DELAY probe$D_IN;
	if (sft$EN) sft <= `BSV_ASSIGNMENT_DELAY sft$D_IN;
	if (stripIndex$EN)
	  stripIndex <= `BSV_ASSIGNMENT_DELAY stripIndex$D_IN;
      end
    if (i0$EN) i0 <= `BSV_ASSIGNMENT_DELAY i0$D_IN;
    if (i1$EN) i1 <= `BSV_ASSIGNMENT_DELAY i1$D_IN;
    if (i2$EN) i2 <= `BSV_ASSIGNMENT_DELAY i2$D_IN;
    if (i3$EN) i3 <= `BSV_ASSIGNMENT_DELAY i3$D_IN;
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    i0 =
	1024'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    i1 =
	512'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    i2 =
	256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    i3 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    outR = 16'hAAAA;
    p0_rv = 2'h2;
    p1_rv = 2'h2;
    p2_rv = 2'h2;
    p3_rv = 2'h2;
    p4_rv = 2'h2;
    probe = 6'h2A;
    sft = 7'h2A;
    stripIndex = 2'h2;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkPermute

