package sumTree;
import FixedPoint::*;
import pulse::*;
import FIFO::*;
import FIFOF::*;
import datatypes::*;
import SpecialFIFOs:: * ;
import Real::*;
import Vector::*;
import sum8::*;

#define VectorLength 64

interface SumTree;
        method Action put0(Vector#(VectorLength, DataType) datas);
        method Action put1(Vector#(VectorLength, DataType) datas);
        method Action put2(Vector#(VectorLength, DataType) datas);
        method Action put3(Vector#(VectorLength, DataType) datas);
        method Action put4(Vector#(VectorLength, DataType) datas);
        method Action put5(Vector#(VectorLength, DataType) datas);
        method Action put6(Vector#(VectorLength, DataType) datas);
        method Action put7(Vector#(VectorLength, DataType) datas);		
        method ActionValue#(Vector#(VectorLength,DataType)) result;
        method Action clean;
    	method Action activate;
endinterface

(*synthesize*)
module mkSumTree(SumTree);
Reg#(Vector#(VectorLength,DataType)) s0[8];

Sum8 s8[64];

for(int i=0;i<64; i = i + 1)
	s8[i] <- mkSum8;

for(int i=0;i<8; i = i + 1) begin
	s0[i] <- mkRegU;
end

FIFOF#(Bit#(1)) p0 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p1 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p2 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p3 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p4 <- mkPipelineFIFOF;


	for(int i = 0; i<64; i = i + 1)
	rule _sum8;
		Vector#(8,DataType) d = replicate(0);
		d[0] = s0[0][i];
		d[1] = s0[1][i];
		d[2] = s0[2][i];
		d[3] = s0[3][i];
		d[4] = s0[4][i];
		d[5] = s0[5][i];
		d[6] = s0[6][i];
		d[7] = s0[7][i];
		if( i == 0 || i == 1 || i == 2)
		$display("--- %d %d %d %d %d %d %d %d ---", fxptGetInt(d[0]), fxptGetInt(d[1]), fxptGetInt(d[2]),fxptGetInt(d[3]), fxptGetInt(d[4]), fxptGetInt(d[5]),fxptGetInt(d[6]), fxptGetInt(d[7])); 
		s8[i].put(d);
	endrule
		
		
	//################################################ 
	rule _activate0;
		p0.deq;
		p1.enq(1);
    	endrule

    	rule _activate1;
                    p1.deq;
                    p2.enq(1);
    	endrule

   	rule _activate2;
                    p2.deq;
		    p3.enq(1);
    	endrule
   	
	rule _activate24;
                    p3.deq;
		    p4.enq(1);
    	endrule
	
	//################################################
	

    	method Action activate;
                p0.enq(1);
    	endmethod

	
        method Action put0(Vector#(VectorLength, DataType) datas);
		s0[0] <= datas;
	endmethod
        method Action put1(Vector#(VectorLength, DataType) datas);
		s0[1] <= datas;
	endmethod
        method Action put2(Vector#(VectorLength, DataType) datas);
		s0[2] <= datas;
	endmethod
        method Action put3(Vector#(VectorLength, DataType) datas);
		s0[3] <= datas;
	endmethod
        method Action put4(Vector#(VectorLength, DataType) datas);
		s0[4] <= datas;
	endmethod
        method Action put5(Vector#(VectorLength, DataType) datas);
		s0[5] <= datas;
	endmethod
        method Action put6(Vector#(VectorLength, DataType) datas);
		s0[6] <= datas;
	endmethod
        method Action put7(Vector#(VectorLength, DataType) datas);
		s0[7] <= datas;
	endmethod
	
        method ActionValue#(Vector#(VectorLength,DataType)) result;
			p4.deq;
			Vector#(VectorLength, DataType) res = newVector;
			for(int i=0;i<64; i = i + 1)
				res[i] = s8[i].result;	
			return res;
	endmethod
		
	method Action clean;
		p0.clear;
		p1.clear;
		p2.clear;
		p3.clear;
		p4.clear;
	endmethod	
endmodule
endpackage
