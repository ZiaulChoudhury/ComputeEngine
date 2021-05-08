package line3;
import FixedPoint::*;
import pulse::*;
import FIFO::*;
import FIFOF::*;
import datatypes::*;
import SpecialFIFOs:: * ;
import Real::*;
import Vector::*;
import cacheFIFO::*;
import sumTree::*;

#define LEN 128
#define SHIFT 5
interface Line3;
	method Action putFmap(DataType datas);
	method ActionValue#(Vector#(9,DataType)) get;
	method Action reset(Width imageSize);	
        method Action clean;
endinterface

(*synthesize*)
module mkLine3(Line3);

//############### CONFIG PARAMETERS ######################################
Reg#(Width)     alpha      <-  mkReg(3);
Reg#(Width)     img        <-  mkReg(0);
FIFOF#(Vector#(9,DataType)) outQ <- mkFIFOF;
CacheFIFOF  _LB[3];
FIFOF#(DataType)                                instream <- mkFIFOF;
Reg#(Width)                                 r1     <- mkReg(0);
Reg#(Width)                                 c1     <- mkReg(0);
Reg#(Width)                                 c2     <- mkReg(0);
Reg#(Bool)                                  collectWindow <- mkReg(False);
for(int i=0;i<3; i = i + 1)
                _LB[i] <- mkCacheFIFOF;
//#########################################################################

	//#################################### BLOCK LOADED HERE ##########################################	
	rule _putDataInLB0 (collectWindow == False);
                                if(c1 == img-1) begin
                                        c1 <= 0;
                                        if(r1 >= 2) begin
                                                collectWindow <= True;
                                        end
                                 else
                                                r1 <= r1 + 1;
                                 end
                                 else
                                 c1 <= c1 + 1;

                                 let d = instream.first; instream.deq;
                                 _LB[r1].enq(d);	
        endrule
	//###################################################################################################

	
        rule _serialShiftLeft(collectWindow == True);
                        Vector#(3,DataType) dx = newVector;
                        Vector#(9,DataType) dy = newVector;
                        for(Width i=0;i<3; i = i + 1)
                                dx[i] = _LB[i].read;
                        dy = unpack(extend(pack(dx)>>(16)));

			$display(" R1 = %d ", r1);
                        let dd = instream.first; instream.deq;
                        dy[r1] = dd;
			
			Vector#(9,DataType) window = newVector;
                       	for(UInt#(8) i=0;i<3; i = i + 1) begin
                                       Vector#(8,DataType) d <- _LB[i].enQdeQ(dy[i]);
                                       for(UInt#(8) j=0;j<3; j = j + 1) begin
                                         	window[i*3+j] = d[j];
			end
			end
			if(c1 == img-1)
                                        c1 <= 0;
                        else
                                        c1 <= c1 + 1;
                        if(c1 < img-extend(alpha-1)) begin
				outQ.enq(window); 
                        end
			
        endrule

	rule _AND_RULE;
	endrule

	rule _SHIFT_RULE;
	endrule
	

	method Action putFmap(DataType datas);
				instream.enq(datas);
	endmethod
	
	method ActionValue#(Vector#(9,DataType)) get;
			outQ.deq;
			return outQ.first;
	endmethod
	
	method Action clean;
		for(Width i=0;i<3; i = i + 1)
               		_LB[i].clean;
                c1 <= 0;
                c2 <= 0;
                r1 <= 0;
                collectWindow <= False;
		instream.clear;
		outQ.clear;
	endmethod
		
	method Action reset(Width imageSize);	
                img        <= imageSize;
	endmethod
endmodule
endpackage
