package flowtest2;
import FixedPoint:: *;
import SpecialFIFOs:: * ;
import Vector:: *;
import FIFO:: *;
import FIFOF:: *;
import datatypes::*;
import permute::*;


(*synthesize*)
module mkFlowTest();
	Permute px <- mkPermute;
	Reg#(Int#(10)) rx <- mkReg(0);
	Reg#(Int#(10)) cx <- mkReg(0);
	Reg#(int) col <- mkReg(0);
	Reg#(int) count <- mkReg(0);
	Reg#(Bool) init <- mkReg(False);	
	
	rule cyccount;
		count <= count + 1;
	endrule

	rule configure(init == False);
		px.setIndex(30);
		init <= True;
	endrule

	rule send(count%1==0 && init == True);
		Vector#(32,DataType) mx = newVector;
	
		for(Int#(10) i = 0; i<32; i = i + 1)
			mx[i] = fromInt(i);
		
		px.put(mx);
	endrule

	rule receive(count%10==0 && init == True);
		let b <- px.get;
		$display("%d", fxptGetInt(b));
		$finish(0);
	endrule

endmodule
endpackage

