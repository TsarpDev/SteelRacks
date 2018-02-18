
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
	
###################################################################################################
#          Define Masses										  
###################################################################################################


	set massX [expr 9*20387*$kg*0.01/2];	#500 kg at each top node



###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################

# define material properties
	set Es [expr 210*$GPa];						# steel Young's modulus
	set fy [expr 275*$MPa];

# define column section Tube 100x100mm t=2mm 
	set A_col [expr 7.84e-4*$m2];				# cross-sectional area
	set I_col  [expr 1.255e-6*$m4];				# moment of inertia

# define bracing section 
	set A_br  [expr 3.048e-4*$m2];				# cross-sectional area 
	set I_br  [expr 7.393e-09*$m4];

# define bracing elements


	
# set up geometric transformations of element
	set PDeltaTransf 1;
	geomTransf PDelta $PDeltaTransf; 			# PDelta transformation
	
# generate built up columns: akreo (x2)
	set N_col_akreo		2;						# total number of columns 
	set N_box		2;							# total number of x boxes
	set big_x_akreo		0;						# 1 for internal bracing, 0 if not
	set h0	[expr 1.05*$m];						# horizontal distance between columns
	set a	[expr 1*$m];						# vertical length of default box
	set Special_Boxes { "2" "0.5" };				# first column the index of the box, second the vertical lengths of each;
	set y0	[expr 0.0*$m];						#starting y0 to build column
	
	
	set x1	[expr 0.0*$m];				# starting x0 to build column 1	  
	
# command nonLinearX_columnMassTop Region_ID  Es	fy	  A_col  I_col  A_br I_br  A_beam I_beam   Geom_TransID  massX  {N_col 2} {N_box 20}  {h0 1}  {a 1}  {x0 0}  {y0 0}  *Special_Boxes  {big_x 0} {imp_coef "c"} {Node_ID 1000} {Ele_ID 1000}   } {

			

		
	nonLinearX_columnMassTop		1		$Es		$fy		$A_col	   $I_col	$A_br   $I_br 	$A_br	$I_br   $PDeltaTransf	  $massX	$N_col_akreo	$N_box		$h0		$a		$x1		$y0		Special_Boxes		$big_x_akreo   "c";
			
	
	end_of_element_definitions;
	
	
	lineX_delete 1 1.5 "X Bracing";
	
	lineX_delete 1 1.5 "Ver Bracing";
	
	
	
	PrintRegions;
	
	write_removed_elements;
	
	printMaterials;

	
	
	
# display the model with the node numbers
	DisplayModel2D NodeNumbers	5	700	0	1000	1000;	
		
	#DisplayModel2D ModeShape	50	700	0	1000	1000;

	
############################################################################
#                       Eigenvalue Analysis                    			   
############################################################################
	set pi [expr 2.0*asin(1.0)];						# Definition of pi
	set nEigenI 1;										# mode i = 1
	set nEigenJ 2;										# mode j = 2
	set lambdaN [eigen [expr $nEigenJ]];				# eigenvalue analysis for nEigenJ modes
	set lambdaI [lindex $lambdaN [expr 0]];				# eigenvalue mode i = 1
	set lambdaJ [lindex $lambdaN [expr $nEigenJ-1]];	# eigenvalue mode j = 2

	set w1 [expr pow($lambdaI,0.5)];					# w1 (1st mode circular frequency)
	set w2 [expr pow($lambdaJ,0.5)];					# w2 (2nd mode circular frequency)
	set T1 [expr 2.0*$pi/$w1];							# 1st mode period of the structure
	set T2 [expr 2.0*$pi/$w2];							# 2nd mode period of the structure
	puts "T1 = $T1 s";									# display the first mode period in the command window
	puts "T2 = $T2 s";									# display the second mode period in the command window

	
###################################################################################################
#          Apply Gravity Loads													  
###################################################################################################

# apply gravity loads
	#command: pattern PatternType $PatternID TimeSeriesType
	pattern Plain 101 Constant {
		
		convert_massX;
		
	}

# Gravity-analysis: load-controlled static analysis
	set Tol 1.0e-6;							# convergence tolerance for test
	constraints Plain;						# how it handles boundary conditions
	numberer RCM;							# renumber dof's to minimize band-width (optimization)
	system BandGeneral;						# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	test NormDispIncr $Tol 6;				# determine if convergence has been achieved at the end of an iteration step
	algorithm Newton;						# use Newton's solution algorithm: updates tangent stiffness at every iteration
	set NstepGravity 10;					# apply gravity in 10 steps
	set DGravity [expr 1.0/$NstepGravity];	# load increment
	integrator LoadControl $DGravity;		# determine the next time step for an analysis
	analysis Static;						# define type of analysis: static or transient
	analyze $NstepGravity;					# apply gravity

# maintain constant gravity loads and reset time to zero
	loadConst -time 0.0
	puts "Model Built"
	
	
############################################################################
#              Recorders					                			   
############################################################################
	
# record floor displacements
	set topNode [getNode 1 0.0 1.5];
	recorder Node -file $dataDir/Disp.out -time -node $topNode -dof 1 disp;
	
	

	
	
	recorder Node -file $dataDir/Vbase.out -node 1001	1002   -dof 1 reaction;

	

###################################################################################################
#          Run pushover													  
###################################################################################################

	if {$analysisType == "pushover"} { 
	puts "Running Pushover..."
# assign lateral loads and create load pattern:  use ASCE 7-10 distribution
	pattern Plain 200 Linear {			

	
			lineX_forces 1 1.0 [expr 1.0];
			lineX_forces 1 1.5 [expr 26.0];
	
			
		
	}
	
# display deformed shape:
	set ViewScale 1;
	DisplayModel2D DeformedShape $ViewScale 700	0	1000	1000;	# display deformed shape, the scaling factor needs to be adjusted for each model

# displacement parameters
	set IDctrlNode [getNode 1 0.0 1.5];				# node where disp is read for disp control
	
	
	set IDctrlDOF 1;					# degree of freedom read for disp control (1 = x displacement)
	set Dmax [expr 0.2];					# maximum displacement of pushover: 10% roof drift
	set Dincr [expr 0.001];				# displacement increment

# analysis commands
	if 0 {
	set Tol 1.0e-6;							# convergence tolerance for test
	constraints Plain;						# how it handles boundary conditions
	numberer RCM;							# renumber dof's to minimize band-width (optimization)
	system BandGeneral;						# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	test NormDispIncr $Tol 6;				# determine if convergence has been achieved at the end of an iteration step
	algorithm Newton;						# use Newton's solution algorithm: updates tangent stiffness at every iteration
	set NstepGravity 50;					# apply gravity in 10 steps
	set DGravity [expr 1.0/$NstepGravity];	# load increment
	integrator LoadControl $DGravity;		# determine the next time step for an analysis
	analysis Static;						# define type of analysis: static or transient
	analyze $NstepGravity;					# apply gravity
	}
	
	

	constraints Plain;					# how it handles boundary conditions
	numberer RCM;						# renumber dof's to minimize band-width (optimization)
	system BandGeneral;					# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	test NormUnbalance 1.0e-6 400;		# type of convergence criteria with tolerance, max iterations
	algorithm Newton;					# use Newton's solution algorithm: updates tangent stiffness at every iteration
	integrator DisplacementControl  $IDctrlNode   $IDctrlDOF $Dincr;	# use displacement-controlled analysis
	analysis Static;					# define type of analysis: static for pushover
	set Nsteps [expr int($Dmax/$Dincr)];# number of pushover analysis steps
	set ok [analyze $Nsteps];			# this will return zero if no convergence problems were encountered
	puts "Pushover complete";			# display this message in the command window
	
	
	
	
	
	print model.out ;
	
}






###################################################################################################
#          CLEAN ALL												  
###################################################################################################	

	cleanall;
	
generatePushoverDiagram		"$dataDir/Disp.out"		"$dataDir/Vbase.out" ;

if {[traceYield]} {
	puts "Done!";
}