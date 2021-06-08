package permute;
import FIFOF::*;
import datatypes::*;
import Vector::*;
import SpecialFIFOs:: * ;
import FixedPoint::*;

interface Permute;
        method Action put(Vector#(192,DataType) inR);
        method Action setIndex(UInt#(8) inx2);
	method ActionValue#(DataType) get;
endinterface

(*synthesize*)
module mkPermute(Permute);
Reg#(UInt#(6)) 		  probe <- mkReg(0);
Reg#(UInt#(7)) 		  sft   <- mkReg(0);
Reg#(DataType) 		  outR  <- mkReg(0);
Reg#(Vector#(64,DataType))  i0   <- mkRegU;
Reg#(Vector#(32,DataType))  i1   <- mkRegU;
Reg#(Vector#(16,DataType))  i2   <- mkRegU;
Reg#(Vector#(8,DataType))   i3   <- mkRegU;

Reg#(UInt#(2)) stripIndex	<- mkReg(0);
FIFOF#(Bit#(1)) p0 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p1 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p2 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p3 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p4 <- mkPipelineFIFOF;

	rule _S0;
		Bit#(6) x = pack(probe);
		Vector#(2,Vector#(32,DataType)) y = unpack(pack(i0));
		if(x[5] == 0)
			i1 <= y[0];
		else
			i1 <= y[1];
		p0.deq;
		p1.enq(1);
	endrule
	
	rule _S1;
		Bit#(6) x = pack(probe);
		p1.deq;
		p2.enq(1);
		Vector#(2,Vector#(16,DataType)) y = unpack(pack(i1));
		if(x[4] == 0)
			i2 <= y[0];
		else
			i2 <= y[1];
	endrule

	rule _S2;
		Bit#(6) x = pack(probe);
		p2.deq;
		p3.enq(1);
		Vector#(2,Vector#(8,DataType)) y = unpack(pack(i2));
		if(x[3] == 0)
			i3 <= y[0];
		else
			i3 <= y[1];
	endrule
	
	
	rule _S3;
		p3.deq;
		p4.enq(1);
		outR                   <= unpack(truncate(pack(i3) >> (sft << 4)));	 
	endrule

		
		
        method Action put(Vector#(192,DataType) inR);
		Vector#(3,Vector#(64,DataType)) x = unpack(pack(inR));
		if(stripIndex == 0)
			i0 <= x[0];
		else if(stripIndex == 1)
			i0 <= x[1];
		else if(stripIndex == 2)
			i0 <= x[2];
			
		p0.enq(1); 
       	endmethod		
	 
        method Action setIndex(UInt#(8) inx2);
		stripIndex <= truncate(inx2); 	
		UInt#(6) inx = unpack(truncate(pack(inx2) >> 2));
		probe <= inx;
		Bit#(6) x = pack(inx);
		x[5] = 0;
		x[4] = 0;
		x[3] = 0;
		sft   <= zeroExtend(unpack(x));
	endmethod
	
	method ActionValue#(DataType) get;
			p4.deq;
			return outR;
	endmethod
	
endmodule
endpackage

