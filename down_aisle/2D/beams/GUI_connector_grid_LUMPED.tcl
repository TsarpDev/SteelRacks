#################################################################
#################### GUI_connector_grid_LUMPED ##################
#################################################################
#	GUI Arbitrary connector beams 	with grid				    # 
#	beams: LUMPED									    		#
#															    #
#	fixity: fixed											    #


proc_ref	GUI_connector_grid_LUMPED	{ Region_ID  Master_ID Slave_ID *conYpoints *conXpoints fragments *connector_beams *connector_subBeams  beamOffset subBeamOffset rigidSection    {Node_ID 100} {Ele_ID 1000}  {InternalNode_ID 100  } {InternalEle_ID 100  } } {

	kill_if_2D "ERROR: GUI_connector_grid_LUMPED is only for 3D analysis. Change analysis type.";
	
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
	
	set Ycanvas [llength $conYpoints]
	set Xcanvas [llength $conXpoints]

#############################################
#         Initial Checks					#

	
	if {[expr $Ycanvas*$Xcanvas] ne [llength $connector_beams]} {
		error_clean "ERROR. Size of canvas ([expr $Ycanvas*$Xcanvas]) is different than the connector_beams length ([llength $connector_beams])!"
	}
	
	if {[expr $Ycanvas*($Xcanvas-1)] ne [llength $connector_subBeams]} {
		error_clean "ERROR. Ycanvas*(Xcanvas-1)=[expr $Ycanvas*($Xcanvas-1)] is different than the connector_subBeams length ([llength $connector_subBeams])!"
	}
	

	set zMaster [getZcoord $Master_ID [lindex $conXpoints 0] [lindex $conYpoints 0]]
	set zSlave [getZcoord $Slave_ID [lindex $conXpoints 0] [lindex $conYpoints 0]]
	
	if {$zMaster<$zSlave} {
		
	} else {
		error_clean "ERROR. zMaster < zSlave. (not done yet!!)";
	}

	set MasterNodes ""
	set SlaveNodes ""
	set StartingNodes ""
	for {set i 0} {$i<$Ycanvas} {incr i} {
		for {set j 0} {$j<$Xcanvas} {incr j} {
			lappend MasterNodes 00
			lappend SlaveNodes 00
			lappend StartingNodes 00
		}
	}
	
	
	for {set i [expr $Ycanvas-1]} {$i>=0} {set i [expr $i-1]} {
	
		for {set j 0} {$j<$Xcanvas} {incr j} {
		
			set Xcoord [lindex $conXpoints $j]
			set Ycoord [lindex $conYpoints [expr $Ycanvas-1-$i]]
			
			set pos [expr $i*$Xcanvas+$j]
			
			if {[lindex $connector_beams $pos] ne {00 00 00}} {
				lset MasterNodes $pos [getXY_Node $Master_ID $Xcoord $Ycoord]
				lset SlaveNodes $pos [getXY_Node $Slave_ID $Xcoord $Ycoord]
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
		
		puts "Printing SlaveNodes:"
		for {set i 0} {$i<$Ycanvas} {incr i} {
		
			for {set j 0} {$j<$Xcanvas} {incr j} {
				set pos [expr $i*$Xcanvas+$j]
				puts -nonewline "[lindex $SlaveNodes $pos]\t"
			}
			puts "\n"
		}
		puts "========================\n"
	}
	
	
###################################################################################################
#          NODE GENERATION													  
###################################################################################################

#	node numbering: A(000000)ij. A=Region_ID and ij is the number of the node. 
#	example:	523 = Node 23 in region 5. If Node_ID=1000 then 5023. 


	
	set RegionNode_ID [expr $Region_ID*$Node_ID]; 

	set clearDist [abs [expr $zSlave-$zMaster-2.*$beamOffset]]
	
	set fragDist [expr $clearDist/$fragments]
	
	set current_node [expr $RegionNode_ID+1]
	
	for {set i [expr $Ycanvas-1]} {$i>=0} {set i [expr $i-1]} {

		for {set j 0} {$j < $Xcanvas} {incr j} {
		
			set position [expr $i*$Xcanvas+$j]
			
			if  { [lindex $MasterNodes $position] ne 00 } {
			
				for {set k 0} {$k<=$fragments} {incr k} {
				
					set x [lindex $conXpoints $j]
					set y [lindex $conYpoints [expr $Ycanvas-1-$i]]
					set z [expr $zMaster+$beamOffset+$fragDist*$k];
						
						
					node $current_node $x $y $z
					
					if {$k==0} {
						lset StartingNodes $position $current_node 
					}
					
					
					incr current_node
					
						
				}
			}
		
			
			
		}
		
	}
	
	if 0 {
		puts "Printing StartingNodes:"
		for {set i 0} {$i<$Ycanvas} {incr i} {
		
			for {set j 0} {$j<$Xcanvas} {incr j} {
				set pos [expr $i*$Xcanvas+$j]
				puts -nonewline "[lindex $StartingNodes $pos]\t"
			}
			puts "\n"
		}
		puts "========================\n"
	}
	
	
###################################################################################################
#               ADD NODES												  
###################################################################################################

	write_region_nodes $Region_ID $Xcanvas $Ycanvas StartingNodes
	addExternalNodes [expr $RegionNode_ID+1]	[expr $current_node - 1];
	addNodes [expr $RegionNode_ID+1]	[expr $current_node - 1];
	

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
	
	set current_beam [expr $RegionBeamElement_ID]
	
	for {set i [expr $Ycanvas-1]} {$i>=0} {set i [expr $i-1]} {
	
		for {set j 0} {$j < $Xcanvas} {incr j} {
		
			set position [expr $i*$Xcanvas+$j]
			
			if {[lindex $MasterNodes $position] ne 00} {
			
				
				scan [lindex [lindex $connector_beams $position] 1] %d sectionTag
				set sectionTag 

				set A_beam [getElasticA $sectionTag]
				set E_beam [getElasticE $sectionTag]
				set G_beam [getElasticG $sectionTag]
				set Iy_beam [getElasticIy $sectionTag]
				set Iz_beam [getElasticIz $sectionTag]
				set J_beam [getElasticJ $sectionTag]

				scan [lindex [lindex $connector_beams $position] 0] %d springID_zStart
				set springID_zStart
				
				scan [lindex [lindex $connector_beams $position] 2] %d springID_zEnd
				set springID_zEnd 
				
				set node_i [lindex $MasterNodes $position]
				set node_j [lindex $SlaveNodes $position]
				
				########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg		
				#	4	3	2
				#	5		1
				#	6	7	8
				
				for {set k 0} {$k<=[expr $fragments+1]} {incr k} {
					if {$k==0} {
						set node_1 $node_i;
						set node_2 [expr [lindex $StartingNodes $position]+$k]
						
					} elseif {$k==1} {
						set node_1 [expr ([lindex $StartingNodes $position]+$k-1)*$InternalNode_ID + 1];

						node $node_1 [nodeCoord [expr [lindex $StartingNodes $position]+$k-1] 1] \
									 [nodeCoord [expr [lindex $StartingNodes $position]+$k-1] 2] \
									 [nodeCoord [expr [lindex $StartingNodes $position]+$k-1] 3]
						
						set node_2 [expr [lindex $StartingNodes $position]+$k];
					
					} elseif {$k==$fragments} {
						set node_1 [expr [lindex $StartingNodes $position]+$k-1];
						
						set node_2 [expr ([lindex $StartingNodes $position]+$k)*$InternalNode_ID + 5];
									
						node $node_2 [nodeCoord [expr [lindex $StartingNodes $position]+$k] 1] \
									 [nodeCoord [expr [lindex $StartingNodes $position]+$k] 2] \
									 [nodeCoord [expr [lindex $StartingNodes $position]+$k] 3]

					} elseif {$k==[expr $fragments+1]} {
						set node_1 [expr [lindex $StartingNodes $position]+$k-1];
						set node_2 $node_j;
						
					} else {
						set node_1 [expr [lindex $StartingNodes $position]+$k-1];
						set node_2 [expr [lindex $StartingNodes $position]+$k];
					}
					
					
					if {$k==0 || $k==[expr $fragments+1]} {
					
						incr current_beam
						element elasticBeamColumn	$current_beam  	$node_1  $node_2  $A_rigid $E_rigid $G_rigid \
																					  $J_rigid $Iy_rigid $Iz_rigid \
																					  $Ln_beam;
						write_element $current_beam $node_1  $node_2;
						
					} else {
						incr current_beam
						element elasticBeamColumn	$current_beam  	$node_1  $node_2		  $A_beam $E_beam $G_beam \
																							  $J_beam $Iy_beam $Iz_beam \
																							  $Ln_beam;
						write_element $current_beam $node_1  $node_2;
					
					}
					
					
					if {$k==1} {
							set external_node [expr [lindex $StartingNodes $position]+$k-1]
							set x1_local -1
							set x2_local 0
							set x3_local 0
							set y1_local 0
							set y2_local 1
							set y3_local 0
							element zeroLength [expr $current_beam*$InternalEle_ID] $external_node $node_1 \
									-mat $springID_zStart  -dir 4 -orient $x1_local $x2_local $x3_local \
																			  $y1_local $y2_local $y3_local
							equalDOF $external_node $node_1 1 2 3 5 6
					} elseif {$k==$fragments} {
							set external_node [expr [lindex $StartingNodes $position]+$k]
							element zeroLength [expr $current_beam*$InternalEle_ID] $external_node $node_2 \
									-mat $springID_zEnd  -dir 4 
							equalDOF $external_node $node_2 1 2 3 5 6
					}
						
					
				}
			
			}
			
		
		}
	}
	
	addElements "Beams"	[expr $RegionBeamElement_ID+1]	[expr $current_beam];


#############################################
#         Generate Sub Beam 	                #


	set RegionSubBeamElement_ID	[expr $Reg_Ele_ID+$SUBBEAM*$Ele_ID];

	set current_ele [expr $RegionSubBeamElement_ID];
	
	for {set i [expr $Ycanvas-1]} {$i>=0} {set i [expr $i-1]} {
		
		for {set j 0} {$j < [expr $Xcanvas-1]} {incr j} {
			
			set position [expr $i*$Xcanvas+$j]
			set subBeam_position [expr $i*($Xcanvas-1)+$j] 
			
			if {[lindex $connector_subBeams $subBeam_position] ne {00 00 00} } {
				
				
				scan [lindex [lindex $connector_subBeams $subBeam_position] 1] %d sectionTag
				set sectionTag
				
				set A_beam [getElasticA $sectionTag]
				set E_beam [getElasticE $sectionTag]
				set G_beam [getElasticG $sectionTag]
				set Iy_beam [getElasticIy $sectionTag]
				set Iz_beam [getElasticIz $sectionTag]
				set J_beam [getElasticJ $sectionTag]

				
				scan  [lindex [lindex $connector_subBeams $subBeam_position] 0] %d springID_start
				set springID_start
				
				scan  [lindex [lindex $connector_subBeams $subBeam_position] 2] %d springID_end
				set springID_end

				for {set k 1} {$k < $fragments} {incr k} {

					set node_i [expr [lindex $StartingNodes $position]+$k]; 
					set node_j [expr [lindex $StartingNodes [expr $position+1] ]+$k];
					
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
					
					
					puts "$node_i $node_j  $node_1  $node_11   $node_2  $node_22 "
					###master rigid
					incr current_ele;
					element elasticBeamColumn	$current_ele  	$node_i  $node_1  $A_rigid $E_rigid $G_rigid \
																					  $J_rigid $Iy_rigid $Iz_rigid \
																					  $Ln_SubBeam;
					write_element $current_ele $node_i  $node_1 ;
					
					element zeroLength [expr $current_ele*$InternalEle_ID] $node_1 $node_11 -mat $springID_start  -dir 6
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
														-mat $springID_end  -dir 6 -orient $x1_local $x2_local $x3_local \
																			  $y1_local $y2_local $y3_local
					equalDOF $node_2 $node_22 1 2 3 4 5
								
				}

			}
		
		}
	}
	#set Tot_beam	$current_ele;
	addElements "SubBeams"	[expr $RegionSubBeamElement_ID+1]	[expr $current_ele];


CloseRegion;


}













