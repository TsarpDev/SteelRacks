proc_ref	x_columnMassTop	{ Region_ID  Es  A_col  I_col  A_br  A_beam  TrussMatID  Geom_TransID  massX  {N_col 2} {N_box 20}  {h0 1}  {a 1}  {x0 0}  {y0 0}  *Special_Boxes  {big_x 0} {Node_ID 1000} {Ele_ID 1000}   } {


###################################################################################################
#          INITIAL CALCULATIONS													  
###################################################################################################
	
AddRegion $Region_ID;




#############################################
#         Initial Checks					#
	if { $N_col <=0 || $N_box <=0} {
		error_clean "ERROR: In region $Region_ID, number of columns and boxes must be greater than zero!";
	}
	
	if { [expr ($N_box+1)*$N_col] >=$Node_ID } {
		error_clean "ERROR: Number of nodes at region $Region_ID is $Node_ID or greater.\nPlease modify function x_column. Suggested node numbering: 1001,1002..."; 
	}
	
	
	set Negligible 1e-9;	
	set N_special [llength [lindex $Special_Boxes 0]];
	set Htot	[expr ($N_box-$N_special)*$a] ;	
	for {set j 0} {$j < $N_special} {incr j} {
		set Htot [expr $Htot + [lindex $Special_Boxes 1 $j] ];
	}

	
###################################################################################################
#          NODE GENERATION													  
###################################################################################################

#	node numbering: A(000000)ij. A=Region_ID and ij is the number of the node. 
#	example:	523 = Node 23 in region 5. If Node_ID=1000 then 5023. 
	set H_temp	0;
	set current_node	1;
	for {set i 1} {$i <= $N_box} {incr i} {
		#checking if it is a special box
		set ladder		$a;
		for {set j 0} {$j < $N_special} {incr j} {
				if {  [lindex $Special_Boxes 0 $j] == $i } {
					set ladder [lindex $Special_Boxes 1 $j];
					break;
				}
		}
		set H_temp [expr $H_temp+$ladder];
		if {$i==1} {
			for {set j 1} {$j <= $N_col} {incr j} {
				# command:  node nodeID xcoord ycoord -mass mass_dof1 mass_dof2 mass_dof3
				
				node	[expr $Region_ID*$Node_ID+$current_node]		[expr $x0+$h0*($j-1)]		$y0; 
				incr current_node;
			}
		} 
		for {set j 1} {$j <= $N_col} {incr j} {
			
			if {$i == $N_box} {	
				node	[expr $Region_ID*$Node_ID+$current_node]		[expr $x0+$h0*($j-1)]		[expr $y0+$H_temp]  -mass $massX $Negligible $Negligible;
			} else {
				node	[expr $Region_ID*$Node_ID+$current_node]		[expr $x0+$h0*($j-1)]		[expr $y0+$H_temp]	-mass $massX $Negligible $Negligible;
				write_node_with_mass [expr $Region_ID*$Node_ID+$current_node] $massX $Negligible $Negligible;
			}
			incr current_node;
		}
	}
	
	
	addNodes [expr $Region_ID*$Node_ID+1]	[expr $Region_ID*$Node_ID+$current_node-1];
	

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
		set node_i	[expr $Region_ID*$Node_ID + $j]; 
		for {set i 1} {$i <= $N_box} {incr i} {
			set node_j [expr $node_i+$increment];
			incr current_ele;
			element elasticBeamColumn	$current_ele  	$node_i  $node_j  $A_col $Es $I_col $Geom_TransID;
			
			write_element $current_ele $node_i $node_j;
			
			set node_i $node_j;
		}
	}
	#set Tot_col	$current_ele;
	
	addElements "Columns"	[expr $Reg_Ele_ID+$COL*$Ele_ID+1]	[expr $current_ele];
	
#############################################
#         Generate Bracing                  #
	set current_ele		[expr $Reg_Ele_ID+$BR*$Ele_ID];
	set increment [expr $N_col];

	if { $big_x == 0 } {
		for	{set j 1} {$j < $N_col} {incr j} {
			set node_i	[expr $Region_ID*$Node_ID + $j]; 
			for {set i 1} {$i <= $N_box} {incr i} {
				set node_j [expr $node_i+$increment];
				incr current_ele;
				element truss $current_ele [expr $node_i] [expr $node_j+1] $A_br $TrussMatID;
				
				write_element $current_ele [expr $node_i] [expr $node_j+1];
				
				incr current_ele;
				element truss $current_ele [expr $node_i+1] [expr $node_j] $A_br $TrussMatID;
				
				write_element $current_ele [expr $node_i+1] [expr $node_j];
				
				set node_i $node_j;
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
			set node_i	[expr $Region_ID*$Node_ID + $j]; 
			
				set node_j [expr $node_i+$increment];
				incr current_ele;
				element truss $current_ele [expr $node_i] [expr $node_j+1] $A_br $TrussMatID;
				
				write_element $current_ele [expr $node_i] [expr $node_j+1];
				
				incr current_ele;
				element truss $current_ele [expr $node_i+1] [expr $node_j] $A_br $TrussMatID;
				
				write_element $current_ele [expr $node_i+1] [expr $node_j];
				
				set node_i $node_j;
			
			if { [expr $j%2 == 0] } {
				set switch 1;
			} else {
				set switch 0;
			}
			for {set i 2} {$i <= $N_box} {incr i} {
				set node_j [expr $node_i+$increment];
				incr current_ele;
				if {$switch ==0} {
					element truss $current_ele [expr $node_i] [expr $node_j+1] $A_br $TrussMatID;
					
					write_element $current_ele [expr $node_i] [expr $node_j+1];
					
					set switch 1;
				} else {
					element truss $current_ele [expr $node_i+1] [expr $node_j] $A_br $TrussMatID;
					
					write_element $current_ele [expr $node_i+1] [expr $node_j];
					
					set switch 0;
				}
					set node_i $node_j;
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
		set node_j	[expr $Region_ID*$Node_ID + $j]; 
		for {set i 1} {$i <= $N_box} {incr i} {
			set node_j [expr $node_j+$increment];
			incr current_ele;
			element truss	$current_ele  	$node_j  [expr $node_j+1]  $A_beam $TrussMatID;
			
			write_element $current_ele $node_j  [expr $node_j+1];
		}
	}
	#set Tot_beam	$current_ele;
	addElements "Ver Bracing"	[expr $Reg_Ele_ID+$BEAM*$Ele_ID+1]	[expr $current_ele];
	

###################################################################################################
#               APPLY FIXITY												  
###################################################################################################
	set current_node 1;
	for {set i 1} {	$i<= $N_col} {incr i} {
		set current_node	[expr $Region_ID*$Node_ID+$i];
		#puts "applying pins in node $current_node";
		fix $current_node 1 1 0;
		incr current_node;
	}



	


CloseRegion;



}





