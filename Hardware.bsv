package Hardware; 
import FixedPoint:: *; 
import datatypes:: *; 
import SpecialFIFOs:: * ;
import Vector:: *; 
import FIFO:: *; 
import FIFOF:: *;
import BRAMFIFO::*;
import computeTree::*;
import drain2::*;
import line3::*;
import conv3::*;

#define SPLITTERS 32
#define MERGERS 32

#define CONTROLWORDS 33

interface Stdin;
	method ActionValue#(Bit#(256)) get;
	method Action put(Bit#(256) datas);
endinterface

(*synthesize *) 
module mkHardware(Stdin);
Reg#(Bool) initialize 				<- mkReg(True);
Reg#(UInt#(4)) clean 				<- mkReg(0);
Reg#(UInt#(16)) recv 				<- mkReg(0);
ComputeTree fx 					<- mkComputeTree;
Reg#(UInt#(16)) _DATACNTR 			<- mkReg(0);
Reg#(UInt#(16)) _RECV 				<- mkReg(128);
Drain dram 					<- mkDrain;
Reg#(UInt#(6))	ctrl 				<- mkReg(0);
Reg#(Width)     _L  				<- mkReg(0);
Reg#(Width)     _B  				<- mkReg(0);
Reg#(UInt#(10)) _D                          	<- mkReg(0);
Reg#(UInt#(10))  depth                          <- mkReg(0);
Reg#(Width) 	 _F                          	<- mkReg(0);
Reg#(UInt#(4))   _K1 				<- mkReg(0);
Reg#(UInt#(5))   _K2 				<- mkReg(0);
Reg#(UInt#(6))   banks 				<- mkReg(0);
Reg#(UInt#(6))   bx 				<- mkReg(0);
Reg#(Width)      _PS    			<- mkReg(0);
Reg#(Width)      _PD    			<- mkReg(0);
Reg#(UInt#(10))  _PF				<- mkReg(0);
Reg#(UInt#(10))  totalParallelism		<- mkReg(0);
Reg#(UInt#(4)) _OUTLEVEL			<- mkReg(0);
Reg#(UInt#(4))  rowStride  			<- mkReg(0);
Reg#(UInt#(4))  colStride  			<- mkReg(0);

Reg#(UInt#(7)) 	treeIndex                       <- mkReg(0);
Reg#(UInt#(16)) _SEND                           <- mkReg(0);
Reg#(Vector#(16,UInt#(16))) configuration	<- mkRegU;
Reg#(Bool) configured 				<- mkReg(False);
Reg#(Bool) startPad				<- mkReg(False);

Reg#(Bool) b0 					<- mkReg(False);
Reg#(Bool) b1 					<- mkReg(False);
FIFOF#(Bit#(256)) inQ 				<- mkFIFOF;	
Reg#(Bit#(256))   cpuIn				<- mkReg(0);
Reg#(Bit#(1)) 	  x0				<- mkReg(0);
Reg#(Bit#(1)) 	  y0				<- mkReg(0);
	
FIFOF#(Bit#(1))   c0 				<- mkFIFOF;
Reg#(DataType) strideFactor			<- mkReg(0);
Reg#(UInt#(4))  _RSTRIDE			<- mkReg(0);
Reg#(UInt#(4))  _CSTRIDE			<- mkReg(0);
Reg#(Width)     c2    				<- mkReg(0);
Reg#(Width)     r2    				<- mkReg(0);
FIFOF#(Bit#(256))	cpuQ	    		<- mkFIFOF;
Reg#(Width)		    txx			<- mkReg(0);
Reg#(UInt#(7))		    _SPLIT		<- mkReg(0);
Reg#(UInt#(7))		    _SPLIT0		<- mkReg(0);
Reg#(UInt#(7))		    wx1			<- mkReg(0);
Reg#(UInt#(7))		    s0			<- mkReg(0);
Reg#(UInt#(1))		    wx0			<- mkReg(0);
Reg#(Vector#(2,Bit#(256)))	    weightVector	<- mkRegU;
Reg#(UInt#(4))			    s			<- mkReg(0);
Reg#(int)			    ctx 		<- mkReg(0);
//########################################################################
Reg#(int) clk <- mkReg(0);
Reg#(int) counter <- mkReg(0);

rule _CLK;
	clk <= clk + 1;
endrule

FIFOF#(Bit#(256)) outReg0 	     <- mkFIFOF;
FIFOF#(Bit#(128)) outReg1 	     <- mkFIFOF;
FIFOF#(Bit#(256)) dRAM    	     <- mkFIFOF;
Reg#(UInt#(4))    oID	  	     <- mkReg(0);
Reg#(Vector#(8,DataType))   latchOut <- mkRegU;


Line3 lx[8];
Conv  cv3[8];
for(int i = 0; i<8 ; i = i + 1) begin
         lx[i] <- mkLine3;
        cv3[i] <- mkConv3;
end
FIFOF#(Bit#(256))	cpuQ2	    		<- mkFIFOF;
Reg#(UInt#(1))		ds			<- mkReg(0);
Reg#(UInt#(10))  	_PFx			<- mkReg(0);
Reg#(UInt#(10))  	pfx			<- mkReg(0);
Reg#(UInt#(16)) 	_SEND2                  <- mkReg(0);
Reg#(UInt#(16)) 	dx0                	<- mkReg(0);
Reg#(UInt#(16)) 	dx1                  	<- mkReg(0);
Reg#(Vector#(128,Bit#(256))) 	dWeights	<- mkRegU;

(*descending_urgency="_CONFIGURE1,_start"*)
rule _CONFIGURE1 (initialize == True && b0 == True && configured == True);
	_L        <= truncate(configuration[0]);
	_SPLIT    <= truncate(configuration[1]);
	_D        <= truncate(configuration[2]);
	_SPLIT0   <= truncate(configuration[3]);
	_K1   	  <= truncate(configuration[4]); 
	_K2   	  <= truncate(configuration[5]); 
	banks   	  <= truncate(configuration[6]);
	Vector#(4,UInt#(4)) ss = unpack(pack(configuration[7])); 
        _RSTRIDE   <= ss[2];
        _CSTRIDE   <= ss[1];
        oID        <= ss[0];
	ds	   <= 1; //truncate(ss[0]);
	_PS       <= truncate(configuration[8]);
	_PF       <= truncate(configuration[9]);
	_PD	  <= truncate(configuration[10]);
        _OUTLEVEL <= truncate(configuration[11]);
        _RECV     <= truncate(configuration[12]);
     	_SEND     	     <= truncate(configuration[13]+extend(ss[1]-1));
     	_SEND2     	     <= truncate(configuration[14]);
     	txx       	     <= truncate(configuration[15]);
	b0 <= False;
endrule

rule _start (treeIndex == SPLITTERS && initialize == True && configured == True);
		$display(" Length    		  = %d ", _L);
		$display(" Breadth   		  = %d ", _L);
		$display(" Depth     		  = %d ", _D);
		$display(" Kernel    		  = %d ", _K1);
		$display(" rowStride    	  = %d ", _RSTRIDE);
		$display(" colStride   		  = %d ", _CSTRIDE);
		$display(" Pool    		  = %d ", oID);
		$display(" Filter  Parallelism    = %d ", _PF);
		$display(" Surface Parallelism    = %d ", _PS);
		$display(" Depth   Parallelism    = %d ", _PD);
		$display(" Level   Output         = %d ", _OUTLEVEL);
		$display(" _RECV Counter          = %d ", _RECV);
		$display(" _SEND Counter          = %d ", _SEND);
		$display(" SEND2            	  = %d ", _SEND2);
		$display(" SPLIT            	  = %d ", _SPLIT);
		$display(" SPLIT0            	  = %d ", _SPLIT0);
		$display(" PIVOT            	  = %d ",  txx);
		$display(" MAPVECTOR              = %d ", _K2);
		$display(" BANKS    		  = %d ", banks);
		for(int i=0;i<8; i = i + 1)
			lx[i].reset(_L);
		fx.reset(_K1,_K2,1,_L,_PS,_D,_OUTLEVEL,_SEND, _CSTRIDE,txx, totalParallelism, _PD);
		dram.reset(banks,_SEND);
		if( ds == 1) 
			_PFx <= _PF;
		else
			_PFx <= 0;
		initialize <= False;
endrule

rule _pad(recv == _RECV && clean == 0 && configured == True);
	Bit#(256) x = 0;
	fx.putFmap(unpack(x));
endrule

rule flushOut(clean == 0);
        fx.drain;
	if(_DATACNTR == _SEND) 
                clean <= clean + 1;
        _DATACNTR <= _DATACNTR + 1;
endrule


(*descending_urgency="_Accumulate00,_Accumulate01,_Accumulate02"*)
	rule _Accumulate00(depth == 0 && clean == 0);
		let d <- fx.dramOut0;
		dram.dramIn00(d);
	endrule

	rule _Accumulate01(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut0;
		dram.dramIn0(d, 0);
	endrule

	rule _Accumulate02(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut0;
		dram.dramIn0(d, 1);
	endrule

(*descending_urgency="_Accumulate10,_Accumulate11,_Accumulate12"*)
	rule _Accumulate10(depth == 0 && clean == 0);
		let d <- fx.dramOut1;
		dram.dramIn01(d);
	endrule

	rule _Accumulate11(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut1;
		dram.dramIn1(d, 0);
	endrule

	rule _Accumulate12(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut1;
		dram.dramIn1(d, 1);
	endrule

(*descending_urgency="_Accumulate20,_Accumulate21,_Accumulate22"*)
	rule _Accumulate20(depth == 0 && clean == 0);
		let d <- fx.dramOut2;
		dram.dramIn02(d);
	endrule

	rule _Accumulate21(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut2;
		dram.dramIn2(d, 0);
	endrule

	rule _Accumulate22(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut2;
		dram.dramIn2(d, 1);
	endrule

(*descending_urgency="_Accumulate30,_Accumulate31,_Accumulate32"*)
	rule _Accumulate30(depth == 0 && clean == 0);
		let d <- fx.dramOut3;
		dram.dramIn03(d);
	endrule

	rule _Accumulate31(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut3;
		dram.dramIn3(d, 0);
	endrule

	rule _Accumulate32(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut3;
		dram.dramIn3(d, 1);
	endrule

(*descending_urgency="_Accumulate40,_Accumulate41,_Accumulate42"*)
	rule _Accumulate40(depth == 0 && clean == 0);
		let d <- fx.dramOut4;
		dram.dramIn04(d);
	endrule

	rule _Accumulate41(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut4;
		dram.dramIn4(d, 0);
	endrule

	rule _Accumulate42(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut4;
		dram.dramIn4(d, 1);
	endrule

(*descending_urgency="_Accumulate50,_Accumulate51,_Accumulate52"*)
	rule _Accumulate50(depth == 0 && clean == 0);
		let d <- fx.dramOut5;
		dram.dramIn05(d);
	endrule

	rule _Accumulate51(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut5;
		dram.dramIn5(d, 0);
	endrule

	rule _Accumulate52(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut5;
		dram.dramIn5(d, 1);
	endrule

(*descending_urgency="_Accumulate60,_Accumulate61,_Accumulate62"*)
	rule _Accumulate60(depth == 0 && clean == 0);
		let d <- fx.dramOut6;
		dram.dramIn06(d);
	endrule

	rule _Accumulate61(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut6;
		dram.dramIn6(d, 0);
	endrule

	rule _Accumulate62(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut6;
		dram.dramIn6(d, 1);
	endrule

(*descending_urgency="_Accumulate70,_Accumulate71,_Accumulate72"*)
	rule _Accumulate70(depth == 0 && clean == 0);
		let d <- fx.dramOut7;
		dram.dramIn07(d);
	endrule

	rule _Accumulate71(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut7;
		dram.dramIn7(d, 0);
	endrule

	rule _Accumulate72(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut7;
		dram.dramIn7(d, 1);
	endrule

(*descending_urgency="_Accumulate80,_Accumulate81,_Accumulate82"*)
	rule _Accumulate80(depth == 0 && clean == 0);
		let d <- fx.dramOut8;
		dram.dramIn08(d);
	endrule

	rule _Accumulate81(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut8;
		dram.dramIn8(d, 0);
	endrule

	rule _Accumulate82(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut8;
		dram.dramIn8(d, 1);
	endrule

(*descending_urgency="_Accumulate90,_Accumulate91,_Accumulate92"*)
	rule _Accumulate90(depth == 0 && clean == 0);
		let d <- fx.dramOut9;
		dram.dramIn09(d);
	endrule

	rule _Accumulate91(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut9;
		dram.dramIn9(d, 0);
	endrule

	rule _Accumulate92(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut9;
		dram.dramIn9(d, 1);
	endrule

(*descending_urgency="_Accumulate100,_Accumulate101,_Accumulate102"*)
	rule _Accumulate100(depth == 0 && clean == 0);
		let d <- fx.dramOut10;
		dram.dramIn010(d);
	endrule

	rule _Accumulate101(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut10;
		dram.dramIn10(d, 0);
	endrule

	rule _Accumulate102(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut10;
		dram.dramIn10(d, 1);
	endrule

(*descending_urgency="_Accumulate110,_Accumulate111,_Accumulate112"*)
	rule _Accumulate110(depth == 0 && clean == 0);
		let d <- fx.dramOut11;
		dram.dramIn011(d);
	endrule

	rule _Accumulate111(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut11;
		dram.dramIn11(d, 0);
	endrule

	rule _Accumulate112(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut11;
		dram.dramIn11(d, 1);
	endrule

(*descending_urgency="_Accumulate120,_Accumulate121,_Accumulate122"*)
	rule _Accumulate120(depth == 0 && clean == 0);
		let d <- fx.dramOut12;
		dram.dramIn012(d);
	endrule

	rule _Accumulate121(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut12;
		dram.dramIn12(d, 0);
	endrule

	rule _Accumulate122(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut12;
		dram.dramIn12(d, 1);
	endrule

(*descending_urgency="_Accumulate130,_Accumulate131,_Accumulate132"*)
	rule _Accumulate130(depth == 0 && clean == 0);
		let d <- fx.dramOut13;
		dram.dramIn013(d);
	endrule

	rule _Accumulate131(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut13;
		dram.dramIn13(d, 0);
	endrule

	rule _Accumulate132(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut13;
		dram.dramIn13(d, 1);
	endrule

(*descending_urgency="_Accumulate140,_Accumulate141,_Accumulate142"*)
	rule _Accumulate140(depth == 0 && clean == 0);
		let d <- fx.dramOut14;
		dram.dramIn014(d);
	endrule

	rule _Accumulate141(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut14;
		dram.dramIn14(d, 0);
	endrule

	rule _Accumulate142(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut14;
		dram.dramIn14(d, 1);
	endrule

(*descending_urgency="_Accumulate150,_Accumulate151,_Accumulate152"*)
	rule _Accumulate150(depth == 0 && clean == 0);
		let d <- fx.dramOut15;
		dram.dramIn015(d);
	endrule

	rule _Accumulate151(depth > 0 && depth < _D - 1 && clean == 0);
		let d <- fx.dramOut15;
		dram.dramIn15(d, 0);
	endrule

	rule _Accumulate152(depth == _D - 1 && clean == 0);
		let d <- fx.dramOut15;
		dram.dramIn15(d, 1);
	endrule

rule _ResetCounters(clean == 1);
	  fx.clean;
	 _DATACNTR <= 0;
	 clean <= clean + 1;
endrule

rule _ResetCounters2(clean == 2);
	  if(depth == _D - 1) begin
		clean <= clean + 1;
	  end
	  else begin
          	recv <=0;
	  	clean <= 0;
		wx1 <= 0;
         	wx0 <= 0;
	  end
	  $display("		DEPTH %d done at cycles = %d ", depth, clk);
	  depth <= depth + 1;
endrule

rule _NextIteration0(clean == 3);
	dram.cleanMemory;
        recv       <= 0;
        clean      <= 0;
        ctrl       <= 0;
        treeIndex  <= 0;
        wx1        <= 0;
        wx0        <= 0;
        bx         <= 0;
        configured <= False;
        initialize <= True;
endrule

		

rule _fromHOST(bx == banks && wx1 == 2*MERGERS && recv < _RECV && initialize == False && pfx == _PFx);
		let datas = inQ.first; inQ.deq;
		/*Vector#(8,DataType) dx = unpack(datas);
		for(int i=0;i<8 ; i = i + 1) begin
			fxptWrite(4,dx[i]);
			$display();
		end
		$finish(0);*/
                fx.putFmap(unpack(datas));
		recv <= recv + 1;
endrule

//##################################################################################### WEIGHT LOADING ##############
rule _Stream1Weights(wx1 < 2*MERGERS && initialize == False && wx1 >= MERGERS && bx == banks && pfx == _PFx);
        if(wx1 < _SPLIT0 + MERGERS ) begin
                let d = inQ.first; inQ.deq;
                weightVector[wx0] <= d;
                wx0 <= wx0 + 1;
                if(wx0 == 1) begin
                        Vector#(2,Bit#(256)) x = newVector;
                        x[0] = weightVector[0];
                        x[1] = d;
                        fx.streamWeights(pack(x));
                        wx1 <= wx1 + 1;
                end
        end
        else begin
                fx.streamWeights(0);
                wx1 <= wx1 + 1;
        end

endrule

rule _Stream0Weights(wx1 < MERGERS && initialize == False && bx == banks && pfx == _PFx);
        if(wx1 < _SPLIT ) begin
                let d = inQ.first; inQ.deq;
                weightVector[wx0] <= d;
                wx0 <= wx0 + 1;
                if(wx0 == 1) begin
                        Vector#(2,Bit#(256)) x = newVector;
                        x[0] = weightVector[0];
                        x[1] = d;
                        fx.streamWeights(pack(x));
                        wx1 <= wx1 + 1;
                end
        end
        else begin
                fx.streamWeights(0);
                wx1 <= wx1 + 1;
        end

endrule

rule _StreamBiases(bx < banks && initialize == False);		
                let d = inQ.first; inQ.deq;
		dram.streamBiases(d);
		bx <= bx + 1;
endrule

rule _StreamDepths(bx == banks && initialize == False && pfx < _PFx);
        let d = inQ.first; inQ.deq;
	dWeights[pfx] <= d;
	pfx <= pfx + 1;
endrule

//############################################### POOLING MERGE #####################################
rule out0(depth == _D);
        let d <- dram.dramOut;
	Vector#(8,DataType) y = unpack(d);
	Vector#(8,DataType) x = newVector;
	for(int i=0;i<8; i = i + 1)
		x[i] = max(y[i],0);
	outReg0.enq(pack(x));
endrule

rule out1(oID == 1);
	let d = outReg0.first; outReg0.deq;
	Vector#(8,DataType) y = unpack(d);
	Vector#(4,DataType) x = newVector;
	for(int i=0;i<4; i = i + 1)
		x[i] = max(y[2*i],y[2*i+1]);
	outReg1.enq(pack(x));
endrule

rule _retreive0(oID == 0);
	outReg0.deq;
	dRAM.enq(outReg0.first);
endrule

rule _retreive1(oID == 1);
	outReg1.deq;
	dRAM.enq(zeroExtend(outReg1.first));
endrule

//###################################################################################################
rule _toHOST(depth == _D);
                let d = dRAM.first; dRAM.deq;
	
		Vector#(8,DataType) x = unpack(d);
		Vector#(8,DataType) pooled = replicate(0);
		for(int i=0;i<8 ; i = i + 1)
			pooled[i] = max(x[i], latchOut[i]);					

                if(c2 == extend(_CSTRIDE - 1)) begin
                        c2 <= 0;
			Vector#(8,DataType) z = replicate(0);
			latchOut <=  z;
			if(oID > 1)
				cpuQ.enq(pack(pooled));
			else
                        	cpuQ.enq(pack(d));
                        
                end
		else begin
				latchOut <= pooled;
				c2 <= c2 + 1;
		end

endrule

//########################################################################################################################

//##################################################################################### ACCELERATOR CONFIGURATION ##############
rule _setRouting(configured == True && initialize == True && treeIndex < SPLITTERS);
        Vector#(32,UInt#(8)) d = unpack(truncate(inQ.first)); inQ.deq;
        $display("%d %d", d[0], d[1]);
        let x = inQ.first;
	fx.routeTree(truncate(pack(d)));
        treeIndex <= treeIndex + 1;
endrule

rule _configureAccelerator(configured == False && initialize == True);
	let datas = inQ.first; inQ.deq;
        configuration <= unpack(datas);
        b0 <= True;
	depth      <= 0;
        outReg0.clear;
        outReg1.clear;
        dRAM.clear;
	pfx <= 0;
        configured <= True;
endrule
//########################################################################################################################
	

rule padDepthSeperable (ds == 1 && dx0 == _SEND+1 && dx1 < _SEND2);
	for(int i=0;i<8; i = i + 1)
		lx[i].putFmap(0);
endrule

rule cleanDepthSeparable(ds == 1 && dx1 == _SEND2 && pfx == _PFx);
		for(int i=0;i<8; i = i + 1) begin
			lx[i].clean;
			cv3[i].clean;
		end
		dx0 <= 0;
		dx1 <= 0;
		$display(" Depth separable ");
		dWeights <= unpack((pack(dWeights)>>2048));
endrule


rule depthSeparable0 (ds == 1 && dx0 < (_SEND+1));
        let d = cpuQ.first; cpuQ.deq;
	dx0 <= dx0 + 1;
        Vector#(8,DataType) x = unpack(d);
        for(int i=0;i<8; i = i + 1)
                lx[i].putFmap(x[i]);
endrule

rule depthSeparable1 (ds == 1 && dx1 < _SEND2);

	/*Vector#(9,CoeffType) daa = unpack(truncate(dWeights[0]));
	for(int i=0;i<9 ; i = i + 1) begin		
			fxptWrite(4,daa[i]);
			$write("   ");
	end
	$finish(0);*/
        for(int i=0;i<8; i = i + 1) begin
                let d <- lx[i].get;
		if(counter == 2) begin
		for(int j=0;j<9 ; j = j + 1) begin
			fxptWrite(4,d[j]);
			$write("  ");
		end
		$display();
		end
                cv3[i].fmapIn(d);
                cv3[i].weightsIn(unpack(truncate(dWeights[i])));
        end
	counter <= counter + 1;
	if (counter == 2)
	$finish(0);
endrule

rule depthSeparable2 (ds == 1 && dx1 < _SEND2);
        Vector#(8,DataType) x = newVector;
        for(int i=0;i<8; i = i + 1) begin
                x[i] <- cv3[i].get;
		fxptWrite(4,x[i]);
		$display();
	end
        cpuQ2.enq(pack(x));
	dx1 <= dx1 + 1;
endrule

rule noDepthSeparable (ds == 0);
        let d = cpuQ.first; cpuQ.deq;
        cpuQ2.enq(d);
endrule

method ActionValue#(Bit#(256)) get;
        let d = cpuQ2.first; cpuQ2.deq;
        return d;
endmethod


method Action put(Bit#(256) datas) if(ctrl <CONTROLWORDS || (recv < _RECV && initialize == False));
	inQ.enq(datas);
	if(ctrl < CONTROLWORDS)
		ctrl <= ctrl + 1;
endmethod
endmodule
endpackage

