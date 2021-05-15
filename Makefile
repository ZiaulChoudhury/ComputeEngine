# This Makefile can be used from each of the Part subdirectories
# For example:    'make s1'

BSC=bsc

# ----------------------------------------------------------------
# Bluesim targets

.PHONY: bluespec verilog


bluespec:
	$(BSC)  -sim  -u -g mkComputeTree +RTS -K200M -RTS -show-schedule -parallel-sim-link 8 -steps-max-intervals 1600000 -no-warn-action-shadowing -cpp computeTree.bsv
	$(BSC)  -sim  -e mkComputeTree -o compute

verilog:
	$(BSC)  -verilog -u -cpp +RTS -K200M -RTS -parallel-sim-link 8 -steps-max-intervals 1600000 -no-warn-action-shadowing line3.bsv
	$(BSC)  -verilog -o ver -e mkLine3 *.v 

verilogTest:
	$(BSC)  -verilog -u -cpp +RTS -K200M -RTS -parallel-sim-link 8 -steps-max-intervals 1600000 -no-warn-action-shadowing hardware.bsv

hard:
	#$(BSC)  -verilog -u -cpp +RTS -K20M -RTS -parallel-sim-link 8 -no-warn-action-shadowing Blur3TB.bsv
	#$(BSC)  -verilog -o ver -e mkBlur3TB *.v  
	$(BSC)  -sim  -u -g mkFlowTest +RTS -K200M -RTS -show-schedule -steps-max-intervals 1600000 -parallel-sim-link 8 -no-warn-action-shadowing -cpp  flowtest2.bsv
	$(BSC)  -sim  -e mkFlowTest  +RTS -K200M -RTS -o blu


simulate:
	#$(BSC)  -verilog -u -cpp +RTS -K20M -RTS -parallel-sim-link 8 -no-warn-action-shadowing Blur3TB.bsv
	#$(BSC)  -verilog -o ver -e mkBlur3TB *.v  
	$(BSC)  -sim  -u -g mkFlowTest +RTS -K200M -RTS -show-schedule -steps-max-intervals 1600000 -parallel-sim-link 8 -no-warn-action-shadowing -cpp  flowtest.bsv
	$(BSC)  -sim  -e mkFlowTest  +RTS -K200M -RTS -o sim
simulatex:
	$(BSC)  -sim  -u -g mkFlexnnTest +RTS -K200M -RTS -show-schedule -steps-max-intervals 1600000 -no-warn-action-shadowing -cpp  FlexnnTest.bsv
	$(BSC)  -sim  -e mkFlexnnTest    +RTS -K200M -RTS -o sim *.ba host.cpp
# -----------------------------------------------------------------

.PHONY: clean fullclean

# Clean all intermediate files
clean:
	rm -f  *~  *.bi  *.bo  *.ba  *.h  *.cxx  *.o

# Clean all intermediate files, plus Verilog files, executables, schedule outputs
fullclean:
	rm -rf  *~  *.bi  *.bo  *.ba  *.h  *.cxx  *.o *.v xsim* *.sched webtalk* vivado*
	rm -rf  *.exe   *.so  *.sched  *.v  *.vcd xe* ve* xsim* *.sched

