package sumTree;
import FixedPoint::*;
import pulse::*;
import FIFO::*;
import FIFOF::*;
import datatypes::*;
import SpecialFIFOs:: * ;
import Real::*;
import Vector::*;

#define VectorLength 64
#define L0 8
#define L1 4
#define L2 2
#define L3 1


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
Reg#(Vector#(VectorLength,DataType)) s0[L0];
Reg#(Vector#(VectorLength,DataType)) s1[L1];
Reg#(Vector#(VectorLength,DataType)) s2[L2];
Reg#(Vector#(VectorLength,DataType)) s3[L3];

for(int i=0;i<L0; i = i + 1) begin
	s0[i] <- mkRegU;
	if(i < L1)
	s1[i] <- mkRegU;
	if(i < L2)
	s2[i] <- mkRegU;
	if(i < L3)
	s3[i] <- mkRegU;
	
end

FIFOF#(Bit#(1)) p0 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p1 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p2 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p3 <- mkPipelineFIFOF;


	for(int i=0;i<L1;i=i+1)
	rule _Q1;
		Vector#(VectorLength, DataType) d = replicate(0);
		let a = s0[i];
		let b = s0[2*i+1];
		
		for(int j=0; j < VectorLength; j = j + 1) begin
			d[i] = fxptTruncate(fxptAdd(a[j],b[j]));	
		end
		s1[i] <= unpack(truncate(pack(d)));
	endrule
	
	for(int i=0;i<L2;i=i+1)
	rule _Q2;
		Vector#(VectorLength, DataType) d = replicate(0);
		let a = s1[i];
		let b = s1[2*i+1];
		
		for(int j=0; j < VectorLength; j = j + 1) begin
			d[i] = fxptTruncate(fxptAdd(a[i],b[i]));	
		end
		s2[i] <= unpack(truncate(pack(d)));
	endrule
	
	for(int i=0;i<L3;i=i+1)
	rule _Q3;
		Vector#(VectorLength, DataType) d = replicate(0);
		let a = s2[i];
		let b = s2[2*i+1];
		
		for(int j=0; j < VectorLength; j = j + 1) begin
			d[i] = fxptTruncate(fxptAdd(a[i],b[i]));	
		end
		s3[i] <= unpack(truncate(pack(d)));
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
			p3.deq;
			return s3[0];
	endmethod
		
	method Action clean;
		p0.clear;
		p1.clear;
		p2.clear;
		p3.clear;
	endmethod	
endmodule
endpackage
