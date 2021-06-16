/*
 * Generated by Bluespec Compiler (build 00185f79)
 * 
 * On Wed Jun 16 20:33:49 IST 2021
 * 
 * To automatically register this VPI wrapper with a Verilog simulator use:
 *     #include "vpi_wrapper_initialize.h"
 *     void (*vlog_startup_routines[])() = { initialize_vpi_register, 0u };
 */
#include <stdlib.h>
#include <vpi_user.h>
#include "bdpi.h"

/* the type of the wrapped function */
void initialize();

/* VPI wrapper function */
PLI_INT32 initialize_calltf(PLI_BYTE8 *user_data)
{
  
  /* call the imported C function */
  initialize();
  
  return 0;
}

/* VPI wrapper registration function */
void initialize_vpi_register()
{
  s_vpi_systf_data tf_data;
  
  /* Fill in registration data */
  tf_data.type = vpiSysTask;
  tf_data.tfname = "$imported_initialize";
  tf_data.calltf = initialize_calltf;
  tf_data.compiletf = 0u;
  tf_data.sizetf = 0u;
  tf_data.user_data = "$imported_initialize";
  
  /* Register the function with VPI */
  vpi_register_systf(&tf_data);
}
