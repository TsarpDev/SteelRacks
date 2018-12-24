#################################################################
#################### rackBracing2D ##################
#################################################################
#	Elastic rack bracings			   						    # 
#	bracings: elastic									    	#
#															    #
#	fixity: pinned											    #


proc_ref	rackBracing2D	{ Region_ID  frame_ID  *brYpoints *brXpoints *bracings *Orientation  {imp 0} {Node_ID 100} {Ele_ID 1000}  {InternalNode_ID 100  } {InternalEle_ID 100  } } {

	kill_if_3D "ERROR: rackBracing2D is only for 2D analysis. Change analysis type.";
	
###################################################################################################
#          INITIAL CALCULATIONS													  
###################################################################################################

	upvar #0 PDeltaTransf_COL Pd_col;
	upvar #0 LinearTransf_FRAME Ln_beam;
	upvar #0 CorotTransf Crt_br;
	
	AddRegion $Region_ID;

	set Negligible 1e-9;	
	
	set Ycanvas [llength $brYpoints]
	set Xcanvas [llength $brXpoints]
	
	set floors [expr $Ycanvas-1]
	set bays   [expr $Xcanvas-1]

#############################################
#         Initial Checks					#

	
	if {[expr ($Ycanvas-1)*($Xcanvas-1)] ne [llength $bracings]} {
		error_clean "ERROR. Must be (Ycanvas-1)*(Xcanvas-1) == llength(bracings)!"
	}

	set MasterNodes ""
	set StartingNodes ""
	
	for {set i 0} {$i<$Ycanvas} {incr i} {
		for {set j 0} {$j<$Xcanvas} {incr j} {
			lappend MasterNodes 00
			lappend StartingNodes 00
		}
	}
	
	for {set i [expr $Ycanvas-1]} {$i>=0} {set i [expr $i-1]} {
	
		for {set j 0} {$j<$Xcanvas} {incr j} {
		
			set Xcoord [lindex $brXpoints $j]
			set Ycoord [lindex $brYpoints [expr $Ycanvas-1-$i]]
			
			set pos [expr $i*$Xcanvas+$j]
			
			if {[getXY_Node $frame_ID $Xcoord $Ycoord]} {
				lset MasterNodes $pos [getXY_Node $frame_ID $Xcoord $Ycoord]		
			}
		}
	}

	
	if 0 {
		puts "Printing MasterNodes:"
		for {set i 0} {$i<$Ycanvas} {incr i} {
		
			for {set j 0} {$j<$Xcanvas} {incr j} {
				set pos [expr $i*$Xcanvas+$j]
				puts -nonewline "[lindex $MasterNodes $pos]\t"
			}
			puts "\n"
		}
		puts "========================\n"

	}
	

	

###################################################################################################
#          ELEMENT GENERATION													  
###################################################################################################

#	element numbering: RTijk. R=Region_ID,	T=type and ijk the number of the element. By default T=1 column,  2 beam.
#	example:	52090 = Beam 90 in region 5. 
	set Reg_Ele_ID	[expr $Ele_ID*10*$Region_ID];
	set BRACING 1;
	set RegionInternalNode_ID [expr $Region_ID*$InternalNode_ID]; 

	set RegionNode_ID [expr $Region_ID*$Node_ID]; 	
	set current_node [expr $RegionNode_ID]	

#############################################
#         Generate Bracing 	                #

	set RegionBracingElement_ID	[expr $Reg_Ele_ID+$BRACING*$Ele_ID];
	
	set current_bracing [expr $RegionBracingElement_ID]
	
	for {set i [expr $floors-1]} {$i>=0} {set i [expr $i-1]} {
	
		for {set j 0} {$j < $bays} {incr j} {
		
			set position [expr $i*$bays+$j];

			##################################
			########## ELASTIC BRACING ##########
			if {[lindex $bracings $position] ne 00} {
				
				if { ([lindex $Orientation $position] ne "l") && ([lindex $Orientation $position] ne "r")} {
					error_clean "ERROR: Orientation must be l (left) or r (right). You gave: [lindex $Orientation $position]"
				}
				
				scan [lindex $bracings $position] %d sectionTag
				set sectionTag 
				set A_br [get2DElasticA $sectionTag]
				set E_br [get2DElasticE $sectionTag]
				set Iz_br [get2DElasticIz $sectionTag]
				
				if { [lindex $Orientation $position] == "r"} {

					########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg		
					#	4	3	2
					#	5		1
					#	6	7	8
					
					set node_i	[lindex $MasterNodes [expr ($i+1)*$Xcanvas+($j)]]
					
					set node_j  [lindex $MasterNodes [expr ($i)*$Xcanvas+($j+1)]]
					
					###############################
					###############################
					##### LEFT INTERNAL NODE ######
					set internal_nodeI [expr $node_i*$RegionInternalNode_ID+2];
					set x_i [expr [nodeCoord $node_i 1]];
					set y_i [expr [nodeCoord $node_i 2]];
										
					node	[expr $internal_nodeI]		$x_i	$y_i
					###############################
					
					###############################
					###############################
					##### RIGHT INTERNAL NODE #####
					set internal_nodeJ [expr $node_j*$RegionInternalNode_ID+6];
					set x_j [expr [nodeCoord $node_j 1]];
					set y_j [expr [nodeCoord $node_j 2]];
										
					node	[expr $internal_nodeJ]		$x_j	$y_j
					###############################
					
					if {$imp == 0 } {
						##################################
						######## ELASTIC ELEMENT #########
						incr current_bracing;
						element elasticBeamColumn $current_bracing $internal_nodeI $internal_nodeJ $A_br $E_br $Iz_br $Crt_br;
						write_element $current_bracing $internal_nodeI $internal_nodeJ;
						###############################
						
						equalDOF $node_i $internal_nodeI 1 2
						equalDOF $node_j $internal_nodeJ 1 2 
					} else {
					
						incr current_node;
						set imp_nod [generate2DImperfectionPointID $current_node $internal_nodeI $internal_nodeJ $imp];

						
						##################################
						######## ELASTIC ELEMENT #########
						incr current_bracing;
						element elasticBeamColumn $current_bracing $internal_nodeI $imp_nod $A_br $E_br $Iz_br $Crt_br;
						write_element $current_bracing $internal_nodeI $imp_nod;
						
						incr current_bracing;
						element elasticBeamColumn $current_bracing $imp_nod $internal_nodeJ $A_br $E_br $Iz_br $Crt_br;
						write_element $current_bracing $imp_nod $internal_nodeJ;
						###############################
						
						equalDOF $node_i $internal_nodeI 1 2					 
						equalDOF $node_j $internal_nodeJ 1 2 
					
					}
				} else {
				
						set node_i	[lindex $MasterNodes [expr ($i+1)*$Xcanvas+($j)+1]]
						set node_j  [lindex $MasterNodes [expr ($i)*$Xcanvas+($j+1)-1]]
						
						##### LEFT INTERNAL NODE ######
						set internal_nodeI [expr $node_i*$RegionInternalNode_ID+8];
						set x_i [expr [nodeCoord $node_i 1]];
						set y_i [expr [nodeCoord $node_i 2]];				
						node	[expr $internal_nodeI]		$x_i	$y_i
						###############################

						##### RIGHT INTERNAL NODE #####
						set internal_nodeJ [expr $node_j*$RegionInternalNode_ID+4];
						set x_j [expr [nodeCoord $node_j 1]];
						set y_j [expr [nodeCoord $node_j 2]];
						node	[expr $internal_nodeJ]		$x_j	$y_j
						###############################
						
						if {$imp == 0 } {
							##################################
							######## ELASTIC ELEMENT #########
							incr current_bracing;
							element elasticBeamColumn $current_bracing $internal_nodeI $internal_nodeJ $A_br $E_br $Iz_br $Crt_br;
							write_element $current_bracing $internal_nodeI $internal_nodeJ;
							###############################
							
							equalDOF $node_i $internal_nodeI 1 2									 
							equalDOF $node_j $internal_nodeJ 1 2  
						} else {
							
							incr current_node;
							set imp_nod [generate2DImperfectionPointID $current_node $internal_nodeI $internal_nodeJ $imp];

							
							##################################
							######## ELASTIC ELEMENT #########
							incr current_bracing;
							element elasticBeamColumn $current_bracing $internal_nodeI $imp_nod $A_br $E_br $Iz_br $Crt_br;
							write_element $current_bracing $internal_nodeI $imp_nod;
							
							incr current_bracing;
							element elasticBeamColumn $current_bracing $imp_nod $internal_nodeJ $A_br $E_br $Iz_br $Crt_br;
							write_element $current_bracing $imp_nod $internal_nodeJ;
							###############################
							
							equalDOF $node_i $internal_nodeI 1 2									 
							equalDOF $node_j $internal_nodeJ 1 2 
										
						}
					}
						
			
				
			}
			
			##################################
		}
	}
	
	
	
	addElements "Bracings"	[expr $RegionBracingElement_ID+1]	[expr $current_bracing];
	
	
###################################################################################################
#               ADD NODES												  
###################################################################################################

	if {$imp ne 0} {
		addNodes [expr $RegionNode_ID+1]	[expr $current_node];
		addExternalNodes [expr $RegionNode_ID+1]	[expr $current_node];
	} else {
		addNodes NULL	NULL;
		addExternalNodes NULL	NULL;
	}
CloseRegion;


}













