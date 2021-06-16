package drain;
import FixedPoint:: *;
import SpecialFIFOs:: * ;
import Vector:: *;
import FIFO:: *;
import FIFOF:: *;
import BRAMFIFO::*;
import datatypes::*;
import TubeHeader::*;

#define CORES 4
interface Drain;
	method ActionValue#(Bit#(512)) deq;
	method Action enq0(Bit#(512) a);
	method Action enq1(Bit#(512) a);
	method Action enq2(Bit#(512) a);
	method Action enq3(Bit#(512) a);
	method Action reset(Vector#(CORES,UInt#(8)) scans);
endinterface

(*synthesize*)
module mkDrain(Drain);
	FIFOF#(Bit#(512))   inQ[CORES];
	Reg#(Bit#(512))     tempF0[CORES];
	Reg#(Bit#(512))     tempF1[CORES/2];
	FIFOF#(Bit#(1))     p0 <- mkPipelineFIFOF;
	FIFOF#(Bit#(1))     p1 <- mkPipelineFIFOF;


	FIFOF#(Bit#(512))  outQ <- mkFIFOF;
	Reg#(UInt#(8))     shifts[CORES];
	
	for(int i=0;i<CORES; i = i + 1) begin
		shifts[i] <- mkReg(0);
                inQ[i]    <- mkFIFOF;
		tempF0[i] <- mkReg(0);
                if(i<(CORES/2))
                        tempF1[i] <- mkReg(0);
        end

	for(int i=0;i<CORES; i = i + 1) begin
	rule shiftA;
			let d         = inQ[i].first; inQ[i].deq;
			Bit#(512) x   = zeroExtend(pack(d));
			UInt#(16) sfx = extend(shifts[i]) << 4;
			Bit#(512) y   = x << sfx;
			tempF0[i] <= y;
	endrule
	end
	
	rule trigger (inQ[0].notEmpty || inQ[1].notEmpty || inQ[2].notEmpty || inQ[3].notEmpty);		
		p0.enq(1);
	endrule	

	rule add1;
		p0.deq;
		for(int i=0;i<CORES/2; i = i + 1) begin
			let a = tempF0[2*i];
			let b = tempF0[2*i+1];
			Bit#(512) c = a|b;
			tempF1[i] <= c;
		end
		p1.enq(1);	
	endrule
	
	rule add2;	
		p1.deq;
		Bit#(512) c = tempF1[0]|tempF1[1];
		outQ.enq(c);	
	endrule
	
	method Action enq0(Bit#(512) a);
		inQ[0].enq(a);
	endmethod

	method Action enq1(Bit#(512) a);
		inQ[1].enq(a);
	endmethod

	method Action enq2(Bit#(512) a);
		inQ[2].enq(a);
	endmethod

	method Action enq3(Bit#(512) a);
		inQ[3].enq(a);
	endmethod

	method ActionValue#(Bit#(512)) deq;
		outQ.deq;
		return outQ.first;
	endmethod		
	
	method Action reset(Vector#(CORES,UInt#(8)) scans);
		for(int i=0;i<CORES; i = i + 1)
			shifts[i] <= scans[i];
	endmethod
		
endmodule
endpackage

