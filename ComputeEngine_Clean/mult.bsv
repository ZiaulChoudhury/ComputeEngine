package mult;
import datatypes::*;
import MULT_wrapper::*;
import FixedPoint::*;

interface Mult;
        method Action   a(DataType _a);
        method Action   b(DataType _b);
	method DataType c;
endinterface

(*synthesize*)
module mkMult(Mult);
	MULT_Ifc       dut <- mkMULT;
	Reg#(DataType) aIn <- mkReg(0);
	Reg#(DataType) bIn <- mkReg(0);
	Reg#(DataType) cOut <- mkReg(0);
	 
	rule multiply;
			dut.put(pack(aIn),pack(bIn)); 
	endrule

	rule read_output;
		FixedPoint#(16,16) a1 = unpack(dut.read_response());
		cOut <= fxptTruncate(a1);
	endrule
	
		
        method Action   a(DataType _a);
		aIn <= _a;
	endmethod
	
        method Action   b(DataType _b);
		bIn <= _b;
	endmethod
	
	method DataType c;
		return cOut;
	endmethod
	
endmodule
endpackage

