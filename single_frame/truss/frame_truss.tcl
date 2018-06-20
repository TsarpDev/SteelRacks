
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


################ COLUMNS ################

set Es [expr 210*$GPa];

set RHS1 1; # 120x80x10 S355
set Acol1 3.60e-3;
set Icol1 3.32e-6;

set RHS2 2; # 120x80x6 S355
set Acol2 2.256e-3;
set Icol2 4.382e-6;

set RHS3 3; # 120x80x4 S355
set Acol3 1.536e-3;
set Icol3 3.090e-6;


addElasticSection $RHS1
addElasticSectionProperties $RHS1 $Es $Acol1 $Icol1;

addElasticSection $RHS2
addElasticSectionProperties $RHS2 $Es $Acol2 $Icol2;

addElasticSection $RHS3
addElasticSectionProperties $RHS3 $Es $Acol3 $Icol3;


set	h0	[expr	60	*$mm	]
set	h1	[expr	1060	*$mm	]
set	h2	[expr	2310	*$mm	]
set	h3	[expr	3560	*$mm	]
set	h4	[expr	4810	*$mm	]
set	h5	[expr	6060	*$mm	]
set	h6	[expr	7310	*$mm	]
set	h7	[expr	8560	*$mm	]
set	h8	[expr	9810	*$mm	]
set	h9	[expr	11060	*$mm	] 
set	h10	[expr	12310	*$mm	]
set	h11	[expr	13560	*$mm	]
set	h12	[expr	14810	*$mm	]
set	h13	[expr	16060	*$mm	]
set	h14	[expr	17310	*$mm	]
set	h15	[expr	18560	*$mm	]
set	h16	[expr	19810	*$mm	]
set	h17	[expr	21060	*$mm	]
set	h18	[expr	22130	*$mm	]
set	h19	[expr	23200	*$mm	]





set columns { 1 1 1 1 1 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3}

################ BRACINGS - small ################


set L40x40x5xS355_156 4; # L40x40x5 S355
addMultiElastic $L40x40x5xS355_156 "trusses/L40x40x5xS355_l=1.56.txt"

set L40x40x5xS355_173 5; # L40x40x5 S355
addMultiElastic $L40x40x5xS355_173 "trusses/L40x40x5xS355_l=1.73.txt"

 
set L40x40x4xS275_173 6; # L40x40x4 S275
addMultiElastic $L40x40x4xS275_173 "trusses/L40x40x4xS275_l=1.73.txt"


set L35x35x4xS275_173 7; # L35x35x4 S275
addMultiElastic $L35x35x4xS275_173 "trusses/L35x35x4xS275_l=1.73.txt"

set L35x35x4xS235_173 8; # L35x35x4 S235
addMultiElastic $L35x35x4xS235_173 "trusses/L35x35x4xS235_l=1.73.txt"


set L30x30x4xS235_173 9; # L30x30x4 S235
addMultiElastic $L30x30x4xS235_173 "trusses/L30x30x4xS235_l=1.73.txt"

set L30x30x4xS235_160 10; # L30x30x4 S235
addMultiElastic $L30x30x4xS235_160 "trusses/L30x30x4xS235_l=1.60.txt"


set bracings_small { 4 5 5 6 6 6 6 6 6 7 8 8 8 9 9 9 9 10 10 }


################ BRACINGS - big ################

set L40x40x5xS355_big156 11; # L40x40x5 S355
addMultiElastic $L40x40x5xS355_big156 "trusses/L40x40x5xS355_l=1.56.txt"

set RHS30x30x2punto5xS355 12;  #  RHS30x30x2.5 S355
addMultiElastic $RHS30x30x2punto5xS355 "trusses/RHS30x30x2.5xS355_l=1.73.txt"

set RHS30x30x2punto5xS275 13;  #  RHS30x30x2.5 S275
addMultiElastic $RHS30x30x2punto5xS275 "trusses/RHS30x30x2.5xS275_l=1.73.txt"

set RHS30x30x2punto5xS235 14;  #  RHS30x30x2.5 S235
addMultiElastic $RHS30x30x2punto5xS235 "trusses/RHS30x30x2.5xS235_l=1.73.txt"

set RHS30x30x2xS235 15;  #  RHS30x30x2 S235
addMultiElastic $RHS30x30x2xS235 "trusses/RHS30x30x2xS235_l=1.73.txt"

set RHS30x30x2xS235160 16;  #  RHS30x30x2 S235
addMultiElastic $RHS30x30x2xS235160 "trusses/RHS30x30x2xS235_l=1.60.txt"

set bracings_big { 11 12 12 12 12 12 13 13 13 13 13 14 14 14 15 15 15 16 16 }




################ BEAMS ################



set DC80x50x3 17; # Double Channel 80x50x3 S355
set Abeam 1.0446e-3
set Ibeam 1.0925e-6


addElasticSection $DC80x50x3
addElasticSectionProperties $DC80x50x3 $Es $Abeam $Ibeam;


set beams { 17 17 17 17 17 17 17 17 17 17 17 17 17 17 17 17 17 17 17}



################ ZIC-BEAM ################

set DA45x45x4 18; #Double Angle 45x45x4 S355
set Ah_beam 6.88e-4;
set Ih_beam 1.333e-7

set DA55x55x4 19; #Double Angle 55x55x4 S355
set Av_beam 8.48e-4;
set Iv_beam 2.4916e-7;

addElasticSection $DA45x45x4
addElasticSectionProperties $DA45x45x4 $Es $Ah_beam $Ih_beam

addElasticSection $DA55x55x4
addElasticSectionProperties $DA55x55x4 $Es $Av_beam $Iv_beam

set horizontal_truss  18

set vertical_truss 19




###################################################################################################
#          Frame
###################################################################################################



############ COLUMNS #########################################################################################################
set heights "0.0 $h0 $h1 $h2 $h3 $h4 $h5 $h6 $h7 $h8 $h9 $h10 $h11 $h12	$h13 $h14 $h15 $h16 $h17 $h18 $h19";
#set massX   "0	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87	203.87";
set massX   "0	50	50	50	50	50	50	50	50	50	50	50	50	50	50	50	50	50	50	50	50";


x_column_NL_FULLY_TRUSS	1   massX heights  0.0  1.2 columns beams bracings_small   0

x_column_NL_FULLY_TRUSS	2   massX heights  3.1  1.2 columns beams bracings_big   1

x_column_NL_FULLY_TRUSS	3   massX heights  7.4  1.2 columns beams bracings_big   1

x_column_NL_FULLY_TRUSS	4   massX heights  11.7  1.2 columns beams bracings_big   1

x_column_NL_FULLY_TRUSS	5   massX heights  16.0  1.2 columns beams bracings_big   1

x_column_NL_FULLY_TRUSS	6   massX heights  20.3  1.2 columns beams bracings_small   0

##############################################################################################################################



############ BEAMS ###########################################################################################################

set l1 [expr 0.0*$mm]
set l2 [expr $l1 + 1200.0*$mm]
set l3 [expr $l2 + 950.0*$mm]
set l4 [expr $l3 + 950.0*$mm]
set l5 [expr $l4 + 1200.0*$mm]
set l6 [expr $l5 + 1200.0*$mm]
set l7 [expr $l6 + 950.0*$mm]
set l8 [expr $l7 + 950.0*$mm]
set l9 [expr $l8 + 1200.0*$mm]
set l10 [expr $l9 + 1200.0*$mm]
set l11 [expr $l10 + 950.0*$mm]


set lengths "$l1 $l2 $l3 $l4 $l5 $l6 $l7 $l8 $l9 $l10 $l11";


#command:  zic_beam_truss	 Region_ID  beams  trusses  massX   *lengths_sym  {h0_start 1.0} {h0_end 1.1}  {x0 0.0}  {y0 0.0}  {Node_ID 1000} {Ele_ID 1000}


set mass_beam	[expr 50*$kg];
set x7			[expr 0.0*$m];								# starting x0 to build beam 7
set y7 			[expr $h19*$m];							# starting y0 to build beam 7
set h0_start 	[expr 1000.0*$mm];
set h0_end   	[expr 1300.0*$mm];

#zic_beam_NL_FIBER	 	7  	$horizontal_truss   $vertical_truss   $mass_beam   lengths $h0_start $h0_end $x7 $y7;

zic_beam_FULLY_TRUSS	 	7  	$horizontal_truss   $vertical_truss   $mass_beam   lengths $h0_start $h0_end $x7 $y7;


###############################################################################################################################


end_of_element_definitions; ################### NEVER FORGET THIS

PrintRegions;



###################################################################################################
#          Merge
###################################################################################################


	merge_common 7 1;
	merge_common 7 2;
	merge_common 7 3;
	merge_common 7 4;
	merge_common 7 5;
	merge_common 7 6;

	write_removed_elements;



	DisplayModel2D DeformedShape 5	700	0	1000	1000;

###################################################################################################
#          Analysis
###################################################################################################

############################################################################
#                       Eigenvalue Analysis
############################################################################

	if 0 {
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
	}



	
###################################################################################################
#          Apply Gravity Loads
###################################################################################################

if 0 {

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
	
	puts "Applying gravity loads..."
	analyze $NstepGravity;					# apply gravity

# maintain constant gravity loads and reset time to zero
	loadConst -time 0.0
	puts "Gravity loads applied successfully!"
}

############################################################################
#              Recorders
############################################################################

	puts "Setting up recorders..."
# record floor displacements
	set topNode7 [getNode 7 0.0 23.2];
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
	
	puts "Recorders done!"

###################################################################################################
#          Run pushover													  
###################################################################################################	


set Fx_top [expr 1*$N];
pattern Plain 200 Linear {			
#command SPO_x_eigen $Region_ID $X_coord $Fx_top
		 #SPO_x_eigen 1 $x1 $Fx_top
		 
		 #SPO_x_eigen 2 $x2 $Fx_top
		 
		 #SPO_x_eigen 3 $x3 $Fx_top
		 
		 #SPO_x_eigen 4 $x4 $Fx_top
		 
		 #SPO_x_eigen 5 $x5 $Fx_top
		 
		 #SPO_x_eigen 6 $x6 $Fx_top
		 
		 load [getNode 7 0 24.2] 1.0 0.0 0.0
}

set IDctrlNode [getNode 7 0 24.2];	

RunPushover2Converge $IDctrlNode [expr 130*$mm] [expr 0.5*$mm] 


print "model.out"

###################################################################################################
#          CLEAN ALL
###################################################################################################

	cleanall;
	
	
	

###################################################################################################
#          POST PROCESSING
###################################################################################################

addReactions $Vnames  "$dataDir/Vbase.out";

generatePushoverDiagram		"$dataDir/Disp.out"		"$dataDir/Vbase.out";

