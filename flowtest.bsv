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
	
	rule cyccount;
		count <= count + 1;
	endrule

	rule configure(init == False);
		px.reset(16);
		init <= True;
	endrule

	rule send(count%10==0 && init == True);

		if(cx == 15) begin
			rx <= rx + 1;
			cx <= 0;
		end
		else
			cx <= cx + 1;
		
		Int#(10) dx = (rx * cx + 10)%255;
		DataType d = fromInt(dx);
		px.putFmap(d);
	endrule

	rule receive(count%100==0 && init == True);
		let b <- px.get;
		for(int i=0;i<9;i=i+1)begin
				$write(fxptGetInt(b[i]));
				$write(" ");
		end
		$display();
		col <= col+1;
		if(col == 195) begin
			$finish(0);
		end
	endrule

endmodule
endpackage

