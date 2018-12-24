#################################################################
####################### x_column_NL_TIMO ########################
#################################################################
#	LINK x_column, GIVEN Vy, Vult			  				    # 
#	link: Two Node Link Element					     			#
#	fixity: fixed											    #


proc_ref	x_column_NL_TIMO	{ Region_ID   *masses *heights  x0  h0 *columns *beams *bracings  *Vy  *Vult Es G  {big_x 0} {who_fails "diagonal"} {e_ult 0.1} {hardening 0.05} {Node_ID 1000} {Ele_ID 1000} {mat_ID 1000} } {


###################################################################################################
#          INITIAL CALCULATIONS													  
###################################################################################################
	
AddRegion $Region_ID;

set N_box [expr [llength $heights]-1]

#############################################
#         Initial Checks					#


	
	for {set i 1} { $i < [llength $heights]} {incr i} {
		if { [lindex $heights $i]<= [lindex $heights [expr $i-1] ] } {
			error_clean "ERROR: In region $Region_ID, heights in arbitrary columns must be sorted. [lindex $heights $i]<= [lindex $heights [expr $i-1] ]"; 
		}
	}
	

	if {[llength $masses] == 0 || [llength $heights] == 0 } {
		error_clean "ERROR: In region $Region_ID. List masses and heights must have at least one element";
	}
	

	if { ([llength $masses] ne 1) && ([llength $masses] ne [llength $heights]) } {
		error_clean "ERROR: In region $Region_ID. Length(masses) must be equal to Length(heigths).\nYou gave Length(masses) = [llength $masses] and Length(heights) = [llength $heights]";
	}
	
	if {[llength $masses] == 1} {
		set tmpMass [lindex $masses 0];
		for {set i 1} {$i < [llength $heights]} {incr i} {
			lappend masses $tmpMass;
		}
	}
	
	
	if {[llength $columns] ne [expr [llength $heights] - 1] } {
		error_clean "ERROR: In region $Region_ID. Length(heigths)-1 must be equal to Length(columns).\nYou gave Length(columns) = [llength $columns] and Length(heights) = [llength $heights]";
	}
	
	if {[llength $beams] ne [expr [llength $heights] - 1] } {
		error_clean "ERROR: In region $Region_ID. Length(heigths)-1 must be equal to Length(beams).\nYou gave Length(beams) = [llength $beams] and Length(heights) = [llength $heights]";
	}
	
	if {[llength $bracings] ne [expr [llength $heights] - 1] } {
		error_clean "ERROR: In region $Region_ID. Length(heigths)-1 must be equal to Length(bracings).\nYou gave Length(bracings) = [llength $bracings] and Length(heights) = [llength $heights]";
	}
	
	
	set Negligible 1e-9;	
	

	
###################################################################################################
#          NODE GENERATION													  
###################################################################################################

#	node numbering: A(000000)ij. A=Region_ID and ij is the number of the node. 
#	example:	523 = Node 23 in region 5. If Node_ID=1000 then 5023. 


#
#		1005|	1006|
#		1001|	1004|
#		1001|	1002|
#
	set current_node	1;
	
	set RegionNode_ID [expr $Region_ID*$Node_ID]; 	
	
	for {set i 0} {$i <= $N_box} {incr i} {

		set H_temp		[lindex $heights $i ];
		
		if {$big_x == 0} {
			set mass_temp	[expr 2.0*[lindex $masses $i]];
		} else {
			set mass_temp	[expr 4.0*[lindex $masses $i]];
		}
			
		if { [lindex $masses $i] > 0 } {
		
			node	[expr $RegionNode_ID+$current_node]		$x0		$H_temp 	-mass $mass_temp $Negligible $Negligible;
			
			write_node_with_mass [expr $RegionNode_ID+$current_node] $mass_temp $Negligible $Negligible;

		} else {
			node	[expr $RegionNode_ID+$current_node]		$x0	$H_temp;	
		}
		incr current_node;
		
		
	}
	
	

###################################################################################################
#          SET UP PROPERTIES												  
###################################################################################################

	
	
	set dh {}
	for {set i 1} {$i<[llength $heights]} {incr i} {
		lappend dh [expr [lindex $heights $i] - [lindex $heights [expr $i-1]]];
	}

	set diagonals {}
	foreach a $dh {
		lappend diagonals [expr pow([expr $h0*$h0+$a*$a],0.5)]
	}
	
	
########## CALCULATE AREA SECTION ##########

	set Areal {}

	
	for {set i 0} {$i<[llength $dh]} {incr i} {
		set sectionTag [lindex $columns $i]
		set A_col [getElasticA $sectionTag]
		
		if {$big_x == 0 } {
			lappend Areal [expr $A_col*2.0]
		} else {
			lappend Areal [expr $A_col*3.0]
		}
		
	}
	
########## CALCULATE MOMENT OF INERTIA ##########

	set Inertia {}

	for {set i 0} {$i<[llength $dh]} {incr i} {
		set sectionTag [lindex $columns $i]
		set A_col [getElasticA $sectionTag]
		
		
		if {$big_x == 0 } {
			lappend Inertia [expr $A_col*$h0*$h0/2.0]
		} else {
			lappend Inertia [expr $A_col*(2.0*$h0)*(2*$h0)/2.0]
		}
		
	}
	
	
	

########## CALCULATE Aeff ##########



 ######### LINEAR Aeff #########
set Aeff {}

for {set i 0} {$i<[llength $dh]} {incr i} {
	set sectionTag [lindex $bracings $i]
	set A_d [getElasticA $sectionTag]
	set a [lindex $dh $i]
	set d [lindex $diagonals $i]
	
	
	lappend Aeff [expr 2.0*$a*$Es*$A_d*$h0*$h0/($d*$d*$d)/$G]
}
 ###############################


  ######### Aeff_y : AFTER DIAGONAL BUCKLING #########
set Aeff_y {}

for {set i 0} {$i<[llength $dh]} {incr i} {
	set sectionDiag [lindex $bracings $i]
	set A_d [getElasticA $sectionDiag]
	
	set sectionVer [lindex $beams $i]
	set A_v [getElasticA $sectionVer]
	
	set a [lindex $dh $i]
	set d [lindex $diagonals $i]
	
	
	lappend Aeff_y [expr $Es*$A_d*($h0*$h0/$d/$d)*($a/$d)/(1.0+$h0*$h0*$h0/$d/$d/$d*$A_d/$A_v)/$G]
	
}
	
 ######### Aeff_y : AFTER DIAGONAL BUCKLING #########
set Aeff_ult {}

for {set i 0} {$i<[llength $dh]} {incr i} {
	set sectionDiag [lindex $bracings $i]
	set A_d [getElasticA $sectionDiag]
	
	set sectionVer [lindex $beams $i]
	set A_v [getElasticA $sectionVer]
	
	set a [lindex $dh $i]
	set d [lindex $diagonals $i]
	
	
	lappend Aeff_ult [expr    $Es * ($hardening*$A_d) * ($h0*$h0/$d/$d)*($a/$d)/(1.0+$h0*$h0*$h0/$d/$d/$d*($hardening*$A_d)/$A_v)/$G]
	
}


########## CALCULATE phi ##########

set phi {}

for {set i 0} {$i<[llength $dh]} {incr i} {
	
	lappend phi	[expr 12*$Es*[lindex $Inertia $i]/($G*[lindex $Aeff $i]*[lindex $dh $i]*[lindex $dh $i])]

}


set phi_y {}

for {set i 0} {$i<[llength $dh]} {incr i} {
	
	lappend phi_y	[expr 12*$Es*[lindex $Inertia $i]/($G*[lindex $Aeff_y $i]*[lindex $dh $i]*[lindex $dh $i])]

}


set phi_ult {}

for {set i 0} {$i<[llength $dh]} {incr i} {
	
	lappend phi_ult	[expr 12*$Es*[lindex $Inertia $i]/($G*[lindex $Aeff_ult $i]*[lindex $dh $i]*[lindex $dh $i])]

}



########## CALCULATE kappa ##########

set kappa {}

for {set i 0} {$i<[llength $dh]} {incr i} {
	
	lappend kappa	[expr 12*$Es*[lindex $Inertia $i]/( (1+[lindex $phi $i]) *[lindex $dh $i]*[lindex $dh $i]*[lindex $dh $i])]

}

set kappa_y {}

for {set i 0} {$i<[llength $dh]} {incr i} {
	
	lappend kappa_y	[expr 12*$Es*[lindex $Inertia $i]/( (1+[lindex $phi_y $i]) *[lindex $dh $i]*[lindex $dh $i]*[lindex $dh $i])]

}

set kappa_res {}
for {set i 0} {$i<[llength $dh]} {incr i} {

	
	lappend kappa_res	[expr 12*$Es*[lindex $Inertia $i]/( (1+[lindex $phi_ult $i]) *[lindex $dh $i]*[lindex $dh $i]*[lindex $dh $i])]

}



########## CALCULATE crot ##########

set crot {}

for {set i 0} {$i<[llength $dh]} {incr i} {
	
	lappend crot [expr $Es*[lindex $Inertia $i]/[lindex $dh $i]]
	
}

########## SETTING MATERIALS ##########

set matTag [expr $mat_ID*$Region_ID+1]

set linkMats {}

for {set i 0} {$i<[llength $dh]} {incr i} {
	
	#####################
	#### direction 1 ####
	#####################
	
	uniaxialMaterial Elastic $matTag [expr $Es*[lindex $Areal $i]/[lindex $dh $i]]
	sub_lappend_mod linkMats $i $matTag
	incr matTag
	#####################
	
	
	#####################
	#### direction 2 ####
	#####################
	
	set Fy [lindex $Vy $i]
	set Fult [expr [lindex $Vult $i]*1.0]
	

	set dy [expr $Fy/[lindex $kappa $i]]
	set dult [expr ($Fult-$Fy)/[lindex $kappa_y $i]+$dy]
	
	
	set dres [expr $e_ult*[lindex $diagonals $i]*[lindex $diagonals $i]/$h0]

	set Fres [expr $Fult+[lindex $kappa_res $i] *($dres-$dult)]

	
	set dfinito [expr $dres*1.1]
	set Ffinito [expr 0.01*$Fres]



	if 1 {
		
		uniaxialMaterial Pinching4 $matTag \
		     $Fy $dy $Fult $dult $Fres $dres $Ffinito $dfinito\
			 [expr -$Fy] [expr -$dy] [expr -$Fult] [expr -$dult] [expr -$Fres]  [expr -$dres] [expr -$Ffinito] [expr -$dfinito]\
					0.3 0.6 0.0 \
		            0.3 0.6 0.0 \
					0.0 0.0 0.0 0.0 0.0 \
		            0.0 0.0 0.0 0.0 0.0 \
					0. 0. 0. 0. 0. \
		10. "energy"  
	
	}			

	sub_lappend_mod linkMats $i $matTag
	incr matTag
	#####################
	
	
	#####################
	#### direction 3 ####
	#####################
	
	uniaxialMaterial Elastic $matTag [lindex $crot $i]
	sub_lappend_mod linkMats $i $matTag
	incr matTag
	#####################
		
}



	

###################################################################################################
#          ELEMENT GENERATION													  
###################################################################################################

#	element numbering: RTijk. R=Region_ID,	T=type and ijk the number of the element. By default T=1 column, 2 bracing, 3 beam bracing.
#	example:	52090 = Bracing 90 in region 5. 
	set Reg_Ele_ID	[expr $Ele_ID*10*$Region_ID];
	set COL 1;


#############################################
#         Generate Columns					#
	set current_ele		[expr $Reg_Ele_ID+$COL*$Ele_ID];
	set increment 1;
	
	set node_i	[expr $RegionNode_ID+1]; 
	
	for {set i 0} {$i<[llength $dh]} {incr i} {

		set mat1 [lindex [lindex $linkMats $i] 0]
		set mat2 [lindex [lindex $linkMats $i] 1]
		set mat3 [lindex [lindex $linkMats $i] 2]
		
		set node_j [expr $node_i+$increment];
		
		incr current_ele 

		
		if 0 {
			set perc [expr -0.1]
		}
		
		if 1 {
			set perc [expr 0]
		}
		
		if 0 {
			set phi_tmp [lindex $phi_res $i]
			set perc [expr -0.1/([lindex $phi_tmp $i]*[lindex $phi_tmp $i])]
		
		}
		
		
		element twoNodeLink $current_ele $node_i  $node_j -mat $mat1 $mat2 $mat3 -dir 1 2 3 -pDelta $perc $perc

		write_element $current_ele $node_i $node_j;
		
		set node_i $node_j;
		
	}
	
	
	
	addElements "Columns"	[expr $Reg_Ele_ID+$COL*$Ele_ID+1]	[expr $current_ele];
	


	
###################################################################################################
#               ADD NODES												  
###################################################################################################

addNodes [expr $Region_ID*$Node_ID+1]	[expr $RegionNode_ID+$current_node-1];
	
###################################################################################################
#               APPLY FIXITY												  
###################################################################################################
	fix [expr $Region_ID*$Node_ID+1] 1 1 1;



	


CloseRegion;



}













