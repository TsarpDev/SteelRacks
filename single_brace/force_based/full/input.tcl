wipe all

###################################################################################################
#          Set Up & Source Definition
###################################################################################################
	
source units.tcl;					
source display/display_header.tcl;
source procs/RunPushover2Converge_REV.tcl;
source sections/sections_header.tcl
source fitter.tcl

model BasicBuilder -ndm 2 - ndf 3 

set analysisType "compression";

set length 1.732772345;
	
set imp [expr $length/200]
	
set pts 3;
	 
uniaxialMaterial Steel02 1 [expr 355*$MPa] [expr 210.0*$GPa] 0.0 18 0.925 0.15
	
set sec 4; # L40x40x5 S355
Angle $sec  1  [expr 40*$mm]  [expr 40*$mm]  [expr 5*$mm]  [expr 5*$mm]  0  0  0  
	
set nIntPt 3 
set maxIters 20
set tolIter 1.e-8

set dmax 0.5
set dincr 0.01

source single_brace.tcl

fitter $analysisType 1

