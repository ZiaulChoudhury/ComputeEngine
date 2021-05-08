package TubeHeader;
import datatypes::*;
import Vector::*;

interface PXL;
        method Action putA(DataType a);
        method Action putB(DataType b);
        method Action putC(DataType b);
        method Action putD(DataType b);
        method ActionValue#(DataType) get;
        method Action operation(UInt#(2) opr);
        method Action constant(DataType b);
	method Action reset(Vector#(16, Width) csr);
	method Action weights(Vector#(16, CoeffType) weights);
	method Action resetDone;
	method Action clean;
endinterface
endpackage
