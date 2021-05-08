package mapVector;
import FIFOF::*;
import Vector::*;
import datatypes::*;
import SpecialFIFOs:: * ;
import FixedPoint::*;

#define LEN 64

interface MapVector;
        method Action put(Vector#(LEN,DataType) d);
	method ActionValue#(Vector#(2,Vector#(LEN,DataType))) get;
   	method Action clean;
	method Action activate;
	method Action reset(Width _a, Width str, Width ro);
endinterface

(*synthesize*)
module mkMapVector(MapVector);

	Reg#(UInt#(5)) stride 		  		<- mkReg(1);
	Reg#(UInt#(4)) roof 		  		<- mkReg(1);
	Reg#(Width) alpha 		  		<- mkReg(0);
	Reg#(Vector#(LEN,DataType)) inQ 		<- mkRegU;
	Reg#(Vector#(2,Vector#(LEN,DataType))) outQ 		<- mkRegU;
	Reg#(Vector#(LEN,DataType)) 		_x 	<- mkRegU;
	Reg#(Vector#(LEN,DataType)) 		_Wx2 	<- mkRegU;
	Reg#(Vector#(LEN,DataType)) 		_Wx3 	<- mkRegU;
	Reg#(Vector#(2,Vector#(LEN,DataType))) _x2 	<- mkRegU;
        Reg#(Bit#(1)) p0 <- mkReg(0);	
        Reg#(Bit#(1)) c0 <- mkReg(0);	
        Reg#(Bit#(1)) p1 <- mkReg(0);	
        Reg#(Bit#(1)) c1 <- mkReg(0);	
        Reg#(Bit#(1)) p2 <- mkReg(0);	
        Reg#(Bit#(1)) c2 <- mkReg(0);	
        Reg#(Bit#(1)) p3 <- mkReg(0);	
        Reg#(Bit#(1)) c3 <- mkReg(0);	
        Reg#(Bit#(1)) p4 <- mkReg(0);	
        Reg#(Bit#(1)) c4 <- mkReg(0);	
	
	rule _x3 (alpha == 3);
			let d = inQ;
			Vector#(LEN,DataType) temp = d;
                        for(int i=1;i<7;i = i + 1) begin
                                for(int j=0;j<9; j=j+1)
                                        temp[i*9 + j] = d[i*3 + j];
			end
		         _x <= temp;
	endrule
	
	rule _y3(alpha == 3);
			Vector#(LEN,DataType) xx = replicate(0);
                        Vector#(2,Vector#(LEN,DataType))  _temp$ = replicate(xx);
                        Vector#(7,Vector#(9,DataType))   _temp$$ = unpack(truncate(pack(_x)));
                        for(int k = 0; k < 7; k = k + 1) begin
                                for(int i=0;i<8;i=i+1)
                                        _temp$[0][k*8+i] = _temp$$[k][i];
                                for(int i=0;i<1;i=i+1)
                                        _temp$[1][k+i] = _temp$$[k][8+i];
                        end			
			_x2 <= _temp$;	
	endrule

	rule _x5 (alpha == 5);
                        let d = inQ;
                        Vector#(LEN,DataType) temp = d;
                        for(int i=1;i<2;i = i + 1) begin
                                for(int j=0;j<25; j=j+1)
                                        temp[i*25 + j] = d[i*5 + j];
                        end
                         _x <= temp;
        endrule

        rule _y5 (alpha == 5);
                        Vector#(LEN,DataType) xx = replicate(0);
                        Vector#(2,Vector#(LEN,DataType))   _temp$  = replicate(xx);
                        Vector#(2,Vector#(25,DataType))    _temp$$ = unpack(truncate(pack(_x)));

                        for(int k = 0; k < 2; k = k + 1) begin
                                for(int i=0;i<24;i=i+1)
                                        _temp$[0][k*24+i] = _temp$$[k][i];
                                for(int i=0;i<1;i=i+1)
                                        _temp$[1][k+i] = _temp$$[k][24+i];
                        end
                        _x2 <= _temp$;
        endrule

	
	rule f_0(stride == 1);
		Vector#(4,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(32,Vector#(4,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_1(stride == 2);
		Vector#(8,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(16,Vector#(8,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_2(stride == 3);
		Vector#(12,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(11,Vector#(12,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_3(stride == 4);
		Vector#(16,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(8,Vector#(16,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_4(stride == 5);
		Vector#(20,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(7,Vector#(20,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_5(stride == 6);
		Vector#(24,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(6,Vector#(24,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_6(stride == 7);
		Vector#(28,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(5,Vector#(28,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_7(stride == 8);
		Vector#(32,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(4,Vector#(32,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_8(stride == 9);
		Vector#(36,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(4,Vector#(36,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_9(stride == 10);
		Vector#(40,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(4,Vector#(40,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_10(stride == 11);
		Vector#(44,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(3,Vector#(44,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_11(stride == 12);
		Vector#(48,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(3,Vector#(48,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_12(stride == 13);
		Vector#(52,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(3,Vector#(52,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_13(stride == 14);
		Vector#(56,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(3,Vector#(56,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule

	rule f_14(stride == 15);
		Vector#(60,DataType) z = unpack(truncate(pack(_x2[0])));
		Vector#(3,Vector#(60,DataType)) x = replicate(z);
		_Wx2 <= unpack(truncate(pack(x)));
	endrule



	rule g_1(roof == 1);
		Vector#(1,DataType) z = unpack(truncate(pack(_x2[1])));
                Vector#(16,Vector#(1,DataType)) x = replicate(z);
                _Wx3 <= unpack(extend(pack(x)));
	endrule
	rule g_2(roof == 2);
		Vector#(2,DataType) z = unpack(truncate(pack(_x2[1])));
                Vector#(8,Vector#(2,DataType)) x = replicate(z);
                _Wx3 <= unpack(extend(pack(x)));
	endrule
	rule g_3(roof == 3);
		Vector#(3,DataType) z = unpack(truncate(pack(_x2[1])));
                Vector#(6,Vector#(3,DataType)) x = replicate(z);
                _Wx3 <= unpack(extend(pack(x)));
	endrule
	rule g_4(roof == 4);
		Vector#(4,DataType) z = unpack(truncate(pack(_x2[1])));
                Vector#(4,Vector#(4,DataType)) x = replicate(z);
                _Wx3 <= unpack(extend(pack(x)));
	endrule
	rule g_5(roof == 5);
		Vector#(5,DataType) z = unpack(truncate(pack(_x2[1])));
                Vector#(4,Vector#(5,DataType)) x = replicate(z);
                _Wx3 <= unpack(extend(pack(x)));
	endrule	
	rule g_6(roof == 6);
		Vector#(6,DataType) z = unpack(truncate(pack(_x2[1])));
                Vector#(3,Vector#(6,DataType)) x = replicate(z);
                _Wx3 <= unpack(extend(pack(x)));
	endrule
	rule g_7(roof == 7);
		Vector#(7,DataType) z = unpack(truncate(pack(_x2[1])));
                Vector#(3,Vector#(7,DataType)) x = replicate(z);
                _Wx3 <= unpack(extend(pack(x)));
	endrule
	
	
	rule _b3;
			Vector#(2,Vector#(LEN,DataType)) x = newVector;
			x[0] = _Wx2;
			x[1] = _Wx3;
			outQ <= x;
	endrule
	
	
	rule a1((p0^c0)==1);
                c0 <= p0;
                p1 <= ~p1;
        endrule
	rule a2((p1^c1)==1);
                c1 <= p1;
                p2 <= ~p2;
        endrule	
	rule a3((p2^c2)==1);
                c2 <= p2;
                p3 <= ~p3;
        endrule
	
	rule a4((p3^c3)==1);
                c3 <= p3;
                p4 <= ~p4;
        endrule
	
	method Action activate;
			p0 <= ~p0;
	endmethod
	method Action reset(Width _a, Width str, Width ro);
			alpha  <= _a;
			stride <= truncate(str);
			roof   <= truncate(ro);
	endmethod
	
        method Action put(Vector#(LEN,DataType) d);
			inQ <= (d);
	endmethod
		
	method ActionValue#(Vector#(2,Vector#(LEN,DataType))) get if((c4^p4)==1);
			c4 <= p4;
			return outQ;
	endmethod

	method Action clean;
		p0 <= 0;
		c0 <= 0;
		p1 <= 0;
		c1 <= 0;
		p2 <= 0;
		c2 <= 0;
		p3 <= 0;
		c3 <= 0;
		p4 <= 0;
		c4 <= 0;
	endmethod
	
endmodule
endpackage

