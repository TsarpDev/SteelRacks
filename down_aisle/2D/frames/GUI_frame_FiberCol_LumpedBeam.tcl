#################################################################
#################### GUI_frame_FiberCol_LumpedBeam ##############
#################################################################
#	GUI Arbitrary frame 					  				    # 
#	columns: NL FIBER							     			#
#	beams: LUMPED									    		#
#															    #
#	fixity: fixed											    #



proc_ref	GUI_frame_FiberCol_LumpedBeam	{ Region_ID   *masses *Ypoints  *Xpoints x0 z0 *frame colOffset beamOffset rigidSection    {Node_ID 100} {Ele_ID 1000}  {InternalNode_ID 100  } {InternalEle_ID 100  } {nIntPt 3} {maxIters 20} {tolIter 1.e-8} } {


###################################################################################################
#          INITIAL CALCULATIONS													  
###################################################################################################

upvar #0 PDeltaTransf_COL Pd_col;
upvar #0 LinearTransf_FRAME Ln_beam;
upvar #0 LinearTransf_COL Ln_col;



AddRegion $Region_ID;


set Ycanvas [llength $Ypoints];	

set Xcanvas [llength $Xpoints];

set floors [expr $Ycanvas-1]
set bays [expr $Xcanvas-1]

set triggers ""
for {set i 0} {$i<$Ycanvas} {incr i} {
	for {set j 0} {$j<$Xcanvas} {incr j} {
		lappend triggers 0;
	}
}

set node_tags ""
for {set i 0} {$i<$Ycanvas} {incr i} {
	for {set j 0} {$j<$Xcanvas} {incr j} {
		lappend node_tags 0;
	}
}

#############################################
#         Initial Checks					#
	
	if { [expr $Ycanvas*$Xcanvas] >=$Node_ID } {
		error_clean "ERROR: Number of nodes at region $Region_ID is $Node_ID or greater.\nPlease modify function x_column. Suggested node numbering: x1000"; 
	}
	
	if { $Region_ID >=$InternalNode_ID } {
		error_clean "ERROR: Number of internal nodes at region $Region_ID must be $Region_ID or greater.\nPlease modify function x_column. Suggested node numbering: x1000"; 
	}
	
	for {set i 1} { $i < $Ycanvas} {incr i} {
		if { [lindex $Ypoints $i]<= [lindex $Ypoints [expr $i-1] ] } {
			error_clean "ERROR: In region $Region_ID, Ypoints in arbitrary columns must be sorted. [lindex $Ypoints $i]<= [lindex $Ypoints [expr $i-1] ]"; 
		}
	}
	

	if {[llength $masses] ne [expr $Ycanvas*$Xcanvas]  } {
		error_clean "ERROR: In region $Region_ID. Invalid length of masses list.";
	}
	
	
	set Negligible 1e-9;	
	
	set sectionTag $rigidSection
	set A_rigid [getElasticA $sectionTag]
	set G_rigid [getElasticG $sectionTag]
	set E_rigid [getElasticE $sectionTag]
	set Iy_rigid [getElasticIy $sectionTag]
	set Iz_rigid [getElasticIz $sectionTag]
	set J_rigid [getElasticJ $sectionTag]
	
###################################################################################################
#          NODE GENERATION													  
###################################################################################################

#############################################
#        Calculate Triggers					#

for {set i 1} {$i<=$floors} {incr i} {
	
	for {set j 1} {$j<=[expr $bays+1]} {incr j} {
	
		set col_index [expr ($Ycanvas-1-$i)*(2*$Xcanvas-1)+$Xcanvas+$j-2]
		
		 
		if {[lindex $frame $col_index] > 0} {
			set node_i [expr ($Ycanvas-$i)*$Xcanvas+$j-1]
			set node_j [expr ($Ycanvas-$i-1)*$Xcanvas+$j-1]
			
			lset triggers $node_i  [expr [lindex $triggers $node_i]+1]
			lset triggers $node_j  [expr [lindex $triggers $node_j]+1]
		}
		
		if {$j ne [expr $bays+1]} {
			set beam_index [expr ($Ycanvas-1-$i)*(2*$Xcanvas-1)+$j-1]
			
			if {[lindex $frame $beam_index]	ne {00 00 00}} {

				set node_i [expr ($Ycanvas-$i-1)*$Xcanvas+$j-1]
				set node_j [expr ($Ycanvas-$i-1)*$Xcanvas+$j]
				
			lset triggers $node_i  [expr [lindex $triggers $node_i]+1]
			lset triggers $node_j  [expr [lindex $triggers $node_j]+1]
			}
		}
		
	}
}

if 0 {
	puts "\nTriggers have been set. Now printing:\n"
	for {set i 0} {$i<$Ycanvas} {incr i} {
		
		for {set j 0} {$j<$Xcanvas} {incr j} {
			set pos [expr $i*$Xcanvas+$j]
			puts -nonewline "[lindex $triggers $pos]\t"
		}
		puts "\n"
	}
	puts "================================="
}

#############################################
#        Node Generation					#
	
	set RegionNode_ID [expr $Region_ID*$Node_ID]; 	

	
	set current_node [expr $RegionNode_ID+1]
	
	for {set i [expr $Ycanvas-1]} {$i>=0} {set i [expr $i-1]} {
		for {set j 0} {$j<$Xcanvas} {incr j} {
			
			set pos [expr $i*$Xcanvas+$j]
			
		
			if {[lindex $triggers $pos]>0} {
			
				lset node_tags $pos $current_node
				
				set mass_temp	[lindex $masses $pos];
				set X_temp [expr $x0+[lindex $Xpoints $j]]
				set Y_temp [lindex $Ypoints [expr $Ycanvas-1-$i]]
				
				if { $mass_temp > 0 } {
					node	$current_node	$X_temp	  $Y_temp		$z0		\
							-mass $mass_temp $Negligible $mass_temp $Negligible $Negligible $Negligible;
																	
					write_node_with_mass $current_node \
							$mass_temp $Negligible $mass_temp $Negligible $Negligible $Negligible;
				} else {
					node	$current_node	$X_temp	  $Y_temp		$z0;	
				}

				incr current_node
			} else {
				lset node_tags $pos 0
			}
			
		}
	}

if 0 {
puts "\nNodes have been set. Now printing:\n"
for {set i 0} {$i<$Ycanvas} {incr i} {
	
	for {set j 0} {$j<$Xcanvas} {incr j} {
		set pos [expr $i*$Xcanvas+$j]
		puts -nonewline "[lindex $node_tags $pos]\t"
	}
	puts "\n"
}
puts "================================="
}

	
###################################################################################################
#               ADD NODES												  
###################################################################################################

	write_region_nodes $Region_ID $Xcanvas $Ycanvas node_tags
	addNodes [expr $RegionNode_ID+1]	[expr $current_node-1];
	addExternalNodes [expr $RegionNode_ID+1]	[expr $current_node-1];


###################################################################################################
#          ELEMENT GENERATION													  
###################################################################################################

#	element numbering: RTijk. R=Region_ID,	T=type and ijk the number of the element. By default T=1 column,  2 beam.
#	example:	52090 = Beam 90 in region 5. 
	set Reg_Ele_ID	[expr $Ele_ID*10*$Region_ID];
	set COL 1;
	set BEAM 2;
	

#############################################
#         Generate Columns					#
	
	set current_ele		[expr $Reg_Ele_ID+$COL*$Ele_ID];


	########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg		
	#	4	3	2
	#	5		1
	#	6	7	8
	
	for {set i 1} {$i<=$floors} {incr i} {
	
		for {set j 1} {$j<=[expr $bays+1]} {incr j} {
		
			set col_index [expr ($Ycanvas-1-$i)*(2*$Xcanvas-1)+$Xcanvas+$j-2]
			
			set node_i [lindex $node_tags [expr ($Ycanvas-$i)*$Xcanvas+$j-1]]
			set node_j [lindex $node_tags [expr ($Ycanvas-$i-1)*$Xcanvas+$j-1]]
			
			if {[lindex $frame $col_index]>0} {
			
				##############################
				###### TOP RIGID NODE ########
				set internal_nodeJ [expr $node_j*$InternalNode_ID+7];
				set x_j [expr [nodeCoord $node_j 1]];
				set y_j [expr [nodeCoord $node_j 2]-$colOffset];			
				node	[expr $internal_nodeJ]		$x_j	$y_j $z0
				##############################

				##################################
				########## FIBER COLUMN ##########
				incr current_ele;
				
				scan [lindex $frame $col_index] %d sectionTag
				set sectionTag

				element nonlinearBeamColumn   $current_ele  	$node_i    $internal_nodeJ $nIntPt  $sectionTag  $Pd_col \
												-iter $maxIters $tolIter
				write_element $current_ele $node_i $internal_nodeJ;
				##################################
				
				##################################
				####### TOP RIGID ELEMENT ########
				incr current_ele;
				element elasticBeamColumn	$current_ele  	$internal_nodeJ  $node_j  $A_rigid $E_rigid $G_rigid \
																					  $J_rigid $Iy_rigid $Iz_rigid \
																					  $Pd_col;
										
				write_element $current_ele $internal_nodeJ $node_j;
				##################################

			}
		}
	}

	addElements "Columns"	[expr $Reg_Ele_ID+$COL*$Ele_ID+1]	[expr $current_ele];


#############################################
#         Generate Beam 	                #


	set current_ele		[expr $Reg_Ele_ID+$BEAM*$Ele_ID];

	
	for {set i 1} {$i<=$floors} {incr i} {
	
		for {set j 1} {$j<=$bays} {incr j} {
		
			set beam_index [expr ($Ycanvas-1-$i)*(2*$Xcanvas-1)+$j-1]
			
			set node_i [lindex $node_tags [expr ($Ycanvas-$i-1)*$Xcanvas+$j-1]]
			set node_j [lindex $node_tags [expr ($Ycanvas-$i-1)*$Xcanvas+$j]]
			
			if {[lindex $frame $beam_index] ne {00 00 00}} {
					
				scan [lindex [lindex $frame $beam_index] 1] %d sectionTag
				set sectionTag
				
				scan [lindex [lindex $frame $beam_index] 0] %d springID_left
				set springID_left
				
				scan [lindex [lindex $frame $beam_index] 2] %d springID_right
				set springID_right
				
				set A_beam [getElasticA $sectionTag]
				set E_beam [getElasticE $sectionTag]
				set G_beam [getElasticG $sectionTag]
				set Iy_beam [getElasticIy $sectionTag]
				set Iz_beam [getElasticIz $sectionTag]
				set J_beam [getElasticJ $sectionTag]

				
				########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg		
				#	4	3	2
				#	5		1
				#	6	7	8
				

				
				###############################
				####### LEFT RIGID NODE #######
				set rigid_nodeI [expr $node_i*$InternalNode_ID+1];
				set xR_i [expr [nodeCoord $node_i 1]+$beamOffset];
				set yR_i [expr [nodeCoord $node_i 2]];
									
				node	[expr $rigid_nodeI]		$xR_i	$yR_i	$z0
				###############################
				###############################
				##### LEFT INTERNAL NODE ######
				set internal_nodeI [expr $rigid_nodeI*$InternalNode_ID+1];
				set x_i [expr [nodeCoord $rigid_nodeI 1]];
				set y_i [expr [nodeCoord $rigid_nodeI 2]];
									
				node	[expr $internal_nodeI]		$x_i	$y_i	$z0
				###############################
				
				
				###############################
				####### RIGHT RIGID NODE ######
				set rigid_nodeJ [expr $node_j*$InternalNode_ID+5];
				set xR_j [expr [nodeCoord $node_j 1]-$beamOffset];
				set yR_j [expr [nodeCoord $node_j 2]];
									
				node	[expr $rigid_nodeJ]		$xR_j	$yR_j	$z0

				###############################
				###############################
				##### RIGHT INTERNAL NODE #####
				set internal_nodeJ [expr $rigid_nodeJ*$InternalNode_ID+5];
				set x_j [expr [nodeCoord $rigid_nodeJ 1]];
				set y_j [expr [nodeCoord $rigid_nodeJ 2]];
									
				node	[expr $internal_nodeJ]		$x_j	$y_j	$z0
				###############################
				
				##################################
				###### LEFT RIGID ELEMENT ######
				incr current_ele;
				element elasticBeamColumn	$current_ele  	$node_i  $rigid_nodeI  $A_rigid $E_rigid $G_rigid \
																					  $J_rigid $Iy_rigid $Iz_rigid \
																					  $Ln_beam;
				write_element $current_ele $node_i $rigid_nodeI;
				##################################
				
				##################################
				######## ELASTIC ELEMENT #########
				incr current_ele;
				element elasticBeamColumn	$current_ele  	$internal_nodeI  $internal_nodeJ  $A_beam $E_beam $G_beam \
																							  $J_beam $Iy_beam $Iz_beam \
																							  $Ln_beam;
																							  

				write_element $current_ele $internal_nodeI $internal_nodeJ;
				##################################

				##################################
				###### LEFT RIGID ELEMENT ######
				incr current_ele;
				element elasticBeamColumn	$current_ele  	$rigid_nodeJ  $node_j  $A_rigid $E_rigid $G_rigid \
																					  $J_rigid $Iy_rigid $Iz_rigid \
																					  $Ln_beam;
				write_element $current_ele $rigid_nodeJ $node_j;
				##################################
				
				
				
				
				element zeroLength [expr $current_ele*$InternalEle_ID] $rigid_nodeI $internal_nodeI -mat $springID_left -dir 6
				equalDOF $rigid_nodeI $internal_nodeI 1 2 3 4 5
				
				set x1_local -1
				set x2_local 0
				set x3_local 0
				set y1_local 0
				set y2_local 1
				set y3_local 0
			
				element zeroLength [expr $current_ele*$InternalEle_ID+1] $rigid_nodeJ $internal_nodeJ \
											-mat $springID_right -dir 6 -orient $x1_local $x2_local $x3_local \
																			  $y1_local $y2_local $y3_local
				equalDOF $rigid_nodeJ $internal_nodeJ 1 2 3 4 5
			}
		}
	}
	#set Tot_beam	$current_ele;
	addElements "Beams"	[expr $Reg_Ele_ID+$BEAM*$Ele_ID+1]	[expr $current_ele];
	



###################################################################################################
#               APPLY FIXITY												  
###################################################################################################

	for {set j 0} {	$j< $Xcanvas} {incr j} {
		set pos [expr ($Ycanvas-1)*$Xcanvas+$j]
		if {[lindex $node_tags $pos]>0} {
			#puts "applying pins in node [lindex $node_tags $pos]";
			fix [lindex $node_tags $pos] 1 1 1 1 1 1;
		}
	}




CloseRegion;



}













