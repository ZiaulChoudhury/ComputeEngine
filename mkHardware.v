//
// Generated by Bluespec Compiler (build 00185f79)
//
// On Sun Jun 20 02:24:46 IST 2021
//
//
// Ports:
// Name                         I/O  size props
// get                            O    32 reg
// RDY_get                        O     1 reg
// RDY_put                        O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// put_datas                      I   512 reg
// EN_put                         I     1
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

module mkHardware(CLK,
		  RST_N,

		  EN_get,
		  get,
		  RDY_get,

		  put_datas,
		  EN_put,
		  RDY_put);
  input  CLK;
  input  RST_N;

  // actionvalue method get
  input  EN_get;
  output [31 : 0] get;
  output RDY_get;

  // action method put
  input  [511 : 0] put_datas;
  input  EN_put;
  output RDY_put;

  // signals for module outputs
  wire [31 : 0] get;
  wire RDY_get, RDY_put;

  // register cfgCntr
  reg [19 : 0] cfgCntr;
  wire [19 : 0] cfgCntr$D_IN;
  wire cfgCntr$EN;

  // register drI_0
  reg [1 : 0] drI_0;
  wire [1 : 0] drI_0$D_IN;
  wire drI_0$EN;

  // register drI_1
  reg [1 : 0] drI_1;
  wire [1 : 0] drI_1$D_IN;
  wire drI_1$EN;

  // register drI_2
  reg [1 : 0] drI_2;
  wire [1 : 0] drI_2$D_IN;
  wire drI_2$EN;

  // register drI_3
  reg [1 : 0] drI_3;
  wire [1 : 0] drI_3$D_IN;
  wire drI_3$EN;

  // register drO_0
  reg [1 : 0] drO_0;
  wire [1 : 0] drO_0$D_IN;
  wire drO_0$EN;

  // register drO_1
  reg [1 : 0] drO_1;
  wire [1 : 0] drO_1$D_IN;
  wire drO_1$EN;

  // register drO_2
  reg [1 : 0] drO_2;
  wire [1 : 0] drO_2$D_IN;
  wire drO_2$EN;

  // register drO_3
  reg [1 : 0] drO_3;
  wire [1 : 0] drO_3$D_IN;
  wire drO_3$EN;

  // ports of submodule drain
  wire [511 : 0] drain$deq,
		 drain$enq0_a,
		 drain$enq1_a,
		 drain$enq2_a,
		 drain$enq3_a;
  wire [31 : 0] drain$reset_scans;
  wire drain$EN_deq,
       drain$EN_enq0,
       drain$EN_enq1,
       drain$EN_enq2,
       drain$EN_enq3,
       drain$EN_reset,
       drain$RDY_deq,
       drain$RDY_enq0,
       drain$RDY_enq1,
       drain$RDY_enq2,
       drain$RDY_enq3;

  // ports of submodule fQ0
  wire [511 : 0] fQ0$D_IN, fQ0$D_OUT;
  wire fQ0$CLR, fQ0$DEQ, fQ0$EMPTY_N, fQ0$ENQ, fQ0$FULL_N;

  // ports of submodule fQ1
  wire [511 : 0] fQ1$D_IN, fQ1$D_OUT;
  wire fQ1$CLR, fQ1$DEQ, fQ1$EMPTY_N, fQ1$ENQ, fQ1$FULL_N;

  // ports of submodule fQ2
  wire [511 : 0] fQ2$D_IN, fQ2$D_OUT;
  wire fQ2$CLR, fQ2$DEQ, fQ2$EMPTY_N, fQ2$ENQ, fQ2$FULL_N;

  // ports of submodule fQ3
  wire [511 : 0] fQ3$D_IN, fQ3$D_OUT;
  wire fQ3$CLR, fQ3$DEQ, fQ3$EMPTY_N, fQ3$ENQ, fQ3$FULL_N;

  // ports of submodule pe0
  wire [511 : 0] pe0$get, pe0$put_datas;
  wire [15 : 0] pe0$loadConfig_inx;
  wire pe0$EN_get, pe0$EN_loadConfig, pe0$EN_put, pe0$RDY_get, pe0$RDY_put;

  // ports of submodule pe1
  wire [511 : 0] pe1$get, pe1$put_datas;
  wire [15 : 0] pe1$loadConfig_inx;
  wire pe1$EN_get, pe1$EN_loadConfig, pe1$EN_put, pe1$RDY_get, pe1$RDY_put;

  // ports of submodule pe2
  wire [511 : 0] pe2$get, pe2$put_datas;
  wire [15 : 0] pe2$loadConfig_inx;
  wire pe2$EN_get, pe2$EN_loadConfig, pe2$EN_put, pe2$RDY_get, pe2$RDY_put;

  // ports of submodule pe3
  wire [511 : 0] pe3$get, pe3$put_datas;
  wire [15 : 0] pe3$loadConfig_inx;
  wire pe3$EN_get, pe3$EN_loadConfig, pe3$EN_put, pe3$RDY_get, pe3$RDY_put;

  // rule scheduling signals
  wire WILL_FIRE_RL_in_P1,
       WILL_FIRE_RL_in_P2,
       WILL_FIRE_RL_in_P3,
       WILL_FIRE_RL_out_P0,
       WILL_FIRE_RL_out_P0_P1,
       WILL_FIRE_RL_out_P0_P1_O,
       WILL_FIRE_RL_out_P1,
       WILL_FIRE_RL_out_P1_P2,
       WILL_FIRE_RL_out_P1_P2_O,
       WILL_FIRE_RL_out_P2,
       WILL_FIRE_RL_out_P2_P3,
       WILL_FIRE_RL_out_P2_P3_O;

  // inputs to muxes for submodule ports
  wire MUX_pe1$put_1__SEL_1, MUX_pe2$put_1__SEL_1, MUX_pe3$put_1__SEL_1;

  // remaining internal signals
  wire NOT_cfgCntr_3_ULT_207_4_6_AND_NOT_cfgCntr_3_UL_ETC___d129,
       NOT_cfgCntr_3_ULT_207_4_6_AND_NOT_cfgCntr_3_UL_ETC___d137,
       NOT_cfgCntr_3_ULT_414_7_9_AND_NOT_cfgCntr_3_UL_ETC___d112,
       NOT_cfgCntr_3_ULT_621_00_03_AND_NOT_cfgCntr_3__ETC___d119,
       cfgCntr_3_ULT_207___d94,
       cfgCntr_3_ULT_414___d97,
       cfgCntr_3_ULT_621___d100,
       cfgCntr_3_ULT_828___d104,
       cfgCntr_3_ULT_832___d109,
       cfgCntr_3_ULT_836___d116,
       cfgCntr_3_ULT_837___d123;

  // actionvalue method get
  assign get = drain$deq[31:0] ;
  assign RDY_get = drain$RDY_deq ;

  // action method put
  assign RDY_put = fQ0$FULL_N && fQ1$FULL_N && fQ2$FULL_N && fQ3$FULL_N ;

  // submodule drain
  mkDrain drain(.CLK(CLK),
		.RST_N(RST_N),
		.enq0_a(drain$enq0_a),
		.enq1_a(drain$enq1_a),
		.enq2_a(drain$enq2_a),
		.enq3_a(drain$enq3_a),
		.reset_scans(drain$reset_scans),
		.EN_deq(drain$EN_deq),
		.EN_enq0(drain$EN_enq0),
		.EN_enq1(drain$EN_enq1),
		.EN_enq2(drain$EN_enq2),
		.EN_enq3(drain$EN_enq3),
		.EN_reset(drain$EN_reset),
		.deq(drain$deq),
		.RDY_deq(drain$RDY_deq),
		.RDY_enq0(drain$RDY_enq0),
		.RDY_enq1(drain$RDY_enq1),
		.RDY_enq2(drain$RDY_enq2),
		.RDY_enq3(drain$RDY_enq3),
		.RDY_reset());

  // submodule fQ0
  FIFO2 #(.width(32'd512), .guarded(1'd1)) fQ0(.RST(RST_N),
					       .CLK(CLK),
					       .D_IN(fQ0$D_IN),
					       .ENQ(fQ0$ENQ),
					       .DEQ(fQ0$DEQ),
					       .CLR(fQ0$CLR),
					       .D_OUT(fQ0$D_OUT),
					       .FULL_N(fQ0$FULL_N),
					       .EMPTY_N(fQ0$EMPTY_N));

  // submodule fQ1
  FIFO2 #(.width(32'd512), .guarded(1'd1)) fQ1(.RST(RST_N),
					       .CLK(CLK),
					       .D_IN(fQ1$D_IN),
					       .ENQ(fQ1$ENQ),
					       .DEQ(fQ1$DEQ),
					       .CLR(fQ1$CLR),
					       .D_OUT(fQ1$D_OUT),
					       .FULL_N(fQ1$FULL_N),
					       .EMPTY_N(fQ1$EMPTY_N));

  // submodule fQ2
  FIFO2 #(.width(32'd512), .guarded(1'd1)) fQ2(.RST(RST_N),
					       .CLK(CLK),
					       .D_IN(fQ2$D_IN),
					       .ENQ(fQ2$ENQ),
					       .DEQ(fQ2$DEQ),
					       .CLR(fQ2$CLR),
					       .D_OUT(fQ2$D_OUT),
					       .FULL_N(fQ2$FULL_N),
					       .EMPTY_N(fQ2$EMPTY_N));

  // submodule fQ3
  FIFO2 #(.width(32'd512), .guarded(1'd1)) fQ3(.RST(RST_N),
					       .CLK(CLK),
					       .D_IN(fQ3$D_IN),
					       .ENQ(fQ3$ENQ),
					       .DEQ(fQ3$DEQ),
					       .CLR(fQ3$CLR),
					       .D_OUT(fQ3$D_OUT),
					       .FULL_N(fQ3$FULL_N),
					       .EMPTY_N(fQ3$EMPTY_N));

  // submodule pe0
  mkPECore pe0(.CLK(CLK),
	       .RST_N(RST_N),
	       .loadConfig_inx(pe0$loadConfig_inx),
	       .put_datas(pe0$put_datas),
	       .EN_put(pe0$EN_put),
	       .EN_get(pe0$EN_get),
	       .EN_loadConfig(pe0$EN_loadConfig),
	       .RDY_put(pe0$RDY_put),
	       .get(pe0$get),
	       .RDY_get(pe0$RDY_get),
	       .RDY_loadConfig());

  // submodule pe1
  mkPECore pe1(.CLK(CLK),
	       .RST_N(RST_N),
	       .loadConfig_inx(pe1$loadConfig_inx),
	       .put_datas(pe1$put_datas),
	       .EN_put(pe1$EN_put),
	       .EN_get(pe1$EN_get),
	       .EN_loadConfig(pe1$EN_loadConfig),
	       .RDY_put(pe1$RDY_put),
	       .get(pe1$get),
	       .RDY_get(pe1$RDY_get),
	       .RDY_loadConfig());

  // submodule pe2
  mkPECore pe2(.CLK(CLK),
	       .RST_N(RST_N),
	       .loadConfig_inx(pe2$loadConfig_inx),
	       .put_datas(pe2$put_datas),
	       .EN_put(pe2$EN_put),
	       .EN_get(pe2$EN_get),
	       .EN_loadConfig(pe2$EN_loadConfig),
	       .RDY_put(pe2$RDY_put),
	       .get(pe2$get),
	       .RDY_get(pe2$RDY_get),
	       .RDY_loadConfig());

  // submodule pe3
  mkPECore pe3(.CLK(CLK),
	       .RST_N(RST_N),
	       .loadConfig_inx(pe3$loadConfig_inx),
	       .put_datas(pe3$put_datas),
	       .EN_put(pe3$EN_put),
	       .EN_get(pe3$EN_get),
	       .EN_loadConfig(pe3$EN_loadConfig),
	       .RDY_put(pe3$RDY_put),
	       .get(pe3$get),
	       .RDY_get(pe3$RDY_get),
	       .RDY_loadConfig());

  // rule RL_in_P1
  assign WILL_FIRE_RL_in_P1 = pe1$RDY_put && fQ1$EMPTY_N && drI_1 == 2'd1 ;

  // rule RL_in_P2
  assign WILL_FIRE_RL_in_P2 = pe2$RDY_put && fQ2$EMPTY_N && drI_2 == 2'd1 ;

  // rule RL_in_P3
  assign WILL_FIRE_RL_in_P3 = pe3$RDY_put && fQ3$EMPTY_N && drI_3 == 2'd1 ;

  // rule RL_out_P0_P1
  assign WILL_FIRE_RL_out_P0_P1 =
	     pe0$RDY_get && pe1$RDY_put && drO_0 == 2'd0 && drI_1 == 2'd0 ;

  // rule RL_out_P0_P1_O
  assign WILL_FIRE_RL_out_P0_P1_O =
	     pe0$RDY_get && pe1$RDY_put && drain$RDY_enq0 && drO_0 == 2'd2 &&
	     drI_1 == 2'd0 ;

  // rule RL_out_P0
  assign WILL_FIRE_RL_out_P0 =
	     pe0$RDY_get && drain$RDY_enq0 && drO_0 == 2'd1 ;

  // rule RL_out_P1_P2
  assign WILL_FIRE_RL_out_P1_P2 =
	     pe1$RDY_get && pe2$RDY_put && drO_1 == 2'd0 && drI_2 == 2'd0 ;

  // rule RL_out_P1_P2_O
  assign WILL_FIRE_RL_out_P1_P2_O =
	     pe1$RDY_get && pe2$RDY_put && drain$RDY_enq1 && drO_1 == 2'd2 &&
	     drI_2 == 2'd0 ;

  // rule RL_out_P1
  assign WILL_FIRE_RL_out_P1 =
	     pe1$RDY_get && drain$RDY_enq1 && drO_1 == 2'd1 ;

  // rule RL_out_P2_P3
  assign WILL_FIRE_RL_out_P2_P3 =
	     pe2$RDY_get && pe3$RDY_put && drO_2 == 2'd0 && drI_3 == 2'd0 ;

  // rule RL_out_P2_P3_O
  assign WILL_FIRE_RL_out_P2_P3_O =
	     pe2$RDY_get && pe3$RDY_put && drain$RDY_enq2 && drO_2 == 2'd2 &&
	     drI_3 == 2'd0 ;

  // rule RL_out_P2
  assign WILL_FIRE_RL_out_P2 =
	     pe2$RDY_get && drain$RDY_enq2 && drO_2 == 2'd1 ;

  // inputs to muxes for submodule ports
  assign MUX_pe1$put_1__SEL_1 =
	     WILL_FIRE_RL_out_P0_P1_O || WILL_FIRE_RL_out_P0_P1 ;
  assign MUX_pe2$put_1__SEL_1 =
	     WILL_FIRE_RL_out_P1_P2_O || WILL_FIRE_RL_out_P1_P2 ;
  assign MUX_pe3$put_1__SEL_1 =
	     WILL_FIRE_RL_out_P2_P3_O || WILL_FIRE_RL_out_P2_P3 ;

  // register cfgCntr
  assign cfgCntr$D_IN = cfgCntr + 20'd1 ;
  assign cfgCntr$EN = EN_put ;

  // register drI_0
  assign drI_0$D_IN = drI_1 ;
  assign drI_0$EN =
	     EN_put && !cfgCntr_3_ULT_207___d94 &&
	     NOT_cfgCntr_3_ULT_414_7_9_AND_NOT_cfgCntr_3_UL_ETC___d112 ;

  // register drI_1
  assign drI_1$D_IN = drI_2 ;
  assign drI_1$EN =
	     EN_put && !cfgCntr_3_ULT_207___d94 &&
	     NOT_cfgCntr_3_ULT_414_7_9_AND_NOT_cfgCntr_3_UL_ETC___d112 ;

  // register drI_2
  assign drI_2$D_IN = drI_3 ;
  assign drI_2$EN =
	     EN_put && !cfgCntr_3_ULT_207___d94 &&
	     NOT_cfgCntr_3_ULT_414_7_9_AND_NOT_cfgCntr_3_UL_ETC___d112 ;

  // register drI_3
  assign drI_3$D_IN = put_datas[1:0] ;
  assign drI_3$EN =
	     EN_put && !cfgCntr_3_ULT_207___d94 &&
	     NOT_cfgCntr_3_ULT_414_7_9_AND_NOT_cfgCntr_3_UL_ETC___d112 ;

  // register drO_0
  assign drO_0$D_IN = drO_1 ;
  assign drO_0$EN =
	     EN_put && !cfgCntr_3_ULT_207___d94 && !cfgCntr_3_ULT_414___d97 &&
	     NOT_cfgCntr_3_ULT_621_00_03_AND_NOT_cfgCntr_3__ETC___d119 ;

  // register drO_1
  assign drO_1$D_IN = drO_2 ;
  assign drO_1$EN =
	     EN_put && !cfgCntr_3_ULT_207___d94 && !cfgCntr_3_ULT_414___d97 &&
	     NOT_cfgCntr_3_ULT_621_00_03_AND_NOT_cfgCntr_3__ETC___d119 ;

  // register drO_2
  assign drO_2$D_IN = drO_3 ;
  assign drO_2$EN =
	     EN_put && !cfgCntr_3_ULT_207___d94 && !cfgCntr_3_ULT_414___d97 &&
	     NOT_cfgCntr_3_ULT_621_00_03_AND_NOT_cfgCntr_3__ETC___d119 ;

  // register drO_3
  assign drO_3$D_IN = put_datas[1:0] ;
  assign drO_3$EN =
	     EN_put && !cfgCntr_3_ULT_207___d94 && !cfgCntr_3_ULT_414___d97 &&
	     NOT_cfgCntr_3_ULT_621_00_03_AND_NOT_cfgCntr_3__ETC___d119 ;

  // submodule drain
  assign drain$enq0_a = pe0$get ;
  assign drain$enq1_a = pe1$get ;
  assign drain$enq2_a = pe2$get ;
  assign drain$enq3_a = pe3$get ;
  assign drain$reset_scans = put_datas[31:0] ;
  assign drain$EN_deq = EN_get ;
  assign drain$EN_enq0 = WILL_FIRE_RL_out_P0 || WILL_FIRE_RL_out_P0_P1_O ;
  assign drain$EN_enq1 = WILL_FIRE_RL_out_P1 || WILL_FIRE_RL_out_P1_P2_O ;
  assign drain$EN_enq2 = WILL_FIRE_RL_out_P2 || WILL_FIRE_RL_out_P2_P3_O ;
  assign drain$EN_enq3 = pe3$RDY_get && drain$RDY_enq3 && drO_3 == 2'd1 ;
  assign drain$EN_reset =
	     EN_put &&
	     NOT_cfgCntr_3_ULT_207_4_6_AND_NOT_cfgCntr_3_UL_ETC___d129 ;

  // submodule fQ0
  assign fQ0$D_IN = put_datas ;
  assign fQ0$ENQ =
	     EN_put &&
	     NOT_cfgCntr_3_ULT_207_4_6_AND_NOT_cfgCntr_3_UL_ETC___d137 ;
  assign fQ0$DEQ =
	     fQ0$EMPTY_N && drI_0 == 2'd0 ||
	     pe0$RDY_put && fQ0$EMPTY_N && drI_0 == 2'd1 ;
  assign fQ0$CLR = 1'b0 ;

  // submodule fQ1
  assign fQ1$D_IN = put_datas ;
  assign fQ1$ENQ =
	     EN_put &&
	     NOT_cfgCntr_3_ULT_207_4_6_AND_NOT_cfgCntr_3_UL_ETC___d137 ;
  assign fQ1$DEQ = fQ1$EMPTY_N && drI_1 == 2'd0 || WILL_FIRE_RL_in_P1 ;
  assign fQ1$CLR = 1'b0 ;

  // submodule fQ2
  assign fQ2$D_IN = put_datas ;
  assign fQ2$ENQ =
	     EN_put &&
	     NOT_cfgCntr_3_ULT_207_4_6_AND_NOT_cfgCntr_3_UL_ETC___d137 ;
  assign fQ2$DEQ = fQ2$EMPTY_N && drI_2 == 2'd0 || WILL_FIRE_RL_in_P2 ;
  assign fQ2$CLR = 1'b0 ;

  // submodule fQ3
  assign fQ3$D_IN = put_datas ;
  assign fQ3$ENQ =
	     EN_put &&
	     NOT_cfgCntr_3_ULT_207_4_6_AND_NOT_cfgCntr_3_UL_ETC___d137 ;
  assign fQ3$DEQ = fQ3$EMPTY_N && drI_3 == 2'd0 || WILL_FIRE_RL_in_P3 ;
  assign fQ3$CLR = 1'b0 ;

  // submodule pe0
  assign pe0$loadConfig_inx = put_datas[15:0] ;
  assign pe0$put_datas = fQ0$D_OUT ;
  assign pe0$EN_put = pe0$RDY_put && fQ0$EMPTY_N && drI_0 == 2'd1 ;
  assign pe0$EN_get =
	     WILL_FIRE_RL_out_P0 || WILL_FIRE_RL_out_P0_P1_O ||
	     WILL_FIRE_RL_out_P0_P1 ;
  assign pe0$EN_loadConfig = EN_put && cfgCntr_3_ULT_207___d94 ;

  // submodule pe1
  assign pe1$loadConfig_inx = put_datas[15:0] ;
  assign pe1$put_datas = MUX_pe1$put_1__SEL_1 ? pe0$get : fQ1$D_OUT ;
  assign pe1$EN_put =
	     WILL_FIRE_RL_out_P0_P1_O || WILL_FIRE_RL_out_P0_P1 ||
	     WILL_FIRE_RL_in_P1 ;
  assign pe1$EN_get =
	     WILL_FIRE_RL_out_P1 || WILL_FIRE_RL_out_P1_P2_O ||
	     WILL_FIRE_RL_out_P1_P2 ;
  assign pe1$EN_loadConfig =
	     EN_put && !cfgCntr_3_ULT_207___d94 && cfgCntr_3_ULT_414___d97 ;

  // submodule pe2
  assign pe2$loadConfig_inx = put_datas[15:0] ;
  assign pe2$put_datas = MUX_pe2$put_1__SEL_1 ? pe1$get : fQ2$D_OUT ;
  assign pe2$EN_put =
	     WILL_FIRE_RL_out_P1_P2_O || WILL_FIRE_RL_out_P1_P2 ||
	     WILL_FIRE_RL_in_P2 ;
  assign pe2$EN_get =
	     WILL_FIRE_RL_out_P2 || WILL_FIRE_RL_out_P2_P3_O ||
	     WILL_FIRE_RL_out_P2_P3 ;
  assign pe2$EN_loadConfig =
	     EN_put && !cfgCntr_3_ULT_207___d94 && !cfgCntr_3_ULT_414___d97 &&
	     cfgCntr_3_ULT_621___d100 ;

  // submodule pe3
  assign pe3$loadConfig_inx = put_datas[15:0] ;
  assign pe3$put_datas = MUX_pe3$put_1__SEL_1 ? pe2$get : fQ3$D_OUT ;
  assign pe3$EN_put =
	     WILL_FIRE_RL_out_P2_P3_O || WILL_FIRE_RL_out_P2_P3 ||
	     WILL_FIRE_RL_in_P3 ;
  assign pe3$EN_get = pe3$RDY_get && drain$RDY_enq3 && drO_3 == 2'd1 ;
  assign pe3$EN_loadConfig =
	     EN_put && !cfgCntr_3_ULT_207___d94 && !cfgCntr_3_ULT_414___d97 &&
	     !cfgCntr_3_ULT_621___d100 &&
	     cfgCntr_3_ULT_828___d104 ;

  // remaining internal signals
  assign NOT_cfgCntr_3_ULT_207_4_6_AND_NOT_cfgCntr_3_UL_ETC___d129 =
	     !cfgCntr_3_ULT_207___d94 && !cfgCntr_3_ULT_414___d97 &&
	     !cfgCntr_3_ULT_621___d100 &&
	     !cfgCntr_3_ULT_828___d104 &&
	     !cfgCntr_3_ULT_832___d109 &&
	     !cfgCntr_3_ULT_836___d116 &&
	     cfgCntr_3_ULT_837___d123 ;
  assign NOT_cfgCntr_3_ULT_207_4_6_AND_NOT_cfgCntr_3_UL_ETC___d137 =
	     !cfgCntr_3_ULT_207___d94 && !cfgCntr_3_ULT_414___d97 &&
	     !cfgCntr_3_ULT_621___d100 &&
	     !cfgCntr_3_ULT_828___d104 &&
	     !cfgCntr_3_ULT_832___d109 &&
	     !cfgCntr_3_ULT_836___d116 &&
	     !cfgCntr_3_ULT_837___d123 ;
  assign NOT_cfgCntr_3_ULT_414_7_9_AND_NOT_cfgCntr_3_UL_ETC___d112 =
	     !cfgCntr_3_ULT_414___d97 && !cfgCntr_3_ULT_621___d100 &&
	     !cfgCntr_3_ULT_828___d104 &&
	     cfgCntr_3_ULT_832___d109 ;
  assign NOT_cfgCntr_3_ULT_621_00_03_AND_NOT_cfgCntr_3__ETC___d119 =
	     !cfgCntr_3_ULT_621___d100 && !cfgCntr_3_ULT_828___d104 &&
	     !cfgCntr_3_ULT_832___d109 &&
	     cfgCntr_3_ULT_836___d116 ;
  assign cfgCntr_3_ULT_207___d94 = cfgCntr < 20'd207 ;
  assign cfgCntr_3_ULT_414___d97 = cfgCntr < 20'd414 ;
  assign cfgCntr_3_ULT_621___d100 = cfgCntr < 20'd621 ;
  assign cfgCntr_3_ULT_828___d104 = cfgCntr < 20'd828 ;
  assign cfgCntr_3_ULT_832___d109 = cfgCntr < 20'd832 ;
  assign cfgCntr_3_ULT_836___d116 = cfgCntr < 20'd836 ;
  assign cfgCntr_3_ULT_837___d123 = cfgCntr < 20'd837 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        cfgCntr <= `BSV_ASSIGNMENT_DELAY 20'd0;
	drI_0 <= `BSV_ASSIGNMENT_DELAY 2'd0;
	drI_1 <= `BSV_ASSIGNMENT_DELAY 2'd0;
	drI_2 <= `BSV_ASSIGNMENT_DELAY 2'd0;
	drI_3 <= `BSV_ASSIGNMENT_DELAY 2'd0;
	drO_0 <= `BSV_ASSIGNMENT_DELAY 2'd0;
	drO_1 <= `BSV_ASSIGNMENT_DELAY 2'd0;
	drO_2 <= `BSV_ASSIGNMENT_DELAY 2'd0;
	drO_3 <= `BSV_ASSIGNMENT_DELAY 2'd0;
      end
    else
      begin
        if (cfgCntr$EN) cfgCntr <= `BSV_ASSIGNMENT_DELAY cfgCntr$D_IN;
	if (drI_0$EN) drI_0 <= `BSV_ASSIGNMENT_DELAY drI_0$D_IN;
	if (drI_1$EN) drI_1 <= `BSV_ASSIGNMENT_DELAY drI_1$D_IN;
	if (drI_2$EN) drI_2 <= `BSV_ASSIGNMENT_DELAY drI_2$D_IN;
	if (drI_3$EN) drI_3 <= `BSV_ASSIGNMENT_DELAY drI_3$D_IN;
	if (drO_0$EN) drO_0 <= `BSV_ASSIGNMENT_DELAY drO_0$D_IN;
	if (drO_1$EN) drO_1 <= `BSV_ASSIGNMENT_DELAY drO_1$D_IN;
	if (drO_2$EN) drO_2 <= `BSV_ASSIGNMENT_DELAY drO_2$D_IN;
	if (drO_3$EN) drO_3 <= `BSV_ASSIGNMENT_DELAY drO_3$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    cfgCntr = 20'hAAAAA;
    drI_0 = 2'h2;
    drI_1 = 2'h2;
    drI_2 = 2'h2;
    drI_3 = 2'h2;
    drO_0 = 2'h2;
    drO_1 = 2'h2;
    drO_2 = 2'h2;
    drO_3 = 2'h2;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkHardware

