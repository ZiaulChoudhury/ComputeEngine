/*
 * Generated by Bluespec Compiler (build f2da894e)
 * 
 * On Sat Jul 17 19:53:59 IST 2021
 * 
 */

/* Generation options: */
#ifndef __mkLine3_h__
#define __mkLine3_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"
#include "mkCacheFIFOF.h"


/* Class declaration for the mkLine3 module */
class MOD_mkLine3 : public Module {
 
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
  MOD_Reg<tUInt32> INST__unnamed_;
  MOD_mkCacheFIFOF INST__unnamed__1;
  MOD_mkCacheFIFOF INST__unnamed__2;
  MOD_mkCacheFIFOF INST__unnamed__3;
  MOD_mkCacheFIFOF INST__unnamed__4;
  MOD_mkCacheFIFOF INST__unnamed__5;
  MOD_mkCacheFIFOF INST__unnamed__6;
  MOD_mkCacheFIFOF INST__unnamed__7;
  MOD_mkCacheFIFOF INST__unnamed__8;
  MOD_Reg<tUInt32> INST_alpha;
  MOD_Reg<tUInt32> INST_alpha2;
  MOD_Reg<tUInt32> INST_c1;
  MOD_Reg<tUInt32> INST_c2;
  MOD_Reg<tUInt8> INST_collectWindow;
  MOD_Reg<tUInt32> INST_img;
  MOD_Fifo<tUInt64> INST_instream;
  MOD_Fifo<tUWide> INST_outQ;
  MOD_Reg<tUInt32> INST_r1;
 
 /* Constructor */
 public:
  MOD_mkLine3(tSimStateHdl simHdl, char const *name, Module *parent);
 
 /* Symbol init methods */
 private:
  void init_symbols_0();
 
 /* Reset signal definitions */
 private:
  tUInt8 PORT_RST_N;
 
 /* Port definitions */
 public:
  tUWide PORT_get;
 
 /* Publicly accessible definitions */
 public:
 
 /* Local definitions */
 private:
  tUInt8 DEF_c1_1_ULE_unnamed__2_MINUS_1_3___d37;
  tUInt32 DEF_x__h3364;
  tUInt8 DEF_c1_1_EQ_unnamed__2_MINUS_1_3___d24;
  tUInt8 DEF_c1_1_ULT_img_4___d35;
  tUInt64 DEF_dd__h1853;
  tUWide DEF__unnamed__8_enQdeQ___d118;
  tUWide DEF__unnamed__7_enQdeQ___d120;
  tUWide DEF__unnamed__6_enQdeQ___d122;
  tUWide DEF__unnamed__5_enQdeQ___d123;
  tUWide DEF__unnamed__4_enQdeQ___d125;
  tUWide DEF__unnamed__3_enQdeQ___d126;
  tUWide DEF__unnamed__2_enQdeQ___d128;
  tUWide DEF__unnamed__1_enQdeQ___d129;
  tUInt32 DEF_b__h1373;
  tUInt32 DEF_b__h1354;
  tUInt32 DEF_b__h1583;
  tUWide DEF_unnamed__8_enQdeQ_18_BITS_447_TO_0___d119;
  tUInt8 DEF_NOT_c1_1_ULT_img_4_5_6_AND_c1_1_ULE_unnamed__2_ETC___d38;
  tUInt8 DEF_r1_7_EQ_7___d52;
  tUInt8 DEF_r1_7_EQ_6___d50;
  tUInt8 DEF_r1_7_EQ_5___d48;
  tUInt8 DEF_r1_7_EQ_4___d46;
  tUInt8 DEF_r1_7_EQ_3___d44;
  tUInt8 DEF_r1_7_EQ_2___d42;
  tUInt8 DEF_r1_7_EQ_1___d40;
  tUInt8 DEF_r1_7_EQ_0___d33;
  tUInt32 DEF_IF_c1_1_EQ_unnamed__2_MINUS_1_3_4_THEN_0_ELSE__ETC___d26;
  tUInt32 DEF_unnamed__2_MINUS_1___d23;
  tUWide DEF__0_CONCAT_unnamed__8_enQdeQ_18_BITS_447_TO_0_19_ETC___d130;
  tUWide DEF__0_CONCAT_unnamed__8_enQdeQ_18_BITS_447_TO_0_19_ETC___d127;
  tUWide DEF__0_CONCAT_unnamed__8_enQdeQ_18_BITS_447_TO_0_19_ETC___d124;
  tUWide DEF__0_CONCAT_unnamed__8_enQdeQ_18_BITS_447_TO_0_19_ETC___d121;
  tUInt8 DEF_c1_1_ULT_img_4_5_OR_NOT_c1_1_ULE_unnamed__2_MI_ETC___d55;
  tUWide DEF_get__avValue1;
 
 /* Rules */
 public:
  void RL__putDataInLB0();
  void RL__serialShiftLeft();
 
 /* Methods */
 public:
  void METH_putFmap(tUInt64 ARG_putFmap_datas);
  tUInt8 METH_RDY_putFmap();
  tUWide METH_get();
  tUInt8 METH_RDY_get();
  void METH_reset(tUInt32 ARG_reset_imageSize, tUInt32 ARG_reset_a2);
  tUInt8 METH_RDY_reset();
  void METH_clean();
  tUInt8 METH_RDY_clean();
  void METH_loadShift(tUInt32 ARG_loadShift_inx);
  tUInt8 METH_RDY_loadShift();
 
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
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkLine3 &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkLine3 &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkLine3 &backing);
  void vcd_submodules(tVCDDumpType dt, unsigned int levels, MOD_mkLine3 &backing);
};

#endif /* ifndef __mkLine3_h__ */
