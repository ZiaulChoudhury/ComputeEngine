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
//import sum8::*;

interface Line3;
	method Action  putFmap(Bit#(64) datas);
	method ActionValue#(Vector#(64,Bit#(64))) get;
	method Action  reset(Width imageSize);	
        method Action  clean;
	method  Action loadShift(UInt#(16) inx);
endinterface

(*synthesize*)
module mkLine3(Line3);

//############### CONFIG PARAMETERS ######################################
Reg#(Width)     alpha      <-  mkReg(8);
Reg#(Width)     img        <-  mkReg(0);
FIFOF#(Vector#(64,Bit#(64))) outQ <- mkFIFOF;
CacheFIFOF  _LB[8];
FIFOF#(Bit#(64))                                instream <- mkFIFOF;
Reg#(Width)                                 r1     <- mkReg(0);
Reg#(Width)                                 c1     <- mkReg(0);
Reg#(Width)                                 c2     <- mkReg(0);
Reg#(Bool)                                  collectWindow <- mkReg(False);
for(int i=0;i<8; i = i + 1)
                _LB[i] <- mkCacheFIFOF;

//Sum8 sum <- mkSum8;

//#########################################################################

	//#################################### BLOCK LOADED HERE ##########################################	
	rule _putDataInLB0 (collectWindow == False);
                                if(c1 == img-1) begin
                                        c1 <= 0;
                                        if(r1 >= 7) begin
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
                        Vector#(8,Bit#(64)) dx = newVector;
                        Vector#(64,Bit#(64)) dy = newVector;
                        for(Width i=0;i<8; i = i + 1)
                                dx[i] = _LB[i].read;
                        dy = unpack(extend(pack(dx)>>(64)));

                        let dd = instream.first; instream.deq;
                        dy[r1] = dd;
			
			Vector#(64,Bit#(64)) d = newVector;
			Vector#(64,Bit#(64)) window = newVector;
                       	for(UInt#(8) i=0;i<8; i = i + 1) begin
                                       Vector#(8,Bit#(64)) dmm <- _LB[i].enQdeQ(dy[i]);
                                       for(UInt#(8) j=0;j<8; j = j + 1) begin
                                         	window[i*8+j] = dmm[j];	
					end
			end
			window[63]=0;
						/*window[0] = d[0];
						window[1] = d[1];
						window[2] = d[2];	
						window[3] = d[8];
						window[4] = d[9];
						window[5] = d[10];
						window[6] = d[16];
						window[7] = d[17];
						window[8] = d[18];*/
			if(c1 == img-1)
                                        c1 <= 0;
                        else
                                        c1 <= c1 + 1;
                        if(c1 < img-extend(alpha-1)) begin
				outQ.enq(window); 
                        end
			
        endrule

	
	method Action putFmap(Bit#(64) datas);
				instream.enq(datas);
	endmethod
	
	method ActionValue#(Vector#(64,Bit#(64))) get;
			outQ.deq;
			return outQ.first;
	endmethod
	
	method Action clean;
		for(Width i=0;i<8; i = i + 1)
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
	/*method  Action loadShift(UInt#(16) inx);
		sum.loadShift(inx);
	endmethod*/
endmodule
endpackage


