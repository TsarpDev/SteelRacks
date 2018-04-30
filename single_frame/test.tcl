
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
	
	
if 0 {
###################################################################################################
#          Define Masses										  
###################################################################################################


# calculate nodal masses -- lump floor masses at frame nodes

	set massX [expr 500*$kg];	#500 kg at each top node



###################################################################################################
#          Define Section Properties and Elements													  
###################################################################################################

# define material properties
	set Es [expr 210*$GPa];						# steel Young's modulus

# define column section Tube 100x100mm t=2mm 
	set A_col [expr 7.84e-4*$m2];				# cross-sectional area
	set I_col  [expr 1.255e-6*$m4];				# moment of inertia

# define bracing section 
	set A_br  [expr 1.66e-4*$m2];				# cross-sectional area 
# define bracing elements
	set TrussMatID 600;		# define a material ID
	uniaxialMaterial Elastic $TrussMatID $Es;		# define truss material

# define beam section
	set A_beam	[expr 6.82e-4*$m2];				# cross sectional area
	set I_beam	[expr 1.354e-6*$m4];			# moments of inertia
	
# set up geometric transformations of element
	set PDeltaTransf 1;
	geomTransf PDelta $PDeltaTransf; 			# PDelta transformation
	
# generate built up columns: akreo (x2)
	set N_col_akreo		2;						# total number of columns 
	set N_col_meseo		3;						# 
	set N_box		19;							# total number of x boxes
	set big_x_akreo		0;						# 1 for internal bracing, 0 if not
	set big_x_meseo		1;						# 1 for internal bracing, 0 if not
	set h0	[expr 1*$m];						# horizontal distance between columns
	set a	[expr 1*$m];						# vertical length of default box
	
	
	set Special_Boxes { "1 18 19" "0.9 0.9 0.9" };			# first column the index of the box, second the vertical lengths of each;
	
	
	set y0	[expr 0.0*$m];				#starting y0 to build column
	
#command: x_column $Region_ID		$Es		$A_col	   $I_col	$A_br	$A_beam   $TrussMatID		$Geom_TransID	$massX     <$N_col			$N_box	 		$h0			$a			$x0			$y0			Special_Boxes			$big_x>	 			
		  set x1	[expr 0.0*$m];				# starting x0 to build column 1
		  set x2	[expr 2.6*$m];				# starting x0 to build column 2
		  set x3	[expr 6.2*$m];				# starting x0 to build column 3
		  set x4	[expr 9.8*$m];				# starting x0 to build column 4
		  set x5	[expr 13.4*$m];				# starting x0 to build column 5
		  set x6	[expr 17.0*$m];				# starting x0 to build column 6
		  
		  
		  x_column		1			$Es		$A_col	   $I_col	$A_br	$A_beam   $TrussMatID	    $PDeltaTransf	$massX		$N_col_akreo	$N_box			$h0			$a			$x1			$y0			Special_Boxes			$big_x_akreo;
		  x_column		2			$Es		$A_col	   $I_col	$A_br	$A_beam   $TrussMatID	    $PDeltaTransf	$massX		$N_col_meseo	$N_box			$h0			$a			$x2			$y0			Special_Boxes			$big_x_meseo;
		  x_column		3			$Es		$A_col	   $I_col	$A_br	$A_beam   $TrussMatID	    $PDeltaTransf	$massX		$N_col_meseo	$N_box			$h0			$a			$x3			$y0			Special_Boxes			$big_x_meseo;
		  x_column		4			$Es		$A_col	   $I_col	$A_br	$A_beam   $TrussMatID	    $PDeltaTransf	$massX		$N_col_meseo	$N_box			$h0			$a			$x4			$y0			Special_Boxes			$big_x_meseo;
		  x_column		5			$Es		$A_col	   $I_col	$A_br	$A_beam   $TrussMatID	    $PDeltaTransf	$massX		$N_col_meseo	$N_box			$h0			$a			$x5			$y0			Special_Boxes			$big_x_meseo;
		  x_column		6			$Es		$A_col	   $I_col	$A_br	$A_beam   $TrussMatID	    $PDeltaTransf	$massX		$N_col_akreo	$N_box			$h0			$a			$x6			$y0			Special_Boxes			$big_x_akreo;
	
			
#set heights {0.0  1.0  2.0  3.0  4.0  5.0  6.0  7.0  8.0  9.0  10.0  11.0  12.0  13.0  14.0  15.0  16.0  17.0  18.0  19.0  20.0};
#command: x_column_arb	Region_ID	Es		A_col  		I_col  	 A_br    A_beam    TrussMatID     Geom_TransID    massX   {N_col 2} 	*heigths  	{h0 1} 	   {x0 0}      {y0 0}       {big_x 0} {Node_ID 1000} {Ele_ID 1000}   
#x_column_arb		10  	   $Es    $A_col       $I_col   $A_br   $A_beam   $TrussMatID    $PDeltaTransf   $massX  $N_col_akreo 	 heights   $h0_akreo   $x0_akreo      $big_x_akreo;
		  

	set lengths_sym "[expr 0.0*$m] [expr 1.0*$m] [expr 1.8*$m] [expr 2.6*$m] [expr 3.6*$m] [expr 4.6*$m] [expr 5.4*$m] [expr 6.2*$m] [expr 7.2*$m] [expr 8.2*$m] [expr 9.0*$m]";
	
	
#command:  zic_beam_sym	 Region_ID  Es   A_beam   I_beam     A_ver  A_diag  TrussMatID   Geom_TransID     massX  *lengths_sym  {h0_start 1} {h0_end 1.1}  {x0 0}  {y0 0}  {Node_ID 1000} {Ele_ID 1000}   
		set mass_beam	[expr 50*$kg];			
		set x7			[expr 0.0*$m];								# starting x0 to build beam 7
		set y7 			[expr 18.70*$m];							# starting y0 to build beam 7
		set h0_start 	[expr 1.0*$m];
		set h0_end   	[expr 2.0*$m];
	
		zic_beam_sym	 	7  		$Es  $A_beam  $I_beam   $A_br   $A_br   $TrussMatID  $PDeltaTransf   $mass_beam   lengths_sym $h0_start $h0_end $x7 $y7;
	
	
	end_of_element_definitions;
	
	PrintRegions;

###################################################################################################
#          Connect Regions													  
###################################################################################################
	
	#merge_common #master_region_id #slave_region_id
	
	
	
	merge_common 7 1;	
	merge_common 7 2;
	merge_common 7 3;
	merge_common 7 4;
	merge_common 7 5;
	merge_common 7 6;
	
	
	write_removed_elements;

	
	

	
	
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
	
	
###################################################################################################
#          Run pushover													  
###################################################################################################

	if {$analysisType == "pushover"} { 
	puts "Running Pushover..."
# assign lateral loads and create load pattern:  use ASCE 7-10 distribution
	set Fx_top [expr 1*$N];
	pattern Plain 200 Linear {			
#command SPO_x_eigen $Region_ID $X_coord $Fx_top
		 SPO_x_eigen 1 $x1 $Fx_top
		 
		 SPO_x_eigen 2 $x2 $Fx_top
		 
		 SPO_x_eigen 3 $x3 $Fx_top
		 
		 SPO_x_eigen 4 $x4 $Fx_top
		 
		 SPO_x_eigen 5 $x5 $Fx_top
		 
		 SPO_x_eigen 6 $x6 $Fx_top
	}
	
# display deformed shape:
	set ViewScale 1;
	DisplayModel2D DeformedShape $ViewScale 700	0	1000	1000;	# display deformed shape, the scaling factor needs to be adjusted for each model

# displacement parameters
	set IDctrlNode [getNode 7 0 19.7];				# node where disp is read for disp control
	
	
	set IDctrlDOF 1;					# degree of freedom read for disp control (1 = x displacement)
	set Dmax [expr 2];					# maximum displacement of pushover: 10% roof drift
	set Dincr [expr 0.05];				# displacement increment

# analysis commands
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
} 	
	


	
	print model.out ;

		
	

###################################################################################################
#          CLEAN ALL												  
###################################################################################################	
}
	cleanall;

if 0 {	
addReactions $Vnames  "$dataDir/Vbase.out";

generatePushoverDiagram		"$dataDir/Disp.out"		"$dataDir/Vbase.out";

if {[traceYield]} {
	puts "Done!";
	}
}

	