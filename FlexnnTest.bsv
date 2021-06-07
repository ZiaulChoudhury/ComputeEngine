package FlexnnTest;
import datatypes::*;
import Vector::*;
import FixedPoint::*;
import FIFOF::*;
import Hardware::*;

import "BDPI" function Action initialize(Int#(32) ri);
import "BDPI" function Action layerInit();
import "BDPI" function Action store32(Int#(32) index, UInt#(32) d1, UInt#(32) d2, UInt#(32) d3, UInt#(32) d4, UInt#(32) d5, UInt#(32) d6, UInt#(32) d7, UInt#(32) d8);
import "BDPI" function Action storeFmaps(Int#(32) ri);
import "BDPI" function Action dump();
import "BDPI" function Int#(32) readC();
import "BDPI" function Int#(32) readT();
import "BDPI" function Int#(32) readD();
import "BDPI" function Int#(32) readO();
import "BDPI" function UInt#(32) readByte(Int#(32) ri, Int#(32) layer);


module mkFlexnnTest();
	Reg#(int) test <- mkReg(0);	
	Reg#(Bool) i0 <- mkReg(True);
	Reg#(Bool) i1 <- mkReg(False);
	Reg#(Bool) i2 <- mkReg(False);
	Reg#(Bool) i3 <- mkReg(False);
	Reg#(Bool) iD <- mkReg(False);
	Reg#(int)  _C <- mkReg(0);	
	Reg#(int)  _T <- mkReg(0);	
	Reg#(int)  _D <- mkReg(0);
	Reg#(int)  _O <- mkReg(0);
	Reg#(int)  c <- mkReg(0);	
	Reg#(int)  cx <- mkReg(0);	
	Reg#(int)  t <- mkReg(0);	
	Reg#(int)  d <- mkReg(0);	
	Reg#(int)  sx <- mkReg(0);	
	Stdin fx <- mkHardware;
	Reg#(int) clk <- mkReg(0);
	Reg#(int) layer <- mkReg(0);
	Reg#(UInt#(1)) id <- mkReg(0);
	rule _CLK;
		clk <= clk + 1;	
	endrule		

	rule _initData(iD == False);
		layerInit();
		iD <= True;
	endrule
		
	rule _A0(i0 == True && iD == True);
		initialize(layer);	
		i0 <= False;
		i1 <= True;
	endrule

	rule _A1(i1 == True && iD == True);
		_C <= readC();
		_T <= readT();
		_D <= readD();
		_O <= readO();
		i1 <= False;
		i2 <= True;
	endrule
	
	rule configureHardware(i2 == True && iD == True);
		//$display(" %d %d %d %d ", _C,_T,_D, _O);
		Vector#(32,UInt#(8)) c = newVector;
		for(int i=0;i<32; i = i + 1)
			c[i] = truncate(readByte(i,layer));
		fx.put(pack(c));
		i2 <= False;
		i3 <= True;
	endrule

	rule configureRoutes(i3 == True && t < _T && iD == True);
		Vector#(32,UInt#(8)) route = newVector;
		for(int i=0;i<32; i = i + 1) begin
			route[i] = truncate(readByte(_C+t+i, layer));
		end
		fx.put(pack(route));
		t <= t + 32;		
	endrule

	rule sendInput(i3==True && t==_T && d < _D && iD == True); //&& clk%10 == 0 && !(clk>50 && clk < 20000));
		Vector#(32,UInt#(8))  x = newVector;
		for(int i=0;i<32; i = i + 1) begin
			x[i] = truncate(readByte(_C+t+d+i,layer));
			//$display("%d", x[i]);
		end
		//$display("-----------------------------------");
		fx.put(pack(x));
		d <= d + 32;
	endrule
	
	rule _Out(iD == True); //(clk%5 == 0);
                let dm <- fx.get;
                Vector#(8,UInt#(32)) dx = unpack(dm);
		store32(sx, dx[0],dx[1], dx[2], dx[3], dx[4], dx[5], dx[6], dx[7]);
                if(cx == _O - 1) begin
                        cx <= 0;
			test <= 0;
			i0 <= True;
			i1 <= False;
			i2 <= False;
			i3 <= False;
			c <= 0;
			t <= 0;
			d <= 0;
			sx <= 0;
			storeFmaps(layer);
			$display("BATCH %d DONE ", layer);
			if(layer == 3) begin
				dump();
				$finish(0);
			end
			else
				layer <= layer + 1;
                end
                else begin
			sx <= sx + 8;
                	cx <= cx + 1;
		end

        endrule

	
endmodule
endpackage
