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
	
## beams	(YOURS)
	set SecBeam8 6;			# normal beam					(YOURS)
	set SecBeamHEA 7;		# bracing normal beam			(YOURS)

## bracing diagonals	(YOURS)
	set BracDiagL60x40x6 8; # lower bracing diagonal		(YOURS) (SEC)
	set BracDiag13	9;		# upper bracing diagonal 		(YOURS) (SEC)

## Legamenti
	set Legamenti 10;		#								(YOURS)

	
########################## SPRINGS  ##########################	
	set SpringBeam8 1;		#								(MAT)
	set SpringBeamHEA 2;	#								(MAT)
	set SpringBottom 3;		#								(MAT)
	
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
set AxialMultiplier 1.5;
set Nr1		[expr $AxialMultiplier*518*$kN];			# this is for 1650 mm (EXPR)
set Nr2		[expr $AxialMultiplier*247*$kN];			# this is for 1650 mm (ABQS)
set Nr3		[expr $AxialMultiplier*316.472*$kN];		# this is for 1650 mm (ABQS)
set Nr4		[expr $AxialMultiplier*155.51*$kN];		# this is for 1650 mm (EXPR)


###################################################################################################
#          Define Sections
###################################################################################################

################ COLUMNS ################
set E_column1 [expr 210.0*$GPa];
set A_column1 [expr 1720.0*$mm2];
set Iz_column1 [expr 3930538.0*$mm4];	

set flexibilityMultiplier 2.0;
addElasticSection $SecCol1
add2DElasticSectionProperties $SecCol1 $E_column1  $A_column1 $Iz_column1;
incr currentAxialMat		
#uniaxialMaterial ElasticPP $currentAxialMat [expr $flexibilityMultiplier*$E_column1*$A_column1]	[expr $Nr1/($flexibilityMultiplier*$E_column1*$A_column1)];
uniaxialMaterial MultiLinear $currentAxialMat [expr $Nr1/($flexibilityMultiplier*$E_column1*$A_column1)] $Nr1\
											[expr 3.0*$Nr1/($flexibilityMultiplier*$E_column1*$A_column1)] [expr 0.1*$Nr1]\
											[expr 4.0*$Nr1/($flexibilityMultiplier*$E_column1*$A_column1)] [expr 0.1*$Nr1];
incr currentSection
section Elastic $currentSection $E_column1  [expr $flexibilityMultiplier*$A_column1] $Iz_column1;

section Aggregator $SecCol1 $currentAxialMat P  -section $currentSection


set E_column1a [expr 210.0*$GPa];
set A_column1a [expr 3443.0*$mm2];
set Iz_column1a [expr 9032635.0*$mm4];	
addElasticSection $SecCol1a
add2DElasticSectionProperties $SecCol1a $E_column1a  $A_column1a $Iz_column1a;
section Elastic $SecCol1a $E_column1a  $A_column1a $Iz_column1a;


set E_column2 [expr 210.0*$GPa];
set A_column2 [expr 1070.0*$mm2];
set Iz_column2 [expr 2488602.0*$mm4];	
addElasticSection $SecCol2
add2DElasticSectionProperties $SecCol2 $E_column2  $A_column2 $Iz_column2;
incr currentAxialMat
#uniaxialMaterial ElasticPP $currentAxialMat [expr $flexibilityMultiplier*$E_column2*$A_column2]	[expr $Nr2/($flexibilityMultiplier*$E_column2*$A_column2)];
uniaxialMaterial MultiLinear $currentAxialMat [expr $Nr2/($flexibilityMultiplier*$E_column2*$A_column2)] $Nr2\
											[expr 3.0*$Nr2/($flexibilityMultiplier*$E_column2*$A_column2)] [expr 0.1*$Nr2]\
											[expr 4.0*$Nr2/($flexibilityMultiplier*$E_column2*$A_column2)] [expr 0.1*$Nr2];
											
incr currentSection
section Elastic $currentSection $E_column2  [expr $flexibilityMultiplier*$A_column2] $Iz_column2;
section Aggregator $SecCol2 $currentAxialMat P  -section $currentSection


set E_column3 [expr 210.0*$GPa];
set A_column3 [expr 1290.0*$mm2];
set Iz_column3 [expr 2982693.0*$mm4];	
addElasticSection $SecCol3
add2DElasticSectionProperties $SecCol3 $E_column3  $A_column3 $Iz_column3;
incr currentAxialMat
uniaxialMaterial MultiLinear $currentAxialMat [expr $Nr3/($flexibilityMultiplier*$E_column3*$A_column3)] $Nr3\
											[expr 3.0*$Nr3/($flexibilityMultiplier*$E_column3*$A_column3)] [expr 0.1*$Nr3]\
											[expr 4.0*$Nr3/($flexibilityMultiplier*$E_column3*$A_column3)] [expr 0.1*$Nr3];
#uniaxialMaterial ElasticPP $currentAxialMat [expr $flexibilityMultiplier*$E_column3*$A_column3]	[expr $Nr3/($flexibilityMultiplier*$E_column3*$A_column3)];

incr currentSection
section Elastic $currentSection $E_column3  [expr $flexibilityMultiplier*$A_column3] $Iz_column3;
section Aggregator $SecCol3 $currentAxialMat P  -section $currentSection


set E_column4 [expr 210.0*$GPa];
set A_column4 [expr 860.0*$mm2];
set Iz_column4 [expr 2011487.0*$mm4];	
addElasticSection $SecCol4
add2DElasticSectionProperties $SecCol4 $E_column4  $A_column4 $Iz_column4;
incr currentAxialMat
uniaxialMaterial MultiLinear $currentAxialMat [expr $Nr4/($flexibilityMultiplier*$E_column4*$A_column4)] $Nr4\
											[expr 3.0*$Nr4/($flexibilityMultiplier*$E_column4*$A_column4)] [expr 0.1*$Nr4]\
											[expr 4.0*$Nr4/($flexibilityMultiplier*$E_column4*$A_column4)] [expr 0.1*$Nr4];
#uniaxialMaterial ElasticPP $currentAxialMat [expr $flexibilityMultiplier*$E_column4*$A_column4]	[expr $Nr4/($flexibilityMultiplier*$E_column4*$A_column4)];

incr currentSection
section Elastic $currentSection $E_column4  [expr $flexibilityMultiplier*$A_column4] $Iz_column4;
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

################ FIXITY ################
###BOTTOM 
uniaxialMaterial Elastic $SpringBottom [expr 1016*$kN*$m];




