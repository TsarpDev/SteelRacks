
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


	
	
###################################################################################################
#          Define Analysis Type										  
###################################################################################################
# Define type of analysis:  "pushover" = pushover;  "dynamic" = dynamic
	set analysisType "pushover";
	
	if {$analysisType == "pushover"} {
		set dataDir Concentrated-Pushover-Output;	# name of output folder
		file mkdir $dataDir; 						# create output folder
	}
	if {$analysisType == "dynamic"} {
		set dataDir Concentrated-Dynamic-Output;	# name of output folder
		file mkdir $dataDir; 						# create output folder
	}
	

	
############################################################################
#              Recorders					                			   
############################################################################
	
# record floor displacements
	set topNode7 [getNode 7 0.0 19.7];
	recorder Node -file $dataDir/Disp.out -time -node $topNode7 -dof 1 disp;
	
# record base shear reactions
	
	set baseNodes {};
	for {set i 1} {$i<=6} {incr i} {
		set tmpList [  lineX_nodes $i 0.0];
		for {set j 0} {$j<[llength $tmpList]} {incr j} {
			lappend baseNodes [lindex $tmpList $j];
		}
		
	}
	
	
	set Vnames {};
	for {set i 0} {$i< [llength $baseNodes]} {incr i} {
		recorder Node -file "$dataDir/V[lindex $baseNodes $i].out" -node [lindex $baseNodes $i]  -dof 1 reaction;
		lappend Vnames "$dataDir/V[lindex $baseNodes $i].out";
	}
	

addReactions $Vnames  "$dataDir/Vbase.out";

generatePushoverDiagram		"$dataDir/Disp.out"		"$dataDir/Vbase.out";



	