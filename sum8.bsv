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


#define TOTAL_CONFIG_WORDS (4+4+32+32+10+16+8+4+2+1)

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
Reg#(Vector#(L0,DataType)) tL0 <- mkRegU;
Reg#(DataType) _L01[L0];

Reg#(DataType) _T1[L1];
Reg#(DataType) _L1[L1];
Reg#(Vector#(L1,DataType)) tL1 <- mkRegU;


Reg#(DataType) _T2[L2]; 
Reg#(DataType) _L2[L1];
Reg#(Vector#(L2,DataType)) tL2 <- mkRegU;
 
Reg#(DataType) _T3[L3];
Reg#(DataType) _L3[L1];
Reg#(Vector#(L3,DataType)) tL3 <- mkRegU;

Reg#(DataType) _T4[L4];
Reg#(DataType) _L4[L1];

FIFOF#(Vector#(32,DataType)) fQ <- mkSizedBRAMFIFOF(8192);
Reg#(UInt#(9)) _SFT[L0];
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
Reg#(Bit#(1)) outLevel[6];

combine [0] <- mkReg(0);
combine [1] <- mkReg(0);
combine [2] <- mkReg(0);
combine [3] <- mkReg(0);

outLevel[0] <- mkReg(0);
outLevel[1] <- mkReg(0);
outLevel[2] <- mkReg(0);
outLevel[3] <- mkReg(0);

Reg#(UInt#(11)) ldx <- mkReg(0);

Permute _PERM[L0];
for(int i=0;i<L0;i=i+1)
	_PERM[i] <- mkPermute;

Line3 lb0 <- mkLine3;
Line3 lb1 <- mkLine3;
Line3 lb2 <- mkLine3;

Reg#(DataType)       m[L0];
Reg#(DataType)       weight[L0];

Binary bL1[L1];
Binary bL2[L2];
Binary bL3[L3];
Binary bL4[L4];
for(int i=0;i<L0; i = i + 1) begin
	m[i] <- mkReg(0);
	weight[i] <- mkReg(0);
	if (i < L1)
		bL1[i] <- mkBinary;
	if (i < L2)
		bL2[i] <- mkBinary;
	if (i < L3)
		bL3[i] <- mkBinary;
	if (i < L4)
		bL4[i] <- mkBinary;
end

rule loadShifts (ldx == TOTAL_CONFIG_WORDS);
	for(int i=0;i<L0; i = i + 1) begin
		_PERM[i].setIndex(_SFT[i]);
	end
endrule

rule _LB;
		let d  <- lb0.get;
		let d1 <- lb1.get;
		let d2 <- lb2.get;
		let d3 = fQ.first; fQ.deq;
		Vector#(256, DataType) x = newVector;
		for(int i=0; i<64; i = i + 1) begin
			x[i] = d[i];
		end
		for(int i=0; i<32; i = i + 1) begin
			x[i+192] = d3[i];
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
		for(int i = 0;i<L0; i = i + 1) begin
			m[i] <= fxptTruncate(fxptMult(_T0[i],weight[i]));
			_L01[i] <= _L0[i];
		end
endrule

rule _SAD2_1;
			p1.deq;
			p2.enq(1);
			Vector#(L0,DataType) tempL0 = replicate(0);
			for(int i=0; i<L0; i = i + 1)
				tempL0[i] = m[i];
			tL0 <= unpack(pack(tempL0)>> (_LFT[0] << 4));	
			for(int i=0;i<L1;i=i+1) begin
				bL1[i].a_b(m[2*i], m[2*i+1]);
			end
endrule

rule _SAD2_2;
		p2.deq;
		p3.enq(1);
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
		p3.deq;
                p4.enq(1);
		Vector#(L1,DataType) temp = replicate(0);
                for(int i=0; i<L1; i = i + 1)
                                temp[i] = _L1[i];
		tL1 <= unpack(pack(temp)>> (_LFT[2] << 4));
	
                for(int i=0;i<L2;i=i+1) begin
                                bL2[i].a_b(_T1[2*i], _T1[2*i+1]);
                end
	
endrule


rule _SAD4_2;
		p4.deq;
		p5.enq(1);
		Vector#(L1,DataType) temp = unpack(pack(tL1)<< (_LFT[3] << 4));	
		for(int i=0;i<L2;i=i+1) begin
				_T2[i] <=  bL2[i].c;
		end
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
		 Vector#(L2,DataType) temp = replicate(0);
                 for(int i=0; i<L2; i = i + 1)
                        temp[i] = _L2[i];		
		 tL2 <= unpack(pack(temp) >> (_LFT[4] << 4));	
                 for(int i=0;i<L3;i=i+1) begin
                                bL3[i].a_b(_T2[2*i], _T2[2*i+1]);
                 end
endrule

rule _SAD8_2;
		p6.deq;
		p7.enq(1);
		Vector#(L2,DataType) temp = unpack(pack(tL2) << (_LFT[5] << 4));	
		for(int i=0;i<L3;i=i+1)begin
				_T3[i] <=  bL3[i].c;
		end
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

rule _SAD16_1;
		 p7.deq;
		 p8.enq(1);
		 Vector#(L3,DataType) temp = replicate(0);
                 for(int i=0; i<L3; i = i + 1)
                        temp[i] = _L3[i];
                 tL3 <= unpack(pack(temp) >> (_LFT[6] << 4));
                 for(int i=0;i<L4;i=i+1) begin
                                bL4[i].a_b(_T3[2*i], _T3[2*i+1]);
                 end

endrule

rule _SAD16_2;

		p8.deq;
		p9.enq(1);
		Vector#(L3,DataType) temp  = unpack(pack(tL3)<< (_LFT[7] << 4));
		for(int i=0;i<L4;i=i+1)
				_T4[i] <=  bL4[i].c;
		if(combine[3] == 1) begin	
			for(int i=0;i<L4;i=i+1) begin
				_L4[i]    <=  fxptTruncate(fxptAdd(bL4[i].c,temp[i]));
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
	p9.deq;
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
		let d = outQ.first;
		return d;
endmethod
	
method  Action loadConfig(UInt#(16) inx);
	if(ldx < 4) begin	
		for(int i = 0;i<3; i = i + 1)
			combine[i] <= combine[i+1];
		combine[3] <= unpack(truncate(pack(inx)));
	end
	else if (ldx < (4+4)) begin	
		for(int i = 0;i<3; i = i + 1)
			outLevel[i] <= outLevel[i+1];
		outLevel[3] <= unpack(truncate(pack(inx)));
	end	
	else if(ldx < (4+4+10)) begin
		for(int i = 0;i<9; i = i + 1)
			_LFT[i] <= _LFT[i+1];
		_LFT[9] <= (inx);
	end
	else if(ldx < (32+10+4+4)) begin
		for(int i=0;i<L0-1; i = i + 1)
			_SFT[i] <= _SFT[i+1];	
		_SFT[31] <= truncate(inx);
	end
	else if(ldx < (4+4+32+32+10)) begin	
		for(int i=0;i<L0-1; i = i + 1)
			weight[i] <= weight[i+1];	
		Int#(15) x = unpack(truncate(pack(inx)));
		weight[31] <= fromInt(x);
	end

	else if (ldx < (4+4+32+32+10+16))begin	
		for(int i=0;i<L1-1; i = i + 1) begin
			bL1[i].set_operation(bL1[i+1].get_operation);
		end
		UInt#(4) x = unpack(truncate(pack(inx)));
		bL1[L1-1].set_operation(x);
	end
	
	else if( ldx < (4+4+32+32+10+16+8)) begin
		for(int i=0;i<L2-1; i = i + 1) begin
			bL2[i].set_operation(bL2[i+1].get_operation);
		end
		UInt#(4) x = unpack(truncate(pack(inx)));
		bL2[L2-1].set_operation(x);
		
	end
	
	else if(ldx < (4+4+32+32+10+16+8+4)) begin
		for(int i=0;i<L3-1; i = i + 1) begin
			bL3[i].set_operation(bL3[i+1].get_operation);
		end
		UInt#(4) x = unpack(truncate(pack(inx)));
		bL3[L3-1].set_operation(x);
	end

	else if(ldx < (4+4+32+32+10+16+8+4+2)) begin
                for(int i=0;i<L4-1; i = i + 1) begin
                        bL4[i].set_operation(bL4[i+1].get_operation);
                end
                UInt#(4) x = unpack(truncate(pack(inx)));
                bL4[L4-1].set_operation(x);
        end

	else begin
		UInt#(9) x = unpack(truncate(pack(inx)));
		lb0.reset(x);
		lb1.reset(x);
		lb2.reset(x);
	end
	
	
	ldx <= ldx + 1;
endmethod

endmodule
endpackage
