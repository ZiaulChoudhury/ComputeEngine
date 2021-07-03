package flowtest;
import FixedPoint:: *;
import SpecialFIFOs:: * ;
import Vector:: *;
import FIFO:: *;
import FIFOF:: *;
import datatypes::*;
import Hardware::*;


#define L0 64
#define L1 32
#define L2 16
#define L3 8
#define L4 4
#define L5 2


#define TOTAL_CONFIG_WORDS (4+4+L0+L0+L0+10+L1+L2+L3+L4+1)

import "BDPI" function Int#(32) readConfig(Int#(32) cId);
import "BDPI" function Int#(32) readInput(Int#(32) cxx);
import "BDPI" function Action   initialize();

#define IMG 16

//img = IMG + (8 - Kernel Size)

(*synthesize*)
module mkFlowTest();
	//PECore px <- mkPECore;
	Stdin hw <- mkHardware;
	Reg#(int) cx <- mkReg(0);
	Reg#(int) col <- mkReg(0);
	Reg#(int) cId <- mkReg(0);
	Reg#(int) img <- mkReg(0);
	Reg#(int) count <- mkReg(0);
	Reg#(Bool) init <- mkReg(False);	
	Reg#(Bool) load <- mkReg(False);	
		
	rule cyccount;
		count <= count + 1;
	endrule

	rule load_config(load == False);
			initialize();
			load <= True;
	endrule
		
	rule configure(init == False && load == True);
			Int#(32) wrd = readConfig(cId);
			hw.put(unpack(zeroExtend(pack(wrd))));
			if(cId == (4*TOTAL_CONFIG_WORDS+8)) begin
				init <= True;
				img <= unpack(pack(wrd)>>6);
			end
			cId <= cId + 1;
	endrule

	rule send(count%1==0 && init == True);
		cx <= cx + 1;
		Int#(32) pixel = readInput(cx);	
		hw.put(unpack(zeroExtend(pack(pixel))));
	endrule

	rule receive (count%1==0 && init == True);
		let b <- hw.get;
		Vector#(2,DataType) a = unpack(b);
		$write("%d", fxptGetInt(a[0]));
		$display();
		col <= col+1;
		if(col == (248*248)-1) begin
			$finish(0);
		end
	endrule

endmodule
endpackage

