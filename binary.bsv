package binary;
import datatypes::*;
import MULT_wrapper::*;

interface Binary;
        method Action   a(DataType _a);
        method Action   b(DataType _b);
	method DataType c;
	method Action operation(UInt#(4) _ox);
endinterface

(*synthesize*)
module mkBinary(Binary);
	MULT_Ifc       dut <- mkMULT;
	Reg#(DataType) _aIn <- mkReg(0);
	Reg#(DataType) _bIn <- mkReg(0);
	 	
        method Action   a(DataType _a);
		_aIn <= _a;
	endmethod
	
        method Action   b(DataType _b);
		_bIn <= _b;
	endmethod
endmodule
endpackage

