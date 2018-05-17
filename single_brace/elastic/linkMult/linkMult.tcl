
###################################################################################################
#          Set Up & Source Definition
###################################################################################################
	wipe all;							# clear memory of past model definitions


	model BasicBuilder -ndm 2 - ndf 3 
	
	
	source units.tcl;					# procedure for units


	source display/display_header.tcl;
	source procs/RunPushover2Converge_REV.tcl;

	
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
	
	
	
	
	
	
######################### INPUT #########################	
	set length 10.0;
	
	set imp [expr $length/200.0]

	set pts 11;
	
	set A 1e-3
	
	set E 210e6
	
	set Iz 1e-6

######################### INITIALIZE #########################	

	set length2 [expr $length*$length]
	
	set half [expr $length/2.0]
	
	set eles [expr $pts-1]
	
	set fraction [expr $length/($pts-1)];
	
	
	set fraction2 [expr $fraction*$fraction]
	set fraction3 [expr $fraction2*$fraction]
	
	set a [expr -4.0/$length2 * $imp]
	
	set b [expr $length/2.0]
	
	set c [expr $imp]
	
	set x {};
	
	set y {};
	
	
	for {set i 0} {$i<$pts} {incr i} {
		set xtmp [expr $fraction * $i];
		lappend x $xtmp;
		
		
		set ytmp [expr $a*($xtmp-$b)*($xtmp-$b) + $c]
		lappend y $ytmp
	}
	
	
	#element twoNodeLink $eleTag $iNode $jNode -mat $matTags -dir $dirs <-orient <$x1 $x2 $x3> $y1 $y2 $y3> <-pDelta (4 $Mratio)> <-

	
	uniaxialMaterial Elastic 1 [expr $E*$A/$fraction]
	uniaxialMaterial Elastic 2 [expr 12*$E*$Iz/$fraction3]
	uniaxialMaterial Elastic 3 [expr $E*$Iz/$fraction]
	
######################### NODES #########################
	set i 1
	foreach a $x {
		node $i $a [lindex $y [expr $i-1]]
		incr i
	}


######################### ELEMENTS #########################

	set j 1
	for {set i 0} {$i<$eles} {incr i} {
		element twoNodeLink $j [expr $j] [expr $j+1] -mat 1 2 3 -dir 1 2 3 -pDelta -0.1 -0.1
		incr j
	}
	
	
	DisplayModel2D NodeNumbers	1	700	0	500	500;
	
	
######################### FIXITY #########################
	fix 1 0 1 0
	fix $pts 1 1 0


######################### RECORDER #########################
	set halfpt [expr $pts/2 + 1]
	recorder Node -file $dataDir/Disp.out -node $halfpt -dof 2 disp;

	recorder Node -file $dataDir/N.out -node $pts  -dof 1 reaction;
	
	
######################### ANALYSIS #########################

	DisplayModel2D DeformedShape 1 700	0	500	500;	# display deformed shape, the scaling factor needs to be adjusted for each model
	
	
	pattern Plain 200 Linear {				 
		 load 1 0.1 0.0 0.0
	}
	
	
	RunPushover2Converge $halfpt 0.5 0.005 2
	
###################################################################################################
#          CLEAN ALL
###################################################################################################

	wipe all
	