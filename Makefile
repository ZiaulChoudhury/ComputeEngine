# This Makefile can be used from each of the Part subdirectories
# For example:    'make s1'

BSC=bsc

# ----------------------------------------------------------------
# Bluesim targets

.PHONY: bluespec verilog

verilog:
	$(BSC)  -verilog -u -cpp +RTS -K200M -RTS -parallel-sim-link 8 -steps-max-intervals 1600000 -no-warn-action-shadowing flowtest.bsv
	$(BSC)  -verilog -o ver -e mkFlowTest *.v 
simulate:
	$(BSC)  -sim  -u -g mkFlowTest +RTS -K200M -RTS -show-schedule -steps-max-intervals 1600000 -parallel-sim-link 8 -no-warn-action-shadowing -cpp  flowtest.bsv
	$(BSC)  -sim  -e mkFlowTest  +RTS -K200M -RTS -o sim *.ba host.cpp
# -----------------------------------------------------------------

.PHONY: clean fullclean

# Clean all intermediate files
clean:
	rm -f  *~  *.bi  *.bo  *.ba  *.h  *.cxx  *.o

# Clean all intermediate files, plus Verilog files, executables, schedule outputs
fullclean:
	rm -rf  *~  *.bi  *.bo  *.ba  *.h  *.cxx  *.o  xsim* *.sched webtalk* vivado*
	rm -rf  *.exe   *.so  *.sched  *.vcd xe* ve* xsim* *.sched

