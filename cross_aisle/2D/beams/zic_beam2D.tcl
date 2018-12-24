#################################################################
#################### zic_beam2D ##################
#################################################################
#	Zic Zac Beam	2D				    # 
#	beams: BEAM, one section for all (classic in warehouses)	#
#	trusses: BEAM,	one section for all (...)				    #
#	fixity: released										    #



proc_ref	zic_beam2D	{ Region_ID  massX   *lengths_sym *ver_sym *diag_sym *botSec *topSec *verSec *diagSec h0_start  h0_end  x0  y0  {Node_ID 1000} {Ele_ID 1000}  {InternalNode_ID 1000  }  } {

	kill_if_3D "ERROR: zic_beam2D is only for 2D analysis. Change analysis type.";


###################################################################################################
#          INITIAL CALCULATIONS													  
###################################################################################################

	upvar #0 LinearTransf_FRAME Ln_beam;
	
	AddRegion $Region_ID;
	
	set N_sym [llength $lengths_sym];
	set L_sym [lindex $lengths_sym end];
	
	set Ycanvas 2;
	set Xcanvas [expr 2*$N_sym-1];
	
	set node_tags ""
	for {set i 0} {$i<$Ycanvas} {incr i} {
		for {set j 0} {$j<$Xcanvas} {incr j} {
			lappend node_tags 0;
		}
	}

#############################################
#         Initial Checks					#
	
	for {set i 1} { $i < [llength $lengths_sym]} {incr i} {
		if { [lindex $lengths_sym $i]<= [lindex $lengths_sym [expr $i-1] ] } {
			error_clean "ERROR: In region $Region_ID, lengths in zic zac symmetric beams must be sorted."; 
		}
	}
	if {[llength $botSec] ne [expr [llength $lengths_sym]-1]} {
		error_clean "ERROR: (llength botSec) ne (llength $lengths_sym-1). [llength $botSec] ne [expr [llength $lengths_sym]-1]"; 
	}
	if {[llength $topSec] ne [expr [llength $lengths_sym]-1]} {
		error_clean "ERROR: (llength topSec) ne (llength $lengths_sym-1). [llength $topSec] ne [expr [llength $lengths_sym]-1]"; 
	}
	if {[llength $verSec] ne [expr [llength $ver_sym]]} {
		error_clean "ERROR: (llength verSec) ne (llength $ver_sym). [llength $verSec] ne [expr [llength $ver_sym]]"; 
	}
	if {[llength $diagSec] ne [expr [llength $diag_sym]-1]} {
		error_clean "ERROR: (llength diagSec) ne (llength $diag_sym-1). [llength $diagSec] ne [expr [llength $diag_sym]-1]"; 
	}
	
	set Negligible 1e-9;	

#	convert to floats	
	#for {set i 0 } {$i<$N_sym} {incr i} {
	#	set lengths_sym [lreplace $lengths_sym $i $i [expr 1.0*[lindex $lengths_sym $i]]];
	#}

#	half length (symmetric length)

###################################################################################################
#          NODE GENERATION													  
###################################################################################################

#	node numbering: A(000000)ij. A=Region_ID and ij is the number of the node. 
#	example:	523 = Node 23 in region 5. If Node_ID=1000 then 5023. 

	set RegionNode_ID [expr $Region_ID*$Node_ID]; 	
	set current_node	[expr $RegionNode_ID+1];
	
	set slope [expr ($h0_end-$h0_start)/$L_sym ];
	
	for {set i 0} {$i < [expr $N_sym] } {incr i} {
	
		set L_temp		[lindex $lengths_sym $i ];
		
		node	$current_node		[expr $x0+$L_temp]		$y0;
		set pos [expr 1*$Xcanvas+$i];
		lset node_tags $pos $current_node;
		incr current_node;

		
		node	$current_node		[expr $x0+$L_temp]		[expr $y0+$h0_start+$L_temp*$slope]	 -mass $massX $Negligible $Negligible;
		write_node_with_mass2D $current_node $massX $Negligible $Negligible;
		set pos [expr 0*$Xcanvas+$i];
		lset node_tags $pos $current_node;
		incr current_node;
		
	}
	
	set distances {};
	for {set i 0} {$i < [expr $N_sym-1] } {incr i} {
		lappend distances	[expr [lindex $lengths_sym [expr $i+1]]-[lindex $lengths_sym $i] ];
	}
	set rev_distances [lreverse $distances];
	
	
	for {set i 0} {$i < [expr $N_sym-1] } {incr i} {
		set L_temp		[expr $L_temp+[lindex $rev_distances $i] ];
		
		node	$current_node	[expr $x0+$L_temp]		$y0;
		set pos [expr 1*$Xcanvas+$i+$N_sym];
		lset node_tags $pos $current_node;
		incr current_node;
		
		node	$current_node	[expr $x0+$L_temp]		[expr $y0+$h0_end-($L_temp-$L_sym)*$slope]	 -mass $massX $Negligible $Negligible;
		write_node_with_mass2D $current_node $massX $Negligible $Negligible;
		set pos [expr 0*$Xcanvas+$i+$N_sym];
		lset node_tags $pos $current_node;
		incr current_node;
		
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

	set total_nodes [expr $current_node-1];
	
###################################################################################################
#               ADD NODES												  
###################################################################################################

	write_region_nodes $Region_ID $Xcanvas $Ycanvas node_tags
	addNodes [expr $RegionNode_ID+1]	[expr $current_node-1];
	addExternalNodes [expr $RegionNode_ID+1]	[expr $current_node-1];
	
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

	for	{set j 0} {$j < [expr $Xcanvas-1] } {incr j} { 
				
		################################## BOTTOM BEAM ################################
		set node_i	[lindex $node_tags [expr $Xcanvas*1+$j]];
		set node_j [expr $node_i+$increment];
		
		set botSecPos [expr $j-($j/[llength $botSec])*(2*($j-[llength $botSec])+1)]
		if {[lindex $botSec $botSecPos]>0} {
			scan [lindex $botSec $botSecPos] %d sectionTag
			set sectionTag

			set A_h [get2DElasticA $sectionTag]
			set Es [get2DElasticE $sectionTag]
			set I_h [get2DElasticIz $sectionTag]
			
			incr current_ele;
			element elasticBeamColumn	$current_ele  	$node_i  $node_j   $A_h $Es $I_h $Ln_beam;
			write_element $current_ele $node_i  $node_j;
		}

		################################## TOP BRACE ################################
		incr node_i;
		incr node_j;
		
		set topSecPos [expr $j-($j/[llength $topSec])*(2*($j-[llength $topSec])+1)]
		if {[lindex $topSec $topSecPos]>0} {
			scan [lindex $topSec $topSecPos] %d sectionTag
			set sectionTag

			set A_h [get2DElasticA $sectionTag]
			set Es [get2DElasticE $sectionTag]
			set I_h [get2DElasticIz $sectionTag]
			
			incr current_ele;
			element elasticBeamColumn	$current_ele  	$node_i  $node_j   $A_h $Es $I_h $Ln_beam;
			write_element $current_ele $node_i  $node_j;
		}
	}
	addElements "Beams"	[expr $Reg_Ele_ID+$BEAM*$Ele_ID+1]	[expr $current_ele];


#############################################
#         Generate Vertical Bracing         #
	
	set current_ele		[expr $Reg_Ele_ID+$BR_ver*$Ele_ID];

	set topNodes ""
	set botNodes ""
	
	set node_scanner 0;
	for {set i 0} {$i<[llength $lengths_sym]} {incr i} {
		
		if { [lindex $ver_sym $node_scanner] == [lindex $lengths_sym $i]} {
			lappend botNodes [lindex $node_tags [expr 1*$Xcanvas+$i]]
			lappend topNodes [lindex $node_tags [expr 0*$Xcanvas+$i]]
			incr node_scanner;
		}

		if {$node_scanner > [llength $ver_sym]} {
			break;
		}
	}
	set topEndNode [lindex $node_tags [expr 0*$Xcanvas+($i/2)*2]]
	set botEndNode [lindex $node_tags [expr 1*$Xcanvas+($i/2)*2]]

	for {set i [expr [llength $ver_sym]-1]} {$i>=0} {set i [expr $i-1]} {

		set bot_temp [lindex $botNodes $i]
		lappend botNodes [expr $bot_temp+2*($botEndNode-$bot_temp)]

		set top_temp [lindex $topNodes $i]		
		lappend topNodes [expr $top_temp+2*($topEndNode-$top_temp)]
	}
	

	for {set i 0} {$i<[llength $topNodes]} {incr i} {
	
		set node_i [lindex $botNodes $i]
		set node_j [lindex $topNodes $i]
		
		set pos [expr $i-($i/[llength $ver_sym])*(2*($i-[llength $ver_sym])+1)]

		if {[lindex $verSec $pos]  > 0 } {
			scan [lindex $verSec $pos]  %d sectionTag
			set sectionTag

			set A_v [get2DElasticA $sectionTag]
			set E_v [get2DElasticE $sectionTag]
			set Iz_v [get2DElasticIz $sectionTag]	
			
			###############################			
			########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg		
			#	4	3	2
			#	5		1
			#	6	7	8

			##### LEFT INTERNAL NODE ######
			set internal_nodeI [expr $node_i*$InternalNode_ID+3];
			set x_i [expr [nodeCoord $node_i 1]];
			set y_i [expr [nodeCoord $node_i 2]];	
			
			node	[expr $internal_nodeI]		$x_i	$y_i
			###############################
			
			##### RIGHT INTERNAL NODE #####
			set internal_nodeJ [expr $node_j*$InternalNode_ID+7];
			set x_j [expr [nodeCoord $node_j 1]];
			set y_j [expr [nodeCoord $node_j 2]];
									
			node	[expr $internal_nodeJ]		$x_j	$y_j
			###############################
			
			##################################
			######## ELASTIC ELEMENT #########
			incr current_ele;
			element elasticBeamColumn	$current_ele  	$internal_nodeI  $internal_nodeJ  $A_v $E_v $Iz_v \
																							  $Ln_beam;
			write_element $current_ele $internal_nodeI $internal_nodeJ;
			##################################
			
			equalDOF $node_i $internal_nodeI 1 2
			equalDOF $node_j $internal_nodeJ 1 2
		}
				
	
	
	}
	

	
	#set Tot_ver_br	$current_ele;
	addElements "Ver Bracing"	[expr $Reg_Ele_ID+$BR_ver*$Ele_ID+1]	[expr $current_ele];

#############################################
#         Generate Diagonal Bracing         #
	set current_ele		[expr $Reg_Ele_ID+$BR_diag*$Ele_ID];

	set topNodes ""
	set botNodes ""
	
	set node_scanner 0;
	for {set i 0} {$i<[llength $lengths_sym]} {incr i} {
		
		if { [lindex $diag_sym $node_scanner] == [lindex $lengths_sym $i]} {
			lappend botNodes [lindex $node_tags [expr 1*$Xcanvas+$i]]
			lappend topNodes [lindex $node_tags [expr 0*$Xcanvas+$i]]
			incr node_scanner;
		}

		if {$node_scanner > [llength $diag_sym]} {
			break;
		}
	}

	set topEndNode [lindex $node_tags [expr 0*$Xcanvas+($i/2)*2]]
	set botEndNode [lindex $node_tags [expr 1*$Xcanvas+($i/2)*2]]
	for {set i [expr [llength $diag_sym]-1]} {$i>=0} {set i [expr $i-1]} {

		set bot_temp [lindex $botNodes $i]
		lappend botNodes [expr $bot_temp+2*($botEndNode-$bot_temp)]

		set top_temp [lindex $topNodes $i]		
		lappend topNodes [expr $top_temp+2*($topEndNode-$top_temp)]
	}

	for {set i 0} { $i < [expr [llength $botNodes] -1] } {incr i} {
		
		if {$i< [expr [llength $botNodes]/2-1] } {
			set node_i [lindex $botNodes $i];
			set node_j [lindex $topNodes [expr $i+1]];
		} elseif {$i > [expr [llength $botNodes]/2-1]} {
			set node_i [lindex $botNodes [expr $i+1]]
			set node_j [lindex $topNodes [expr $i]];	
		} else {
			continue;
		}

		set pos [expr $i-($i/[llength $diag_sym])*(2*($i+1-[llength $diag_sym])+0)]
		if {[lindex $diagSec $pos]  > 0 } {
			scan [lindex $diagSec $pos]  %d sectionTag
			set sectionTag
		
			set A_d [get2DElasticA $sectionTag]
			set E_d [get2DElasticE $sectionTag]
			set Iz_d [get2DElasticIz $sectionTag]	
			
			###############################			
			########### 1 = 0deg	2 = 45deg	3 = 90deg	4 = 135deg	5 = 180deg	6 =	225deg	7 = 270deg	 8 = 315deg		
			#	4	3	2
			#	5		1
			#	6	7	8

			##### LEFT INTERNAL NODE ######
			set internal_nodeI [expr $node_i*$InternalNode_ID+2];
			set x_i [expr [nodeCoord $node_i 1]];
			set y_i [expr [nodeCoord $node_i 2]];	
			
			node	[expr $internal_nodeI]		$x_i	$y_i
			###############################
			
			##### RIGHT INTERNAL NODE #####
			set internal_nodeJ [expr $node_j*$InternalNode_ID+6];
			set x_j [expr [nodeCoord $node_j 1]];
			set y_j [expr [nodeCoord $node_j 2]];
									
			node	[expr $internal_nodeJ]		$x_j	$y_j
			###############################
			
			##################################
			######## ELASTIC ELEMENT #########
			incr current_ele;
			element elasticBeamColumn	$current_ele  	$internal_nodeI  $internal_nodeJ  $A_d $E_d $Iz_d \
																							  $Ln_beam;
			write_element $current_ele $internal_nodeI $internal_nodeJ;
			##################################
			
			equalDOF $node_i $internal_nodeI 1 2
			equalDOF $node_j $internal_nodeJ 1 2
		}

	}


	
	
	#set Tot_beam	$current_ele;
	addElements "Diag Bracing"	[expr $Reg_Ele_ID+$BR_diag*$Ele_ID+1]	[expr $current_ele];

	

CloseRegion;

}