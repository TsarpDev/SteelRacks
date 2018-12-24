####################################################################
############################### TAGS ###############################
####################################################################
	
########################## SECTIONS	###############################	

## Aggregator multipliers		
	set currentAxialMat 1000;	#(MAT)
	set currentSection	1000;	#(SEC)

## uprights	 
	set SecCol1 1;			# lower bracing upright			(YOURS) (SEC)
	set SecCol1a 2;			# reinforced bracing upright	(YOURS) (SEC)
	set SecCol2 3;			# upper bracing upright			(YOURS) (SEC)
	set SecCol3 4;			# lower pallet upright			(YOURS) (SEC)
	set SecCol4 5;			# upper pallet upright			(YOURS) (SEC)
	
## beams
	set SecBeam8 6;			# normal beam					(YOURS)
	set SecBeamHEA 7;		# bracing normal beam			(YOURS)

## bracing diagonals
	set BracDiagL60x40x6 8; # lower bracing diagonal		(YOURS) (SEC)
	set BracDiag13	9;		# upper bracing diagonal 		(YOURS) (SEC)

## Legamenti
	set Legamenti 10;		#								(YOURS)

## Upright frame bracing
	set UFrameHor5	11;	    #								(YOURS)
	set UFrameDiag6	12;	    #								(YOURS)
	set UFrameDiag7	13;	    #								(YOURS)

## Rail beam
	set RailBeam10 14;		#								(YOURS)

## Machine beam
	set MachIPE100 15;		#								(YOURS)
	
## Bot roof beam
	set botRoofIPE140 16;	#								(YOURS)
	set topRoof15 17;		#								(YOURS)
	
########################## SPRINGS  ##########################	
	set SpringBeam8 1;		#								(MAT)
	set SpringBeamHEA 2;	#								(MAT)
	set SpringBottom 3;		#								(MAT)
	set SpringPinned 99; 	#								(MAT)
	
########################## BASIC MATS  ##########################	
	set S355	355;		#								(MAT)
	set S275	275;		#								(MAT)
	set S350	350;		#								(MAT)

####################################################################
####################################################################

	
###################################################################################################
#          Basic Materials
###################################################################################################
	uniaxialMaterial	Steel02 	$S355	[expr 355*$MPa]	[expr 210*$GPa]	0.1		\
									10	0.925	0.15
						
	uniaxialMaterial	Steel02 	$S275	[expr 275*$MPa]	[expr 210*$GPa]	0.1		\
									10	0.925	0.15
									
	uniaxialMaterial	Steel02 	$S350	[expr 350*$MPa]	[expr 210*$GPa]	0.1		\
									10	0.925	0.15

	
###################################################################################################
#          Define Axial resistances
###################################################################################################

## Upright axial resistances

set Nr1		[expr 528*$kN];			# this is for 1650 mm (EXPR)
set Nr2		[expr 247*$kN];			# this is for 1650 mm (ABQS)
set Nr3		[expr 316.472*$kN];		# this is for 1650 mm (ABQS)
set Nr4		[expr 155.51*$kN];		# this is for 1650 mm (EXPR)


###################################################################################################
#          Define Sections
###################################################################################################

################ COLUMNS ################
set E_column1 [expr 210.0*$GPa];
set A_column1 [expr 1720.0*$mm2];
set Iz_column1 [expr 3930538.0*$mm4];	
set Iy_column1 [expr 3846887.0*$mm4];	

set flexibilityMultiplier 2.0;
addElasticSection $SecCol1
add2DElasticSectionProperties $SecCol1 $E_column1  $A_column1 $Iy_column1;
incr currentAxialMat		
#uniaxialMaterial ElasticPP $currentAxialMat [expr $flexibilityMultiplier*$E_column1*$A_column1]	[expr $Nr1/($flexibilityMultiplier*$E_column1*$A_column1)];
uniaxialMaterial MultiLinear $currentAxialMat [expr $Nr1/($flexibilityMultiplier*$E_column1*$A_column1)] $Nr1\
											[expr 3.0*$Nr1/($flexibilityMultiplier*$E_column1*$A_column1)] [expr 0.1*$Nr1]\
											[expr 4.0*$Nr1/($flexibilityMultiplier*$E_column1*$A_column1)] [expr 0.1*$Nr1];
incr currentSection
section Elastic $currentSection $E_column1  [expr $flexibilityMultiplier*$A_column1] $Iy_column1;

section Aggregator $SecCol1 $currentAxialMat P  -section $currentSection


set E_column1a [expr 210.0*$GPa];
set A_column1a [expr 3443.0*$mm2];
set Iz_column1a [expr 9032635.0*$mm4];	
set Iy_column1a [expr 6767412.0*$mm4];	
addElasticSection $SecCol1a
add2DElasticSectionProperties $SecCol1a $E_column1a  $A_column1a $Iy_column1a;
section Elastic $SecCol1a $E_column1a  $A_column1a $Iy_column1a;


set E_column2 [expr 210.0*$GPa];
set A_column2 [expr 1070.0*$mm2];
set Iz_column2 [expr 2488602.0*$mm4];	
set Iy_column2 [expr 2396250.0*$mm4];	
addElasticSection $SecCol2
add2DElasticSectionProperties $SecCol2 $E_column2  $A_column2 $Iy_column2;
incr currentAxialMat
#uniaxialMaterial ElasticPP $currentAxialMat [expr $flexibilityMultiplier*$E_column2*$A_column2]	[expr $Nr2/($flexibilityMultiplier*$E_column2*$A_column2)];
uniaxialMaterial MultiLinear $currentAxialMat [expr $Nr2/($flexibilityMultiplier*$E_column2*$A_column2)] $Nr2\
											[expr 3.0*$Nr2/($flexibilityMultiplier*$E_column2*$A_column2)] [expr 0.1*$Nr2]\
											[expr 4.0*$Nr2/($flexibilityMultiplier*$E_column2*$A_column2)] [expr 0.1*$Nr2];
incr currentSection
section Elastic $currentSection $E_column2  [expr $flexibilityMultiplier*$A_column2] $Iy_column2;
section Aggregator $SecCol2 $currentAxialMat P  -section $currentSection


set E_column3 [expr 210.0*$GPa];
set A_column3 [expr 1290.0*$mm2];
set Iz_column3 [expr 2982693.0*$mm4];	
set Iy_column3 [expr 2887410.0*$mm4];	
addElasticSection $SecCol3
add2DElasticSectionProperties $SecCol3 $E_column3  $A_column3 $Iy_column3;
incr currentAxialMat
uniaxialMaterial MultiLinear $currentAxialMat [expr $Nr3/($flexibilityMultiplier*$E_column3*$A_column3)] $Nr3\
											[expr 3.0*$Nr3/($flexibilityMultiplier*$E_column3*$A_column3)] [expr 0.1*$Nr3]\
											[expr 4.0*$Nr3/($flexibilityMultiplier*$E_column3*$A_column3)] [expr 0.1*$Nr3];
#uniaxialMaterial ElasticPP $currentAxialMat [expr $flexibilityMultiplier*$E_column3*$A_column3]	[expr $Nr3/($flexibilityMultiplier*$E_column3*$A_column3)];

incr currentSection
section Elastic $currentSection $E_column3  [expr $flexibilityMultiplier*$A_column3] $Iy_column3;
section Aggregator $SecCol3 $currentAxialMat P  -section $currentSection


set E_column4 [expr 210.0*$GPa];
set A_column4 [expr 860.0*$mm2];
set Iz_column4 [expr 2011487.0*$mm4];	
set Iy_column4 [expr 1925642.0*$mm4];
addElasticSection $SecCol4
add2DElasticSectionProperties $SecCol4 $E_column4  $A_column4 $Iy_column4;
incr currentAxialMat
uniaxialMaterial MultiLinear $currentAxialMat [expr $Nr4/($flexibilityMultiplier*$E_column4*$A_column4)] $Nr4\
											[expr 3.0*$Nr4/($flexibilityMultiplier*$E_column4*$A_column4)] [expr 0.1*$Nr4]\
											[expr 4.0*$Nr4/($flexibilityMultiplier*$E_column4*$A_column4)] [expr 0.1*$Nr4];
#uniaxialMaterial ElasticPP $currentAxialMat [expr $flexibilityMultiplier*$E_column4*$A_column4]	[expr $Nr4/($flexibilityMultiplier*$E_column4*$A_column4)];

incr currentSection
section Elastic $currentSection $E_column4  [expr $flexibilityMultiplier*$A_column4] $Iy_column4;
section Aggregator $SecCol4 $currentAxialMat P  -section $currentSection


################ BEAMS ################

###BEAMS 1ST FLOOR
set E_beam8 [expr 210.0*$GPa];
set A_beam8 [expr 541.0*$mm2];
set Iz_beam8 [expr 795387.0*$mm4];
addElasticSection $SecBeam8
# add2DElasticSectionProperties {secTag E A Iz}
add2DElasticSectionProperties $SecBeam8 $E_beam8 $A_beam8 $Iz_beam8;

uniaxialMaterial Elastic $SpringBeam8 [expr 42.7*$kN*$m]


###BEAMS 2ND FLOOR
set E_beamHEA [expr 210.0*$GPa];
set A_beamHEA [expr 2124.0*$mm2];
set Iz_beamHEA [expr 3490000.0*$mm4];
addElasticSection $SecBeamHEA
add2DElasticSectionProperties $SecBeamHEA $E_beamHEA $A_beamHEA $Iz_beamHEA;

uniaxialMaterial Elastic $SpringBeamHEA [expr 58.0*$kN*$m];


################ BRACINGS ################
set E_L60x40x6 [expr 210.0*$GPa];
set A_L60x40x6 [expr 567.9*$mm2];
set Iz_L60x40x6 [expr 201400*$mm4];	
addElasticSection $BracDiagL60x40x6
add2DElasticSectionProperties $BracDiagL60x40x6 $E_L60x40x6  $A_L60x40x6 $Iz_L60x40x6;
AngleSection $BracDiagL60x40x6 $S355 [expr 33*$mm] [expr 66*$mm] [expr 3*$mm] [expr 3*$mm];

set E_Diag13 [expr 210.0*$GPa];
set A_Diag13 [expr 278.69*$mm2];
set Iz_Diag13 [expr 129213.19*$mm4];	
addElasticSection $BracDiag13
add2DElasticSectionProperties $BracDiag13 $E_Diag13  $A_Diag13 $Iz_Diag13;
AngleSection $BracDiag13 $S355 [expr 40*$mm] [expr 60*$mm] [expr 6*$mm] [expr 6*$mm];


################ UPRIGHT FRAME BRACINGS ################
set E_hor5	[expr 210.0*$GPa];
set A_hor5	[expr 249.0*$mm2];
set Iz_hor5	[expr 176539.0*$mm4];
set Iy_hor5	[expr 83390.0*$mm4];
addElasticSection	$UFrameHor5;
add2DElasticSectionProperties $UFrameHor5 $E_hor5  $A_hor5 $Iy_hor5;	#to take into account buckling failure

set E_hor6	[expr 210.0*$GPa];
set A_hor6	[expr 498.0*$mm2];
set Iz_hor6	[expr 334959.0*$mm4];
set Iy_hor6	[expr 153661.0*$mm4];
addElasticSection	$UFrameDiag6;
add2DElasticSectionProperties $UFrameDiag6 $E_hor6  $A_hor6 $Iy_hor6;	#to take into account buckling failure

set E_hor7	[expr 210.0*$GPa];
set A_hor7	[expr 332.0*$mm2];
set Iz_hor7	[expr 231431.0*$mm4];
set Iy_hor7	[expr 108314.0*$mm4];
addElasticSection	$UFrameDiag7;
add2DElasticSectionProperties $UFrameDiag7 $E_hor7  $A_hor7 $Iy_hor7;	#to take into account buckling failure

uniaxialMaterial Elastic $SpringPinned [expr 1e-9*$kN*$m];

################ CA BEAMS ################
set E_RL10	[expr 210.0*$GPa];
set A_RL10	[expr 818.0*$mm2];
set Iz_RL10	[expr 5350178.0*$mm4];
set Iy_RL10	[expr 322185.0*$mm4];
addElasticSection	$RailBeam10;
add2DElasticSectionProperties $RailBeam10 $E_RL10  $A_RL10 $Iz_RL10;

set E_Machine	[expr 210.0*$GPa];
set A_Machine	[expr 1030.0*$mm2];
set Iz_Machine	[expr 1710000.0*$mm4];
set Iy_Machine	[expr 159000.0*$mm4];
addElasticSection	$MachIPE100;
add2DElasticSectionProperties $MachIPE100 $E_Machine  $A_Machine $Iz_Machine;

################ ROOF BEAMS ################
set E_BRoof	[expr 210.0*$GPa];
set A_BRoof	[expr 1640.0*$mm2];
set Iz_BRoof	[expr 5410000.0*$mm4];
set Iy_BRoof	[expr 449000.0*$mm4];
addElasticSection	$botRoofIPE140;
add2DElasticSectionProperties $botRoofIPE140 $E_BRoof  $A_BRoof $Iz_BRoof;

set E_TRoof	[expr 210.0*$GPa];
set A_TRoof	[expr 680.0*$mm2];
set Iz_TRoof	[expr 1376054.0*$mm4];
set Iy_TRoof	[expr 606592.0*$mm4];
addElasticSection	$topRoof15;
add2DElasticSectionProperties $topRoof15 $E_TRoof  $A_TRoof $Iz_TRoof;

################ FIXITY ################
###BOTTOM 
uniaxialMaterial Elastic $SpringBottom [expr 1016*$kN*$m];

