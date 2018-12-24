#################################################################
#################### SpringedAndPinned2D ########################
#################################################################
#			2D Pinned nodes and springs for rotational ##########

proc_ref	SpringedAndPinned2D	{ Region_ID	  SlaveRegion_ID	 y		springMat    {Node_ID 100} {Ele_ID 1000}  } {

	kill_if_3D "ERROR: SpringedAndPinned2D is only for 2D analysis. Change analysis type.";

###################################################################################################
#          INITIAL CALCULATIONS													  
###################################################################################################

AddRegion $Region_ID;
	
set bottomNodes [lineX_nodes $SlaveRegion_ID		$y]

set Negligible 1e-9;

set RegionNode_ID [expr $Region_ID*$Node_ID];

set Reg_Ele_ID	[expr $Ele_ID*10*$Region_ID];

set ZER 1;

scan springMat %d springMat
set springMat

set Xcanvas [llength $bottomNodes]
set Ycanvas 1
set node_tags ""

###################################################################################################
#          BOUNDARY GENERATION												  
###################################################################################################

set current_node [expr $RegionNode_ID+1]

set current_ele		[expr $Reg_Ele_ID+$ZER*$Ele_ID];




foreach n $bottomNodes {

	set x [expr [nodeCoord $n 1]]
	
	set y [expr [nodeCoord $n 2]]

	
	node $current_node $x $y;
	fix $current_node 1 1 1;
	lappend node_tags $current_node
	
	equalDOF $current_node $n 1 2
	element zeroLength $current_ele $current_node $n -mat $springMat -dir 3
	
	incr current_node
	incr current_ele
}	


###################################################################################################
#               ADD NODES												  
###################################################################################################

	write_region_nodes $Region_ID $Xcanvas $Ycanvas node_tags
	addNodes [expr $RegionNode_ID+1]	[expr $current_node-1];
	addExternalNodes [expr $RegionNode_ID+1]	[expr $current_node-1];


###################################################################################################
#               ADD ELEMENTS												  
###################################################################################################
addElements "ZeroLengths"	[expr $Reg_Ele_ID+$ZER*$Ele_ID+1]	[expr $current_ele];


CloseRegion;

}

								



