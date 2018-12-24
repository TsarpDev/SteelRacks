#################################################################
#################### connector_beam_LUMPED ##################
#################################################################
#	Arbitrary connector beams 				  				    # 
#	beams: LUMPED									    		#
#															    #
#	fixity: fixed											    #



proc_ref	connector_beam_LUMPED	{ Region_ID  Master_ID Slave_ID *heights *lengths *beamsElastic *beamsSprings beamOffset rigidSection    {Node_ID 100} {Ele_ID 1000}  {InternalNode_ID 100  } {InternalEle_ID 100  } } {


###################################################################################################
#          INITIAL CALCULATIONS													  
###################################################################################################


	upvar #0 LinearTransf_CONN Ln_beam;
	

	AddRegion $Region_ID;


	set Negligible 1e-9;	
	
	set sectionTag $rigidSection
	set A_rigid [getElasticA $sectionTag]
	set G_rigid [getElasticG $sectionTag]
	set E_rigid [getElasticE $sectionTag]
	set Iy_rigid [getElasticIy $sectionTag]
	set Iz_rigid [getElasticIz $sectionTag]
	set J_rigid [getElasticJ $sectionTag]

#############################################
#         Initial Checks					#

	set Ycanvas [llength $heights]
	set Xcanvas [llength $lengths]
	
	if {[expr $Ycanvas*$Xcanvas] ne [llength $beamsElastic]} {
		error_clean "ERROR. Size of canvas ([expr $Ycanvas*$Xcanvas]) is different than the beamsElastic length ([llength $beamsElastic])!"
	}
	
	if {[llength $beamsSprings] ne [llength $beamsElastic]} {
		error_clean "ERROR. Length of beamSprings ([llength $beamsSprings]) is different than the beamsElastic length ([llength $beamsElastic])!"
	}
	
	set zMaster [getZcoord $Master_ID [lindex $lengths 0] [lindex $heights 0]]
	set zSlave [getZcoord $Slave_ID [lindex $lengths 0] [lindex $heights 0]]
	
	if {$zMaster<$zSlave} {

	} else {
		error_clean "ERROR. zMaster < zSlave. (not done yet!!)";
	}

	set MasterNodes {}
	set SlaveNodes {}
	for {set i 0} {$i<$Ycanvas} {incr i} {
	
		set Ycoord [lindex $heights $i]
		
		for {set j 0} {$j<$Xcanvas} {incr j} {
			
			set Xcoord [lindex $lengths $j]
			
			lappend MasterNodes [getXY_Node $Master_ID $Xcoord $Ycoord]
			lappend SlaveNodes [getXY_Node $Slave_ID $Xcoord $Ycoord]
		
		}
	
	}
	
###################################################################################################
#          NODE GENERATION													  
###################################################################################################

#	node numbering: A(000000)ij. A=Region_ID and ij is the number of the node. 
#	example:	523 = Node 23 in region 5. If Node_ID=1000 then 5023. 


	set current_node	1;
	
	set RegionNode_ID [expr $Region_ID*$Node_ID]; 	
	
	for {set i 0} {$i < $Ycanvas} {incr i} {

		for {set j 0} {$j < $Xcanvas} {incr j} {
		
			set position [expr $i*$Xcanvas+$j]
			
				### MASTER NODE
				set node_i [lindex $MasterNodes $position]
				set x [nodeCoord $node_i 1]
				set y [nodeCoord $node_i 2]
				node	[expr $RegionNode_ID+$current_node]	$x $y [expr $zMaster+$beamOffset];	
				incr current_node;
				
				### MASTER NODE
				set node_j [lindex $SlaveNodes $position]
				set x [nodeCoord $node_j 1]
				set y [nodeCoord $node_j 2]
				node	[expr $RegionNode_ID+$current_node]	$x $y [expr $zSlave-$beamOffset];	
				incr current_node;
			
			

			
		}
		
	}
	
###################################################################################################
#               ADD NODES												  
###################################################################################################

	addExternalNodes [expr $RegionNode_ID+1]	[expr $RegionNode_ID+$current_node-1];
	addNodes [expr $RegionNode_ID+1]	[expr $RegionNode_ID+$current_node-1];
	

###################################################################################################
#          ELEMENT GENERATION													  
###################################################################################################

#	element numbering: RTijk. R=Region_ID,	T=type and ijk the number of the element. By default T=1 column,  2 beam.
#	example:	52090 = Beam 90 in region 5. 
	set Reg_Ele_ID	[expr $Ele_ID*10*$Region_ID];
	set BEAM 2;
	

#############################################
#         Generate Beam 	                #


	set current_ele		[expr $Reg_Ele_ID+$BEAM*$Ele_ID];
	set current_node	1;
	
	for	{set i 0} {$i < $Ycanvas} {incr i} {
	
		
		for {set j 0} {$j < $Xcanvas} {incr j} {
		
			set position [expr $i*$Xcanvas+$j]
			set sectionTag [lindex $beamsElastic $position]
			set A_beam [getElasticA $sectionTag]
			set E_beam [getElasticE $sectionTag]
			set G_beam [getElasticG $sectionTag]
			set Iy_beam [getElasticIy $sectionTag]
			set Iz_beam [getElasticIz $sectionTag]
			set J_beam [getElasticJ $sectionTag]

			set springID [lindex $beamsSprings $position]
			
			set node_i [lindex $MasterNodes $position]
			set node_j [lindex $SlaveNodes $position]
			
			########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg		
			#	4	3	2
			#	5		1
			#	6	7	8
			

			###############################
			####### MASTER RIGID NODE #######
			set rigid_nodeI [expr $RegionNode_ID+$current_node];
			incr current_node;

			####### SLAVE RIGID NODE ######
			set rigid_nodeJ [expr $RegionNode_ID+$current_node];
			incr current_node;
	
			###############################
			##### MASTER INTERNAL NODE ######
			set internal_nodeI [expr $rigid_nodeI*$InternalNode_ID+1];

			set x_i [expr [nodeCoord $rigid_nodeI 1]];
			set y_i [expr [nodeCoord $rigid_nodeI 2]];
			set z_i [expr [nodeCoord $rigid_nodeI 3]];
								
			node	[expr $internal_nodeI]		$x_i	$y_i	$z_i
			###############################
			

			###############################
			###############################
			##### RIGHT INTERNAL NODE #####

			set internal_nodeJ [expr $rigid_nodeJ*$InternalNode_ID+5];

			
			set x_j [expr [nodeCoord $rigid_nodeJ 1]];
			set y_j [expr [nodeCoord $rigid_nodeJ 2]];
			set z_j [expr [nodeCoord $rigid_nodeJ 3]];
								
			node	[expr $internal_nodeJ]		$x_j	$y_j	$z_j
			###############################
			
			##################################
			###### MASTER RIGID ELEMENT ######
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
			
			set x1_local -1
			set x2_local 0
			set x3_local 0
			set y1_local 0
			set y2_local 1
			set y3_local 0
			
			element zeroLength [expr $current_ele*$InternalEle_ID] $rigid_nodeI $internal_nodeI -mat  $springID -dir 4  \
																-orient $x1_local $x2_local $x3_local $y1_local $y2_local $y3_local
			equalDOF $rigid_nodeI $internal_nodeI 1 2 3 5 6
		
			element zeroLength [expr $current_ele*$InternalEle_ID+1] $rigid_nodeJ $internal_nodeJ -mat $springID -dir 4 
			equalDOF $rigid_nodeJ $internal_nodeJ 1 2 3 5 6
		}
	}
	#set Tot_beam	$current_ele;
	addElements "Beams"	[expr $Reg_Ele_ID+$BEAM*$Ele_ID+1]	[expr $current_ele];
	



CloseRegion;



}













