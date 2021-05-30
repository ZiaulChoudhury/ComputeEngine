package flowtest;
import FixedPoint:: *;
import SpecialFIFOs:: * ;
import Vector:: *;
import FIFO:: *;
import FIFOF:: *;
import datatypes::*;
import sum8::*;

#define IMG 256

// Image size = IMG - (7- Kerenel Size + 1)

(*synthesize*)
module mkFlowTest();
	Sum8 px <- mkSum8;
	Reg#(Int#(10)) rx <- mkReg(0);
	Reg#(Int#(10)) cx <- mkReg(0);
	Reg#(int) col <- mkReg(0);
	Reg#(int) count <- mkReg(0);
	Reg#(Bool) init <- mkReg(False);	
	Reg#(Bool) init2 <- mkReg(False);	
	Reg#(UInt#(16)) idx <- mkReg(0);
	Reg#(UInt#(16)) idx2 <- mkReg(0);
	Reg#(UInt#(16)) idx3 <- mkReg(0);
		
	rule cyccount;
		count <= count + 1;
	endrule


	rule configure2(init == False && init2 == False);
		//px.reset(21);
		if(idx3 == 4)
			px.loadConfig(24);
		else
			px.loadConfig(0);
		idx3 <= idx3+1;
		if(idx3 == 5)	
			init <= True;
	endrule
	
	rule configure(init == True && init2 == False);
		if(idx < 3) begin
			UInt#(8) sx = 8;
			UInt#(2) tx = 0;
			sx = unpack((pack(sx) << 2) | zeroExtend(pack(tx))); 
			px.loadConfig(zeroExtend(sx));
		end
		else begin
			UInt#(8) sx = truncate((7-idx2)%8);
			UInt#(2) tx = 0;
			sx = unpack((pack(sx) << 2) | zeroExtend(pack(tx)));
			px.loadConfig(zeroExtend(sx));
			idx2 <= idx2+1;
		end
		if(idx == 27)
			init2 <= True;	
		idx <= idx + 1;
	endrule


	rule send(count%10==0 && init2 == True);

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

	rule receive (count%100==0 && init2 == True);
		let b <- px.get;
		$display(" %d %d %d ", fxptGetInt(b[0]), fxptGetInt(b[1]), fxptGetInt(b[2]));
		col <= col+1;
		if(col == 195) begin
			$finish(0);
		end
	endrule

endmodule
endpackage

