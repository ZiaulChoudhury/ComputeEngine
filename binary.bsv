package binary;
import FixedPoint::*;
import datatypes::*;
import Vector::*;

interface Binary;
        method Action   a_b(DataType _a,DataType _b);
	method DataType c;
	method Action operation(UInt#(4) _ox);
endinterface

(*synthesize*)
module mkBinary(Binary);
	Reg#(DataType) cOut <- mkReg(0);
        method Action   a_b(DataType _a,DataType _b);
		cOut <= fxptTruncate(fxptAdd(_a,_b));
	endmethod
	method DataType c;
		return cOut;
	endmethod
endmodule
endpackage

