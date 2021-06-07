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
import binary::*;

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
Reg#(DataType) _L01[L0];
Reg#(DataType) _L02[L0];
Reg#(DataType) _L03[L0];

Reg#(DataType) _T1[L1];
Reg#(DataType) _L1[L1];
Reg#(DataType) _L12[L1];


Reg#(DataType) _T2[L2]; 
Reg#(DataType) _L2[L1];
Reg#(DataType) _L22[L1];
 
Reg#(DataType) _T3[L3];
Reg#(DataType) _L3[L1];
Reg#(DataType) _T4[L4];
Reg#(DataType) _L4[L1];

FIFOF#(Vector#(32,DataType)) fQ <- mkSizedBRAMFIFOF(8192);
Reg#(UInt#(8)) _SFT[L0];
for(int i=0;i<L0;i=i+1)
_SFT[i] <- mkReg(0);

Reg#(UInt#(16)) _LFT[L0];
_LFT[0] <- mkReg(0);
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
		_L01[i] <- mkReg(0);
		_L02[i] <- mkReg(0);
		_L03[i] <- mkReg(0);
	if(i < L1) begin
		_T1[i] <- mkReg(0);
		_L1[i] <- mkReg(0);
		_L12[i] <- mkReg(0);
		_L2[i] <- mkReg(0);
		_L22[i] <- mkReg(0);
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

FIFOF#(Bit#(1)) q0 <- mkPipelineFIFOF;
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
FIFOF#(Bit#(1)) p15 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p16 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p17 <- mkPipelineFIFOF;
FIFOF#(Bit#(1)) p18 <- mkPipelineFIFOF;


Reg#(Bit#(1)) combine[6];
Reg#(Bit#(1)) outLevel[6];

combine [0] <- mkReg(0);
combine [1] <- mkReg(0);
combine [2] <- mkReg(1);
combine [3] <- mkReg(0);

outLevel[0] <- mkReg(0);
outLevel[1] <- mkReg(0);
outLevel[2] <- mkReg(0);
outLevel[3] <- mkReg(1);

Reg#(UInt#(11)) ldx <- mkReg(0);

Permute _PERM[L0];
for(int i=0;i<L0;i=i+1)
	_PERM[i] <- mkPermute;

Line3 lb0 <- mkLine3;
Line3 lb1 <- mkLine3;
Line3 lb2 <- mkLine3;

Reg#(DataType)       m[L0];
Binary bL1[L1];
Binary bL2[L1];
Binary bL3[L1];
for(int i=0;i<L0; i = i + 1) begin
	m[i] <- mkReg(0);
	if (i < L1)
		bL1[i] <- mkBinary;
	if (i < L2)
		bL2[i] <- mkBinary;
	if (i < L3)
		bL3[i] <- mkBinary;
end


rule loadShifts (ldx == 37);
	for(int i=0;i<L0; i = i + 1) begin
		_PERM[i].setIndex(_SFT[i]);
	end
endrule

rule _LB;
		let d  <- lb0.get;
		let d1 <- lb1.get;
		let d2 <- lb2.get;
		fQ.deq;
		Vector#(96, DataType) x = newVector;
		for(int i=0; i<32; i = i + 1) begin
			x[i] = d[i];
		end
		for(int i=0;i<L0;i=i+1)
			_PERM[i].put(x);	
endrule

rule _MAC;
		for(int i=0;i<L0;i=i+1) begin
		let d <- _PERM[i].get;
			_T0[i] <= d;
			_L0[i] <= d;
		end
		p0.enq(1);
endrule

rule scale;
		p0.deq;
		p1.enq(1);
		DataType d = 1;
		for(int i = 0;i<L0; i = i + 1) begin
			m[i] <= fxptTruncate(fxptMult(_T0[i],d));
			_L01[i] <= _L0[i];
		end
endrule

rule _SAD2_1;
			p1.deq;
			p2.enq(1);
			for(int i=0; i<L0; i = i + 1)
				_L02[i] <= _L01[i];
			
			for(int i=0;i<L1;i=i+1) begin
				bL1[i].a_b(m[2*i], m[2*i+1]);
			end
endrule

rule _SAD2_2;
		p2.deq;
		p3.enq(1);
		Vector#(L0,DataType) tempL0 = replicate(0);
		for(int i=0;i<L0; i = i + 1)
			tempL0[i] = _L02[i];		
		Vector#(L0,DataType) temp = unpack(pack(tempL0)>> (_LFT[0] << 4));	
		for(int i=0;i<L1;i=i+1)
				_T1[i] <=  bL1[i].c;
		
		if (combine[0] == 1) begin	
			for(int i=0;i<L1;i=i+1) begin
				_L1[i] <= fxptTruncate(fxptAdd(bL1[i].c,temp[i]));
			end
		end
		else
			for(int i=0;i<L1;i=i+1)
				_L1[i] <= temp[i];
endrule


rule _SAD4_1;
		p3.deq;
                p4.enq(1);
                for(int i=0; i<L1; i = i + 1)
                                _L12[i] <= _L1[i];

                for(int i=0;i<L2;i=i+1) begin
                                bL2[i].a_b(_T1[2*i], _T1[2*i+1]);
                end
	
endrule


rule _SAD4_2;
		p4.deq;
		p5.enq(1);
		Vector#(L1,DataType) tempL1 = replicate(0);
		for(int i=0;i<L1; i = i + 1)
			tempL1[i] = _L12[i];		
		Vector#(L1,DataType) temp = unpack(pack(tempL1)>> (_LFT[1] << 4));	
		for(int i=0;i<L2;i=i+1)
				_T2[i] <=  bL2[i].c;
		if(combine[1] == 1) begin	
			for(int i=0;i<L2;i=i+1) begin
				_L2[i]  <=  fxptTruncate(fxptAdd(bL2[i].c,temp[i]));
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

rule _SAD8_1;
		 p5.deq;
                 p6.enq(1);
                 for(int i=0; i<L1; i = i + 1)
                        _L22[i] <= _L2[i];
                 for(int i=0;i<L3;i=i+1) begin
                                bL3[i].a_b(_T2[2*i], _T2[2*i+1]);
                 end
endrule

rule _SAD8_2;
		p6.deq;
		p7.enq(1);
		Vector#(L2,DataType) tempL2 = replicate(0);
		for(int i=0;i<L2; i = i + 1)
			tempL2[i] = _L22[i];		
		Vector#(L2,DataType) temp = unpack(pack(tempL2)>> (_LFT[2] << 4));	
		for(int i=0;i<L3;i=i+1)
				_T3[i] <=  bL3[i].c;
		if(combine[2] == 1) begin	
			for(int i=0;i<L3;i=i+1) begin
				_L3[i]    <=  fxptTruncate(fxptAdd(bL3[i].c,temp[i]));
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
		p7.deq;
		p8.enq(1);
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
	p8.deq;
		Vector#(L2,DataType) x = newVector;
		for(int i=0;i<L2;i = i + 1)
			x[i] = _L4[i];
	outQ.enq(x);
		
endrule


method Action put(Vector#(VLEN, DataType) datas) if(outQ.notFull);
		lb0.putFmap(datas[0]);	
		lb1.putFmap(datas[0]);	
		lb2.putFmap(datas[0]);
		fQ.enq(datas);	
endmethod
	
method ActionValue#(Vector#(L2,DataType)) get;
		outQ.deq;
		return outQ.first;
endmethod
	
method  Action loadConfig(UInt#(16) inx);
	if(ldx < 5) begin
		for(int i =0;i<4; i = i + 1)
			_LFT[i] <= _LFT[i+1];
		_LFT[4] <= (inx);
	end
	else begin
		for(int i=0;i<L0-1; i = i + 1)
			_SFT[i] <= _SFT[i+1];	
		_SFT[31] <= truncate(inx);
	end
	ldx <= ldx + 1;
endmethod

endmodule
endpackage
