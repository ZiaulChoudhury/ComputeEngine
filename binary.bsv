package binary;
import datatypes::*;

interface Binary;
        method Action   a(DataType _a);
        method Action   b(DataType _b);
	method DataType c;
	method Action operation(UInt#(4) _ox);
endinterface

(*synthesize*)
module mkBinary(Binary);


endmodule
endpackage

