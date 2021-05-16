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

#define  VLEN 32


#define L0 128
#define L1 64
#define L2 32
#define L3 16
#define L4 8
#define L5 4
#define L6 2


interface Sum8;
        method  Action put(Vector#(VLEN, DataType) datas);
	method  ActionValue#(Vector#(L2,DataType)) get;
	method  Action loadShift(UInt#(10) inx);
endinterface

(*synthesize*)
module mkSum8(Sum8);
Reg#(DataType) _T0[L0];
Reg#(DataType) __T0[L0];
Reg#(DataType) _L0[L0];
Reg#(DataType) _T1[L1];
Reg#(DataType) __T1[L1];
Reg#(DataType) _L1[L1];
Reg#(DataType) __L1[L1];
Reg#(DataType) _T2[L2]; 
Reg#(DataType) __T2[L2]; 
Reg#(DataType) _L2[L1]; 
Reg#(DataType) __L2[L1]; 
Reg#(DataType) _T3[L3];
Reg#(DataType) __T3[L3];
Reg#(DataType) _L3[L1];
Reg#(DataType) __L3[L1];
Reg#(DataType) _T4[L4];
Reg#(DataType) __T4[L4];
Reg#(DataType) _L4[L1];
Reg#(DataType) __L4[L1];

Reg#(UInt#(6)) _SFT[L0];
for(int i=0;i<L0;i=i+1)
_SFT[i] <- mkReg(0);

Reg#(UInt#(10)) _LFT[L0];
_LFT[0] <- mkReg(448);
_LFT[1] <- mkReg(0);
_LFT[2] <- mkReg(0);
_LFT[3] <- mkReg(0);
_LFT[4] <- mkReg(0);
_LFT[5] <- mkReg(0);
_LFT[6] <- mkReg(0);

FIFOF#(Vector#(L2,DataType)) outQ <- mkFIFOF;

for(int i=0;i<L0; i = i + 1) begin
		_T0[i] <- mkReg(0);
		__T0[i] <- mkReg(0);
		_L0[i] <- mkReg(0);
	if(i < L1) begin
		_T1[i] <- mkReg(0);
		__T1[i] <- mkReg(0);
		_L1[i] <- mkReg(0);
		__L1[i] <- mkReg(0);
		_L2[i] <- mkReg(0);
		__L2[i] <- mkReg(0);
		_L3[i] <- mkReg(0);
		__L3[i] <- mkReg(0);
		_L4[i] <- mkReg(0);
		__L4[i] <- mkReg(0);
	end
	if(i < L2) begin
		_T2[i] <- mkReg(0);
		__T2[i] <- mkReg(0);
	end
	if(i < L3) begin
		_T3[i] <- mkReg(0);
		__T3[i] <- mkReg(0);
	end
	if(i<L4) begin
		_T4[i] <- mkReg(0);
		__T4[i] <- mkReg(0);
	end
end

FIFOF#(Bit#(1)) p0 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p1 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p2 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p3 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p4 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p5 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p6 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p7 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p70 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p8 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p80 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p9 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p90 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p10 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p100 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p11 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p110 <- mkPipelineFIFOF;


Reg#(Vector#(VLEN, DataType)) inReg <- mkRegU;
Reg#(Vector#(VLEN, DataType)) _DR0[2];
Reg#(Vector#(VLEN, DataType)) _DR1[4];

Reg#(Bit#(1)) combine[6];
Reg#(Bit#(1)) outLevel[6];

combine[0] <- mkReg(0);
combine[1] <- mkReg(0);
combine[2] <- mkReg(1);
combine[3] <- mkReg(0);

outLevel[0] <- mkReg(0);
outLevel[1] <- mkReg(0);
outLevel[2] <- mkReg(0);
outLevel[3] <- mkReg(1);


_DR0[0] <- mkRegU;
_DR0[1] <- mkRegU;
_DR1[0] <- mkRegU;
_DR1[1] <- mkRegU;
_DR1[2] <- mkRegU;
_DR1[3] <- mkRegU;

Reg#(UInt#(11)) ldx <- mkReg(0);

Reg#(Vector#(L0,DataType)) tempL0 <- mkRegU;
Reg#(Vector#(L1,DataType)) tempL1 <- mkRegU;
Reg#(Vector#(L2,DataType)) tempL2 <- mkRegU;
Reg#(Vector#(L3,DataType)) tempL3 <- mkRegU;


Permute _PERM[L0];
for(int i=0;i<L0;i=i+1)
	_PERM[i] <- mkPermute;

rule _D0;
		 p0.deq;
		 p1.enq(1);
		_DR0[0] <= inReg;
		_DR0[1] <= inReg;	
endrule

rule _D1;
		 p1.deq;
		 p2.enq(1);
		_DR1[0] <= _DR0[0];
		_DR1[1] <= _DR0[0];
		_DR1[2] <= _DR0[1];
		_DR1[3] <= _DR0[1];
endrule


for(int i =0;i<4; i = i + 1)
rule getSft2 (ldx < 5);
	_LFT[i+1] <= _LFT[i];
endrule

for(int i=0;i<L0-1; i = i + 1)
rule getSfts;
	_SFT[i+1] <= _SFT[i];	
endrule

rule loadShifts (ldx == 131);
	for(int i=0;i<L0; i = i + 1) begin
		_PERM[i].setIndex(_SFT[i]);
	end
endrule


rule act0;
	p2.deq;
	p3.enq(1);
endrule

rule act1;
	p3.deq;
	p4.enq(1);
endrule

rule act2;
	p4.deq;
	p5.enq(1);
endrule

rule act3;
	p5.deq;	
	p6.enq(1);
endrule


rule act4;
	p6.deq;	
	p70.enq(1);
endrule

rule act4x;
	p70.deq;
	p7.enq(1);
endrule


rule act5;
	p7.deq;	
	p80.enq(1);
endrule


rule act5x;
	p80.deq;	
	p8.enq(1);
endrule

rule act6;
	p8.deq;	
	p90.enq(1);
endrule

rule act6x;
	p90.deq;	
	p9.enq(1);
endrule

rule act7;
	p9.deq;	
	p100.enq(1);
endrule

rule act7x;
	p100.deq;	
	p10.enq(1);
endrule

rule act8;
	p10.deq;	
	p110.enq(1);
endrule

rule act8x;
	p110.deq;	
	p11.enq(1);
endrule

for(int i=0;i<L0;i=i+1) begin
rule _PERMUTE;
	_PERM[i].put(_DR1[i%4]);	
endrule

rule _MAC;
		let d <- _PERM[i].get;
		__T0[i] <= d;
		_L0[i] <= d;
endrule

end

rule _SAD20;
		Vector#(L0,DataType) temp = replicate(0);
		for(int i=0;i<L0; i = i + 1) begin
			temp[i] = _L0[i];
			_T0[i] <= __T0[i];	
		end	
		tempL0 <= unpack(pack(temp)>> (_LFT[0] << 4));		
endrule

rule _SAD21;

		for(int i=0;i<L1;i=i+1)
				__T1[i] <=  fxptTruncate(fxptAdd(_T0[2*i], _T0[2*i+1]));
		
		if (combine[0] == 1) begin	
			for(int i=0;i<L1;i=i+1) begin
				DataType a =  fxptTruncate(fxptAdd(_T0[2*i], _T0[2*i+1]));
				_L1[i] <= fxptTruncate(fxptAdd(a,tempL0[i]));
			end
		end
		else
			for(int i=0;i<L1;i=i+1)
				_L1[i] <= tempL0[i];
endrule

rule _SAD40;
		Vector#(L1,DataType) temp = replicate(0);
		for(int i=0;i<L1; i = i + 1) begin
			temp[i] = _L1[i];
			_T1[i] <= __T1[i];			
		end	
		tempL1 <= unpack(pack(temp)>> (_LFT[1] << 4));	
endrule

rule _SAD41;
		for(int i=0;i<L2;i=i+1)
				__T2[i] <=  fxptTruncate(fxptAdd(_T1[2*i], _T1[2*i+1]));
		if(combine[1] == 1) begin	
			for(int i=0;i<L2;i=i+1) begin
				DataType a =  fxptTruncate(fxptAdd(_T1[2*i], _T1[2*i+1]));
				_L2[i]  <=  fxptTruncate(fxptAdd(a,tempL1[i]));
			end
		end
		else
			if(outLevel[1] == 1)
				for(int i=0;i<L1;i=i+1)
					_L2[i] <= _L1[i];
			else
				for(int i=0;i<L1;i=i+1)
					_L2[i] <= tempL1[i];
				
endrule

rule _SAD80;
		Vector#(L2,DataType) temp = replicate(0);
		for(int i=0;i<L2; i = i + 1) begin
			temp[i] = _L2[i];
			__L2[i] <= _L2[i];	
			_T2[i] <= __T2[i];
		end	
		tempL2 <= unpack(pack(temp)>> (_LFT[2] << 4));	
endrule

rule _SAD81;
		for(int i=0;i<L3;i=i+1)
				__T3[i] <=  fxptTruncate(fxptAdd(_T2[2*i], _T2[2*i+1]));
		if(combine[2] == 1) begin	
			for(int i=0;i<L3;i=i+1) begin
				DataType a =  fxptTruncate(fxptAdd(_T2[2*i], _T2[2*i+1]));
				_L3[i]    <=  fxptTruncate(fxptAdd(a,tempL2[i]));
			end
		end
		else
			if(outLevel[2] == 1)
				for(int i=0;i<L1;i=i+1)
					_L3[i] <= __L2[i];
			else
				for(int i=0;i<L2;i=i+1)
					_L3[i] <= tempL2[i];
endrule

rule _SAD160;
		Vector#(L3,DataType) temp = replicate(0);
		for(int i=0;i<L3; i = i + 1) begin
			temp[i] = _L3[i];
			_T3[i] <= __T3[i];
			__L3[i] <= _L3[i];	
		end	

		tempL3 <= unpack(pack(temp)>> (_LFT[3] << 4));	
endrule

rule _SAD161;

		for(int i=0;i<L4;i=i+1)
				__T4[i] <=  fxptTruncate(fxptAdd(_T3[2*i], _T3[2*i+1]));
		if(combine[3] == 1) begin	
			for(int i=0;i<L4;i=i+1) begin
				DataType a =  fxptTruncate(fxptAdd(_T3[2*i], _T3[2*i+1]));
				_L4[i]    <=  fxptTruncate(fxptAdd(a,tempL3[i]));
			end
		end
		else
			if(outLevel[3] == 1)
				for(int i=0;i<L1;i=i+1)
					_L4[i] <= __L3[i];
			else
				for(int i=0;i<L3;i=i+1)
					_L4[i] <= tempL3[i];
endrule


rule collect;
	p11.deq;
		Vector#(L2,DataType) x = newVector;
		for(int i=0;i<L2;i = i + 1)
			x[i] = _L4[i];
	outQ.enq(x);
		
endrule
method Action put(Vector#(VLEN, DataType) datas);
		inReg <= unpack(truncate(pack(datas)));
		p0.enq(1);
endmethod
	
method ActionValue#(Vector#(L2,DataType)) get;
		outQ.deq;
		return outQ.first;
endmethod
	
method  Action loadShift(UInt#(10) inx);
	if(ldx < 5) begin
		_LFT[0] <= (inx);
	end
	else
		_SFT[0] <= truncate(inx);
	ldx <= ldx + 1;
endmethod

endmodule
endpackage
