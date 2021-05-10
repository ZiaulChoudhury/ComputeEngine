package sum8;
import FixedPoint::*;
import pulse::*;
import FIFO::*;
import FIFOF::*;
import datatypes::*;
import SpecialFIFOs:: * ;
import Real::*;
import Vector::*;
import permute::*;

#define L0 64
#define L1 32
#define L2 16
#define L3 8
#define L4 4
#define L5 2
#define L6 1


interface Sum8;
        method Action put(Vector#(L0, DataType) datas);
        method  ActionValue#(DataType) get;
endinterface

(*synthesize*)
module mkSum8(Sum8);
Reg#(DataType) _T0[L0];
Reg#(DataType) _T1[L1];
Reg#(DataType) _T2[L2]; 
Reg#(DataType) _T3[L3]; 
Reg#(DataType) _T4[L4];
Reg#(DataType) _T5[L5];
Reg#(DataType) _T6[L6]; 

Reg#(UInt#(16)) _SFT[L0];

_SFT[0] <- mkReg(0);
_SFT[1] <- mkReg(1);
_SFT[2] <- mkReg(2);
_SFT[3] <- mkReg(8);
_SFT[4] <- mkReg(9);
_SFT[5] <- mkReg(10);
_SFT[6] <- mkReg(16);
_SFT[7] <- mkReg(17);
_SFT[8] <- mkReg(18);

_SFT[9]  <- mkReg(24);
_SFT[10] <- mkReg(25);
_SFT[11] <- mkReg(26);


Reg#(UInt#(16)) _LFT[L0];
_LFT[0] <- mkReg(64);
_LFT[1] <- mkReg(32);
_LFT[2] <- mkReg(2);
_LFT[3] <- mkReg(8);
_LFT[4] <- mkReg(4);
_LFT[5] <- mkReg(2);
_LFT[6] <- mkReg(1);


for(int i=12;i<L0; i = i + 1) begin	
		_SFT[i] <- mkReg(65);
end

for(int i=0;i<L0; i = i + 1) begin
		_T0[i] <- mkReg(0);
	if(i < L1)
		_T1[i] <- mkReg(0);
	if(i < L2)
		_T2[i] <- mkReg(0);
	if(i < L3)
		_T3[i] <- mkReg(0);
	if(i < L4)
		_T4[i] <- mkReg(0);
	if(i < L5)
		_T5[i] <- mkReg(0);
	if(i < L6)
		_T6[i] <- mkReg(0);
end

FIFOF#(Bit#(1)) p0 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p1 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p2 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p3 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p4 <- mkPipelineFIFOF;

Reg#(Vector#(L0, DataType)) inReg <- mkRegU;
rule _DIST;
		for(int i=0;i<64; i = i + 1)
			_T0[i] <= unpack(truncate(pack(inReg) >> (_SFT[i] << 4)));
		p0.deq;
		p1.enq(1);
endrule

rule _SAD0;
		p1.deq;
		p2.enq(1);
	
		Vector#(L0,DataType) _L0 = replicate(0);
		for(int i=0;i<L0; i = i + 1)
			_L0[i] = _T0[i];	
		Vector#(L0,DataType) _T01 = unpack(pack(_L0)>> (_LFT[0] << 4));
		
		for(int i=0;i<L1;i=i+1) begin
			DataType a =  fxptTruncate(fxptAdd(_T0[2*i], _T0[2*i+1]));
			_T1[i] <= fxptTruncate(fxptAdd(a,_T01[i]));
		end
endrule


rule _SAD1;
		p2.deq;
		p3.enq(1);
		Vector#(L1,DataType) _L1 = replicate(0);
		for(int i=0;i<L1; i = i + 1)
			_L1[i] = _T1[i];	
		Vector#(L1,DataType) _T12 = unpack(pack(_L1)>>(_LFT[1] << 4));
		
		for(int i=0;i<L2;i=i+1) begin
			DataType a = fxptTruncate(fxptAdd(_T1[2*i], _T1[2*i+1]));	
			//$display("%d + %d + %d ", fxptGetInt(_T1[2*i]), fxptGetInt(_T1[2*i+1]), fxptGetInt(_T12[i])); 
			_T2[i] <= fxptTruncate(fxptAdd(a,_T12[i]));
		end
		//$finish(0);
endrule

rule _SAD2;
		p3.deq;
		p4.enq(1);
		Vector#(L2,DataType) _L2 = replicate(0);
		for(int i=0;i<L2; i = i + 1)
			_L2[i] = _T2[i];	
		Vector#(L2,DataType) _T23 = unpack(pack(_L2)>>(_LFT[2] << 4));
		
		for(int i=0;i<L3;i=i+1) begin
			DataType a =  fxptTruncate(fxptAdd(_T2[2*i], _T2[2*i+1]));	
			_T3[i] <= fxptTruncate(fxptAdd(a,_T23[i]));
		end
endrule


method Action put(Vector#(L0, DataType) datas);
		inReg <= datas;
		p0.enq(1);
endmethod
	
method  ActionValue#(DataType) get;
		p4.deq;
		return _T3[0];
endmethod
	
endmodule
endpackage
