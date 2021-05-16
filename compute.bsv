package compute;

interface Compute;
	method Action putFmap(DataType datas);
	//method ActionValue#(Vector#(256,DataType)) get;
	method ActionValue#(DataType) get(UInt#(8) index);
	method Action reset(Width imageSize);	
        method Action clean;
	method  Action loadShift(UInt#(16) inx);
endinterface

(*synthesize*)
module mkCompute(Compute);


endmodule
endpackage

