
###################################################################################################
#          Set Up & Source Definition
###################################################################################################
	wipe all;							# clear memory of past model definitions




	file delete model.out

	model BasicBuilder -ndm 2 -ndf 3;	# Define the model builder, ndm = #dimension, ndf = #dofs

	source units.tcl;					# procedure for units

	source procs/proc_header.tcl;
	source files/file_header.tcl
	source columns/column_header.tcl;
	source beams/beam_header.tcl;
	source booleans/booleans_header.tcl;
	source display/display_header.tcl;
	source non_linears/non_linears_header.tcl;
	source sections/sections_header.tcl;


###################################################################################################
#          Define Materials
###################################################################################################


set S235 1 
uniaxialMaterial Steel02 $S235 [expr 235*$MPa] [expr 210.0*$GPa] 0.0 18 0.925 0.15

set S275 2 
uniaxialMaterial Steel02 $S275 [expr 275*$MPa] [expr 210.0*$GPa] 0.0 18 0.925 0.15

set S355 3 
uniaxialMaterial Steel02 $S355 [expr 355*$MPa] [expr 210.0*$GPa] 0.0 18 0.925 0.15


###################################################################################################
#          Define Sections
###################################################################################################


set DA55x55x4 16; #Double Angle 55x55x4 S355
DoubleAngle $DA55x55x4  $S355  [expr 55*$mm]  [expr 116*$mm]  [expr 4*$mm]  [expr 4*$mm]  0  0  [expr 6*$mm] 

getProp $DA55x55x4 [expr 210*$GPa]




###################################################################################################
#          CLEAN ALL
###################################################################################################

	cleanall;
	
	
	

###################################################################################################
#          POST PROCESSING
###################################################################################################


