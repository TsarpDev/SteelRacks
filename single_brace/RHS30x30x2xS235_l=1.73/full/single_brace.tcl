

###################################################################################################
#          Define Analysis Type
###################################################################################################


	if {$analysisType == "compression"} {
		set dataDir Concentrated-Compression-Output;	# name of output folder
		file mkdir $dataDir; 						# create output folder
	}
	if {$analysisType == "tension"} {
		set dataDir Concentrated-Tension-Output;	# name of output folder
		file mkdir $dataDir; 						# create output folder
		
		set imp 0;
	}
	
	
######################### INITIALIZE #########################	
	set length2 [expr $length*$length]
	
	set half [expr $length/2.0]
	
	set eles [expr $pts-1]
	
	set fraction [expr $length/($pts-1)];
	
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
	
	
######################### NODES #########################
	set i 1
	foreach a $x {
		node $i $a [lindex $y [expr $i-1]]
		incr i
	}
	

######################### ELEMENTS #########################

	
	
	set transfTag 1
	geomTransf Corotational $transfTag

	set j 1
	for {set i 0} {$i<$eles} {incr i} {
		
		element nonlinearBeamColumn   $j  	[expr $j]  [expr $j+1] $nIntPt  $sec  1 -iter $maxIters $tolIter
		
		incr j
	}
	
	
	DisplayModel2D NodeNumbers	1	700	0	500	500;
	

######################### FIXITY #########################
	fix 1 0 1 0
	fix $pts 1 1 0

	
######################### ANALYSIS #########################
	
	if {$analysisType == "tension"} {


		######################### RECORDER #########################
			set halfpt [expr $pts/2 + 1]
			recorder Node -file $dataDir/Disp.out -node 1 -dof 1 disp;

			recorder Node -file $dataDir/N.out -node $pts  -dof 1 reaction;
		######################### ANALYSIS #########################

			DisplayModel2D DeformedShape 1 700	0	500	500;	# display deformed shape, the scaling factor needs to be adjusted for each model
			
			
			pattern Plain 200 Linear {				 
				 load 1 0.1 0.0 0.0
			}
			
			
			RunPushover2Converge 1 $dmax $dincr 1
			
	} else {

			######################### RECORDER #########################
			set halfpt [expr $pts/2 + 1]
			recorder Node -file $dataDir/Disp.out -node 1 -dof 1 disp;

			recorder Node -file $dataDir/N.out -node $pts  -dof 1 reaction;
			######################### ANALYSIS #########################
		
			DisplayModel2D DeformedShape 1 700	0	500	500;	# display deformed shape, the scaling factor needs to be adjusted for each model
			
			
			pattern Plain 200 Linear {				 
				 load 1 0.1 0.0 0.0
			}
			
			
			RunPushover2Converge $halfpt $dmax $dincr 2

	}	
	
###################################################################################################
#          CLEAN ALL
###################################################################################################

	wipe all
	

	
	
	
