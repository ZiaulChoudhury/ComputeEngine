/*
 * Generated by Bluespec Compiler (build f2da894e)
 * 
 * On Sat Jul 17 19:53:59 IST 2021
 * 
 */

/* Generation options: */
#ifndef __mkFlowTest_h__
#define __mkFlowTest_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"
#include "mkPECore.h"


/* Class declaration for the mkFlowTest module */
class MOD_mkFlowTest : public Module {
 
 /* Clock handles */
 private:
  tClock __clk_handle_0;
 
 /* Clock gate handles */
 public:
  tUInt8 *clk_gate[0];
 
 /* Instantiation parameters */
 public:
 
 /* Module state */
 public:
  MOD_Reg<tUInt32> INST_cId;
  MOD_Reg<tUInt32> INST_col;
  MOD_Reg<tUInt32> INST_count;
  MOD_Reg<tUInt32> INST_cx;
  MOD_Reg<tUInt32> INST_img;
  MOD_Reg<tUInt8> INST_init;
  MOD_Reg<tUInt8> INST_load;
  MOD_mkPECore INST_px;
 
 /* Constructor */
 public:
  MOD_mkFlowTest(tSimStateHdl simHdl, char const *name, Module *parent);
 
 /* Symbol init methods */
 private:
  void init_symbols_0();
 
 /* Reset signal definitions */
 private:
  tUInt8 PORT_RST_N;
 
 /* Port definitions */
 public:
 
 /* Publicly accessible definitions */
 public:
  tUInt32 DEF_x__h678;
 
 /* Local definitions */
 private:
  tUWide DEF_px_get___d31;
  tUWide DEF__0_CONCAT_readInput_cx_5_7___d28;
 
 /* Rules */
 public:
  void RL_cyccount();
  void RL_load_config();
  void RL_configure();
  void RL_send();
  void RL_receive();
 
 /* Methods */
 public:
 
 /* Reset routines */
 public:
  void reset_RST_N(tUInt8 ARG_rst_in);
 
 /* Static handles to reset routines */
 public:
 
 /* Pointers to reset fns in parent module for asserting output resets */
 private:
 
 /* Functions for the parent module to register its reset fns */
 public:
 
 /* Functions to set the elaborated clock id */
 public:
  void set_clk_0(char const *s);
 
 /* State dumping routine */
 public:
  void dump_state(unsigned int indent);
 
 /* VCD dumping routines */
 public:
  unsigned int dump_VCD_defs(unsigned int levels);
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkFlowTest &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkFlowTest &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkFlowTest &backing);
  void vcd_submodules(tVCDDumpType dt, unsigned int levels, MOD_mkFlowTest &backing);
};

#endif /* ifndef __mkFlowTest_h__ */
