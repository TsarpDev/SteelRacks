proc_ref	x_column_NL_TRUSS	{ Region_ID   *masses *heights  x0  h0 *columns *beams *bracings    {big_x 0} {imp 200} {Node_ID 1000} {Ele_ID 1000}  {InternalNode_ID 1000  } {nIntPt 3} {maxIters 20} {tolIter 1.e-8} } {


###################################################################################################
#          INITIAL CALCULATIONS													  
###################################################################################################
	
AddRegion $Region_ID;


set N_box [expr [llength $heights]-1];	

if {$big_x == 0} {
	set N_col 2;
} else {
	set N_col 3;
}


#############################################
#         Initial Checks					#


	
	if { [expr ($N_box+1)*$N_col] >=$Node_ID } {
		error_clean "ERROR: Number of nodes at region $Region_ID is $Node_ID or greater.\nPlease modify function x_column. Suggested node numbering: 1001,1002..."; 
	}
	
	
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
	
	if {[llength $beams] ne [expr [llength $heights] - 2] } {
		error_clean "ERROR: In region $Region_ID. Length(heigths)-2 must be equal to Length(beams).\nYou gave Length(beams) = [llength $beams] and Length(heights) = [llength $heights]";
	}
	
	if {[llength $bracings] ne [expr [llength $heights] - 2] } {
		error_clean "ERROR: In region $Region_ID. Length(heigths)-2 must be equal to Length(bracings).\nYou gave Length(bracings) = [llength $bracings] and Length(heights) = [llength $heights]";
	}
	
	
	set Negligible 1e-9;	
	

	
###################################################################################################
#          NODE GENERATION													  
###################################################################################################

#	node numbering: A(000000)ij. A=Region_ID and ij is the number of the node. 
#	example:	523 = Node 23 in region 5. If Node_ID=1000 then 5023. 


#
#		1005|	1006|
#		1003|	1004|
#		1001|	1002|
#
	set current_node	1;
	
	set RegionNode_ID [expr $Region_ID*$Node_ID]; 	
	
	for {set i 0} {$i <= $N_box} {incr i} {

		set H_temp		[lindex $heights $i ];
		set mass_temp	[lindex $masses $i];
		
		for {set j 1} {$j <= $N_col} {incr j} {
			
			if { [lindex $masses $i] > 0 } {
				if { [expr $j%2] == 0 && $N_col == 3} {
					node	[expr $RegionNode_ID+$current_node]		[expr $x0+$h0*($j-1)]		$H_temp 	-mass [expr 2*$mass_temp] $Negligible $Negligible;
					write_node_with_mass [expr $RegionNode_ID+$current_node] [expr 2*$mass_temp] $Negligible $Negligible;
				} else {
					node	[expr $RegionNode_ID+$current_node]		[expr $x0+$h0*($j-1)]		$H_temp 	-mass $mass_temp $Negligible $Negligible;
					write_node_with_mass [expr $RegionNode_ID+$current_node] $mass_temp $Negligible $Negligible;
				}
			} else {
				node	[expr $RegionNode_ID+$current_node]		[expr $x0+$h0*($j-1)]		$H_temp;	
			}
			incr current_node;
		}
		
	}
	
	#addNodes [expr $Region_ID*$Node_ID+1]	[expr $RegionNode_ID+$current_node-1];
	

###################################################################################################
#          ELEMENT GENERATION													  
###################################################################################################

#	element numbering: RTijk. R=Region_ID,	T=type and ijk the number of the element. By default T=1 column, 2 bracing, 3 beam bracing.
#	example:	52090 = Bracing 90 in region 5. 
	set Reg_Ele_ID	[expr $Ele_ID*10*$Region_ID];
	set COL 1;
	set BR  2;
	set BEAM 3;
	
#############################################
#         Generate Columns					#
	set current_ele		[expr $Reg_Ele_ID+$COL*$Ele_ID];
	set increment [expr $N_col];
	
	for	{set j 1} {$j <= $N_col} {incr j} {
		set node_i	[expr $RegionNode_ID + $j]; 
		for {set i 1} {$i <= $N_box} {incr i} {
			set node_j [expr $node_i+$increment];
			incr current_ele;
			
			set sectionTag [lindex $columns [expr $i-1]]

			element nonlinearBeamColumn   $current_ele  	$node_i  $node_j $nIntPt  $sectionTag  1 -iter $maxIters $tolIter
			
			
			write_element $current_ele $node_i $node_j;
			
			set node_i $node_j;
		}
	}
	
	addElements "Columns"	[expr $Reg_Ele_ID+$COL*$Ele_ID+1]	[expr $current_ele];
	
	
#############################################
#         Generate Bracing                  #
	set current_ele		[expr $Reg_Ele_ID+$BR*$Ele_ID];
	set increment [expr $N_col];
	
	########### 1 = bot_left	  2 = bot_right	 3 = mid_right	4 = top_right	5 = top_left   6 = mid_left
	####	example 10013: in region 1, node 1001 mid_right

	
	
	if { $big_x == 0 } {
		for	{set j 1} {$j < $N_col} {incr j} {
			 
			
			for {set i 1} {$i < $N_box} {incr i} {		# now it starts from second box
			
				set node_i	[expr $RegionNode_ID + $j + $increment * $i];
				
				set sectionTag [lindex $bracings [expr $i-1]]
		
				
				
				############################### FIRST BRACE ##############################	[expr $node_i] [expr $node_j+1]
				
				set node_j [expr $node_i + $increment + 1];
				
				
				incr current_ele;
				element truss $current_ele $node_i $node_j 1 $sectionTag
				
				write_element $current_ele $node_i $node_j;

			
				############################### SECOND BRACE ##############################	[expr $node_i+1] [expr $node_j]
				
				
				
				incr node_i;
				
				set node_j [expr $node_j - 1]
				
	

				
				
				incr current_ele;
				element truss $current_ele $node_i $node_j 1 $sectionTag
				
				write_element $current_ele $node_i $node_j;


				

			}
		}
	}	else {
	
		if { [expr $N_col%2] == 0 } {
			error_clean "In region $Region_ID, Big X Columns need odd number of N_col. You had N_col=$N_col";
		}
		if { $N_box < 3} {
			error_clean "In region $Region_ID, Big X Columns must have N_box greater than 3. You had N_box=$N_box";
			return;
		}
		for	{set j 1} {$j < $N_col} {incr j} {
		
		
			set sectionTag [lindex $bracings 0]

			
			
			############################### FIRST BRACE ##############################	[expr $node_i] [expr $node_j+1]
			
			
			
			set node_i	[expr $RegionNode_ID + $j + $increment]; 
			
			set node_j [expr $node_i + $increment + 1];
	
			
			incr current_ele;
			element truss $current_ele $node_i $node_j 1 $sectionTag
				
			write_element $current_ele $node_i $node_j;

			
			############################### SECOND BRACE ##############################	[expr $node_i+1] [expr $node_j]
			
			

				
			incr node_i;
			set node_j [expr $node_j - 1];
				
			incr current_ele;
			element truss $current_ele $node_i $node_j 1 $sectionTag
				
			write_element $current_ele $node_i $node_j;

		
			
				
			
			
			############################### REST BRACES ##############################	
			if { [expr $j%2 == 0] } {
				set switch 1;
				incr node_j
			} else {
				set switch 0;
			
			}
			for {set i 3} {$i <= $N_box} {incr i} {
				
				set node_i $node_j;
			
				
				
				
				set sectionTag [lindex $bracings [expr $i-2]]

				
				incr current_ele;
				
				
				if {$switch ==0} {
				
					
					set node_j [expr $node_i+$increment + 1];
				
					
				
				
					incr current_ele;
					element truss $current_ele $node_i $node_j 1 $sectionTag
					
					write_element $current_ele $node_i $node_j;


		
					set switch 1;
					
				} else {
				
					set node_j [expr $node_i+$increment - 1];
				
					
				
				
					incr current_ele;
					element truss $current_ele $node_i $node_j 1 $sectionTag
					
					write_element $current_ele $node_i $node_j;


					
					
					
					set switch 0;
				}
					
			}
		}
	}
	#set Tot_br	$current_ele;
	
	addElements "X Bracing"	[expr $Reg_Ele_ID+$BR*$Ele_ID+1]	[expr $current_ele];
	


#############################################
#         Generate Beam Bracing             #



	set current_ele		[expr $Reg_Ele_ID+$BEAM*$Ele_ID];
	set increment [expr $N_col];
	
	for	{set j 1} {$j < $N_col} {incr j} {
	
		
		
		for {set i 1} {$i < $N_box} {incr i} {
		
			
			set sectionTag [lindex $beams [expr $i-1]]


			
			set node_i	[expr $RegionNode_ID + $j + $increment * $i];
			set node_j [expr $node_i + 1];
			
			incr current_ele;
			
			
			set internal_nodeI [expr $node_i*$InternalNode_ID+3];
			set x_i [expr [nodeCoord $node_i 1]];
			set y_i [expr [nodeCoord $node_i 2]];
								
			node	[expr $internal_nodeI]		$x_i	$y_i
				
			set internal_nodeJ [expr $node_j*$InternalNode_ID+6];
			set x_j [expr [nodeCoord $node_j 1]];
			set y_j [expr [nodeCoord $node_j 2]];
					
					
			node	[expr $internal_nodeJ]		$x_j	$y_j
			
			
			element nonlinearBeamColumn   $current_ele  	$internal_nodeI  $internal_nodeJ $nIntPt  $sectionTag  0 -iter $maxIters $tolIter
			#element elasticBeamColumn	$current_ele  	$internal_nodeI  $internal_nodeJ  $A_beam $Es $I_beam 0;
			
			write_element $current_ele $node_i  $node_j;
			
			
			equalDOF $node_i $internal_nodeI 1 2 
			equalDOF $node_j $internal_nodeJ 1 2 
		}
	}
	#set Tot_beam	$current_ele;
	addElements "Ver Bracing"	[expr $Reg_Ele_ID+$BEAM*$Ele_ID+1]	[expr $current_ele];
	
	
###################################################################################################
#               ADD NODES												  
###################################################################################################

addNodes [expr $Region_ID*$Node_ID+1]	[expr $RegionNode_ID+$current_node-1];
	
###################################################################################################
#               APPLY FIXITY												  
###################################################################################################
	set current_node 1;
	for {set i 1} {	$i<= $N_col} {incr i} {
		set current_node	[expr $RegionNode_ID + $i];
		#puts "applying pins in node $current_node";
		fix $current_node 1 1 0;
		incr current_node;
	}



	


CloseRegion;



}













