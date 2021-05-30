package binary;
import FixedPoint::*;
import datatypes::*;
import MULT_wrapper::*;
import Vector::*;

interface Binary;
        method Action   a(DataType _a);
        method Action   b(DataType _b);
	method Action   _L0In(DataType _l0, DataType _l1);
	method DataType c;
	method Vector#(2,DataType) _L0;
	method Action operation(UInt#(4) _ox);
endinterface

(*synthesize*)
module mkBinary(Binary);
	MULT_Ifc       dut <- mkMULT;
	Reg#(DataType) _aIn <- mkReg(0);
	Reg#(DataType) _bIn <- mkReg(0);
	Reg#(Vector#(2,DataType))  __L0 <- mkRegU;
	Reg#(Vector#(2,DataType))  __L1 <- mkRegU;
	Reg#(Vector#(2,DataType))  l2   <- mkRegU;
	Reg#(Vector#(2,DataType))  __L3 <- mkRegU;

	Reg#(DataType)  __M0 <- mkReg(0);
	Reg#(DataType)  __M1 <- mkReg(0);
	Reg#(DataType)  __M2 <- mkReg(0);
	
	
	rule compute;
		__M0 <= fxptTruncate(fxptAdd(_aIn, _bIn));
	        __L1 <=  __L0;	
	endrule
	
	rule store;
	       l2 <=  __L1;
		__M1 <= __M0;	
	endrule

	rule forward;
		__L3 <= l2;
		__M2 <= __M1;
	endrule

		
        method Action   a(DataType _a);
		_aIn <= _a;
	endmethod
	
        method Action   b(DataType _b);
		_bIn <= _b;
	endmethod
	
	method Action   _L0In(DataType _l0, DataType _l1);
			  Vector#(2,DataType) x = newVector;
				x[0] = _l0;
				x[1] = _l1;
			__L0 <= x;
	endmethod
	
	method DataType c;
			return __M2;
	endmethod
	
	method Vector#(2,DataType) _L0;
			return __L3;
	endmethod
	
endmodule
endpackage

