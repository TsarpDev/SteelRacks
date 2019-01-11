
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

	set Xpoints "0.0	3.12	4.66	6.2	 7.74	9.28	10.82	12.36	13.9	15.44	16.98	18.52	20.06	21.6	23.14	24.68	26.22	27.76	29.3	30.84	32.38	33.92	37.04	38.58	40.12	41.66	43.2	44.74	46.28	47.82	49.36	50.9	52.44	53.98	55.52	57.06	58.6	60.14	61.68	63.22	64.76	66.3	67.84	70.96"

	set Ypoints "0.0	0.257	2.882	5.507   5.785	8.132	10.757	11.992	13.382	16.007	18.632	21.257  22.409  23.98403"

	
#########################################
## First, prepare some data for masses ##
	set SteelRho [expr 1.0*7850*$kg/$m3]
	
	set Height [expr 2.625*$m]; 		# not perfect but okay
	set BracingSpan [expr 3.12*$m]
	set PalletSpan	[expr 1.54*$m]
	
	set node_massCol1 [expr $A_column1*$Height*$SteelRho]
	set node_massCol1a [expr $A_column1a*$Height*$SteelRho]
	set node_massCol2 [expr $A_column2*$Height*$SteelRho]
	set node_massCol3 [expr $A_column3*$Height*$SteelRho]
	set node_massCol4 [expr $A_column4*$Height*$SteelRho]
	
	set node_massBeam8 [expr $A_beam8*$BracingSpan*$SteelRho]	
	set node_massBeamHEA  [expr 0.5*$A_beamHEA*$PalletSpan*$SteelRho]	
	
	set massScale 0.8
	set pallet1 [expr $massScale*	13.0*$kN/$g]
	set pallet2 [expr $massScale*	10.4*$kN/$g]
	set pallet3 [expr $massScale*	7.8*$kN/$g]
#########################################

######################################
## Now calculate mass for each node ##
	
	set mass1 [expr $node_massCol1a+$node_massBeamHEA]
	set mass2 [expr $node_massCol1+$node_massBeamHEA]
	set mass3 [expr $node_massCol2+$node_massBeamHEA]
	
	set mass1_REAR [expr 0.5*$pallet1+$node_massCol1a+$node_massBeamHEA]
	set mass2_REAR [expr 0.5*$pallet2+$node_massCol1+$node_massBeamHEA]
	set mass3_REAR [expr 0.5*$pallet3+$node_massCol2+$node_massBeamHEA]
	
	set mass4 [expr $pallet1+$node_massCol3+$node_massBeam8]
	
	set mass5 [expr $pallet2+$node_massCol3+$node_massBeam8]
	
	set mass6 [expr $pallet3+$node_massCol4+$node_massBeam8]
	
	set masses1   "   
	                $mass3    $mass3	    0   	 0   	  0   	   0   	    0   	 0   	  0   	   0   	    0   	 0   	   0   		 0   		0   	 0   		0   		0   	 0   		0    	0   	  $mass3    	 $mass3			0   	 0   	  0   	   0   	    0   	 0   	  0   	   0   	    0   	 0   	   0   		 0   		0   	 0   		0   		0   	 0   		0    	0   	  $mass3	    $mass3 
					0   	  0   	        0   	 0   	  0   	   0   	    0   	 0   	  0   	   0   	    0   	 0   	   0   		 0   		0   	 0   		0   		0   	 0   		0    	0   	  0   	     	 0   	    	0   	 0   	  0   	   0   	    0   	 0   	  0   	   0   	    0   	 0   	   0   		 0   		0   	 0   		0   		0   	 0   		0    	0   	  0   	    	0					
	                $mass3    $mass3_REAR   $mass6   $mass6   $mass6   $mass6   $mass6	 $mass6   $mass6   $mass6   $mass6   $mass6    $mass6    $mass6    $mass6    $mass6    $mass6     $mass6     $mass6    $mass6   $mass6	  $mass3_REAR    $mass3_REAR	$mass6   $mass6   $mass6   $mass6   $mass6	 $mass6   $mass6   $mass6   $mass6   $mass6    $mass6    $mass6    $mass6    $mass6    $mass6     $mass6     $mass6    $mass6   $mass6	  $mass3_REAR   $mass3     
	                $mass3    $mass3_REAR   $mass6   $mass6   $mass6   $mass6   $mass6	 $mass6   $mass6   $mass6   $mass6   $mass6    $mass6    $mass6    $mass6    $mass6    $mass6     $mass6     $mass6    $mass6   $mass6	  $mass3_REAR    $mass3_REAR	$mass6   $mass6   $mass6   $mass6   $mass6	 $mass6   $mass6   $mass6   $mass6   $mass6    $mass6    $mass6    $mass6    $mass6    $mass6     $mass6     $mass6    $mass6   $mass6	  $mass3_REAR   $mass3     
	                $mass3    $mass3_REAR   $mass6   $mass6   $mass6   $mass6   $mass6	 $mass6   $mass6   $mass6   $mass6   $mass6    $mass6    $mass6    $mass6    $mass6    $mass6     $mass6     $mass6    $mass6   $mass6	  $mass3_REAR    $mass3_REAR	$mass6   $mass6   $mass6   $mass6   $mass6	 $mass6   $mass6   $mass6   $mass6   $mass6    $mass6    $mass6    $mass6    $mass6    $mass6     $mass6     $mass6    $mass6   $mass6	  $mass3_REAR   $mass3     
	                $mass3    $mass3_REAR   $mass6   $mass6   $mass6   $mass6   $mass6	 $mass6   $mass6   $mass6   $mass6   $mass6    $mass6    $mass6    $mass6    $mass6    $mass6     $mass6     $mass6    $mass6   $mass6	  $mass3_REAR    $mass3_REAR	$mass6   $mass6   $mass6   $mass6   $mass6	 $mass6   $mass6   $mass6   $mass6   $mass6    $mass6    $mass6    $mass6    $mass6    $mass6     $mass6     $mass6    $mass6   $mass6	  $mass3_REAR   $mass3     
	                0   	  0   	        0   	 0   	  0   	   0   	    0   	 0   	  0   	   0   	    0   	 0   	   0   	     0   	   0   	     0   	   0   	      0   	     0   	   0   	    0   	  0   	     	 0   	    	0   	 0   	  0   	   0   	    0   	 0   	  0   	   0   	    0   	 0   	   0   	     0   	   0   	     0   	   0   	      0   	     0   	   0   	    0   	  0   	    	0   		    
	                $mass2    $mass2_REAR   $mass5   $mass5   $mass5   $mass5   $mass5	 $mass5   $mass5   $mass5   $mass5   $mass5    $mass5    $mass5    $mass5    $mass5    $mass5     $mass5     $mass5    $mass5   $mass5	  $mass2_REAR    $mass2_REAR	$mass5   $mass5   $mass5   $mass5   $mass5	 $mass5   $mass5   $mass5   $mass5   $mass5    $mass5    $mass5    $mass5    $mass5    $mass5     $mass5     $mass5    $mass5   $mass5	  $mass2_REAR   $mass2     
	                $mass2    $mass2_REAR   $mass5   $mass5   $mass5   $mass5   $mass5	 $mass5   $mass5   $mass5   $mass5   $mass5    $mass5    $mass5    $mass5    $mass5    $mass5     $mass5     $mass5    $mass5   $mass5	  $mass2_REAR    $mass2_REAR	$mass5   $mass5   $mass5   $mass5   $mass5	 $mass5   $mass5   $mass5   $mass5   $mass5    $mass5    $mass5    $mass5    $mass5    $mass5     $mass5     $mass5    $mass5   $mass5	  $mass2_REAR   $mass2     
	                0   	  0   	        0   	 0   	  0   	   0   	    0   	 0   	  0   	   0   	    0   	 0   	   0   	     0   	   0   	     0   	   0   	      0   	     0   	   0   	    0   	  0   	     	 0   	    	0   	 0   	  0   	   0   	    0   	 0   	  0   	   0   	    0   	 0   	   0   	     0   	   0   	     0   	   0   	      0   	     0   	   0   	    0   	  0   	    	0   		    
	                $mass1    $mass2_REAR   $mass5   $mass5   $mass5   $mass5   $mass5	 $mass5   $mass5   $mass5   $mass5   $mass5    $mass5    $mass5    $mass5    $mass5    $mass5     $mass5     $mass5    $mass5   $mass5	  $mass2_REAR    $mass2_REAR	$mass5   $mass5   $mass5   $mass5   $mass5	 $mass5   $mass5   $mass5   $mass5   $mass5    $mass5    $mass5    $mass5    $mass5    $mass5     $mass5     $mass5    $mass5   $mass5	  $mass2_REAR   $mass1     
	                $mass1    $mass1_REAR   $mass4   $mass4   $mass4   $mass4   $mass4	 $mass4   $mass4   $mass4   $mass4   $mass4    $mass4    $mass4    $mass4    $mass4    $mass4     $mass4     $mass4    $mass4   $mass4	  $mass1_REAR    $mass1_REAR	$mass4   $mass4   $mass4   $mass4   $mass4	 $mass4   $mass4   $mass4   $mass4   $mass4    $mass4    $mass4    $mass4    $mass4    $mass4     $mass4     $mass4    $mass4   $mass4	  $mass1_REAR   $mass1     
					0   	  $mass1_REAR   $mass4   $mass4   $mass4   $mass4   $mass4	 $mass4   $mass4   $mass4   $mass4   $mass4    $mass4    $mass4    $mass4    $mass4    $mass4     $mass4     $mass4    $mass4   $mass4	  $mass1_REAR    $mass1_REAR	$mass4   $mass4   $mass4   $mass4   $mass4	 $mass4   $mass4   $mass4   $mass4   $mass4    $mass4    $mass4    $mass4    $mass4    $mass4     $mass4     $mass4    $mass4   $mass4	  $mass1_REAR   0   	
					0   	  0   	        0   	 0   	  0   	   0   	    0   	 0   	  0   	   0   	    0   	 0   	   0   		 0   		0   	 0   		0   		0   	 0   		0    	0   	  0   	     	 0   	    	0   	 0   	  0   	   0   	    0   	 0   	  0   	   0   	    0   	 0   	   0   		 0   		0   	 0   		0   		0   	 0   		0    	0   	  0   	    	0   		    					
	"
#########################################

#################
## Draw frames ##
	set frame1 "
		  {02 07 02}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {02 07 02}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {02 07 02}  
		03	        03	        00	        05	        00	        05	        00	        05	        00	        05	        00	        05	        00	        05	        00	        05	        00	        05	        00	        05	        00	        03	        03	        00	        05	        00	        05	        00	        05	        00	        05	        00	        05	        00	        05	        00	        05	        00	        05	        00	        05	        00	        03	        03
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		03	        03	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        03	        03	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        03	        03
		  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  
		03	        03	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        03	        03	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        03	        03
		  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  
		03	        03	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        03	        03	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        03	        03
		  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  
		03	        03	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        03	        03	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        03	        03
		  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  
		03	        03	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        03	        03	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        05	        03	        03
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		01	        01	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        01	        01	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        01	        01
		  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  
		01	        01	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        01	        01	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        01	        01
		  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  
		01	        01	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        01	        01	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        01	        01
		  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  {00 00 00}  
		02	        02	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        02	        02	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        02	        02
		  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  
		02	        02	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        02	        02	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        02	        02
		  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {02 07 02}  
		02	        02	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        02	        02	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        02	        02
		  {00 00 00}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {00 00 00}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {01 06 01}  {00 00 00}  
		02	        02	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        02	        02	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        04	        02	        02
	"


	set Nframes 1;
	set x0 0.0;

#GUI_frame2D_ElasticCol_LumpedBeam	{ Region_ID   *masses *Ypoints  *Xpoints x0 *frame release {Node_ID 100} {Ele_ID 1000}  {InternalNode_ID 100  } {InternalEle_ID 100  } } {
GUI_frame2D_FiberCol_LumpedBeam	1  masses1 Ypoints Xpoints  $x0 frame1 "fullrelease" 1000
#GUI_frame2D_ElasticCol_LumpedBeam	1  masses1 Ypoints Xpoints  $x0 frame1 "fullrelease" 1000
#########################################


##############################
## Create bottom boundaries ##

#SpringedAndPinned2D	{ Region_ID	  SlaveRegion_ID	 y		springMat
SpringedAndPinned2D	2	 1	 0.0	03
#########################################


	set XBracingPoints "0.0	3.12	4.66	6.2	 7.74	9.28	10.82	12.36	13.9	15.44	16.98	18.52	20.06	21.6	23.14	24.68	26.22	27.76	29.3	30.84	32.38	33.92	37.04	38.58	40.12	41.66	43.2	44.74	46.28	47.82	49.36	50.9	52.44	53.98	55.52	57.06	58.6	60.14	61.68	63.22	64.76	66.3	67.84	70.96"

	set YBracingPoints "0.0	  2.882	  5.507  8.132	10.757	13.382	16.007	18.632	21.257  23.98403"
	
	set bracings "
		09	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	09	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	09
		09	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	09	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	09
		09	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	09	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	09
		09	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	09	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	09
		09	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	09	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	09
		08	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	08	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	08
		08	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	08	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	08
		08	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	08	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	08
		08	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	08	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	00	08	
	"
	
	
	
	#rackBracing2D	3  1  YBracingPoints XBracingPoints bracings orientation 200
	
	#frameBracing2D	3  1  YBracingPoints XBracingPoints bracings "double" 1000;#200
	
	frameFiberBracing2D	3  1  YBracingPoints XBracingPoints bracings "double" 1000;#200
	

end_of_element_definitions; ################### NEVER FORGET THIS

PrintRegions;



###################################################################################################
#          Merge
###################################################################################################
	write_removed_elements;


###################################################################################################
#          Analysis
###################################################################################################

###################################################################################################
#          Display													  
###################################################################################################	

	DisplayModel2D DeformedShape 10	700	0	1000	400;

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
	
	
	recorder Element  -file "$dataDir/EleSection1.out" -time -eleRange 11177	11308 -dof 2	globalForce ; # 1198 1242
	
	recorder Element  -file "$dataDir/Bracing.out" -time -ele 31001 -dof 2	globalForce ; # 1198 1242
	
	recorder Element -file "$dataDir/EleSection3.out" -time -ele 11009 -dof 2	globalForce; # 1009 1053
	
	recorder Element -file "$dataDir/EleSection2.out" -time -ele 11397 -dof 2	globalForce; # 1397 1441
	
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
				SPO_x_eigen2D $i $x0 $Fx_top 1
			}
			
	}

	RunPushover2Converge $topNode1 [expr 250.248*$mm] [expr 0.020*$mm] 

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

