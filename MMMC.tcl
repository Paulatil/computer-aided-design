#timing constraint file from synthesis
create_constraint_mode -name CONSTRAINTS -sdc_files {/home/new-ece/poa0002/synthesis/src/sd.sdc}
#create operating condition {P V T} for the timing library
create_op_cond -name OPcondtion -library_file  {/class/ELEC6250/cmos8hp/std_cell/v.20130404/synopsys/typ_v120_t025/PnomV1p20T025_STD_CELL_8HP_12T.lib} -P {1} -V {1.2} -T {25}
#create typical library files for this design
create_library_set -name TYPlib -timing {/class/ELEC6250/cmos8hp/std_cell/v.20130404/synopsys/typ_v120_t025/PnomV1p20T025_STD_CELL_8HP_12T.lib}
#creaate RCcorner from capacitance table
create_rc_corner -name RCcorner -cap_table {/class/ELEC6250/IBM_PDK/BiCMOS8HP_Fire_Ice/bicmos8hp_cadence_20160215/cadence/v.20160215/captable/bicmos8hp_6AM_31_nm.CapTbl} -T {25}
#Delay corner = timing library plus rc corner
#worst-case corner = max delay/affects setup time
#best-case delay = min delay/affects hold time
#for 1-corner use typical values for both
create_delay_corner -name DELAYcorner -library_set TYPlib -rc_corner RCcorner
#analysis view= delay corner matched to constraints
create_analysis_view -name TYPview -delay_corner {DELAYcorner} -constraint_mode {CONSTRAINTS}
#set analysis view to above for both setup ans hold 
set_analysis_view -setup {TYPview} -hold {TYPview}       
