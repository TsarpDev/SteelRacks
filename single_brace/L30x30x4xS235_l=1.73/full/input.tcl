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

#set analysisType "tension";
set analysisType "compression";

set length 1.732772345;

	
set imp [expr $length/200]
	
set pts 3;
	 
uniaxialMaterial Steel02 1 [expr 235*$MPa] [expr 210.0*$GPa] 0.0 18 0.925 0.15
	
set sec 4; # L40x40x5 S275
Angle $sec  1  [expr 30*$mm]  [expr 30*$mm]  [expr 4*$mm]  [expr 4*$mm]  0  0  0  
	
set nIntPt 3 
set maxIters 20
set tolIter 1.e-8

if {$analysisType == "compression"} {
	set dmax [expr 0.1*$length]
	set dincr [expr $dmax/200]
} else {
	set dmax [expr 0.005*$length]
	set dincr [expr $dmax/200]
}


source single_brace.tcl

fitter $analysisType 1 0.7

