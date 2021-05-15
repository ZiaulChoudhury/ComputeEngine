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
	Reg#(UInt#(6)) idx <- mkReg(0);
	Reg#(UInt#(6)) idx2 <- mkReg(0);
		
	rule cyccount;
		count <= count + 1;
	endrule

	rule configure(init == False);
		px.reset(23);	
		if(idx < 3)
			px.loadShift(8);
		else begin
			px.loadShift((7-idx2)%8);
			idx2 <= idx2+1;
		end
		if(idx == 27)
			init <= True;	
		idx <= idx + 1;
		//init <= True;
	endrule

	rule send(count%100==0 && init == True);

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

	rule receive (count%100==0 && init == True);
		let b <- px.get;
		$display(" %d ", fxptGetInt(b[0]));
		col <= col+1;
		if(col == 20) begin
			$finish(0);
		end
	endrule

endmodule
endpackage

