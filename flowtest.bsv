package flowtest;
import FixedPoint:: *;
import SpecialFIFOs:: * ;
import Vector:: *;
import FIFO:: *;
import FIFOF:: *;
import datatypes::*;
import line3::*;

#define IMG 256

(*synthesize*)
module mkFlowTest();
	Line3 px <- mkLine3;
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
		px.reset(23);
		if(idx3 == 4)
			px.loadShift(112);
		else
			px.loadShift(0);
		idx3 <= idx3+1;
		if(idx3 == 5)	
			init <= True;
	endrule
	
	rule configure(init == True && init2 == False);
		if(idx < 14)
			px.loadShift(8);
		else begin
			px.loadShift(truncate((7-idx2)%8));
			idx2 <= idx2+1;
		end
		if(idx == 126)
			init2 <= True;	
		idx <= idx + 1;
	endrule


	rule send(count%100==0 && init2 == True);

		if(cx == 22) begin
			rx <= rx + 1;
			cx <= 0;
		end
		else
			cx <= cx + 1;
		
		if(cx < 18) begin
		Int#(10) dx = (rx * cx + 10)%255;
		DataType d = fromInt(dx);
			px.putFmap(d);
		end
		else
			px.putFmap(0);
	endrule

	rule receive (count%100==0 && init2 == True);
		let b <- px.get;
		$display(" %d ", fxptGetInt(b[13]));
		col <= col+1;
		if(col == 20) begin
			$finish(0);
		end
	endrule

endmodule
endpackage

