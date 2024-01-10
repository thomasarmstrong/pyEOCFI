#include <explorer_lib.h>


extern "C" xl_time_id  time_ref_init_file(int time_model_id, 
										long n_files,
										char *time_file,
										int time_init_mode_id,
										double time0,
										double time1,
										long orbit0,
										long orbit1)
{
    long time_model, n_files, time_init_mode, time_ref;
    long orbit0, orbit1;
    char **time_file;
    double time0, time1, val_time0, val_time1;
    xl_time_id time_id = {NULL};
    long ierr[XL_NUM_ERR_TIME_REF_INIT_FILE], status;
    status = xl_time_ref_init_file (//input
                                    &time_model,
                                    &n_files, time_file,
                                    &time_init_mode, &time_ref,
                                    &time0, &time1, &orbit0, &orbit1,
                                    //output
                                    &val_time0,&val_time1,
                                    &time_id, ierr);
}
