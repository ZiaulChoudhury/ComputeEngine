package hardware;
import datatypes::*;
import Vector::*;
import FixedPoint::*;
import FIFOF::*;
import TubeHeader::*;
import BRAMFIFO::*;
import SpecialFIFOs::*;
import rEG::*;

interface STDIN;
        method ActionValue#(Vector#(49,DataType)) get;
        method Action put(Bit#(128) datas);
        method Action params(Vector#(3,Bit#(16)) datas);
endinterface

(*synthesize *)
module mkHardware(STDIN);

	    REGIN rEG[7];
        Reg#(Bit#(4)) regId[8];
        FIFOF#(DataType) bram[8];
	    FIFOF#(DataType) inQ <- mkSizedFIFOF(2);
	    Reg#(UInt#(8)) memId <- mkReg(0);
        Reg#(Bit#(16)) img <- mkReg(0);
        Reg#(Bit#(16)) param <- mkReg(0);
        Reg#(Bit#(16)) col <- mkReg(0);
        Reg#(Bit#(8)) clr <- mkReg(0);
        Reg#(Bit#(16)) update <- mkReg(0);
        Reg#(Bit#(16)) memcount[8];
        Reg#(Bit#(8)) _frow <- mkReg(20);
        Vector#(7,Reg#(DataType)) _d0 <- replicateM(mkReg(0));
        Vector#(7,Reg#(DataType)) _d1 <- replicateM(mkReg(0));
        Vector#(7,Reg#(DataType)) _d2 <- replicateM(mkReg(0));
        Vector#(7,Reg#(DataType)) _d3 <- replicateM(mkReg(0));
        Vector#(7,Reg#(DataType)) _d4 <- replicateM(mkReg(0));
        Vector#(7,Reg#(DataType)) _d5 <- replicateM(mkReg(0));
        Vector#(7,Reg#(DataType)) _d6 <- replicateM(mkReg(0));
        FIFOF#(Bit#(1)) _sQ <- mkPipelineFIFOF;
        for(int i=0; i<8; i=i+1)begin
                bram[i]                 <- mkSizedBRAMFIFOF(1024);
                regId[i]                   <- mkReg(0);
                memcount[i]             <- mkReg(0);
                if(i<7) begin
                        rEG[i]          <- mkrEG;       
                end        
        end        
        Reg#(Bool) i0 			<- mkReg(False);

        rule configure0 (i0 == True && _frow == 1);
                for(Bit#(4) i=0;i<1;i=i+1)
                    regId[i] <= i+1;
                i0 <= False;
        endrule

        rule configure1 (i0 == True && _frow == 2);
                for(Bit#(4) i=0;i<2;i=i+1)
                    regId[i] <= i+1;
                i0 <= False;
        endrule

        rule configure2 (i0 == True && _frow == 3);
                for(Bit#(4) i=0;i<3;i=i+1)
                    regId[i] <= i+1;
                i0 <= False;
        endrule

        rule configure3 (i0 == True && _frow == 4);
                for(Bit#(4) i=0;i<4;i=i+1)
                    regId[i] <= i+1;
                i0 <= False;
        endrule

        rule configure4 (i0 == True && _frow == 5);
                for(Bit#(4) i=0;i<5;i=i+1)
                    regId[i] <= i+1;
                i0 <= False;
        endrule

        rule configure5 (i0 == True && _frow == 6);
                for(Bit#(4) i=0;i<6;i=i+1)
                    regId[i] <= i+1;
                i0 <= False;
        endrule

        rule configure6 (i0 == True && _frow == 7);
                for(Bit#(4) i=0;i<7;i=i+1)
                    regId[i] <= i+1;
                i0 <= False;
        endrule

                rule _colupdate(col == img);
                        col <= 0;
                        memId <= (memId + 1)%(unpack(_frow)+1);//8
                endrule               

                rule regIdupdate(update == param);
                                update <= 0;
                                for(Bit#(8) i=0;i<8;i=i+1)//8
                                        regId[i] <= regId[(_frow+i)%(_frow+1)];//(7+i)%8       
                                for(Bit#(8) j=0;j<7;j=j+1)//7
                                    rEG[j].reset();
                endrule

                rule clrbram0(clr == 0 && update == param && memcount[0] == img);
                        bram[0].clear();
                        clr <= (clr+1)% (unpack(_frow)+1);//8
                        memcount[0] <= 0;
                endrule

                rule clrbram1(clr == 1 && update == param && memcount[1] == img);
                        bram[1].clear();
                        clr <= (clr+1)% (unpack(_frow)+1);//8
                        memcount[1] <= 0;
                endrule
                
                rule clrbram2(clr == 2 && update == param && memcount[2] == img);
                        bram[2].clear();
                        clr <= (clr+1)%(unpack(_frow)+1);//8
                        memcount[2] <= 0;
                endrule
                
                rule clrbram3(clr == 3 && update == param && memcount[3] == img);
                        bram[3].clear();
                        clr <= (clr+1)%(unpack(_frow)+1);//8
                        memcount[3] <= 0;
                endrule

                rule clrbram4(clr == 4 && update == param && memcount[4] == img);
                        bram[4].clear();
                        clr <= (clr+1)%(unpack(_frow)+1);//8
                        memcount[4] <= 0;
                endrule

                rule clrbram5(clr == 5 && update == param && memcount[5] == img);
                        bram[5].clear();
                        clr <= (clr+1)%(unpack(_frow)+1);//8
                        memcount[5] <= 0;
                endrule
                
                rule clrbram6(clr == 6 && update == param && memcount[6] == img);
                        bram[6].clear();
                        clr <= (clr+1)%(unpack(_frow)+1);//8
                        memcount[6] <= 0;
                endrule
                
                rule clrbram7(clr == 7 && update == param && memcount[7] == img);
                        bram[7].clear();
                        clr <= (clr+1)%(unpack(_frow)+1);//8
                        memcount[7] <= 0;
                endrule
                		
        
                rule _QMem00 (memId == 0 && memcount[0] < img);
                        inQ.deq;
                        bram[0].enq(inQ.first);
                        memcount[0]<= memcount[0]+1;
                endrule

                rule _QMem101 (memId == 0 && memcount[0] == img);
                        col <= col+1;
                endrule

	    rule _QMem01 (memId != 0 && regId[0] == 1);
                let d = bram[0].first;bram[0].deq;
                rEG[0].enq(d);
                bram[0].enq(d);
        endrule

        rule _QMem02 (memId != 0 && regId[0] == 2);
                let d = bram[0].first;bram[0].deq;
                rEG[1].enq(d);
                bram[0].enq(d);
        endrule

        rule _QMem03 (memId != 0 && regId[0] == 3);
                let d = bram[0].first;bram[0].deq;
                rEG[2].enq(d);
                bram[0].enq(d);
        endrule

         rule _QMem04 (memId != 0 && regId[0] == 4);
                let d = bram[0].first;bram[0].deq;
                rEG[3].enq(d);
                bram[0].enq(d);
        endrule

        rule _QMem05 (memId != 0 && regId[0] == 5);
                let d = bram[0].first;bram[0].deq;
                rEG[4].enq(d);
                bram[0].enq(d);
        endrule

        rule _QMem06 (memId != 0 && regId[0] == 6);
                let d = bram[0].first;bram[0].deq;
                rEG[5].enq(d);
                bram[0].enq(d);
        endrule
		
        rule _QMem07 (memId != 0 && regId[0] == 7);
                let d = bram[0].first;bram[0].deq;
                rEG[6].enq(d);
                bram[0].enq(d);
        endrule
        
                rule _QMem10 (memId == 1 && memcount[1] < img);
                        inQ.deq;
                        bram[1].enq(inQ.first);
                        memcount[1] <= memcount[1]+1;
                endrule

                rule _QMem201 (memId == 1 && memcount[1] == img);
                        col <= col+1;
                endrule

        rule _QMem11 (memId != 1 && regId[1] == 1);
                let d = bram[1].first;bram[1].deq;
                rEG[0].enq(d);
                bram[1].enq(d);
        endrule

        rule _QMem12 (memId != 1 && regId[1] == 2);
                let d = bram[1].first;bram[1].deq;
                rEG[1].enq(d);
                bram[1].enq(d);
        endrule

        rule _QMem13 (memId != 1 && regId[1] == 3);
                let d = bram[1].first;bram[1].deq;
                rEG[2].enq(d);
                bram[1].enq(d);
        endrule

        rule _QMem14 (memId != 1 && regId[1] == 4);
                let d = bram[1].first;bram[1].deq;
                rEG[3].enq(d);
                bram[1].enq(d);
        endrule

        rule _QMem15 (memId != 1 && regId[1] == 5);
                let d = bram[1].first;bram[1].deq;
                rEG[4].enq(d);
                bram[1].enq(d);
        endrule

        rule _QMem16 (memId != 1 && regId[1] == 6);
                let d = bram[1].first;bram[1].deq;
                rEG[5].enq(d);
                bram[1].enq(d);
        endrule

         rule _QMem17 (memId != 1 && regId[1] == 7);
                let d = bram[1].first;bram[1].deq;
                rEG[6].enq(d);
                bram[1].enq(d);
        endrule

                rule _QMem20 (memId == 2 && memcount[2]<img);
                        inQ.deq;
                        bram[2].enq(inQ.first);
                        memcount[2] <= memcount[2]+1;
                endrule

                rule _QMem301 (memId == 2 && memcount[2] == img);
                        col <= col+1;
                endrule

	    rule _QMem21 (memId != 2 && regId[2] == 1);
                let d = bram[2].first;bram[2].deq;
                rEG[0].enq(d);
                bram[2].enq(d);
        endrule

        rule _QMem22 (memId != 2 && regId[2] == 2);
                let d = bram[2].first;bram[2].deq;
                rEG[1].enq(d);
                bram[2].enq(d);
        endrule

        rule _QMem23 (memId != 2 && regId[2] == 3);
                let d = bram[2].first;bram[2].deq;
                rEG[2].enq(d);
                bram[2].enq(d);
        endrule

        rule _QMem24 (memId != 2 && regId[2] == 4);
                let d = bram[2].first;bram[2].deq;
                rEG[3].enq(d);
                bram[2].enq(d);
        endrule

        rule _QMem25 (memId != 2 && regId[2] == 5);
                let d = bram[2].first;bram[2].deq;
                rEG[4].enq(d);
                bram[2].enq(d);
        endrule

        rule _QMem26 (memId != 2 && regId[2] == 6);
                let d = bram[2].first;bram[2].deq;
                rEG[5].enq(d);
                bram[2].enq(d);
        endrule

        rule _QMem27 (memId != 2 && regId[2] == 7);
                let d = bram[2].first;bram[2].deq;
                rEG[6].enq(d);
                bram[2].enq(d);
        endrule
	
                rule _QMem30 (memId == 3 && memcount[3] < img);
                        inQ.deq;
                        bram[3].enq(inQ.first);
                        //fxptWrite(6,inQ.first);
                        memcount[3] <= memcount[3]+1;
                endrule
        	
                rule _QMem401 (memId == 3 && memcount[3] == img);
                        col <= col+1;
                endrule

        rule _QMem31 (memId != 3  && regId[3] == 1);
                 let d = bram[3].first;bram[3].deq;
                rEG[0].enq(d);
                bram[3].enq(d);
        endrule

        rule _QMem32 (memId != 3  && regId[3] == 2);
                let d = bram[3].first;bram[3].deq;
                rEG[1].enq(d);
                bram[3].enq(d);
        endrule

        rule _QMem33 (memId != 3  && regId[3] == 3);
                let d = bram[3].first;bram[3].deq;
                rEG[2].enq(d);
                bram[3].enq(d);
        endrule

        rule _QMem34 (memId != 3  && regId[3] == 4);
                let d = bram[3].first;bram[3].deq;
                rEG[3].enq(d);
                bram[3].enq(d);
        endrule

        rule _QMem35 (memId != 3  && regId[3] == 5);
                let d = bram[3].first;bram[3].deq;
                rEG[4].enq(d);
                bram[3].enq(d);
        endrule

        rule _QMem36 (memId != 3  && regId[3] == 6);
                let d = bram[3].first;bram[3].deq;
                rEG[5].enq(d);
                bram[3].enq(d);
        endrule

        rule _QMem37 (memId != 3  && regId[3] == 7);
                let d = bram[3].first;bram[3].deq;
                rEG[6].enq(d);
                bram[3].enq(d);
        endrule

                rule _QMem40 (memId == 4 && memcount[4] < img);
                        inQ.deq;
                        bram[4].enq(inQ.first);
                        memcount[4] <= memcount[4]+1;
                endrule
            
                rule _QMem501 (memId == 4 && memcount[4] == img);
                        col <= col+1;
                endrule

        rule _QMem41 (memId != 4  && regId[4] == 1);
                 let d = bram[4].first;bram[4].deq;
                rEG[0].enq(d);
                bram[4].enq(d);
        endrule

        rule _QMem42 (memId != 4  && regId[4] == 2);
                let d = bram[4].first;bram[4].deq;
                rEG[1].enq(d);
                bram[4].enq(d);
        endrule

        rule _QMem43 (memId != 4  && regId[4] == 3);
                let d = bram[4].first;bram[4].deq;
                rEG[2].enq(d);
                bram[4].enq(d);
        endrule

        rule _QMem44 (memId != 4  && regId[4] == 4);
                 let d = bram[4].first;bram[4].deq;
                rEG[3].enq(d);
                bram[4].enq(d);
        endrule

        rule _QMem45 (memId != 4  && regId[4] == 5);
                let d = bram[4].first;bram[4].deq;
                rEG[4].enq(d);
                bram[4].enq(d);
        endrule

        rule _QMem46 (memId != 4  && regId[4] == 6);
                let d = bram[4].first;bram[4].deq;
                rEG[5].enq(d);
                bram[4].enq(d);
        endrule

        rule _QMem47 (memId != 4  && regId[4] == 7);
                let d = bram[4].first;bram[4].deq;
                rEG[6].enq(d);
                bram[4].enq(d);
        endrule


            rule _QMem50 (memId == 5 && memcount[5] < img);
                        inQ.deq;
                        bram[5].enq(inQ.first);
                        memcount[5] <= memcount[5]+1;
                endrule
            
                rule _QMem601 (memId == 5 && memcount[5] == img);
                        col <= col+1;
                endrule

        rule _QMem51 (memId != 5  && regId[5] == 1);
                 let d = bram[5].first;bram[5].deq;
                rEG[0].enq(d);
                bram[5].enq(d);
        endrule

        rule _QMem52 (memId != 5  && regId[5] == 2);
                let d = bram[5].first;bram[5].deq;
                rEG[1].enq(d);
                bram[5].enq(d);
        endrule

        rule _QMem53 (memId != 5  && regId[5] == 3);
                let d = bram[5].first;bram[5].deq;
                rEG[2].enq(d);
                bram[5].enq(d);
        endrule

        rule _QMem54 (memId != 5  && regId[5] == 4);
                 let d = bram[5].first;bram[5].deq;
                rEG[3].enq(d);
                bram[5].enq(d);
        endrule

        rule _QMem55 (memId != 5  && regId[5] == 5);
                let d = bram[5].first;bram[5].deq;
                rEG[4].enq(d);
                bram[5].enq(d);
        endrule

        rule _QMem56 (memId != 5  && regId[5] == 6);
                let d = bram[5].first;bram[5].deq;
                rEG[5].enq(d);
                bram[5].enq(d);
        endrule

        rule _QMem57 (memId != 5  && regId[5] == 7);
                let d = bram[5].first;bram[5].deq;
                rEG[6].enq(d);
                bram[5].enq(d);
        endrule

                rule _QMem60 (memId == 6 && memcount[6] < img);
                        inQ.deq;
                        bram[6].enq(inQ.first);
                        memcount[6] <= memcount[6]+1;
                endrule
            
                rule _QMem701 (memId == 6 && memcount[6] == img);
                        col <= col+1;
                endrule

        rule _QMem61 (memId != 6  && regId[6] == 1);
                 let d = bram[6].first;bram[6].deq;
                rEG[0].enq(d);
                bram[6].enq(d);
        endrule

        rule _QMem62 (memId != 6  && regId[6] == 2);
                let d = bram[6].first;bram[6].deq;
                rEG[1].enq(d);
                bram[6].enq(d);
        endrule

        rule _QMem63 (memId != 6  && regId[6] == 3);
                let d = bram[6].first;bram[6].deq;
                rEG[2].enq(d);
                bram[6].enq(d);
        endrule

        rule _QMem64 (memId != 6  && regId[6] == 4);
                 let d = bram[6].first;bram[6].deq;
                rEG[3].enq(d);
                bram[6].enq(d);
        endrule

        rule _QMem65 (memId != 6  && regId[6] == 5);
                let d = bram[6].first;bram[6].deq;
                rEG[4].enq(d);
                bram[6].enq(d);
        endrule

        rule _QMem66 (memId != 6  && regId[6] == 6);
                let d = bram[6].first;bram[6].deq;
                rEG[5].enq(d);
                bram[6].enq(d);
        endrule

        rule _QMem67 (memId != 6  && regId[6] == 7);
                let d = bram[6].first;bram[6].deq;
                rEG[6].enq(d);
                bram[6].enq(d);
        endrule

                rule _QMem70 (memId == 7 && memcount[7] < img);
                        inQ.deq;
                        bram[7].enq(inQ.first);
                        memcount[7] <= memcount[7]+1;
                endrule
            
                rule _QMem801 (memId == 7 && memcount[7] == img);
                        col <= col+1;
                endrule

        rule _QMem71 (memId != 7  && regId[7] == 1);
                let d = bram[7].first;bram[7].deq;
                rEG[0].enq(d);
                bram[7].enq(d);
        endrule

        rule _QMem72 (memId != 7  && regId[7] == 2);
                let d = bram[7].first;bram[7].deq;
                rEG[1].enq(d);
                bram[7].enq(d);
        endrule

        rule _QMem73 (memId != 7  && regId[7] == 3);
                let d = bram[7].first;bram[7].deq;
                rEG[2].enq(d);
                bram[7].enq(d);
        endrule

        rule _QMem74 (memId != 7  && regId[7] == 4);
                let d = bram[7].first;bram[7].deq;
                rEG[3].enq(d);
                bram[7].enq(d);
        endrule

        rule _QMem75 (memId != 7  && regId[7] == 5);
                let d = bram[7].first;bram[7].deq;
                rEG[4].enq(d);
                bram[7].enq(d);
        endrule

        rule _QMem76 (memId != 7  && regId[7] == 6);
                let d = bram[7].first;bram[7].deq;
                rEG[5].enq(d);
                bram[7].enq(d);
        endrule

        rule _QMem77 (memId != 7  && regId[7] == 7);
                let d = bram[7].first;bram[7].deq;
                rEG[6].enq(d);
                bram[7].enq(d);
        endrule

        rule get0 (_frow == 1);
            Vector#(7,DataType) d0 <- rEG[0].get;
            for(int i=0;i<7;i=i+1)
                _d0[i] <= d0[i];
            _sQ.enq(1);
        endrule

        rule get1 (_frow == 2);
            Vector#(7,DataType) d0 <- rEG[0].get;
            Vector#(7,DataType) d1 <- rEG[1].get;
            for(int i=0;i<7;i=i+1) begin
                _d0[i] <= d0[i];
                _d1[i] <= d1[i];
            end
            _sQ.enq(1);
        endrule

        rule get2 (_frow == 3);
            Vector#(7,DataType) d0 <- rEG[0].get;
            Vector#(7,DataType) d1 <- rEG[1].get;
            Vector#(7,DataType) d2 <- rEG[2].get;
            for(int i=0;i<7;i=i+1) begin
                _d0[i] <= d0[i];
                _d1[i] <= d1[i];
                _d2[i] <= d2[i];
            end
            _sQ.enq(1);
        endrule

        rule get3 (_frow == 4);
            Vector#(7,DataType) d0 <- rEG[0].get;
            Vector#(7,DataType) d1 <- rEG[1].get;
            Vector#(7,DataType) d2 <- rEG[2].get;
            Vector#(7,DataType) d3 <- rEG[3].get;
            for(int i=0;i<7;i=i+1) begin
                _d0[i] <= d0[i];
                _d1[i] <= d1[i];
                _d2[i] <= d2[i];
                _d3[i] <= d3[i];
            end
            _sQ.enq(1);
        endrule

        rule get4 (_frow == 5);
            Vector#(7,DataType) d0 <- rEG[0].get;
            Vector#(7,DataType) d1 <- rEG[1].get;
            Vector#(7,DataType) d2 <- rEG[2].get;
            Vector#(7,DataType) d3 <- rEG[3].get;
            Vector#(7,DataType) d4 <- rEG[4].get;
            for(int i=0;i<7;i=i+1) begin
                _d0[i] <= d0[i];
                _d1[i] <= d1[i];
                _d2[i] <= d2[i];
                _d3[i] <= d3[i];
                _d4[i] <= d4[i];
            end
            _sQ.enq(1);
        endrule

        rule get5 (_frow == 6);
            Vector#(7,DataType) d0 <- rEG[0].get;
            Vector#(7,DataType) d1 <- rEG[1].get;
            Vector#(7,DataType) d2 <- rEG[2].get;
            Vector#(7,DataType) d3 <- rEG[3].get;
            Vector#(7,DataType) d4 <- rEG[4].get;
            Vector#(7,DataType) d5 <- rEG[5].get;
            for(int i=0;i<7;i=i+1) begin
                _d0[i] <= d0[i];
                _d1[i] <= d1[i];
                _d2[i] <= d2[i];
                _d3[i] <= d3[i];
                _d4[i] <= d4[i];
                _d5[i] <= d5[i];
            end
            _sQ.enq(1);
        endrule

        rule get6 (_frow == 7);
            Vector#(7,DataType) d0 <- rEG[0].get;
            Vector#(7,DataType) d1 <- rEG[1].get;
            Vector#(7,DataType) d2 <- rEG[2].get;
            Vector#(7,DataType) d3 <- rEG[3].get;
            Vector#(7,DataType) d4 <- rEG[4].get;
            Vector#(7,DataType) d5 <- rEG[5].get;
            Vector#(7,DataType) d6 <- rEG[6].get;
            for(int i=0;i<7;i=i+1) begin
                _d0[i] <= d0[i];
                _d1[i] <= d1[i];
                _d2[i] <= d2[i];
                _d3[i] <= d3[i];
                _d4[i] <= d4[i];
                _d5[i] <= d5[i];
                _d6[i] <= d6[i];
            end
            _sQ.enq(1);
        endrule

        method Action put(Bit#(128) datas) if(col < img);
                Vector#(16,DataType) d = unpack(extend(pack(datas)));
                inQ.enq(d[0]);
                col <= col+1;
        endmethod

        method ActionValue#(Vector#(49,DataType)) get if(update < param);
                _sQ.deq;
                update <= update+1;
                let d0 = _d0;
                let d1 = _d1;
                let d2 = _d2;
                let d3 = _d3;
                let d4 = _d4;
                let d5 = _d5;
                let d6 = _d6; 
                Vector#(49, DataType) d = newVector;
                for(int i=0;i<7;i=i+1)begin
                        d[i] = d0[i];
                        d[i+7] = d1[i];
                        d[i+14] = d2[i];
                        d[i+21] = d3[i];
                        d[i+28] = d4[i];
                        d[i+35] = d5[i];
                        d[i+42] = d6[i];     
                end
                return d;
        endmethod

        method Action params(Vector#(3,Bit#(16)) datas);
            _frow <= truncate(datas[1]);
            img <= datas[2];
            param <= datas[2]-datas[0]+1;
            Vector#(2,Bit#(16)) regIN = newVector;
            regIN[0] = datas[0];
            regIN[1] = datas[2];
            for(int i=0;i<7;i=i+1)
                rEG[i].paramrEG(regIN);
            i0 <= True;
            memId <= 0;
            clr  <= 0;
        endmethod	
	
endmodule
endpackage

