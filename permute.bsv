package permute;
import FIFOF::*;
import datatypes::*;
import Vector::*;
import SpecialFIFOs:: * ;
import FixedPoint::*;

interface Permute;
        method Action put(Vector#(32,DataType) inR);
        method Action setIndex(UInt#(6) inx);	
	method ActionValue#(DataType) get;
endinterface

(*synthesize*)
module mkPermute(Permute);
Reg#(UInt#(6)) 		  probe <- mkReg(0);
Reg#(UInt#(7)) 		  sft   <- mkReg(0);
Reg#(DataType) 		  outR  <- mkReg(0);
Reg#(Vector#(32,DataType)) i0   <- mkRegU;
Reg#(Vector#(16,DataType)) i1   <- mkRegU;
Reg#(Vector#(8,DataType))  i2   <- mkRegU;

FIFOF#(Bit#(1)) p0 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p1 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p2 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p3 <- mkPipelineFIFOF;

	rule _S0;
		Bit#(6) x = pack(probe);
		Vector#(2,Vector#(16,DataType)) y = unpack(pack(i0));
		if(x[4] == 0)
			i1 <= y[0];
		else
			i1 <= y[1];
		p0.deq;
		p1.enq(1);
	endrule
	
	rule _S1;
		p1.deq;
		p2.enq(1);
		Bit#(6) x = pack(probe);
		Vector#(2,Vector#(8,DataType)) y = unpack(pack(i1));
		if(x[3] == 0)
			i2 <= y[0];
		else
			i2 <= y[1];
	endrule
	
	rule _S2;
		p2.deq;
		p3.enq(1);
		outR                   <= unpack(truncate(pack(i2) >> (sft << 4)));	 
	endrule

		
		
        method Action put(Vector#(32,DataType) inR);
		i0 <= inR;
		p0.enq(1); 
       	endmethod		
	 
        method Action setIndex(UInt#(6) inx);	
		probe <= inx;
		Bit#(6) x = pack(inx);
		x[4] = 0;
		x[3] = 0;
		sft   <= zeroExtend(unpack(x));
	endmethod
	
	method ActionValue#(DataType) get;
			p3.deq;
			return outR;
	endmethod
	
endmodule
endpackage

