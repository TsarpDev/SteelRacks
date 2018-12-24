#################################################################
#################### zic_beam2D_NL_FIBER ##################
#################################################################
#	Zic Zac Beam	2D				    # 
#	beams: FIBER, one section for all (classic in warehouses)	#
#	trusses: FIBER,	one section for all (...)				    #
#	fixity: released										    #



proc_ref	zic_beam2D_NL_FIBER	{ Region_ID  beams  trusses  massX   *lengths_sym  h0_start  h0_end  x0  y0 {Node_ID 1000} {Ele_ID 1000}  {InternalNode_ID 1000  } {nIntPt 3} {maxIters 20} {tolIter 1.e-8} } {
	
	kill_if_3D "ERROR: zic_beam2D_NL_FIBER is only for 2D analysis. Change analysis type.";

###################################################################################################
#          INITIAL CALCULATIONS													  
###################################################################################################
	upvar #0 LinearTransf_FRAME Ln_beam;
	
	AddRegion $Region_ID;

#############################################
#         Initial Checks					#
	
	for {set i 1} { $i < [llength $lengths_sym]} {incr i} {
		if { [lindex $lengths_sym $i]<= [lindex $lengths_sym [expr $i-1] ] } {
			error_clean "ERROR: In region $Region_ID, lengths in zic zac symmetric beams must be sorted."; 
		}
	}
	
	set Negligible 1e-9;	
	
	set N_sym [llength $lengths_sym];

#	convert to floats	
	for {set i 0 } {$i<$N_sym} {incr i} {
		set lengths_sym [lreplace $lengths_sym $i $i [expr 1.0*[lindex $lengths_sym $i]]];
	}

#	half length (symmetric length)
	set L_sym [lindex $lengths_sym end];

	
###################################################################################################
#          NODE GENERATION													  
###################################################################################################

#	node numbering: A(000000)ij. A=Region_ID and ij is the number of the node. 
#	example:	523 = Node 23 in region 5. If Node_ID=1000 then 5023. 

	set current_node	1;
	set slope [expr ($h0_end-$h0_start)/$L_sym ];
	
	for {set i 0} {$i < [expr $N_sym] } {incr i} {
		set L_temp		[lindex $lengths_sym $i ];
		
		node	[expr $Region_ID*$Node_ID+$current_node]		[expr $x0+$L_temp]		$y0;
		incr current_node;
		
		node	[expr $Region_ID*$Node_ID+$current_node]		[expr $x0+$L_temp]		[expr $y0+$h0_start+$L_temp*$slope]	 -mass $massX $Negligible $Negligible;
		write_node_with_mass2D [expr $Region_ID*$Node_ID+$current_node] $massX $Negligible $Negligible;
		
		incr current_node;
	}
	
	set distances {};
	for {set i 0} {$i < [expr $N_sym-1] } {incr i} {
		lappend distances	[expr [lindex $lengths_sym [expr $i+1]]-[lindex $lengths_sym $i] ];
	}
	set rev_distances [lreverse $distances];
	
	
	
	for {set i 0} {$i < [expr $N_sym-1] } {incr i} {
		set L_temp		[expr $L_temp+[lindex $rev_distances $i] ];
		
		node	[expr $Region_ID*$Node_ID+$current_node]		[expr $x0+$L_temp]		$y0;
		incr current_node;
		
		node	[expr $Region_ID*$Node_ID+$current_node]		[expr $x0+$L_temp]		[expr $y0+$h0_end-($L_temp-$L_sym)*$slope]	 -mass $massX $Negligible $Negligible;
		write_node_with_mass2D [expr $Region_ID*$Node_ID+$current_node] $massX $Negligible $Negligible;
		
		incr current_node;
	}
	set total_nodes [expr $current_node-1];
	
	
###################################################################################################
#               ADD NODES												  
###################################################################################################

	
	addNodes [expr $Region_ID*$Node_ID+1]	[expr $Region_ID*$Node_ID+$current_node-1];
	addExternalNodes [expr $Region_ID*$Node_ID+1]	[expr $Region_ID*$Node_ID+$current_node-1];
	
###################################################################################################
#          ELEMENT GENERATION													  
###################################################################################################

#	element numbering: RTijk. R=Region_ID,	T=type and ijk the number of the element. By default T=1 column, 2 bracing, 3 beam bracing.
#	example:	52090 = Bracing 90 in region 5. 
	set Reg_Ele_ID	[expr $Ele_ID*10*$Region_ID];
	set BEAM 1;
	set BR_ver  2;
	set BR_diag 3;
	
#############################################
#         Generate Horizontal Beams			#
	set current_ele		[expr $Reg_Ele_ID+$BEAM*$Ele_ID];
	set increment 2;

	for	{set j 1} {$j <= [expr 2*($N_sym-1)] } {incr j} { 
		
		set sectionTag $beams

		################################## BOTTOM BRACE ################################
		########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg		
		#	4	3	2
		#	5		1
		#	6	7	8
		
		incr current_ele;
		
		set node_i	[expr $Region_ID*$Node_ID+ ($j - 1) * $increment + 1 ];
		set node_j [expr $node_i+$increment];
		
		
		set internal_nodeI [expr $node_i*$InternalNode_ID+ 1];
		set x_i [expr [nodeCoord $node_i 1]];
		set y_i [expr [nodeCoord $node_i 2]];
		node	[expr $internal_nodeI]		$x_i	$y_i
		
		
		set internal_nodeJ [expr $node_j*$InternalNode_ID+ 5];
		set x_j [expr [nodeCoord $node_j 1]];
		set y_j [expr [nodeCoord $node_j 2]];
		node	[expr $internal_nodeJ]		$x_j	$y_j
		
		element nonlinearBeamColumn   $current_ele   $internal_nodeI  $internal_nodeJ $nIntPt  $sectionTag  $Ln_beam -iter $maxIters $tolIter
		
		write_element $current_ele $node_i $node_j;
				
		equalDOF $node_i $internal_nodeI 1 2
		equalDOF $node_j $internal_nodeJ 1 2
	
		
		################################## TOP BRACE ################################
		########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg
		#	4	3	2
		#	5		1
		#	6	7	8
		
		incr current_ele;
		
		incr node_i;
		incr node_j;
		
	
		set internal_nodeI [expr $node_i*$InternalNode_ID+1];
		set x_i [expr [nodeCoord $node_i 1]];
		set y_i [expr [nodeCoord $node_i 2]];
		node	[expr $internal_nodeI]		$x_i	$y_i
		
		
		set internal_nodeJ [expr $node_j*$InternalNode_ID+5];
		set x_j [expr [nodeCoord $node_j 1]];
		set y_j [expr [nodeCoord $node_j 2]];
		node	[expr $internal_nodeJ]		$x_j	$y_j
		
		element nonlinearBeamColumn   $current_ele   $internal_nodeI  $internal_nodeJ $nIntPt  $sectionTag  $Ln_beam -iter $maxIters $tolIter
		
		write_element $current_ele $node_i $node_j;
				
		equalDOF $node_i $internal_nodeI 1 2
		equalDOF $node_j $internal_nodeJ 1 2
		
		}
	
	addElements "Beams"	[expr $Reg_Ele_ID+$BEAM*$Ele_ID+1]	[expr $current_ele];


	
#############################################
#         Generate Vertical Bracing         #
	
	set current_ele		[expr $Reg_Ele_ID+$BR_ver*$Ele_ID];
	set increment [expr 1];

	
	for	{set j 1} {$j <= [expr $total_nodes-1] } {incr j 2} {
	
		set sectionTag $trusses

		incr current_ele;
		
		set node_i	[expr $Region_ID*$Node_ID + $j]; 
		set node_j [expr $node_i+$increment];
		
		element nonlinearBeamColumn   $current_ele  $node_i $node_j $nIntPt  $sectionTag  $Ln_beam -iter $maxIters $tolIter
		
		write_element $current_ele $node_i $node_j;
		
		########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg
		#	4	3	2
		#	5		1
		#	6	7	8
		
		if 0 {
		set internal_nodeI [expr $node_i*$InternalNode_ID+3];
		set x_i [expr [nodeCoord $node_i 1]];
		set y_i [expr [nodeCoord $node_i 2]];
		node	[expr $internal_nodeI]		$x_i	$y_i
		
		
		set internal_nodeJ [expr $node_j*$InternalNode_ID+7];
		set x_j [expr [nodeCoord $node_j 1]];
		set y_j [expr [nodeCoord $node_j 2]];
		node	[expr $internal_nodeJ]		$x_j	$y_j
		
		element nonlinearBeamColumn   $current_ele   $internal_nodeI  $internal_nodeJ $nIntPt  $sectionTag  $Ln_beam -iter $maxIters $tolIter
		#element elasticBeamColumn	$current_ele  	$internal_nodeI  $internal_nodeJ   $A_v $Es $I_v 0;
		
		write_element $current_ele $node_i $node_j;
				
		equalDOF $node_i $internal_nodeI 1 2
		equalDOF $node_j $internal_nodeJ 1 2
		

		}
	}
	
	#set Tot_ver_br	$current_ele;
	addElements "Ver Bracing"	[expr $Reg_Ele_ID+$BR_ver*$Ele_ID+1]	[expr $current_ele];

#############################################
#         Generate Diagonal Bracing         #
	set current_ele		[expr $Reg_Ele_ID+$BR_diag*$Ele_ID];
	set increment [expr 1];
	
	for	{set j 2} {$j <= [expr $total_nodes-2] } {incr j 2} {

		set sectionTag $trusses

		
		incr current_ele;
		
		if {$j >= [expr $total_nodes/2]} {
		
			set node_i	[expr $Region_ID*$Node_ID + $j - 1]; 
			set node_j [expr $node_i+$increment + 2];
			
				########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg
				#	4	3	2
				#	5		1
				#	6	7	8
				

			set internal_nodeI [expr $node_i*$InternalNode_ID+ 6];
			set x_i [expr [nodeCoord $node_i 1]];
			set y_i [expr [nodeCoord $node_i 2]];
			node	[expr $internal_nodeI]		$x_i	$y_i
		
		
			set internal_nodeJ [expr $node_j*$InternalNode_ID+2];
			set x_j [expr [nodeCoord $node_j 1]];
			set y_j [expr [nodeCoord $node_j 2]];
			node	[expr $internal_nodeJ]		$x_j	$y_j
		
			element nonlinearBeamColumn   $current_ele   $internal_nodeI  $internal_nodeJ $nIntPt  $sectionTag  0 -iter $maxIters $tolIter
			#element elasticBeamColumn	$current_ele  	$internal_nodeI  $internal_nodeJ   $A_d $Es $I_d 0;
		
			write_element  $current_ele $node_i $node_j;
				
			equalDOF $node_i $internal_nodeI 1 2
			equalDOF $node_j $internal_nodeJ 1 2
	
		
			#element truss $current_ele [expr $node_i-1] [expr $node_j+1] $A_diag $TrussMatID;
			#write_element $current_ele [expr $node_i-1] [expr $node_j+1];
			
		} else {
		
			set node_i	[expr $Region_ID*$Node_ID + $j]; 
			set node_j [expr $node_i+$increment];
			
			########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg
			#	4	3	2
			#	5		1
			#	6	7	8
			
			
			set internal_nodeI [expr $node_i*$InternalNode_ID+8];
			set x_i [expr [nodeCoord $node_i 1]];
			set y_i [expr [nodeCoord $node_i 2]];
			node	[expr $internal_nodeI]		$x_i	$y_i
		
		
			set internal_nodeJ [expr $node_j*$InternalNode_ID+4];
			set x_j [expr [nodeCoord $node_j 1]];
			set y_j [expr [nodeCoord $node_j 2]];
			node	[expr $internal_nodeJ]		$x_j	$y_j
		
			element nonlinearBeamColumn   $current_ele   $internal_nodeI  $internal_nodeJ $nIntPt  $sectionTag  0 -iter $maxIters $tolIter
			#element elasticBeamColumn	$current_ele  	$internal_nodeI  $internal_nodeJ   $A_d $Es $I_d 0;
		
			write_element $current_ele $node_i $node_j;
				
			equalDOF $node_i $internal_nodeI 1 2
			equalDOF $node_j $internal_nodeJ 1 2
		
		}
	}
	#set Tot_beam	$current_ele;
	addElements "Diag Bracing"	[expr $Reg_Ele_ID+$BR_diag*$Ele_ID+1]	[expr $current_ele];
	
	
	
	
	
	




CloseRegion;

}