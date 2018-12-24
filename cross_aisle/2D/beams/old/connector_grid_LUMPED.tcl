#################################################################
#################### connector_grid_LUMPED ##################
#################################################################
#	Arbitrary connector beams 	with grid					    # 
#	beams: LUMPED									    		#
#															    #
#	fixity: fixed											    #



proc_ref	connector_grid_LUMPED	{ Region_ID  Master_ID Slave_ID *heights *lengths fragments *beamsElastic *beamsSprings *subBeamsElastic *subBeamsSprings beamOffset subBeamOffset rigidSection    {Node_ID 100} {Ele_ID 1000}  {InternalNode_ID 100  } {InternalEle_ID 100  } } {


###################################################################################################
#          INITIAL CALCULATIONS													  
###################################################################################################


	upvar #0 LinearTransf_CONN Ln_beam;
	upvar #0 LinearTransf_FRAME Ln_SubBeam;

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
	
	if {[expr $Ycanvas] ne [llength $subBeamsElastic]} {
		error_clean "ERROR. Size of Ycanvas ([expr $Ycanvas]) is different than the subBeamsElastic length ([llength $subBeamsElastic])!"
	}
	
	if {[llength $subBeamsElastic] ne [llength $subBeamsSprings]} {
		error_clean "ERROR. Length of subBeamsSprings ([llength $subBeamsSprings]) is different than the subBeamsElastic length ([llength $subBeamsElastic])!"
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


	
	set RegionNode_ID [expr $Region_ID*$Node_ID]; 

	set clearDist [abs [expr $zSlave-$zMaster-2.*$beamOffset]]
	
	set fragDist [expr $clearDist/$fragments]
	
	for {set i 0} {$i < $Ycanvas} {incr i} {

		for {set j 0} {$j < $Xcanvas} {incr j} {
		
			set position [expr $i*$Xcanvas+$j]
			
			set x [lindex $lengths $j]
			set y [lindex $heights $i]
			
			
				
				for {set k 0} {$k<=$fragments} {incr k} {
			
					set z [expr $zMaster+$beamOffset+$fragDist*$k];
					
					set node_tag [expr $RegionNode_ID + ($fragments + 1) * $position + $k + 1] ;
					
					node $node_tag $x $y $z
					
				}
		
			
			
		}
		
	}

	
###################################################################################################
#               ADD NODES												  
###################################################################################################

	addExternalNodes [expr $RegionNode_ID+1]	[expr $RegionNode_ID+($fragments + 1)* $position + $fragments + 1];
	addNodes [expr $RegionNode_ID+1]	[expr $RegionNode_ID+($fragments + 1)* $position + $fragments + 1];
	

###################################################################################################
#          ELEMENT GENERATION													  
###################################################################################################

#	element numbering: RTijk. R=Region_ID,	T=type and ijk the number of the element. By default T=1 column,  2 beam.
#	example:	52090 = Beam 90 in region 5. 
	set Reg_Ele_ID	[expr $Ele_ID*10*$Region_ID];
	set BEAM 1;
	set SUBBEAM 2;
	

#############################################
#         Generate Beam 	                #


	set RegionBeamElement_ID	[expr $Reg_Ele_ID+$BEAM*$Ele_ID];
	
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
			
			for {set k 0} {$k<=[expr $fragments+1]} {incr k} {
				if {$k==0} {
					set node_1 $node_i;
					set node_2 [expr $RegionNode_ID + ($fragments + 1) * $position + $k + 1];
					
				} elseif {$k==1} {
					set node_1 [expr ($RegionNode_ID + ($fragments + 1) * $position + $k )\
								*$InternalNode_ID + 1];

					node $node_1 [nodeCoord [expr ($RegionNode_ID + ($fragments + 1) * $position + $k )] 1] \
								 [nodeCoord [expr ($RegionNode_ID + ($fragments + 1) * $position + $k )] 2] \
								 [nodeCoord [expr ($RegionNode_ID + ($fragments + 1) * $position + $k )] 3]
					
					set node_2 [expr $RegionNode_ID + ($fragments + 1) * $position + $k + 1];
				
				} elseif {$k==$fragments} {
					set node_1 [expr $RegionNode_ID + ($fragments + 1) * $position + $k ];
					
					set node_2 [expr ($RegionNode_ID + ($fragments + 1) * $position + $k +1)\
								*$InternalNode_ID + 5];
								
					node $node_2 [nodeCoord [expr ($RegionNode_ID + ($fragments + 1) * $position + $k +1)] 1] \
								 [nodeCoord [expr ($RegionNode_ID + ($fragments + 1) * $position + $k +1)] 2] \
								 [nodeCoord [expr ($RegionNode_ID + ($fragments + 1) * $position + $k +1)] 3]

				} elseif {$k==[expr $fragments+1]} {
					set node_1 [expr $RegionNode_ID + ($fragments + 1) * $position + $k ];
					set node_2 $node_j;
					
				} else {
					set node_1 [expr $RegionNode_ID + ($fragments + 1) * $position + $k ];
					set node_2 [expr $RegionNode_ID + ($fragments + 1) * $position + $k +1];
				}
				
				set ele_tag [expr $RegionBeamElement_ID + ($fragments + 2) * $position + $k + 1]
				
				if {$k==0 || $k==[expr $fragments+1]} {
				
					element elasticBeamColumn	$ele_tag  	$node_1  $node_2  $A_rigid $E_rigid $G_rigid \
																			      $J_rigid $Iy_rigid $Iz_rigid \
																				  $Ln_beam;
					write_element $ele_tag $node_1  $node_2;
					
				} else {
				
					element elasticBeamColumn	$ele_tag  	$node_1  $node_2			  $A_beam $E_beam $G_beam \
																						  $J_beam $Iy_beam $Iz_beam \
																						  $Ln_beam;
					write_element $ele_tag $node_1  $node_2;
				
				}
				
				
				if {$k==1} {
						set external_node [expr ($RegionNode_ID + ($fragments + 1) * $position + $k )]
						set x1_local -1
						set x2_local 0
						set x3_local 0
						set y1_local 0
						set y2_local 1
						set y3_local 0
						element zeroLength [expr $ele_tag*$InternalEle_ID] $external_node $node_1 \
								-mat $springID  -dir 4 -orient $x1_local $x2_local $x3_local \
																		  $y1_local $y2_local $y3_local
						equalDOF $external_node $node_1 1 2 3 5 6
				} elseif {$k==$fragments} {
						set external_node [expr ($RegionNode_ID + ($fragments + 1) * $position + $k +1)]
						element zeroLength [expr $ele_tag*$InternalEle_ID] $external_node $node_2 \
								-mat $springID  -dir 4 
						equalDOF $external_node $node_2 1 2 3 5 6
				}
					
				
			}
			
		
		}
	}
	
	addElements "Beams"	[expr $RegionBeamElement_ID+1]	[expr $RegionBeamElement_ID + ($fragments + 2) * $position + ($fragments +1) + 1];



#############################################
#         Generate Sub Beam 	                #


	set RegionSubBeamElement_ID	[expr $Reg_Ele_ID+$SUBBEAM*$Ele_ID];

	set current_ele [expr $RegionSubBeamElement_ID];
	
	for	{set i 0} {$i < $Ycanvas} {incr i} {
	
		set sectionTag [lindex $subBeamsElastic $i]
		set A_beam [getElasticA $sectionTag]
		set E_beam [getElasticE $sectionTag]
		set G_beam [getElasticG $sectionTag]
		set Iy_beam [getElasticIy $sectionTag]
		set Iz_beam [getElasticIz $sectionTag]
		set J_beam [getElasticJ $sectionTag]

		set springID [lindex $subBeamsSprings $i]
	
		
		for {set j 0} {$j < [expr $Xcanvas-1]} {incr j} {
			
			set position [expr $i*$Xcanvas+$j]
			
			for {set k 1} {$k < $fragments} {incr k} {
				
				set node_i [expr $RegionNode_ID + ($fragments + 1) * $position + $k + 1] ; 
				set node_j [expr $RegionNode_ID + ($fragments + 1)* ($i*$Xcanvas+$j+1) + $k + 1] ;
				
				set node_1 [expr $node_i * $InternalNode_ID + 1]
				set node_11 [expr $node_1 * $InternalNode_ID + 1]
				node $node_1 	[expr [nodeCoord $node_i 1] + $subBeamOffset] \
								[nodeCoord $node_i 2] \
								[nodeCoord $node_i 3]
								
				node $node_11 	[nodeCoord $node_1 1] \
								[nodeCoord $node_1 2] \
								[nodeCoord $node_1 3]

				
				
				set node_2 [expr $node_j * $InternalNode_ID + 5]
				set node_22 [expr $node_2 * $InternalNode_ID + 5]
				node $node_2 	[expr [nodeCoord $node_j 1] - $subBeamOffset] \
								[nodeCoord $node_j 2] \
								[nodeCoord $node_j 3]
								
				node $node_22 	[nodeCoord $node_2 1] \
								[nodeCoord $node_2 2] \
								[nodeCoord $node_2 3]
				
				###master rigid
				incr current_ele;
				element elasticBeamColumn	$current_ele  	$node_i  $node_1  $A_rigid $E_rigid $G_rigid \
																			      $J_rigid $Iy_rigid $Iz_rigid \
																				  $Ln_SubBeam;
				write_element $current_ele $node_i  $node_1 ;
				
				element zeroLength [expr $current_ele*$InternalEle_ID] $node_1 $node_11 -mat $springID  -dir 6
				equalDOF $node_1 $node_11 1 2 3 4 5
				
				###elastic
				incr current_ele;
				element elasticBeamColumn	$current_ele  	$node_11  $node_22  $A_beam $E_beam $G_beam \
																					$J_beam $Iy_beam $Iz_beam \
																					$Ln_SubBeam
				write_element $current_ele $node_11  $node_22 ;
				
				###slave rigid
				incr current_ele;
				element elasticBeamColumn	$current_ele  	$node_2  $node_j  $A_rigid $E_rigid $G_rigid \
																			      $J_rigid $Iy_rigid $Iz_rigid \
																				  $Ln_SubBeam;
				write_element $current_ele $node_2  $node_j ;
				
				set x1_local -1
				set x2_local 0
				set x3_local 0
				set y1_local 0
				set y2_local 1
				set y3_local 0
				
				element zeroLength [expr $current_ele*$InternalEle_ID] $node_2 $node_22 \
													-mat $springID  -dir 6 -orient $x1_local $x2_local $x3_local \
																		  $y1_local $y2_local $y3_local
				equalDOF $node_2 $node_22 1 2 3 4 5
			
			}
		
		}
	}
	#set Tot_beam	$current_ele;
	addElements "SubBeams"	[expr $RegionSubBeamElement_ID+1]	[expr $current_ele];
	



CloseRegion;



}













