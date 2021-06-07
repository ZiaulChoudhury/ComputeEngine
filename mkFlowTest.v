//
// Generated by Bluespec Compiler (build 00185f79)
//
// On Mon Jun  7 19:55:04 IST 2021
//
//
// Ports:
// Name                         I/O  size props
// CLK                            I     1 clock
// RST_N                          I     1 reset
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

module mkFlowTest(CLK,
		  RST_N);
  input  CLK;
  input  RST_N;

  // register col
  reg [31 : 0] col;
  wire [31 : 0] col$D_IN;
  wire col$EN;

  // register count
  reg [31 : 0] count;
  wire [31 : 0] count$D_IN;
  wire count$EN;

  // register cx
  reg [9 : 0] cx;
  wire [9 : 0] cx$D_IN;
  wire cx$EN;

  // register idx
  reg [15 : 0] idx;
  wire [15 : 0] idx$D_IN;
  wire idx$EN;

  // register idx2
  reg [15 : 0] idx2;
  wire [15 : 0] idx2$D_IN;
  wire idx2$EN;

  // register idx3
  reg [15 : 0] idx3;
  wire [15 : 0] idx3$D_IN;
  wire idx3$EN;

  // register init
  reg init;
  wire init$D_IN, init$EN;

  // register init2
  reg init2;
  wire init2$D_IN, init2$EN;

  // register rx
  reg [9 : 0] rx;
  wire [9 : 0] rx$D_IN;
  wire rx$EN;

  // ports of submodule px
  wire [511 : 0] px$put_datas;
  wire [127 : 0] px$get;
  wire [15 : 0] px$loadConfig_inx;
  wire px$EN_get, px$EN_loadConfig, px$EN_put, px$RDY_get, px$RDY_put;

  // rule scheduling signals
  wire WILL_FIRE_RL_configure, WILL_FIRE_RL_configure2, WILL_FIRE_RL_receive;

  // inputs to muxes for submodule ports
  wire [15 : 0] MUX_px$loadConfig_1__VAL_1, MUX_px$loadConfig_1__VAL_2;

  // remaining internal signals
  wire [31 : 0] IF_count_BIT_31_7_THEN_NEG_count_8_ELSE_count__ETC___d30,
		x__h926;
  wire [19 : 0] rx_0_MUL_cx_6___d45;
  wire [15 : 0] _7_MINUS_idx2__q1;
  wire [14 : 0] n_i__h5218;
  wire [9 : 0] IF_rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10_7_BIT_ETC___d51,
	       IF_rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10_7_BIT_ETC__q2,
	       rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10___d47,
	       x__h3194;
  wire [7 : 0] b__h723;
  wire IF_count_BIT_31_7_THEN_NEG_IF_count_BIT_31_7_T_ETC___d34,
       idx_4_ULT_3___d15;

  // submodule px
  mkSum8 px(.CLK(CLK),
	    .RST_N(RST_N),
	    .loadConfig_inx(px$loadConfig_inx),
	    .put_datas(px$put_datas),
	    .EN_put(px$EN_put),
	    .EN_get(px$EN_get),
	    .EN_loadConfig(px$EN_loadConfig),
	    .RDY_put(px$RDY_put),
	    .get(px$get),
	    .RDY_get(px$RDY_get),
	    .RDY_loadConfig());

  // rule RL_configure2
  assign WILL_FIRE_RL_configure2 = !init && !init2 ;

  // rule RL_configure
  assign WILL_FIRE_RL_configure = init && !init2 ;

  // rule RL_receive
  assign WILL_FIRE_RL_receive = px$RDY_get && init2 ;

  // inputs to muxes for submodule ports
  assign MUX_px$loadConfig_1__VAL_1 = (idx3 == 16'd4) ? 16'd24 : 16'd0 ;
  assign MUX_px$loadConfig_1__VAL_2 =
	     idx_4_ULT_3___d15 ? 16'd32 : { 8'd0, b__h723 } ;

  // register col
  assign col$D_IN = col + 32'd1 ;
  assign col$EN = WILL_FIRE_RL_receive ;

  // register count
  assign count$D_IN = count + 32'd1 ;
  assign count$EN = 1'd1 ;

  // register cx
  assign cx$D_IN = (cx == 10'd20) ? 10'd0 : cx + 10'd1 ;
  assign cx$EN =
	     px$RDY_put &&
	     IF_count_BIT_31_7_THEN_NEG_IF_count_BIT_31_7_T_ETC___d34 ;

  // register idx
  assign idx$D_IN = idx + 16'd1 ;
  assign idx$EN = WILL_FIRE_RL_configure ;

  // register idx2
  assign idx2$D_IN = idx2 + 16'd1 ;
  assign idx2$EN = WILL_FIRE_RL_configure && !idx_4_ULT_3___d15 ;

  // register idx3
  assign idx3$D_IN = idx3 + 16'd1 ;
  assign idx3$EN = WILL_FIRE_RL_configure2 ;

  // register init
  assign init$D_IN = 1'd1 ;
  assign init$EN = WILL_FIRE_RL_configure2 && idx3 == 16'd5 ;

  // register init2
  assign init2$D_IN = 1'd1 ;
  assign init2$EN = WILL_FIRE_RL_configure && idx == 16'd27 ;

  // register rx
  assign rx$D_IN = rx + 10'd1 ;
  assign rx$EN =
	     px$RDY_put &&
	     IF_count_BIT_31_7_THEN_NEG_IF_count_BIT_31_7_T_ETC___d34 &&
	     cx == 10'd20 ;

  // submodule px
  assign px$loadConfig_inx =
	     WILL_FIRE_RL_configure2 ?
	       MUX_px$loadConfig_1__VAL_1 :
	       MUX_px$loadConfig_1__VAL_2 ;
  assign px$put_datas =
	     ((cx ^ 10'h200) < 10'd528 && (rx ^ 10'h200) < 10'd528) ?
	       { 496'd0, n_i__h5218, 1'd0 } :
	       512'd0 ;
  assign px$EN_put =
	     px$RDY_put &&
	     IF_count_BIT_31_7_THEN_NEG_IF_count_BIT_31_7_T_ETC___d34 ;
  assign px$EN_get = WILL_FIRE_RL_receive ;
  assign px$EN_loadConfig =
	     WILL_FIRE_RL_configure2 || WILL_FIRE_RL_configure ;

  // remaining internal signals
  assign IF_count_BIT_31_7_THEN_NEG_IF_count_BIT_31_7_T_ETC___d34 =
	     (count[31] ?
		-IF_count_BIT_31_7_THEN_NEG_count_8_ELSE_count__ETC___d30 :
		IF_count_BIT_31_7_THEN_NEG_count_8_ELSE_count__ETC___d30) ==
	     32'd0 &&
	     init2 ;
  assign IF_count_BIT_31_7_THEN_NEG_count_8_ELSE_count__ETC___d30 =
	     x__h926 % 32'd10 ;
  assign IF_rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10_7_BIT_ETC___d51 =
	     x__h3194 % 10'd255 ;
  assign IF_rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10_7_BIT_ETC__q2 =
	     rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10___d47[9] ?
	       -IF_rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10_7_BIT_ETC___d51 :
	       IF_rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10_7_BIT_ETC___d51 ;
  assign _7_MINUS_idx2__q1 = 16'd7 - idx2 ;
  assign b__h723 = { 3'd0, _7_MINUS_idx2__q1[2:0], 2'd0 } ;
  assign idx_4_ULT_3___d15 = idx < 16'd3 ;
  assign n_i__h5218 =
	     { {5{IF_rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10_7_BIT_ETC__q2[9]}},
	       IF_rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10_7_BIT_ETC__q2 } ;
  assign rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10___d47 =
	     rx_0_MUL_cx_6___d45[9:0] + 10'd10 ;
  assign rx_0_MUL_cx_6___d45 = rx * cx ;
  assign x__h3194 =
	     rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10___d47[9] ?
	       -rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10___d47 :
	       rx_0_MUL_cx_6_5_BITS_9_TO_0_6_PLUS_10___d47 ;
  assign x__h926 = count[31] ? -count : count ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        col <= `BSV_ASSIGNMENT_DELAY 32'd0;
	count <= `BSV_ASSIGNMENT_DELAY 32'd0;
	cx <= `BSV_ASSIGNMENT_DELAY 10'd0;
	idx <= `BSV_ASSIGNMENT_DELAY 16'd0;
	idx2 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	idx3 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	init <= `BSV_ASSIGNMENT_DELAY 1'd0;
	init2 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	rx <= `BSV_ASSIGNMENT_DELAY 10'd0;
      end
    else
      begin
        if (col$EN) col <= `BSV_ASSIGNMENT_DELAY col$D_IN;
	if (count$EN) count <= `BSV_ASSIGNMENT_DELAY count$D_IN;
	if (cx$EN) cx <= `BSV_ASSIGNMENT_DELAY cx$D_IN;
	if (idx$EN) idx <= `BSV_ASSIGNMENT_DELAY idx$D_IN;
	if (idx2$EN) idx2 <= `BSV_ASSIGNMENT_DELAY idx2$D_IN;
	if (idx3$EN) idx3 <= `BSV_ASSIGNMENT_DELAY idx3$D_IN;
	if (init$EN) init <= `BSV_ASSIGNMENT_DELAY init$D_IN;
	if (init2$EN) init2 <= `BSV_ASSIGNMENT_DELAY init2$D_IN;
	if (rx$EN) rx <= `BSV_ASSIGNMENT_DELAY rx$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    col = 32'hAAAAAAAA;
    count = 32'hAAAAAAAA;
    cx = 10'h2AA;
    idx = 16'hAAAA;
    idx2 = 16'hAAAA;
    idx3 = 16'hAAAA;
    init = 1'h0;
    init2 = 1'h0;
    rx = 10'h2AA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_receive)
	$display(" %d %d %d ",
		 $signed(px$get[15:1]),
		 $signed(px$get[31:17]),
		 $signed(px$get[47:33]));
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_receive && col == 32'd195) $finish(32'd0);
  end
  // synopsys translate_on
endmodule  // mkFlowTest

