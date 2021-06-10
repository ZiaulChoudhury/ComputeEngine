package flowtest;
import FixedPoint:: *;
import SpecialFIFOs:: * ;
import Vector:: *;
import FIFO:: *;
import FIFOF:: *;
import datatypes::*;
import sum8::*;

#define TOTAL_CONFIG_WORDS (32+32+10+16)
import "BDPI" function Int#(32) readConfig(Int#(32) cId);
import "BDPI" function Action   initialize();

#define IMG 256

// Image size = IMG + (7- Kernel Size + 1)

(*synthesize*)
module mkFlowTest();
	Sum8 px <- mkSum8;
	Reg#(Int#(10)) rx <- mkReg(0);
	Reg#(Int#(10)) cx <- mkReg(0);
	Reg#(int) col <- mkReg(0);
	Reg#(int) cId <- mkReg(0);
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
			px.loadConfig(truncate(unpack(pack(wrd))));
			if(cId == TOTAL_CONFIG_WORDS-1)
				init <= True;
			cId <= cId + 1;
			load <= False;	
	endrule

	rule send(count%10==0 && init == True);

		if(cx == 20) begin
			rx <= rx + 1;
			cx <= 0;
		end
		else
			cx <= cx + 1;
		
		if(cx < 16 && rx < 16) begin
		Int#(10) dx = (rx * cx + 10)%255;
		DataType d = fromInt(dx);
			px.put(unpack(zeroExtend(pack(d))));
		end
		else begin
			Vector#(32,DataType) x = replicate(0);
			px.put(x);
		end
	endrule

	rule receive (count%1000==0 && init == True);
		let b <- px.get;
		$display(" %d %d %d %d %d %d %d %d ", fxptGetInt(b[0]), fxptGetInt(b[1]), fxptGetInt(b[2]), b[3],b[4],b[5],b[6],b[7]);
		col <= col+1;
		if(col == 195) begin
			$finish(0);
		end
	endrule

endmodule
endpackage

