package cacheFIFO;
import pulse::*;
import FixedPoint::*;
import datatypes::*;
import SpecialFIFOs:: * ;
import FIFOF::*;
import BRAMFIFO::*;
import Vector::*;

#define CACHE 8
#define WIDTH 512
#define DEBUG 0

interface CacheFIFOF;
        method Action enq(DataType a);
	method ActionValue#(Vector#(CACHE,DataType)) enQdeQ(DataType a);
	method DataType read;
	method Action clean;
	method Action dummy;
endinterface

(*synthesize*)
module mkCacheFIFOF(CacheFIFOF);
	
	Reg#(DataType) cache[CACHE];
	for(int i = 0; i<CACHE; i = i + 1)
			cache[i] <- mkReg(0);
	FIFOF#(DataType) mem <- mkSizedBRAMFIFOF(WIDTH);
	Reg#(Width) _cx <- mkReg(0);	

        method Action enq(DataType a);
		if(_cx < CACHE) begin
			cache[_cx] <= a;
			_cx <= _cx + 1;
		end
		else
			mem.enq(a);	
	endmethod
        
	method ActionValue#(Vector#(CACHE,DataType)) enQdeQ(DataType a);
		Vector#(CACHE,DataType) x = newVector;
		for(int i=0;i<CACHE; i = i + 1)
			x[i] = cache[i];	
		for(int i=1;i<CACHE; i = i + 1)
			cache[i-1] <= cache[i];
		cache[CACHE-1] <= mem.first; mem.deq;
		mem.enq(a);
		return x;	
	endmethod
	

	method DataType read;
		return cache[0];	
	endmethod
	
	method Action dummy;
			DataType x = 12;
			mem.enq(0);
	endmethod

	method Action clean;
		mem.clear;
		_cx <= 0;	
	endmethod
endmodule
endpackage

