
###netlist
set design_netlisttype verilog
set init_verilog /home/new-ece/poa0002/countSyn/NoDft/sync.v
set init_verilog_set_top 1
set init_top_cell "mod6_counter_data_flow"

###lef
set init_lef_file {/class/ELEC6250/cmos8hp/techlef/v.20160204/lef/bicmos8hp_6AM_31_tech.lef /class/ELEC6250/cmos8hp/std_cell/v.20130404/lef/IBM_BICMO\S8HP_SC_1P2V_12T_RVT_091712.lef}


### VDD &GND
set init_pwr_net {VDD}
set init_gnd_net {VSS}

####mmmc
set init_mmmc_file {/home/new-ece/poa0002/countSyn/NoDft/MMMC.tcl}

init_design

###floorplan 
floorplan -r 0.8 0.7 20 20 20 20

###power ring
addRing -nets {VDD VSS} -type core_rings -around user_defined    -center 0 -spacing 5 -width 2 -offset 0.2 -threshold auto     -layer {bottom M1 top M1 right M2 left M2}

###power route
sroute -connect {blockPin padPin padRing corePin floatingStripe} -allowJogging true -allowLayerChange true -blockPin useLef -targetViaLayerRange {M1 AM}

###pin
editPin -side TOP -layer M3 -fixedPin 1 -spreadType RANGE -start {10 0} -end {120 0} -pin {I[0] I[1] I[2]}
editPin -side LEFT -layer M3 -fixedPin 1 -spreadType RANGE -start {0 10} -end {0 95}  -pin {CLK CLR}
editPin -side RIGHT -layer M3 -fixedPin 1 -spreadType RANGE -start {130 10} -end {130 95}   -spreadDirection CounterClockwise -pin {LC}
editPin -side BOTTOM -layer M3 -fixedPin 1 -spreadType RANGE -start {10 0} -end {120 0} -spreadDirection CounterClockwise -pin {Q[0] Q[1] Q[2]}

saveDesign /home/new-ece/poa0002/countSyn/NoDft/postplace.enc -def

###std cell placing
setPlaceMode -timingDriven true -congEffort medium -modulePlan true
placeDesign -preplaceopt


### preCTS timing opt
##source /home/new-ece/pzr0020/newdivider/inv/timingopt/.timingopt
##.timingopt:
timeDesign -preCTS -idealClock -numPaths 20 -prefix preCTS -outDir /home/new-ece/poa0002/countSyn/NoDft/
setOptMode -yieldEffort none
setOptMode -effort high
setOptMode -maxDensity 0.95
setOptMode -fixDRC true
setOptMode -fixFanoutLoad true
setOptMode -optimizeFF true
setOptMode -simplifyNetlist false
setOptMode -holdTargetSlack 0.0
setOptMode -setupTargetSlack 0.0
clearClockDomains
setClockDomains -all
setOptMode -usefulSkew false
optDesign -preCTS -drv -outDir /home/new-ece/poa0002/countSyn/NoDft/



###routing
globalDetailRoute

###add filler
setFillerMode -corePrefix dvi_fill -core {FILL1 FILL2 FILL4 FILL8 FILL16 FILL32 FILL64}
addFiller -cell {FILL1 FILL2 FILL4 FILL8 FILL16 FILL32 FILL64} -prefix dvi_fill-markFixed

### postRoute-opt
##source /home/new-ece/pzr0020/newdivider/inv/.postRoute
##.postRoute:
timeDesign -postRoute -idealClock -numPaths 20 -prefix postRoute -outDir /home/new-ece/poa0002/countSyn/NoDft/
setOptMode -yieldEffort none
setOptMode -effort high
setOptMode -maxDensity 0.95
setOptMode -fixDRC true
setOptMode -fixFanoutLoad true
setOptMode -optimizeFF true
setOptMode -simplifyNetlist false
setOptMode -holdTargetSlack 0.0
setOptMode -setupTargetSlack 0.0
clearClockDomains
setClockDomains -all
setOptMode -usefulSkew false
setAnalysisMode -analysisType onChipVariation
optDesign -postRoute -drv -outDir /home/new-ece/poa0002/countSyn/NoDft/

###report
verifyConnectivity -type regular -error 50 -warning 50 -report /home/new-ece/poa0002/countSyn/NoDft/conn_regular.rpt
verifyConnectivity -type special -error 50 -warning 50 -report /home/new-ece/poa0002/countSyn/NoDft/conn_special.rpt
verifyGeometry -allowSameCellViols -noSameNet -noOverlap -report /home/new-ece/poa0002/countSyn/NoDft/geom.rpt

###write result
global dbgLefDelOutVersion
set dbgLefDelOutVersion 5.5
defOut -floorplan -netlist -routing /home/new-ece/poa0002/countSyn/NoDft/dvi.def
saveDesign /home/new-ece/poa002/countSyn/NoDft/dvi.enc -def
saveNetlist /home/new-ece/poa0002/countSyn/NoDft/dvi_soc.v
saveModel -cts -sdf -spef -dir /home/new-ece/poa0002/countSyn/NoDft/
extractRC -outfile /home/new-ece/poa0002/countSyn/NoDft/dvi.cap
rcOut -spef /home/new-ece/poa0002/countSyn/NoDft/dvi.spef
write_sdf /home/new-ece/poa0002/coutnSyn/NoDft/finalsdf.sdf -ideal_clock_network


