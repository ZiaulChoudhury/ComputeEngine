package flowtest;
import FixedPoint:: *;
import SpecialFIFOs:: * ;
import Vector:: *;
import FIFO:: *;
import FIFOF:: *;
import datatypes::*;
import hardware::*;

#define IMG 256

(*synthesize*)
module mkFlowTest();
	STDIN px <- mkHardware;
	Reg#(Int#(10)) rx <- mkReg(0);
	Reg#(Int#(10)) cx <- mkReg(0);
	Reg#(int) col <- mkReg(0);
	Reg#(int) count <- mkReg(0);
	Reg#(Bool) init <- mkReg(False);	
	
	rule cyccount;
		count <= count + 1;
	endrule

	rule configure(init == False);
		Vector#(3,Bit#(16)) datas = newVector;
		datas[0] = 3;//col
		datas[1] = 3;//row
		datas[2] = 16;
		px.params(datas);
		init <= True;
	endrule

	rule send(count%1==0 && init == True);

		if(cx == 15) begin
			rx <= rx + 1;
			cx <= 0;
		end
		else
			cx <= cx + 1;
		
		Int#(10) dx = (rx * cx + 10)%255;
		DataType d = fromInt(dx);
		px.put(extend(pack(d)));
	endrule

	rule receive(count%10==0 && init == True);
		let b <- px.get;
		for(int i=0;i<49;i=i+1)begin
			if(b[i] != 0) begin
				$write(fxptGetInt(b[i]));
				$write(" ");
			end
		end
		$display();
		col <= col+1;
		if(col == 195) begin
			$display("count=%d",count);
			$finish(0);
			end
	endrule

endmodule
endpackage

