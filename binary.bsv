package binary;
import FixedPoint::*;
import datatypes::*;
import Vector::*;
import MULT_wrapper::*;

interface Binary;
        method Action   a_b(DataType _a,DataType _b);
	method DataType c;
	method Action set_operation(UInt#(4) _ox);
	method UInt#(4) get_operation;
endinterface

(*synthesize*)
module mkBinary(Binary);
	Reg#(DataType) cOut <- mkReg(0);
	Reg#(UInt#(4)) op   <- mkReg(0);
	//MULT_Ifc       	     dut <- mkMULT;
		
        method Action   a_b(DataType _a,DataType _b);
		if(op == 1)
			cOut <= fxptTruncate(fxptAdd(_a,_b));
		else if(op == 2)	
			cOut <= fxptTruncate(fxptMult(_a,_b));
			//dut.put(pack(_a), pack(_b));
		else if(op == 3)	
			cOut <= fxptTruncate(max(_a,_b));
		else if(op == 4)	
			cOut <= fxptTruncate(min(_a,_b));
		else if(op == 0)
			cOut <= 0;
	endmethod
	
	method DataType c;
		//FixedPoint#(30,2) a1 = unpack(dut.read_response());
		//if(op == 2)
		//	return fxptTruncate(a1);
		//else
			return cOut;
	endmethod
	method Action set_operation(UInt#(4) _ox);
		op <= _ox;
	endmethod
	method UInt#(4) get_operation;
		return op;
	endmethod
endmodule
endpackage

