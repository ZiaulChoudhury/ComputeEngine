package pecore;
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


#define L0 64
#define L1 32
#define L2 16
#define L3 8
#define L4 4
#define L5 2


#define TOTAL_CONFIG_WORDS (4+4+L0+L0+L0+10+L1+L2+L3+L4+1)

interface PECore;
        method  Action put(Vector#(32, DataType) datas);
	method  ActionValue#(Vector#(32,DataType)) get;
	//method  ActionValue#(DataType) get(UInt#(6) index);
	method  Action loadConfig(UInt#(16) inx);
endinterface

(*synthesize*)
module mkPECore(PECore);
Reg#(DataType) _T0[L0];
Reg#(DataType) _L0[L0];
Reg#(Vector#(L0,DataType)) tL0 <- mkRegU;
Reg#(DataType) _L01[L0];

Reg#(DataType) _T1[L1];
Reg#(DataType) _L1[L1];
Reg#(Vector#(L1,DataType)) tL1 <- mkRegU;


Reg#(DataType) _T2[L2]; 
Reg#(DataType) _L2[L1];
Reg#(Vector#(L1,DataType)) tL2 <- mkRegU;
 
Reg#(DataType) _T3[L3];
Reg#(DataType) _L3[L1];
Reg#(Vector#(L1,DataType)) tL3 <- mkRegU;

Reg#(DataType) _T4[L4];
Reg#(DataType) _L4[L1];

FIFOF#(Vector#(32,DataType)) fQ <- mkSizedBRAMFIFOF(2048);
Reg#(UInt#(12)) _SFT[L0];
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
_LFT[7] <- mkReg(0);
_LFT[8] <- mkReg(0);
_LFT[9] <- mkReg(0);

FIFOF#(Vector#(L2,DataType)) outQ <- mkFIFOF;

for(int i=0;i<L0; i = i + 1) begin
		_T0[i] <- mkReg(0);
		_L0[i] <- mkReg(0);
		_L01[i] <- mkReg(0);
	if(i < L1) begin
		_T1[i] <- mkReg(0);
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
Reg#(UInt#(5)) lIn[6];

combine [0] <- mkReg(0);
combine [1] <- mkReg(0);
combine [2] <- mkReg(0);
combine [3] <- mkReg(0);

lIn[0] <- mkReg(0);
lIn[1] <- mkReg(0);
lIn[2] <- mkReg(0);
lIn[3] <- mkReg(0);

Reg#(UInt#(11)) ldx <- mkReg(0);

Permute _PERM[L0];
Permute _PERM2[L0];
Reg#(Bit#(4)) sel[L0];

for(int i=0;i<L0;i=i+1) begin
	_PERM[i]  <- mkPermute;
	_PERM2[i] <- mkPermute;
	sel[i]	  <- mkReg(0);
end

Line3 lb0 <- mkLine3;

Reg#(DataType)       m[L0];
//MULT_Ifc       	     dut[L0];
Reg#(DataType)       weight[L0];

Binary bL1[L1];
Binary bL2[L2];
Binary bL3[L3];
Binary bL4[L4];
for(int i=0;i<L0; i = i + 1) begin
	m[i] <- mkReg(0);
	weight[i] <- mkReg(0);
	//dut[i] <- mkMULT;
	if (i < L1)
		bL1[i] <- mkBinary;
	if (i < L2)
		bL2[i] <- mkBinary;
	if (i < L3)
		bL3[i] <- mkBinary;
	if (i < L4)
		bL4[i] <- mkBinary;
end

Reg#(Vector#(64,DataType)) tQ1 <- mkRegU;
Reg#(Vector#(32,DataType)) tQ2 <- mkRegU;

rule loadShifts (ldx == TOTAL_CONFIG_WORDS);
	for(int i=0;i<L0; i = i + 1) begin
		Vector#(2,UInt#(6)) s = unpack(pack(_SFT[i]));
		_PERM[i].setIndex(s[1]);
		_PERM2[i].setIndex(s[0]);
	end
endrule

rule act0;
	p10.deq;
	p11.enq(1);
endrule
rule act1;
	p11.deq;
	p12.enq(1);
endrule
rule act2;
	p12.deq;
	p13.enq(1);
endrule
rule act3;
	p13.deq;
	p14.enq(1);
endrule
rule act4;
	p14.deq;
	p15.enq(1);
endrule
rule act5;
	p15.deq;
	p0.enq(1);
endrule


rule actx;
	p0.deq;
	p1.enq(1);
endrule


rule act6;
	p1.deq;
	p2.enq(1);
endrule


rule act7;
	p2.deq;
	p3.enq(1);
endrule


rule act8;
	p3.deq;
	p4.enq(1);
endrule


rule act9;
	p4.deq;
	p5.enq(1);
endrule


rule act10;
	p5.deq;
	p6.enq(1);
endrule


rule act11;
	p6.deq;
	p7.enq(1);
endrule


rule act12;
	p7.deq;
	p8.enq(1);
endrule


rule act13;
	p8.deq;
	p9.enq(1);
endrule


rule _LB;
		let d1  <- lb0.get;
		let d2 = fQ.first; fQ.deq;
		Vector#(L0,DataType) bx = newVector;
		for(int i=0;i<L0; i = i + 1) begin
				Vector#(4,DataType) sx = unpack(d1[i]);
				UInt#(4) sxx = unpack(sel[i]>>1);
				if(sxx == 0)
					bx[i] = sx[0];
				else if(sxx == 1)
					bx[i] = sx[1];
				else if(sxx == 0)
					bx[i] = sx[2];
				else if(sxx == 0)
					bx[i] = sx[3];
		end
		
		tQ1 <= bx;
		tQ2 <= d2;
		p10.enq(0);
endrule

rule _LB1;
		for(int i=0;i<L0;i=i+1)
			_PERM2[i].put(tQ1);
endrule

rule _LB2;
		for(int i=0;i<L0;i=i+1)
			_PERM[i].put(unpack(extend(pack(tQ2))));
endrule

for(int i=0;i<L0;i=i+1) 
rule _MAC;
		let d1 <- _PERM[i].get;
		let d2 <- _PERM2[i].get;

		if(sel[i][0] == 0) begin
			_T0[i] <= d2;
			_L0[i] <= d2;
		end
		else begin
			_T0[i] <= d1;
			_L0[i] <= d1;
		end
endrule

rule scale;
		for(int i = 0;i<L0; i = i + 1) begin
			m[i] <= fxptTruncate(fxptMult(_T0[i],weight[i]));
			//dut[i].put(pack(_T0[i]),pack(weight[i]));
			_L01[i] <= _L0[i];
		end
endrule

rule _SAD2_1;
		Vector#(L0,DataType) tempL0 = replicate(0);
		for(int i=0; i<L0; i = i + 1) begin
			tempL0[i] = m[i];
			//FixedPoint#(30,2) a1 = unpack(dut[i].read_response());
			//tempL0[i] = fxptTruncate(a1);
		end
		tL0 <= unpack(pack(tempL0)>> (_LFT[0] << 4));	
		for(int i=0;i<L1;i=i+1) begin
			bL1[i].a_b(m[2*i], m[2*i+1]);
		end
endrule

rule _SAD2_2;
		Vector#(L0,DataType) temp = unpack(pack(tL0)<< (_LFT[1] << 4));	
		for(int i=0;i<L1;i=i+1) begin
				_T1[i] <=  bL1[i].c;
		end
		
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
		Vector#(L1,DataType) temp = replicate(0);
                for(int i=0; i<L1; i = i + 1)
                                temp[i] = _L1[i];
		tL1 <= unpack(pack(temp)>> (_LFT[2] << 4));
	
                for(int i=0;i<L2;i=i+1) begin
                                bL2[i].a_b(_T1[2*i], _T1[2*i+1]);
                end
	
endrule


rule _SAD4_2;
		Vector#(L1,DataType) temp = unpack(pack(tL1)<< (_LFT[3] << 4));	
		for(int i=0;i<L2;i=i+1) begin
				_T2[i] <=  bL2[i].c;
		end
		if(combine[1] == 1) begin	
			for(int i=0;i<L2;i=i+1) begin
				_L2[i]  <=  fxptTruncate(fxptAdd(bL2[i].c,temp[i]));
			end
			for(int i=L2;i<L1;i = i + 1)
				_L2[i] <= temp[i];
		end
		else
				for(int i=0;i<L1;i=i+1)
					_L2[i] <= temp[i];
				
endrule

rule _SAD8_1;
		 Vector#(L1,DataType) temp = replicate(0);
                 for(int i=0; i<L2; i = i + 1) begin
                        temp[i] = _L2[i];		
		 end
		 tL2 <= unpack(pack(temp) >> (_LFT[4] << 4));	
                 for(int i=0;i<L3;i=i+1) begin
                                bL3[i].a_b(_T2[2*i], _T2[2*i+1]);
                 end
endrule

rule _SAD8_2;
		Vector#(L1,DataType) temp = unpack(pack(tL2) << (_LFT[5] << 4));	
		for(int i=0;i<L3;i=i+1)begin
				_T3[i] <=  bL3[i].c;
		end
		if(combine[2] == 1) begin	
			for(int i=0;i<L3;i=i+1) begin
				_L3[i]    <=  fxptTruncate(fxptAdd(bL3[i].c,temp[i]));
			end
			for(int i=L3;i<L1;i=i+1)
				_L3[i]    <= temp[i]; 
		end
		else
				for(int i=0;i<L1;i=i+1)
					_L3[i] <= temp[i];
endrule

rule _SAD16_1;
		 Vector#(L1,DataType) temp = replicate(0);
                 for(int i=0; i<L1; i = i + 1) begin
                        temp[i] = _L3[i];
		 end
                 tL3 <= unpack(pack(temp) >> (_LFT[6] << 4));
                 for(int i=0;i<L4;i=i+1) begin
                                bL4[i].a_b(_T3[2*i], _T3[2*i+1]);
                 end

endrule

rule _SAD16_2;

		Vector#(L1,DataType) temp  = unpack(pack(tL3)<< (_LFT[7] << 4));
		for(int i=0;i<L4;i=i+1)
				_T4[i] <=  bL4[i].c;
		if(combine[3] == 1) begin	
			for(int i=0;i<L4;i=i+1) begin
				_L4[i]    <=  fxptTruncate(fxptAdd(bL4[i].c,temp[i]));
			end
			for(int i=L4;i<L1;i=i+1)
				_L4[i] <= temp[i];
		end
		else
				for(int i=0;i<L1;i=i+1)
					_L4[i] <= temp[i];
endrule


rule collect;
	p9.deq;
		Vector#(L2,DataType) x = newVector;
		for(int i=0;i<L2;i = i + 1)
			x[i] = _L4[i];
	outQ.enq(x);
		
endrule


method Action put(Vector#(32, DataType) datas) if(outQ.notFull);
		Vector#(4,DataType) bx = newVector;
		bx[0] = datas[lIn[0]];
		bx[1] = datas[lIn[1]];
		bx[2] = datas[lIn[2]];
		bx[3] = datas[lIn[3]];	
		lb0.putFmap(pack(bx));	
		fQ.enq(datas);	
endmethod
	
method ActionValue#(Vector#(32,DataType)) get;
		outQ.deq;
		let d = outQ.first;
		return unpack(zeroExtend(pack(d)));
endmethod
	
method  Action loadConfig(UInt#(16) inx);
	if(ldx < 4) begin	
		for(int i = 0;i<3; i = i + 1)
			combine[i] <= combine[i+1];
		combine[3] <= unpack(truncate(pack(inx)));
	end
	else if (ldx < (4+4)) begin	
		for(int i = 0;i<3; i = i + 1)
			lIn[i] <= lIn[i+1];
		lIn[3] <= unpack(truncate(pack(inx)));
	end	
	else if(ldx < (4+4+10)) begin
		for(int i = 0;i<9; i = i + 1)
			_LFT[i] <= _LFT[i+1];
		_LFT[9] <= (inx);
	end
	else if(ldx < (L0+10+4+4)) begin
		for(int i=0;i<L0-1; i = i + 1)
			_SFT[i] <= _SFT[i+1];	
		_SFT[L0-1] <= truncate(inx);
	end
	else if(ldx < (L0+L0+10+4+4)) begin
		for(int i=0;i<L0-1; i = i + 1)
			sel[i] <= sel[i+1];	
		sel[L0-1] <= pack(truncate(inx));
	end
	else if(ldx < (4+4+L0+L0+L0+10)) begin	
		for(int i=0;i<L0-1; i = i + 1)
			weight[i] <= weight[i+1];	
		Int#(15) x = unpack(truncate(pack(inx)));
		weight[L0-1] <= fromInt(x);
	end

	else if (ldx < (4+4+L0+L0+L0+10+L1))begin	
		for(int i=0;i<L1-1; i = i + 1) begin
			bL1[i].set_operation(bL1[i+1].get_operation);
		end
		UInt#(4) x = unpack(truncate(pack(inx)));
		bL1[L1-1].set_operation(x);
	end
	
	else if( ldx < (4+4+L0+L0+L0+10+L1+L2)) begin
		for(int i=0;i<L2-1; i = i + 1) begin
			bL2[i].set_operation(bL2[i+1].get_operation);
		end
		UInt#(4) x = unpack(truncate(pack(inx)));
		bL2[L2-1].set_operation(x);
		
	end
	
	else if(ldx < (4+4+L0+L0+L0+10+L1+L2+L3)) begin
		for(int i=0;i<L3-1; i = i + 1) begin
			bL3[i].set_operation(bL3[i+1].get_operation);
		end
		UInt#(4) x = unpack(truncate(pack(inx)));
		bL3[L3-1].set_operation(x);
	end

	else if(ldx < (4+4+L0+L0+L0+10+L1+L2+L3+L4)) begin
                for(int i=0;i<L4-1; i = i + 1) begin
                        bL4[i].set_operation(bL4[i+1].get_operation);
                end
                UInt#(4) x = unpack(truncate(pack(inx)));
                bL4[L4-1].set_operation(x);
        end

	else begin
		UInt#(9) x = unpack(truncate(pack(inx)));
		lb0.reset(x);
	end
		
	ldx <= ldx + 1;
endmethod

endmodule
endpackage
