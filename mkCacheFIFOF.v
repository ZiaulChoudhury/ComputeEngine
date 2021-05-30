//
// Generated by Bluespec Compiler (build 00185f79)
//
// On Sun May 30 12:03:10 IST 2021
//
//
// Ports:
// Name                         I/O  size props
// RDY_enq                        O     1
// enQdeQ                         O   128 reg
// RDY_enQdeQ                     O     1
// read                           O    16 reg
// RDY_read                       O     1 const
// RDY_clean                      O     1 const
// RDY_dummy                      O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// enq_a                          I    16
// enQdeQ_a                       I    16
// EN_enq                         I     1
// EN_clean                       I     1
// EN_dummy                       I     1
// EN_enQdeQ                      I     1
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

module mkCacheFIFOF(CLK,
		    RST_N,

		    enq_a,
		    EN_enq,
		    RDY_enq,

		    enQdeQ_a,
		    EN_enQdeQ,
		    enQdeQ,
		    RDY_enQdeQ,

		    read,
		    RDY_read,

		    EN_clean,
		    RDY_clean,

		    EN_dummy,
		    RDY_dummy);
  input  CLK;
  input  RST_N;

  // action method enq
  input  [15 : 0] enq_a;
  input  EN_enq;
  output RDY_enq;

  // actionvalue method enQdeQ
  input  [15 : 0] enQdeQ_a;
  input  EN_enQdeQ;
  output [127 : 0] enQdeQ;
  output RDY_enQdeQ;

  // value method read
  output [15 : 0] read;
  output RDY_read;

  // action method clean
  input  EN_clean;
  output RDY_clean;

  // action method dummy
  input  EN_dummy;
  output RDY_dummy;

  // signals for module outputs
  wire [127 : 0] enQdeQ;
  wire [15 : 0] read;
  wire RDY_clean, RDY_dummy, RDY_enQdeQ, RDY_enq, RDY_read;

  // inlined wires
  wire mem_pwEnqueue$whas, mem_wDataIn$whas;

  // register _unnamed_
  reg [8 : 0] _unnamed_;
  wire [8 : 0] _unnamed_$D_IN;
  wire _unnamed_$EN;

  // register cache_0
  reg [15 : 0] cache_0;
  wire [15 : 0] cache_0$D_IN;
  wire cache_0$EN;

  // register cache_1
  reg [15 : 0] cache_1;
  wire [15 : 0] cache_1$D_IN;
  wire cache_1$EN;

  // register cache_2
  reg [15 : 0] cache_2;
  wire [15 : 0] cache_2$D_IN;
  wire cache_2$EN;

  // register cache_3
  reg [15 : 0] cache_3;
  wire [15 : 0] cache_3$D_IN;
  wire cache_3$EN;

  // register cache_4
  reg [15 : 0] cache_4;
  wire [15 : 0] cache_4$D_IN;
  wire cache_4$EN;

  // register cache_5
  reg [15 : 0] cache_5;
  wire [15 : 0] cache_5$D_IN;
  wire cache_5$EN;

  // register cache_6
  reg [15 : 0] cache_6;
  wire [15 : 0] cache_6$D_IN;
  wire cache_6$EN;

  // register cache_7
  reg [15 : 0] cache_7;
  wire [15 : 0] cache_7$D_IN;
  wire cache_7$EN;

  // register mem_rCache
  reg [27 : 0] mem_rCache;
  wire [27 : 0] mem_rCache$D_IN;
  wire mem_rCache$EN;

  // register mem_rRdPtr
  reg [10 : 0] mem_rRdPtr;
  wire [10 : 0] mem_rRdPtr$D_IN;
  wire mem_rRdPtr$EN;

  // register mem_rWrPtr
  reg [10 : 0] mem_rWrPtr;
  wire [10 : 0] mem_rWrPtr$D_IN;
  wire mem_rWrPtr$EN;

  // ports of submodule mem_memory
  wire [15 : 0] mem_memory$DIA, mem_memory$DIB, mem_memory$DOB;
  wire [9 : 0] mem_memory$ADDRA, mem_memory$ADDRB;
  wire mem_memory$ENA, mem_memory$ENB, mem_memory$WEA, mem_memory$WEB;

  // inputs to muxes for submodule ports
  wire [15 : 0] MUX_cache_7$write_1__VAL_2;
  wire [8 : 0] MUX__unnamed_$write_1__VAL_2;
  wire MUX_cache_0$write_1__SEL_1,
       MUX_cache_1$write_1__SEL_1,
       MUX_cache_2$write_1__SEL_1,
       MUX_cache_3$write_1__SEL_1,
       MUX_cache_4$write_1__SEL_1,
       MUX_cache_5$write_1__SEL_1,
       MUX_cache_6$write_1__SEL_1,
       MUX_cache_7$write_1__SEL_1,
       MUX_mem_wDataIn$wset_1__SEL_1;

  // remaining internal signals
  reg [15 : 0] x__h1407;
  wire [14 : 0] x__read_i__h1415;
  wire [10 : 0] x__h1482, x__h1645;
  wire unnamed__5_ULT_8___d37, x__read_f__h1416;

  // action method enq
  assign RDY_enq = mem_rRdPtr + 11'd512 != mem_rWrPtr ;

  // actionvalue method enQdeQ
  assign enQdeQ =
	     { cache_7,
	       cache_6,
	       cache_5,
	       cache_4,
	       cache_3,
	       cache_2,
	       cache_1,
	       cache_0 } ;
  assign RDY_enQdeQ =
	     mem_rRdPtr + 11'd512 != mem_rWrPtr && mem_rRdPtr != mem_rWrPtr ;

  // value method read
  assign read = cache_0 ;
  assign RDY_read = 1'd1 ;

  // action method clean
  assign RDY_clean = 1'd1 ;

  // action method dummy
  assign RDY_dummy = mem_rRdPtr + 11'd512 != mem_rWrPtr ;

  // submodule mem_memory
  BRAM2 #(.PIPELINED(1'd0),
	  .ADDR_WIDTH(32'd10),
	  .DATA_WIDTH(32'd16),
	  .MEMSIZE(11'd1024)) mem_memory(.CLKA(CLK),
					 .CLKB(CLK),
					 .ADDRA(mem_memory$ADDRA),
					 .ADDRB(mem_memory$ADDRB),
					 .DIA(mem_memory$DIA),
					 .DIB(mem_memory$DIB),
					 .WEA(mem_memory$WEA),
					 .WEB(mem_memory$WEB),
					 .ENA(mem_memory$ENA),
					 .ENB(mem_memory$ENB),
					 .DOA(),
					 .DOB(mem_memory$DOB));

  // inputs to muxes for submodule ports
  assign MUX_cache_0$write_1__SEL_1 =
	     EN_enq && _unnamed_ == 9'd0 && unnamed__5_ULT_8___d37 ;
  assign MUX_cache_1$write_1__SEL_1 =
	     EN_enq && _unnamed_ == 9'd1 && unnamed__5_ULT_8___d37 ;
  assign MUX_cache_2$write_1__SEL_1 =
	     EN_enq && _unnamed_ == 9'd2 && unnamed__5_ULT_8___d37 ;
  assign MUX_cache_3$write_1__SEL_1 =
	     EN_enq && _unnamed_ == 9'd3 && unnamed__5_ULT_8___d37 ;
  assign MUX_cache_4$write_1__SEL_1 =
	     EN_enq && _unnamed_ == 9'd4 && unnamed__5_ULT_8___d37 ;
  assign MUX_cache_5$write_1__SEL_1 =
	     EN_enq && _unnamed_ == 9'd5 && unnamed__5_ULT_8___d37 ;
  assign MUX_cache_6$write_1__SEL_1 =
	     EN_enq && _unnamed_ == 9'd6 && unnamed__5_ULT_8___d37 ;
  assign MUX_cache_7$write_1__SEL_1 =
	     EN_enq && _unnamed_ == 9'd7 && unnamed__5_ULT_8___d37 ;
  assign MUX_mem_wDataIn$wset_1__SEL_1 = EN_enq && !unnamed__5_ULT_8___d37 ;
  assign MUX__unnamed_$write_1__VAL_2 = _unnamed_ + 9'd1 ;
  assign MUX_cache_7$write_1__VAL_2 =
	     (mem_rCache[27] && mem_rCache[26:16] == mem_rRdPtr) ?
	       mem_rCache[15:0] :
	       mem_memory$DOB ;

  // inlined wires
  assign mem_wDataIn$whas =
	     EN_enq && !unnamed__5_ULT_8___d37 || EN_enQdeQ || EN_dummy ;
  assign mem_pwEnqueue$whas =
	     MUX_mem_wDataIn$wset_1__SEL_1 || EN_dummy || EN_enQdeQ ;

  // register _unnamed_
  assign _unnamed_$D_IN = EN_clean ? 9'd0 : MUX__unnamed_$write_1__VAL_2 ;
  assign _unnamed_$EN = EN_enq && unnamed__5_ULT_8___d37 || EN_clean ;

  // register cache_0
  assign cache_0$D_IN = MUX_cache_0$write_1__SEL_1 ? enq_a : cache_1 ;
  assign cache_0$EN =
	     EN_enq && _unnamed_ == 9'd0 && unnamed__5_ULT_8___d37 ||
	     EN_enQdeQ ;

  // register cache_1
  assign cache_1$D_IN = MUX_cache_1$write_1__SEL_1 ? enq_a : cache_2 ;
  assign cache_1$EN =
	     EN_enq && _unnamed_ == 9'd1 && unnamed__5_ULT_8___d37 ||
	     EN_enQdeQ ;

  // register cache_2
  assign cache_2$D_IN = MUX_cache_2$write_1__SEL_1 ? enq_a : cache_3 ;
  assign cache_2$EN =
	     EN_enq && _unnamed_ == 9'd2 && unnamed__5_ULT_8___d37 ||
	     EN_enQdeQ ;

  // register cache_3
  assign cache_3$D_IN = MUX_cache_3$write_1__SEL_1 ? enq_a : cache_4 ;
  assign cache_3$EN =
	     EN_enq && _unnamed_ == 9'd3 && unnamed__5_ULT_8___d37 ||
	     EN_enQdeQ ;

  // register cache_4
  assign cache_4$D_IN = MUX_cache_4$write_1__SEL_1 ? enq_a : cache_5 ;
  assign cache_4$EN =
	     EN_enq && _unnamed_ == 9'd4 && unnamed__5_ULT_8___d37 ||
	     EN_enQdeQ ;

  // register cache_5
  assign cache_5$D_IN = MUX_cache_5$write_1__SEL_1 ? enq_a : cache_6 ;
  assign cache_5$EN =
	     EN_enq && _unnamed_ == 9'd5 && unnamed__5_ULT_8___d37 ||
	     EN_enQdeQ ;

  // register cache_6
  assign cache_6$D_IN = MUX_cache_6$write_1__SEL_1 ? enq_a : cache_7 ;
  assign cache_6$EN =
	     EN_enq && _unnamed_ == 9'd6 && unnamed__5_ULT_8___d37 ||
	     EN_enQdeQ ;

  // register cache_7
  assign cache_7$D_IN =
	     MUX_cache_7$write_1__SEL_1 ? enq_a : MUX_cache_7$write_1__VAL_2 ;
  assign cache_7$EN =
	     EN_enq && _unnamed_ == 9'd7 && unnamed__5_ULT_8___d37 ||
	     EN_enQdeQ ;

  // register mem_rCache
  assign mem_rCache$D_IN =
	     { 1'd1, mem_rWrPtr, x__read_i__h1415, x__read_f__h1416 } ;
  assign mem_rCache$EN = !EN_clean && mem_pwEnqueue$whas ;

  // register mem_rRdPtr
  assign mem_rRdPtr$D_IN = EN_clean ? 11'd0 : x__h1645 ;
  assign mem_rRdPtr$EN = EN_clean || EN_enQdeQ ;

  // register mem_rWrPtr
  assign mem_rWrPtr$D_IN = EN_clean ? 11'd0 : x__h1482 ;
  assign mem_rWrPtr$EN = EN_clean || mem_pwEnqueue$whas ;

  // submodule mem_memory
  assign mem_memory$ADDRA = mem_rWrPtr[9:0] ;
  assign mem_memory$ADDRB = EN_enQdeQ ? x__h1645[9:0] : mem_rRdPtr[9:0] ;
  assign mem_memory$DIA = { x__read_i__h1415, x__read_f__h1416 } ;
  assign mem_memory$DIB = 16'b1010101010101010 /* unspecified value */  ;
  assign mem_memory$WEA = mem_pwEnqueue$whas ;
  assign mem_memory$WEB = 1'd0 ;
  assign mem_memory$ENA = !EN_clean ;
  assign mem_memory$ENB = !EN_clean ;

  // remaining internal signals
  assign unnamed__5_ULT_8___d37 = _unnamed_ < 9'd8 ;
  assign x__h1482 = mem_rWrPtr + 11'd1 ;
  assign x__h1645 = mem_rRdPtr + 11'd1 ;
  assign x__read_f__h1416 = mem_wDataIn$whas && x__h1407[0] ;
  assign x__read_i__h1415 = mem_wDataIn$whas ? x__h1407[15:1] : 15'd0 ;
  always@(MUX_mem_wDataIn$wset_1__SEL_1 or
	  enq_a or EN_enQdeQ or enQdeQ_a or EN_dummy)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_mem_wDataIn$wset_1__SEL_1: x__h1407 = enq_a;
      EN_enQdeQ: x__h1407 = enQdeQ_a;
      EN_dummy: x__h1407 = 16'd0;
      default: x__h1407 = 16'b1010101010101010 /* unspecified value */ ;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        _unnamed_ <= `BSV_ASSIGNMENT_DELAY 9'd0;
	cache_0 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	cache_1 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	cache_2 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	cache_3 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	cache_4 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	cache_5 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	cache_6 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	cache_7 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	mem_rCache <= `BSV_ASSIGNMENT_DELAY 28'd44739242;
	mem_rRdPtr <= `BSV_ASSIGNMENT_DELAY 11'd0;
	mem_rWrPtr <= `BSV_ASSIGNMENT_DELAY 11'd0;
      end
    else
      begin
        if (_unnamed_$EN) _unnamed_ <= `BSV_ASSIGNMENT_DELAY _unnamed_$D_IN;
	if (cache_0$EN) cache_0 <= `BSV_ASSIGNMENT_DELAY cache_0$D_IN;
	if (cache_1$EN) cache_1 <= `BSV_ASSIGNMENT_DELAY cache_1$D_IN;
	if (cache_2$EN) cache_2 <= `BSV_ASSIGNMENT_DELAY cache_2$D_IN;
	if (cache_3$EN) cache_3 <= `BSV_ASSIGNMENT_DELAY cache_3$D_IN;
	if (cache_4$EN) cache_4 <= `BSV_ASSIGNMENT_DELAY cache_4$D_IN;
	if (cache_5$EN) cache_5 <= `BSV_ASSIGNMENT_DELAY cache_5$D_IN;
	if (cache_6$EN) cache_6 <= `BSV_ASSIGNMENT_DELAY cache_6$D_IN;
	if (cache_7$EN) cache_7 <= `BSV_ASSIGNMENT_DELAY cache_7$D_IN;
	if (mem_rCache$EN)
	  mem_rCache <= `BSV_ASSIGNMENT_DELAY mem_rCache$D_IN;
	if (mem_rRdPtr$EN)
	  mem_rRdPtr <= `BSV_ASSIGNMENT_DELAY mem_rRdPtr$D_IN;
	if (mem_rWrPtr$EN)
	  mem_rWrPtr <= `BSV_ASSIGNMENT_DELAY mem_rWrPtr$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    _unnamed_ = 9'h0AA;
    cache_0 = 16'hAAAA;
    cache_1 = 16'hAAAA;
    cache_2 = 16'hAAAA;
    cache_3 = 16'hAAAA;
    cache_4 = 16'hAAAA;
    cache_5 = 16'hAAAA;
    cache_6 = 16'hAAAA;
    cache_7 = 16'hAAAA;
    mem_rCache = 28'hAAAAAAA;
    mem_rRdPtr = 11'h2AA;
    mem_rWrPtr = 11'h2AA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkCacheFIFOF

