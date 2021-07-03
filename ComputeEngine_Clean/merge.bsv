package merge;
import pulse::*;
import FixedPoint::*;
import datatypes::*;
import SpecialFIFOs:: * ;
import FIFOF::*;
import Vector::*;
import pulse::*;
import MULT_wrapper::*;
import BRAMFIFO::*;
import TubeHeader::*;

interface Merge;
        method Action putFmap(Bit#(1024) d);
	method Action putFilter(Bit#(1024) w);
	method DataType get1;		
	method DataType get2;		
	method DataType get3;		
	method DataType get4;		
	method DataType get5;		
	method DataType get6;		
	method DataType get7;		
	method DataType get8;		
endinterface

(*synthesize*)
module mkMerge(Merge);
	Reg#(Bit#(1024))  iReg0 <- mkReg(0);
	Reg#(Bit#(128))   iReg1[8];
	
	Reg#(Bit#(1024))   jReg0 <- mkReg(0);
		
	Reg#(Bit#(128))   jReg1[8];
	
	for(int i = 0; i<8; i = i + 1) begin
			iReg1[i] <- mkReg(0);
			jReg1[i] <- mkReg(0);
	end
	
	Reg#(DataType) oReg0[8];	
	Reg#(DataType) oReg1[8];	
	Reg#(DataType) aReg0[8];	
	//MULT_Ifc       dut[64]; 
	Reg#(DataType) dut[64];
	for(int i=0;i<64; i = i + 1) begin
			//dut[i] <- mkMULT;
			dut[i]   <- mkReg(0);
			if(i < 8) begin
				aReg0[i] <- mkReg(0);
				oReg0[i] <- mkReg(0);
				oReg1[i] <- mkReg(0);
			end
	end

	rule _K1;
			Vector#(8,Bit#(128)) d0   = unpack(iReg0);
			Vector#(8,Bit#(128)) d1   = unpack(jReg0);		
			
			iReg1[0] <= d0[0];
			iReg1[1] <= d0[1];
			iReg1[2] <= d0[2];
			iReg1[3] <= d0[3];
			iReg1[4] <= d0[4];
			iReg1[5] <= d0[5];
			iReg1[6] <= d0[6];
			iReg1[7] <= d0[7];
			
			jReg1[0] <= d1[0];
			jReg1[1] <= d1[1];
			jReg1[2] <= d1[2];
			jReg1[3] <= d1[3];
			jReg1[4] <= d1[4];
			jReg1[5] <= d1[5];
			jReg1[6] <= d1[6];
			jReg1[7] <= d1[7];
			
	endrule

	/*for(int i=0;i<8 ; i = i + 1)	
	rule _K4;
		Vector#(8,Bit#(16))  a = unpack(iReg1[i]);
		Vector#(8,Bit#(16))  b = unpack(jReg1[i]);
		for(int j = 0; j<8 ; j = j + 1) begin
			dut[i*8+j].put(a[j],b[j]); 
		end
	endrule
		
	for(int i=0;i<8; i = i + 1)
	rule _L1;
		FixedPoint#(16,16) a1 = unpack(dut[8*i]  .read_response());
		FixedPoint#(16,16) a2 = unpack(dut[8*i+1].read_response());
		FixedPoint#(16,16) a3 = unpack(dut[8*i+2].read_response());
		FixedPoint#(16,16) a4 = unpack(dut[8*i+3].read_response());
		DataType a0  =  fxptTruncate(fxptAdd(a1,a2));
		DataType b0  =  fxptTruncate(fxptAdd(a3,a4));
		oReg0[i]     <=  fxptTruncate(fxptAdd(a0,b0));
		
		FixedPoint#(16,16) a5 = unpack(dut[8*i+4]  .read_response());
		FixedPoint#(16,16) a6 = unpack(dut[8*i+5].read_response());
		FixedPoint#(16,16) a7 = unpack(dut[8*i+6].read_response());
		FixedPoint#(16,16) a8 = unpack(dut[8*i+7].read_response());
		DataType aa1 =  fxptTruncate(fxptAdd(a5,a6));
		DataType b1  =  fxptTruncate(fxptAdd(a7,a8));
	        oReg1[i]    <=  fxptTruncate(fxptAdd(aa1,b1));
	endrule
	*/
	for(int i=0;i<8 ; i = i + 1)
        rule _K4;
                Vector#(8,Bit#(16))  a = unpack(iReg1[i]);
                Vector#(8,Bit#(16))  b = unpack(jReg1[i]);
                for(int j = 0; j<8 ; j = j + 1) begin
			DataType  ax = unpack(a[j]);
			CoeffType bx = unpack(b[j]);
			//if(ax > 0)
			//$display(" %d * %d ", fxptGetInt(ax), fxptGetInt(bx));
                        dut[i*8+j] <= fxptTruncate(fxptMult(ax,bx));
                end
        endrule

        for(int i=0;i<8; i = i + 1)
        rule _L1;
                DataType a1  =  dut[8*i];
                DataType a2  =  dut[8*i+1];
                DataType a3  =  dut[8*i+2];
                DataType  a4  =  dut[8*i+3];
                DataType a0  =  fxptTruncate(fxptAdd(a1,a2));
                DataType b0  =  fxptTruncate(fxptAdd(a3,a4));
                oReg0[i]    <=  fxptTruncate(fxptAdd(a0,b0));

                DataType a5  =  dut[8*i+4];
                DataType a6  =  dut[8*i+5];
                DataType a7  =  dut[8*i+6];
                DataType a8  =  dut[8*i+7];
                DataType aa1 =  fxptTruncate(fxptAdd(a5,a6));
                DataType b1  =  fxptTruncate(fxptAdd(a7,a8));
                oReg1[i]    <=  fxptTruncate(fxptAdd(aa1,b1));
        endrule

	
	for(int i=0;i<8; i = i + 1)
	rule _L2;
		aReg0[i] <= fxptTruncate(fxptAdd(oReg0[i],oReg1[i]));
	endrule
		
        method Action putFmap(Bit#(1024) d);
			iReg0 <= d;
	endmethod
	
	method Action putFilter(Bit#(1024) w);
		jReg0 <= w;
	endmethod
	
	method DataType get1;	
		return aReg0[0];	
	endmethod
	method DataType get2;	
		return aReg0[1];	
	endmethod
	method DataType get3;	
		return aReg0[2];	
	endmethod
	method DataType get4;	
		return aReg0[3];	
	endmethod
	method DataType get5;	
		return aReg0[4];	
	endmethod
	method DataType get6;	
		return aReg0[5];	
	endmethod
	method DataType get7;	
		return aReg0[6];	
	endmethod
	method DataType get8;	
		return aReg0[7];	
	endmethod
endmodule
endpackage

