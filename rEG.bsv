package rEG;
	
	import datatypes::*;
	import FIFOF::*;
	import Vector::*;
	import FixedPoint:: *;
	import SpecialFIFOs::*;

//#define param 32	


	interface REGIN;
		method Action enq(DataType datas);
		method ActionValue#(Vector#(7,DataType)) get;
		method Action reset();
		method Action paramrEG(Vector#(2,Bit#(16)) datas);
	endinterface 

	(*synthesize*)
	module mkrEG(REGIN);

		Reg#(DataType) inR[7];
		Reg#(Bit#(16)) count <- mkReg(0);
		Reg#(Bit#(16)) count2 <- mkReg(0);
		Reg#(Bit#(16)) count3 <- mkReg(0);
		Reg#(Bit#(16)) _fcol <- mkReg(-1);
		Reg#(Bit#(16)) param <- mkReg(0);
		FIFOF#(DataType) inQ <- mkFIFOF;
		FIFOF#(Bit#(1)) sQ0 <- mkPipelineFIFOF;
		
		for(int i=0;i<7;i=i+1)begin
			inR[i] <- mkReg(0); 
		end

		rule r1 (count < _fcol && count3 < param);
			count <= count+1;
			inR[count] <= inQ.first;
			inQ.deq;
			count3 <= count3+1;
		endrule

		rule r11 (count < _fcol && count2 == param && count3 == param);
			count <= count+1;
			inR[count] <= 0;
		endrule

		rule r2 (count == _fcol);
			sQ0.enq(1);
			//$display("here");
		endrule

		method Action reset();
				//$display("In reset");
				count <= 0;
				count2 <=0;
				count3 <= 0;
				sQ0.clear();
				inQ.clear();
				for(int i=0;i<7;i=i+1)
					inR[i] <= 0;
		endmethod	

		method Action enq(DataType datas) if(count2 < param);
			inQ.enq(datas);
			count2 <= count2+1;
		endmethod

		method ActionValue#(Vector#(7,DataType)) get;
			sQ0.deq;
			//$display("In reg get");
			count <= _fcol-1;
			for(int i=0;i<6;i=i+1)
				inR[i] <= inR[i+1];
			Vector#(7,DataType) d = newVector;
			for(int i=0;i<7;i=i+1)
				d[i] = inR[i];
			return d;	
		endmethod

		method Action paramrEG(Vector#(2,Bit#(16)) datas);
			_fcol <= datas[0];
			param <= datas[1];
		endmethod
	
	endmodule

endpackage