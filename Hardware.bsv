package Hardware; 
import pecore::*;
import drain::*;
import Vector::*;
import datatypes::*;
import FIFOF::*;


interface Stdin;
	method ActionValue#(Bit#(512)) get;
	method Action put(Bit#(512) datas);
endinterface

#define L0 64
#define L1 32
#define L2 16
#define L3 8
#define L4 4
#define L5 2

#define TOTAL_CONFIG_WORDS (4+4+L0+L0+10+L1+L2+L3+L4+1)

(*synthesize *) 
module mkHardware(Stdin);
	PECore pe0  <- mkPECore;
	PECore pe1  <- mkPECore;
	PECore pe2  <- mkPECore;
	PECore pe3  <- mkPECore;
	//Drain drain <- mkDrain;
	FIFOF#(Vector#(32,DataType)) fQ0 <- mkFIFOF;
	FIFOF#(Vector#(32,DataType)) fQ1 <- mkFIFOF;
	FIFOF#(Vector#(32,DataType)) fQ2 <- mkFIFOF;
	FIFOF#(Vector#(32,DataType)) fQ3 <- mkFIFOF;
	
	Reg#(UInt#(2)) drI[4];
	Reg#(UInt#(2)) drO[4];
	for(int i = 0; i < 4; i = i + 1) begin
			drI[i] <- mkReg(0);
			drO[i] <- mkReg(0);
	end
	Reg#(UInt#(20)) cfgCntr <- mkReg(0);
	//################################################# data In ###########################
	rule in_P0;
		fQ0.deq;
		pe0.put(fQ0.first);
	endrule	
	
	rule out_P0_P1;
		let d <- pe0.get;
		pe1.put(d);		
	endrule

	rule out_P1_P2;
                let d <- pe1.get;
                pe2.put(d);
        endrule

        rule out_P2_P3;
                let d <- pe2.get;
                pe3.put(d);
        endrule

		
	method ActionValue#(Bit#(512)) get;
		let d <- pe3.get;
		return pack(d);
	
	endmethod
	
	method Action put(Bit#(512) datas);

			     if(cfgCntr < TOTAL_CONFIG_WORDS)
				pe0.loadConfig(unpack(truncate(datas)));
			else if (cfgCntr < 2*TOTAL_CONFIG_WORDS)	
				pe1.loadConfig(unpack(truncate(datas)));
			else if (cfgCntr < 3*TOTAL_CONFIG_WORDS)	
				pe2.loadConfig(unpack(truncate(datas)));
			else if (cfgCntr < 4*TOTAL_CONFIG_WORDS)	
				pe3.loadConfig(unpack(truncate(datas)));
			else if (cfgCntr < (4*TOTAL_CONFIG_WORDS+4)) begin
					for(int i = 0;i<3; i = i + 1)
						drI[i] <= drI[i+1];
					drI[3] <= unpack(truncate(datas)); 
			end
			else if (cfgCntr < (4*TOTAL_CONFIG_WORDS+8)) begin
					for(int i = 0;i<3; i = i + 1)
						drO[i] <= drO[i+1];
					drO[3] <= unpack(truncate(datas)); 
			end
			//else if (cfgCntr < (4*TOTAL_CONFIG_WORDS+9))
			//	drain.reset(unpack(truncate(datas)));	
			else begin	
				fQ0.enq(unpack(datas));
				//fQ1.enq(unpack(datas));
				//fQ2.enq(unpack(datas));
				//fQ3.enq(unpack(datas));
			end
			cfgCntr <= cfgCntr + 1;
	endmethod
			
endmodule
endpackage

