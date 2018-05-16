
###################################################################################################
#          Set Up & Source Definition
###################################################################################################
	
	source units.tcl;					# procedure for units


	source display/display_header.tcl;
	source procs/RunPushover2Converge_REV.tcl;
	source sections/sections_header.tcl
	
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
	}
	
	

	
######################### NODES #########################
	node 1 0.0 0.0
	node 2 $length 0.0 

######################### ELEMENTS #########################

	
	
	element truss 1 1 2 1 1
	
	
	DisplayModel2D NodeNumbers	1	700	0	500	500;
	

######################### FIXITY #########################
	fix 1 0 1 1
	fix 2 1 1 1

	
######################### ANALYSIS #########################
	
	if {$analysisType == "tension"} {

		######################### RECORDER #########################

			recorder Node -file $dataDir/Disp.out -node 1 -dof 1 disp;

			recorder Node -file $dataDir/N.out -node 2  -dof 1 reaction;
		######################### ANALYSIS #########################

			DisplayModel2D DeformedShape 1 700	0	500	500;	# display deformed shape, the scaling factor needs to be adjusted for each model
			
			
			pattern Plain 200 Linear {				 
				 load 1 0.1 0.0 0.0
			}
			
			
			RunPushover2Converge 1 0.02 0.0001 1
			
	} else {

			######################### RECORDER #########################

			recorder Node -file $dataDir/Disp.out -node 1 -dof 1 disp;

			recorder Node -file $dataDir/N.out -node 2  -dof 1 reaction;
			######################### ANALYSIS #########################
		
			DisplayModel2D DeformedShape 1 700	0	500	500;	# display deformed shape, the scaling factor needs to be adjusted for each model
			
			
			pattern Plain 200 Linear {				 
				 load 1 1.0 0.0 0.0
			}
			
			
			RunPushover2Converge 1 0.4 0.001 1

	}	
	
###################################################################################################
#          CLEAN ALL
###################################################################################################

	wipe all
	

	
	
	
