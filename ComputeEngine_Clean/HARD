package Hardware; 
import pecore::*;
import drain::*;
import Vector::*;
import datatypes::*;
import FIFOF::*;


interface Stdin;
	method ActionValue#(Bit#(32)) get;
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
	Drain drain <- mkDrain;
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
	rule in_P0(drI[0] == 1);
		fQ0.deq;
		pe0.put(fQ0.first);
	endrule	
	rule in_P0_0(drI[0] == 0);
		fQ0.deq;
	endrule
		
	rule in_P1(drI[1] == 1);
		fQ1.deq;
		pe1.put(fQ1.first);
	endrule
	rule in_P1_1(drI[1] == 0);
		fQ1.deq;
	endrule
	
	rule in_P2(drI[2] == 1);
		fQ2.deq;
		pe2.put(fQ2.first);
	endrule
	rule in_P2_2(drI[2] == 0);
		fQ2.deq;
	endrule
	
	rule in_P3(drI[3] == 1);
		fQ3.deq;
		pe3.put(fQ3.first);
	endrule
	rule in_P3_3(drI[3] == 0);
		fQ3.deq;
	endrule
	//##########################################################################################
	
	rule out_P0_P1(drO[0] == 0 && drI[1] == 0) ;
		let d <- pe0.get;
		pe1.put(d);		
	endrule

	rule out_P0(drO[0] == 1);
		let d <- pe0.get;
		drain.enq0(pack(d));
	endrule

	rule out_P1_P2(drO[1] == 0 && drI[2] == 0) ;
                let d <- pe1.get;
                pe2.put(d);
        endrule

        rule out_P1(drO[1] == 1);
                let d <- pe1.get;
                drain.enq1(pack(d));
        endrule
	
        rule out_P2_P3(drO[2] == 0 && drI[3] == 0) ;
                let d <- pe2.get;
                pe3.put(d);
        endrule

        rule out_P2(drO[2] == 1);
                let d <- pe2.get;
                drain.enq2(pack(d));
        endrule
        
	rule out_P3(drO[3] == 1);
                let d <- pe3.get;
                drain.enq3(pack(d));
        endrule


		
	method ActionValue#(Bit#(32)) get;
		let d <- drain.deq;
		return truncate(d);
	
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
			else if (cfgCntr < (4*TOTAL_CONFIG_WORDS+9))
				drain.reset(unpack(truncate(datas)));	
			else begin	
				fQ0.enq(unpack(datas));
				fQ1.enq(unpack(datas));
				fQ2.enq(unpack(datas));
				fQ3.enq(unpack(datas));
			end
			cfgCntr <= cfgCntr + 1;
	endmethod
			
endmodule
endpackage

