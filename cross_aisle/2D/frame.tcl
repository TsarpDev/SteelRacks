
###################################################################################################
#          Delete some data
###################################################################################################
	wipe all;							# clear memory of past model definitions

	if {[file exists frame2D.out]} {
		file delete frame2D.out
	}
	if {[file exists Concentrated-Pushover-Output]} {
		file delete -force -- Concentrated-Pushover-Output
	}
	if {[file exists Concentrated-Dynamic-Output]} {
		file delete -force -- Concentrated-Dynamic-Output
	}
	if {[file exists Region_Output]} {
		file delete -force -- Region_Output
	}

###################################################################################################
#          Define Analysis Type
###################################################################################################
	set Analysis "2D";
	
# Define type of analysis:  "pushover" = pushover;  "dynamic" = dynamic
	set analysisType "pushover";
	#set analysisType "pushover";
	#set analysisType "eigenvalue";

	if {$analysisType == "pushover"} {
		set dataDir Concentrated-Pushover-Output;	# name of output folder
		file mkdir $dataDir; 						# create output folder
	}
	if {$analysisType == "dynamic"} {
		set dataDir Concentrated-Dynamic-Output;	# name of output folder
		file mkdir $dataDir; 						# create output folder
	}

###################################################################################################
#          Set Up & Source Definition
###################################################################################################
	model BasicBuilder -ndm 2 -ndf 3;	# Define the model builder, ndm = #dimension, ndf = #dofs

	source units.tcl;					# procedure for units

	source procs/proc_header.tcl;
	source files/file_header.tcl
	source columns/column_header.tcl;
	source beams/beam_header.tcl;
	source boundaries/boundaries_header.tcl;
	source booleans/booleans_header.tcl;
	source display/display_header.tcl;
	source non_linears/non_linears_header.tcl;
	source sections/sections_header.tcl;
	source frames/frame_header.tcl;
	source bracings/bracings_header.tcl;

################# VAMVATSIKOS' UTILS #################

	source ../util/GetPeriodSetDamping.tcl

################################################
	
	
################# VAMVATSIKOS' READ PARAMETERS #################	
#------------------------------------------------------------------------
# Source the optimization parameters for the bridge (e.g. number of spans)
# The standard file recreates the original Kavala in 2D
	if {[file exists "MatIDA_paramfile.tcl"]} {
	   puts "Using EXTERNAL parameter file for optimization (Matlab-generated)"
	   source MatIDA_paramfile.tcl
	} else {
	   puts "Using STANDARD parameter file"
	   source standard_paramfile.tcl
	}

	#---------------------------------------------------------------------------
	# Source the analysisType information. Better to have it in a distinct file.
	if {[file exists "MatIDA_anlsfile.tcl"]} {
	   puts "Reading EXTERNAL Analysistype file (Matlab-generated)"
	   source MatIDA_anlsfile.tcl
	}

	#----------------------------------------------
	# Source the timehistory information to apply. The default
	# file applies "HDA255.AT2.txt" and "HDA165.AT2.txt", upscaled by 7.5
	# if another exists, then it is treated as if generated to run an IDA.
	if {$analysisType=="dynamic" & [file exists "MatIDA_thfile.tcl"]} {
	   set runIDAflag 1
	   puts "Using EXTERNAL Timehistory data-file (Matlab-generated)"
	   source MatIDA_thfile.tcl
	} else {
	   set runIDAflag 0
	   puts "Using STANDARD Timehistory data-file"
	   source standard_thfile.tcl
	}

	#--------------------------------
	# max allowed subdivisions of dt (for variable transient) or standard subdivisions (for Transient)
	set dtsub 1.0

	if {$nstory<3} {
	  set Neigen $nstory  
	} else {
	  set Neigen 3 	
	}
################################################

##### BOOTING SECTIONS AND MATERIALS ###########
	source bootSectionsAndMats.tcl
	#print2DElasticSections
################################################



###################################################################################################
#          Frames
###################################################################################################

	set Xpoints "0.0	1.35001	2.766	4.11601	5.532	6.88201	8.298	9.64801	11.064	12.41401	13.83	15.18001	17.023	18.37301	19.789	21.13901	22.555	23.90501	25.321	26.67101	28.087	29.43701	30.853	32.20301	32.846	34.19601	35.612	36.96201	38.378	39.72801	41.144	42.49401	43.91	45.26001	46.676	48.02601	49.869	51.21901	52.635	53.98501	55.401	56.75101	58.167	59.51701	60.933	62.28301	63.699	65.04901"
	set Ypoints "0.0	0.0465	0.1305	0.421	1.5555	2.728	2.9805	3.046	4.4055	5.353	5.671	5.8305	7.3305	7.978	8.296	8.8305	10.3305	10.603	10.921	11.8305	11.99203	12.1305	13.228	13.546	13.5555	14.9805	15.853	16.171	16.4055	17.8305	18.478	18.796	19.3305	20.8305	21.103	21.421	22.3305	23.8305	24.06403"

	
#########################################
## First, prepare some data for masses ##
	set SteelRho [expr 1.0*7850*$kg/$m3]

	set FrameWidth [expr 1.35*$m]
	set BracingLength [expr 1.9629*$m]
	set RailSpan	[expr 1.416*$m]
	set MachineSpan [expr 1.843*$m]
	set DbracingHeight [expr 2.85*$m]
	
	set node_massCol3 [expr $A_column3*$DbracingHeight*$SteelRho]
	set node_massCol4 [expr $A_column4*$DbracingHeight*$SteelRho]
	
	set node_massRailBeam10 [expr $A_RL10*(0.5*($RailSpan+$FrameWidth))*$SteelRho]	
	set node_massUFrameHor5 [expr 0.5*$A_hor5*$FrameWidth*$SteelRho]
	set node_massUFrameDiag6 [expr $A_hor6*$BracingLength*$SteelRho]
	set node_massUFrameDiag7 [expr $A_hor7*$BracingLength*$SteelRho]
	set node_massMachIPE100 [expr 0.5*$A_Machine*$MachineSpan*$SteelRho]
	
	set massScale 0.8
	set pallet1_Dist [expr $massScale*	8.3747*$kN/$g/$m]
	set pallet2_Dist [expr $massScale*	6.7*$kN/$g/$m]
	set pallet3_Dist [expr $massScale*	5.0248*$kN/$g/$m]
	
	set totRailLength [expr 15.523*$m]
	set totUprights [expr 11]
	
	set pallet1	[expr $pallet1_Dist*$totRailLength/$totUprights]
	set pallet2	[expr $pallet2_Dist*$totRailLength/$totUprights]	
	set pallet3	[expr $pallet3_Dist*$totRailLength/$totUprights]	
	
#########################################

######################################
## Now calculate mass for each node ##
	
	set massMCH [expr  $node_massMachIPE100]
	set massH5 [expr $node_massUFrameHor5]
	
	set massC3 [expr $node_massCol3+$node_massUFrameHor5+$node_massUFrameDiag6]
	set massC4 [expr $node_massCol4+$node_massUFrameHor5+$node_massUFrameDiag7]
	
	
	set pallet1TOT [expr $pallet1+$node_massRailBeam10]
	set pallet2TOT [expr $pallet2+$node_massRailBeam10]
	set pallet3TOT [expr $pallet3+$node_massRailBeam10]
	
	set pallet1EDG [expr $pallet1+0.5*$node_massRailBeam10]
	set pallet2EDG [expr $pallet2+0.5*$node_massRailBeam10]
	set pallet3EDG [expr $pallet3+0.5*$node_massRailBeam10]
	set masses1   "   0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
					$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5
					$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4
					$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG
					0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0
					$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5
					$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4
					$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG
					0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0
					$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5
					$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4
					$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG
					0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0
					$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5
					$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4	$massC4
					$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG	$pallet3EDG	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3TOT	$pallet3EDG
					0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0
					$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5
					0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
					$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5
					$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG	$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG	$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG	$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG
					0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0
					$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3
					$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5
					$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG	$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG	$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG	$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG
					0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0
					$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3
					$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5
					$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG	$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG	$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG	$pallet2EDG	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2TOT	$pallet2EDG
					0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0
					$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3
					$pallet1EDG	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1EDG	$pallet1EDG	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1EDG	$pallet1EDG	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1EDG	$pallet1EDG	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1EDG
					$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5
					0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0
					$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3	$massC3
					$pallet1EDG	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1EDG	$pallet1EDG	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1EDG	$pallet1EDG	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1EDG	$pallet1EDG	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1TOT	$pallet1EDG
					$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5	$massH5
					0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	$massMCH	$massMCH	0	0	0	0	0	0	0	0	0	0	0
					0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
	"
#########################################

#################
## Draw frames ##
	set frame1 "
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05
		  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05 
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05
		  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05 
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05 
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05 
		  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05 
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05          05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05 
		  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05 
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05 
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05 
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04          04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04          04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {00 00 00}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  {99 14 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  {00 00 00}  {99 11 99}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {99 15 99}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04 	
	"
	

	set Nframes 1;
	set x0 0.0;

#GUI_frame2D_ElasticCol_LumpedBeam	{ Region_ID   *masses *Ypoints  *Xpoints x0 *frame release {Node_ID 100} {Ele_ID 1000}  {InternalNode_ID 100  } {InternalEle_ID 100  } } {
GUI_frame2D_FiberCol_LumpedBeam	1  masses1 Ypoints Xpoints  $x0 frame1 "pinned" 10000 10000
#GUI_frame2D_ElasticCol_LumpedBeam	1  masses1 Ypoints Xpoints  $x0 frame1 "fullrelease" 1000
#########################################


##############################
## Create bottom boundaries ##

#SpringedAndPinned2D	{ Region_ID	  SlaveRegion_ID	 y		springMat
#########################################

##############################
## Create bracing ##

	set XBracingPoints "0.0	1.35001	2.766	4.11601	5.532	6.88201	8.298	9.64801	11.064	12.41401	13.83	15.18001	17.023	18.37301	19.789	21.13901	22.555	23.90501	25.321	26.67101	28.087	29.43701	30.853	32.20301	32.846	34.19601	35.612	36.96201	38.378	39.72801	41.144	42.49401	43.91	45.26001	46.676	48.02601	49.869	51.21901	52.635	53.98501	55.401	56.75101	58.167	59.51701	60.933	62.28301	63.699	65.04901"
	set YBracingPoints "0.1305	1.5555	2.9805	4.4055	5.8305	7.3305	8.8305	10.3305	11.8305	12.1305	13.5555	14.9805	16.4055	17.8305	19.3305	20.8305	22.3305	23.8305"
	
	set bracings "
		13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13
		13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13
		13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13
		13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13
		13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13
		13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13
		13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13
		13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13	00	13
		00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00
		12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12
		12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12
		12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12
		12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12
		12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12
		12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12
		12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12
		12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12	00	12
	"
	
	set orientation "
		l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r
		r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l
		l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r
		r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l
		l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r
		r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l
		l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r
		r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l
		00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00
		l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r
		r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l
		l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r
		r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l
		l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r
		r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l
		l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r
		r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l	00	r	00	r	00	r	00	r	00	r	00	r	00	l	00	l	00	l	00	l	00	l	00	l
	"
	
	set axialMat "
		05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05
		05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05
		05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05
		05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05
		05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05
		05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05
		05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05
		05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05	00	05
		00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00
		04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04
		04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04
		04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04
		04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04
		04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04
		04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04
		04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04
		04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04	00	04
	"

	rackFiberBracing2D	3  1  YBracingPoints XBracingPoints bracings orientation axialMat 6  200; #200
	
	#frameBracing2D	3  1  YBracingPoints XBracingPoints bracings "double" 1000;#200
	
	#frameFiberBracing2D	3  1  YBracingPoints XBracingPoints bracings "double" 1000;#200
#########################################

##############################
## Create roof ##

#zic_beam2D	{ Region_ID  massX   *lengths_sym *ver_sym *diag_sym *botSec *topSec *verSec *diagSec h0_start  h0_end  x0  y0

	set XRoofPoints "0.0	0.07915	1.35001	1.52855	2.766 4.11601 4.12735	5.532	6.88201	6.97609	8.298	9.64801	9.74986	10.7245	11.064	12.41401	12.52362	13.83	15.18001	15.32242	16.94666	17.023	18.37301	19.789	19.79539	21.13901	21.6245	22.555	22.56916	23.90501	25.321	25.34293	26.67101	28.087	28.21669	29.43701	30.74053	30.853	32.20301	32.23986	32.5245"
	set topSec "17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17	17"
	set botSec "16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16	16"
	
	set XDiagPoints "1.52855 4.12735 15.32242 16.94666	28.21669 30.74053"
	set diagSec "13 00 13 00 13"
	
	set XVerPoints "0.07915	1.52855	4.12735	6.97609	9.74986	12.52362 15.32242 16.94666 19.79539	22.56916 25.34293 28.21669 30.74053	32.23986"
	set verSec "13	13	13	13	13	13	13	13	13	13	13	13	13	13"
	
	set massX [expr 25*$kg];
	
	zic_beam2D	4  $massX   XRoofPoints XVerPoints XDiagPoints botSec topSec verSec diagSec\
				0.286  1.252  0.0  24.06403;
#########################################

end_of_element_definitions; ################### NEVER FORGET THIS

PrintRegions;



###################################################################################################
#          Merge
###################################################################################################

	merge_common 1 4

	write_removed_elements;


###################################################################################################
#          Analysis
###################################################################################################

###################################################################################################
#          Display													  
###################################################################################################	

#DisplayModel2D { {ShapeType nill} {dAmp 5}  {xLoc 10} {yLoc 10} {xPixels 512} {yPixels 384} {nEigen 1} } {
	#DisplayModel2D DeformedShape 20	300	100	1500	600;

###################################################################################################
#          MODAL ANALYSIS AND DAMPING ASSIGNMENT
###################################################################################################
	GetPeriodSetDamping $Neigen 0.02 1 2 "simple2DframePeriods.out"


###################################################################################################
#          Apply Gravity Loads
###################################################################################################

# apply gravity loads
#command: pattern PatternType $PatternID TimeSeriesType
	pattern Plain 101 Constant {
		convert_massX2D;
	}
	
	RunGravityAnalysis 10


############################################################################
#              Recorders
############################################################################

if {$analysisType == "pushover"} {
	puts "Setting up recorders for pushover..."
	# record floor displacements
	set topNode1 [getXY_Node 1 $x0 [lindex $Ypoints end]];
	recorder Node -file $dataDir/Disp.out -time -node $topNode1 -dof 1 disp;

	# record base shear reactions

	set baseNodes {};
	for {set i 1} {$i<=$Nframes} {incr i} {
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
	
	# LOWER BOT
	#10049	10050	10051	10052	10053	10054	10055	10056	10057	10058	10059	10060	10061	10062	10063	10064	10065	10066	10067	10068	10069	10070	10071	10072	10073	10074	10075	10076	10077	10078	10079	10080	10081	10082	10083	10084	10085	10086	10087	10088	10089	10090	10091	10092	10093	10094	10095	10096	
	#10001	10002	10003	10004	10005	10006	10007	10008	10009	10010	10011	10012	10013	10014	10015	10016	10017	10018	10019	10020	10021	10022	10023	10024	10025	10026	10027	10028	10029	10030	10031	10032	10033	10034	10035	10036	10037	10038	10039	10040	10041	10042	10043	10044	10045	10046	10047	10048	

	for {set i 110001} {$i<=110048} {incr i} {
		recorder Element -file "$dataDir/botUpright$i.out" -time -ele $i -dof 2	globalForce;
	}
	
	
	# LOWER TOP
	#11057	11058	11059	11060	11061	11062	11063	11064	11065	11066	11067	11068	11069	11070	11071	11072	11073	11074	11075	11076	11077	11078	11079	11080	11081	11082	11083	11084	11085	11086	11087	11088	11089	11090	11091	11092	11093	11094	11095	11096	11097	11098	11099	11100	11101	11102	11103	11104	
	#11009	11010	11011	11012	11013	11014	11015	11016	11017	11018	11019	11020	11021	11022	11023	11024	11025	11026	11027	11028	11029	11030	11031	11032	11033	11034	11035	11036	11037	11038	11039	11040	11041	11042	11043	11044	11045	11046	11047	11048	11049	11050	11051	11052	11053	11054	11055	11056	
	for {set i 111009} {$i<=111056} {incr i} {
		recorder Element -file "$dataDir/topUpright$i.out" -time -ele $i -dof 2	globalForce;
	}
	
	puts "Recorders done!"
	
} elseif {$analysisType == "dynamic"} {

	puts "Setting up recorders for dynamic..."
	# record floor displacements
	set driftNodesY "0.0	2.882	5.507	8.132	10.757	13.382	16.007	18.632	21.257  23.98403";
	set driftNodesX 0.0;
	set driftRegion 1;
	
	set driftNodes ""

	for {set i 0} {$i<[llength $driftNodesY]} {incr i} {
		set y [lindex $driftNodesY $i]
		set tmpNode [getXY_Node $driftRegion	$driftNodesX	$y]
		lappend driftNodes $tmpNode
	}
	
	
	for {set i 1} {$i<=$nstory} {incr i} {
		set node_i [lindex $driftNodes [expr $i-1]];
		set node_j [lindex $driftNodes $i];
		if {$i<10} {
		# use $i\x.out because $ix.out will search for variable $ix not $i.
			recorder Drift -file "$dataDir/idr_0$i\x.out" -time -iNode $node_i -jNode $node_j -dof 1 -perpDirn 2
		} else {
			recorder Drift -file "$dataDir/idr_$i\x.out" -time -iNode $node_i -jNode  $node_j -dof 1 -perpDirn 2
		}

	}
	
	# roof drift. The dof is along x (1) and the height along y (2)
	recorder Drift -file "$dataDir/roofdrx.out" -time -iNode [lindex $driftNodes 0] -jNode [lindex $driftNodes end] -dof 1 -perpDirn 2
	
		puts "Recorders done!"

}



###################################################################################################
#          Run pushover													  
###################################################################################################	


if {$analysisType == "pushover"} { 
	set Fx_top [expr 1*$N];
	pattern Plain 200 Linear {			
			
			for {set i 1} {$i<=$Nframes} {incr i} {
				#SPO_x_triangular $i $x0 1.0
				#SPO_x_eigen {Region_ID X_coord Fx_top modeNum {Negligible 1e-3} }
				for {set j 0} {$j<[llength $Xpoints]} {incr j} {
					SPO_x_eigen2D $i [lindex $Xpoints $j] $Fx_top 1
				}
			}
			
	}

	RunPushover2Converge $topNode1 [expr 500.0*$mm] [expr 0.01*$mm] 

}

if {$analysisType == "dynamic"} { 
  source ../util/ReadSMDFile3.tcl
  source ../util/RunTransient2Converge.tcl
  source ../util/DefineXYZ_UniformExcitation.tcl

  # you are getting back "nptsx" and "dtx"
  DefineXYZ_UniformExcitation $dtsub $g $GMdir $GMfileX $GMfileY $GMfileZ $GMfactorX $GMfactorY $GMfactorZ nptsx dtx

  integrator Newmark 0.5 0.25
  test NormDispIncr 1.0e-8 10 0
  
  
  analysis Transient
  puts "analysis Transient"
  RunTransient2Converge [expr $nptsx*$dtsub] [expr $dtx/$dtsub]
}






###################################################################################################
#          CLEAN ALL
###################################################################################################
	
	print "frame2D.out"	
	cleanall;
	

###################################################################################################
#          POST PROCESSING
###################################################################################################

if {$analysisType == "pushover"} {
	addReactions $Vnames  "$dataDir/Vbase.out";
	generatePushoverDiagram		"$dataDir/Disp.out"		"$dataDir/Vbase.out";
} elseif {$analysisType == "dynamic"} {
	if {!$runIDAflag} {
	  # Delete old file as "print" simply appends the new results
	}
}

