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
import BRAMFIFO::*;
import line3::*;
import MULT_wrapper::*;

#define  VLEN 32


#define L0 32
#define L1 16
#define L2 8
#define L3 4
#define L4 2
#define L5 1


interface Sum8;
        method  Action put(Vector#(VLEN, DataType) datas);
	method  ActionValue#(Vector#(L2,DataType)) get;
	method  Action loadConfig(UInt#(16) inx);
endinterface

(*synthesize*)
module mkSum8(Sum8);
Reg#(DataType) _T0[L0];
Reg#(DataType) _L0[L0];
Reg#(DataType) __L0[L0];
Reg#(DataType) ___L0[L0];
Reg#(DataType) _T1[L1];
Reg#(DataType) __T1[L1];
Reg#(DataType) _L1[L1];
Reg#(DataType) _T2[L2]; 
Reg#(DataType) _L2[L1]; 
Reg#(DataType) _T3[L3];
Reg#(DataType) _L3[L1];
Reg#(DataType) _T4[L4];
Reg#(DataType) _L4[L1];

FIFOF#(DataType) fQ[VLEN];
Reg#(DataType)   t[VLEN];
for(int i=0;i<VLEN; i = i + 1) begin
        fQ[i] <- mkSizedBRAMFIFOF(8);
	t [i] <- mkReg(0);
end

Reg#(UInt#(8)) _SFT[L0];
for(int i=0;i<L0;i=i+1)
_SFT[i] <- mkReg(0);

Reg#(UInt#(16)) _LFT[L0];
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
		_L0[i] <- mkReg(0);
		__L0[i] <- mkReg(0);
		___L0[i] <- mkReg(0);
	if(i < L1) begin
		_T1[i] <- mkReg(0);
		__T1[i] <- mkReg(0);
		_L1[i] <- mkReg(0);
		_L2[i] <- mkReg(0);
		_L3[i] <- mkReg(0);
		_L4[i] <- mkReg(0);
	end
	if(i < L2)
		_T2[i] <- mkReg(0);
	if(i < L3)
		_T3[i] <- mkReg(0);
	if(i<L4)
		_T4[i] <- mkReg(0);
end

FIFOF#(Bit#(1)) p0 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p00 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p1 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p2 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p3 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p4 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p5 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p6 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p7 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p8 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p9 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p10 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p11 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p12 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p13 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p14 <- mkPipelineFIFOF;


Reg#(Vector#(96, DataType)) inReg <- mkRegU;
Reg#(Vector#(96, DataType)) _DR0[2];
Reg#(Vector#(96, DataType)) _DR1[4];

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

Reg#(UInt#(6)) s0 <- mkReg(0);
Reg#(UInt#(6)) s1 <- mkReg(63);

_DR0[0] <- mkRegU;
_DR0[1] <- mkRegU;
_DR1[0] <- mkRegU;
_DR1[1] <- mkRegU;
_DR1[2] <- mkRegU;
_DR1[3] <- mkRegU;

Reg#(UInt#(11)) ldx <- mkReg(0);

Permute _PERM[L0];
for(int i=0;i<L0;i=i+1)
	_PERM[i] <- mkPermute;

Line3 lb0 <- mkLine3;
Line3 lb1 <- mkLine3;

Reg#(Vector#(VLEN,DataType)) lbx0 <- mkRegU;
Reg#(Vector#(VLEN,DataType)) lbx1 <- mkRegU;

Wire#(Bool) rx <- mkWire;
Wire#(Bool) dIn <- mkWire;
Wire#(Vector#(VLEN, DataType)) dataIn <- mkWire;


MULT_Ifc       m[L0];

for(int i=0;i<L0; i = i + 1)
	m[i] <- mkMULT;

for(UInt#(6) i = 0; i<VLEN; i = i + 1) begin

rule _LB1 (i == s0 && s0 != s1);
	let x = fQ[i].first; fQ[i].deq;
	lb0.putFmap(x);	
endrule

rule _LB2 (i == s1 && s0 != s1);
	let y = fQ[i].first; fQ[i].deq;	
	lb1.putFmap(y);
endrule

rule _LB3 (i != s0 && i != s1 && rx == True && s0 != s1);
	let x = fQ[i].first; fQ[i].deq;
        t[i] <= x;	
endrule

end
 
rule _LB4 (s0 != s1);
	p00.enq(1);
	rx <= True;
	let d0 <- lb0.get;	
        lbx0 <= d0;
endrule

rule _LB5;
	let d1 <- lb1.get;	
	lbx1 <= d1;	
	$display(" line buffer 1");
endrule

rule _LB6 (s0 != s1 );
	p00.deq;
	Vector#(96,DataType) x = newVector;
	for(int i=0; i < VLEN; i = i + 1)
		x[i] = lbx0[i];
		
	for(int i=0; i < VLEN; i = i + 1)
		x[i+VLEN] = lbx1[i];
	
	
	for(int i=0; i < VLEN; i = i + 1)
		x[i+2*VLEN] = lbx1[i];
	
	inReg <= unpack(truncate(pack(x)));
	p0.enq(1);
endrule

rule _LB7 (s0 == s1);
		Vector#(VLEN, DataType) x = newVector;
		for(int i=0; i<VLEN; i = i + 1) begin
			x[i] = fQ[i].first; fQ[i].deq;
		end
		inReg <= unpack(zeroExtend(pack(x)));
		p0.enq(1);
endrule

rule _D1;
		 p0.deq;
		 p1.enq(1);
		_DR0[0] <= inReg;
		_DR0[1] <= inReg;	
endrule

rule _D2;
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

rule loadShifts (ldx == 32);
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
	p7.enq(1);
endrule

rule act5;
	p7.deq;	
	p8.enq(1);
endrule


rule act6;
	p8.deq;	
	p9.enq(1);
endrule


rule act7;
	p9.deq;	
	p10.enq(1);
endrule

rule act8;
	p10.deq;	
	p11.enq(1);
endrule

rule act9;
	p11.deq;	
	p12.enq(1);
endrule

rule act10;
	p12.deq;	
	p13.enq(1);
endrule

rule act11;
	p13.deq;	
	p14.enq(1);
endrule

for(int i=0;i<L0;i=i+1) begin
rule _PERMUTE;
	_PERM[i].put(_DR1[i%4]);	
endrule

rule _MAC;
		let d <- _PERM[i].get;
		_T0[i] <= d;
		_L0[i] <= d;
endrule

end


for(int i=0; i<L0; i = i + 1)
rule _SCALE;
		DataType d = 1;
		m[i].put(pack(_T0[i]),pack(d));
		___L0[i] <= _L0[i];
endrule

rule _SAD2_0;
			
			for(int i=0; i<L0; i = i + 1)
				__L0[i] <= ___L0[i];
			
			for(int i=0;i<L1;i=i+1) begin
				FixedPoint#(30,2) _a = unpack(m[2*i].read_response());
				DataType a = fxptTruncate(_a);
			
				FixedPoint#(30,2) _b = unpack(m[2*i+1].read_response());
				DataType b = fxptTruncate(_b);
				
				__T1[i] <=  fxptTruncate(fxptAdd(a, b));
			end
endrule
rule _SAD2_1;
		Vector#(L0,DataType) tempL0 = replicate(0);
		for(int i=0;i<L0; i = i + 1)
			tempL0[i] = __L0[i];		
		Vector#(L0,DataType) temp = unpack(pack(tempL0)>> (_LFT[0] << 4));	
		for(int i=0;i<L1;i=i+1)
				_T1[i] <=  __T1[i];
		
		if (combine[0] == 1) begin	
			for(int i=0;i<L1;i=i+1) begin
				_L1[i] <= fxptTruncate(fxptAdd(__T1[i],temp[i]));
			end
		end
		else
			for(int i=0;i<L1;i=i+1)
				_L1[i] <= temp[i];
endrule


rule _SAD4;
		Vector#(L1,DataType) tempL1 = replicate(0);
		for(int i=0;i<L1; i = i + 1)
			tempL1[i] = _L1[i];		
		Vector#(L1,DataType) temp = unpack(pack(tempL1)>> (_LFT[1] << 4));	
		for(int i=0;i<L2;i=i+1)
				_T2[i] <=  fxptTruncate(fxptAdd(_T1[2*i], _T1[2*i+1]));
		if(combine[1] == 1) begin	
			for(int i=0;i<L2;i=i+1) begin
				DataType a =  fxptTruncate(fxptAdd(_T1[2*i], _T1[2*i+1]));
				_L2[i]  <=  fxptTruncate(fxptAdd(a,temp[i]));
			end
		end
		else
			if(outLevel[1] == 1)
				for(int i=0;i<L1;i=i+1)
					_L2[i] <= _L1[i];
			else
				for(int i=0;i<L1;i=i+1)
					_L2[i] <= temp[i];
				
endrule

rule _SAD8;
		Vector#(L2,DataType) tempL2 = replicate(0);
		for(int i=0;i<L2; i = i + 1)
			tempL2[i] = _L2[i];		
		Vector#(L2,DataType) temp = unpack(pack(tempL2)>> (_LFT[2] << 4));	
		for(int i=0;i<L3;i=i+1)
				_T3[i] <=  fxptTruncate(fxptAdd(_T2[2*i], _T2[2*i+1]));
		if(combine[2] == 1) begin	
			for(int i=0;i<L3;i=i+1) begin
				DataType a =  fxptTruncate(fxptAdd(_T2[2*i], _T2[2*i+1]));
				_L3[i]    <=  fxptTruncate(fxptAdd(a,temp[i]));
			end
		end
		else
			if(outLevel[2] == 1)
				for(int i=0;i<L1;i=i+1)
					_L3[i] <= _L2[i];
			else
				for(int i=0;i<L2;i=i+1)
					_L3[i] <= temp[i];
endrule


rule _SAD16;
		Vector#(L3,DataType) tempL3 = replicate(0);
		for(int i=0;i<L3; i = i + 1)
			tempL3[i] = _L3[i];		

		Vector#(L3,DataType) temp = unpack(pack(tempL3)>> (_LFT[3] << 4));	
		for(int i=0;i<L4;i=i+1)
				_T4[i] <=  fxptTruncate(fxptAdd(_T3[2*i], _T3[2*i+1]));
		if(combine[3] == 1) begin	
			for(int i=0;i<L4;i=i+1) begin
				DataType a =  fxptTruncate(fxptAdd(_T3[2*i], _T3[2*i+1]));
				_L4[i]    <=  fxptTruncate(fxptAdd(a,temp[i]));
			end
		end
		else
			if(outLevel[3] == 1)
				for(int i=0;i<L1;i=i+1)
					_L4[i] <= _L3[i];
			else
				for(int i=0;i<L3;i=i+1)
					_L4[i] <= temp[i];
endrule


rule collect;
	p14.deq;
		Vector#(L2,DataType) x = newVector;
		for(int i=0;i<L2;i = i + 1)
			x[i] = _L4[i];
	outQ.enq(x);
		
endrule

for(int i=0;i<VLEN; i = i + 1)
rule disperse(dIn == True);
		fQ[i].enq(dataIn[i]);
endrule

method Action put(Vector#(VLEN, DataType) datas) if(outQ.notFull);
		dIn <= True;
		dataIn <= datas;
endmethod
	
method ActionValue#(Vector#(L2,DataType)) get;
		outQ.deq;
		return outQ.first;
endmethod
	
method  Action loadConfig(UInt#(16) inx);
	if(ldx < 5) begin
		_LFT[0] <= (inx);
	end
	else
		_SFT[0] <= truncate(inx);
	ldx <= ldx + 1;
endmethod

endmodule
endpackage
