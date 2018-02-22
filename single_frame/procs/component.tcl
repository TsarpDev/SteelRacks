###################################################################################################
#          NAMESPACES												  
###################################################################################################


namespace eval ::spaces {
	set namespaces {};
}

proc addNamespace added_space {

	upvar #0 ::spaces::namespaces tmp_Name;
	
	lappend tmp_Name $added_space;
}


###################################################################################################
#          REGIONS													  
###################################################################################################

namespace eval ::region {
	set ID_g {};
	set Name_g {};
	set start_node {};
	set end_node {};
	set start_ele {		};
	set end_ele {		};
	
	set matTags {};
	set matProperties {};
	
	set removed_elements {};
	
	
	addNamespace	[namespace current];
	
	set merged_regions { };
	
	
	set start_sub_list { {} {} };
	set end_sub_list { {} {} };
	
	
}


proc AddRegion { Region_ID	 } {
	upvar #0 ::region::ID_g ID;
	upvar #0 ::region::Name_g Name;
	
	
	set caller [lindex [info level -1] 0];
	foreach a $ID {
		if { $a == $Region_ID} {
			error_clean "ERROR: Region $Region_ID has already been defined";
		}
	}
	lappend ID $Region_ID;
	lappend Name $caller;
	
	
	upvar #0 ::region::start_sub_list l;
	set l {{} {}} ;
	upvar #0 ::region::end_sub_list e;
	set e {{} {}} ;
	
	upvar #0 ::region::removed_elements re;
	lappend re {}; 
	
}

proc PrintRegions {} {
	upvar #0 ::region::ID_g ID;
	upvar #0 ::region::Name_g Name;
	upvar #0 ::region::start_node start;
	upvar #0 ::region::end_node end;
	
	upvar #0 ::region::start_ele s_ele;
	upvar #0 ::region::end_ele e_ele;
	
	
	puts "================= Printing Regions =================";
			for {set i 0} {$i<[llength $ID]} {incr i} {
				puts "Region: [lindex $ID $i]    Type: [lindex $Name $i]"; 
				puts "From Node [lindex $start $i] To Node [lindex $end $i]"; 
				set sub_start [lindex $s_ele $i];
				set sub_end [lindex $e_ele $i];
				set N [llength [lindex $sub_start 0]];
				for {set j 0} {$j<$N} {incr j} {
						puts "Element Type: [lindex [lindex $sub_start 0] $j], From Element [lindex [lindex $sub_start 1] $j], To Element [lindex [lindex $sub_end 1] $j]";
				}
				
				puts "";puts "";
			}
	puts "====================================================\n";

}


proc CloseRegion {} {
	uplevel 1 {upvar #0 ::region::start_sub_list s_list; }
	uplevel 1 {lappend ::region::start_ele $s_list;}
	uplevel 1 {upvar #0 ::region::end_sub_list e_list;}
	uplevel 1 {lappend ::region::end_ele $e_list;}
	

}

proc getRegionPosition {Region_ID} {
	
	set pos 0;
	upvar #0 ::region::ID_g ID;
	foreach a $ID {
		if {$a==$Region_ID} {
			return $pos;
		}
		incr pos;
	}
	error_clean "ERROR: In getRegionPosition, Region $Region_ID does not exist";
}


proc add_merged_regions { Master_ID Slave_ID } {
	lappend ::region::merged_regions "$Master_ID $Slave_ID";
}


###################################################################################################
#          ELEMENTS													  
###################################################################################################

proc addElements { type start_ele end_ele } {

	upvar #0 ::region::start_sub_list s_list;
	sub_lappend s_list 0 $type;
	sub_lappend s_list 1 $start_ele;
	
	upvar #0 ::region::end_sub_list e_list;
	sub_lappend e_list 0 $type;
	sub_lappend e_list 1 $end_ele;
	
}

proc addRemovedElement { Region_ID ele_ID } {
	upvar #0 ::region::removed_elements _list;
	sub_lappend_mod _list [getRegionPosition $Region_ID] $ele_ID;
	
}


###################################################################################################
#          NODES											  
###################################################################################################

proc getBoundaryNode {Region_ID} {
	
	set pos [getRegionPosition $Region_ID];

	set start_n [lindex $::region::start_node $pos];
	set end_n [lindex $::region::end_node $pos];
	
	return "$start_n $end_n";

}

proc addNodes { start_n end_n } {

	upvar #0 ::region::start_node s_list;
	lappend s_list $start_n;
	
	
	upvar #0 ::region::end_node e_list;
	lappend e_list $end_n;
	
}

proc getNode {Region_ID X Y {Negligible 1e-4}} {
	set bottom [lindex [getBoundaryNode $Region_ID] 0];
	set top	   [lindex [getBoundaryNode $Region_ID] 1];
	
	
	for {set i $bottom} {$i<=$top} {incr i} {
		set cnt 0;
		set x_i [expr [nodeCoord $i 1]];
		
		set y_i [expr [nodeCoord $i 2]];
		
		if {[abs [expr $x_i-$X] ] <= $Negligible } {
			incr cnt;
		}
		
		if {[abs [expr $y_i-$Y] ] <= $Negligible } {
			incr cnt;
		}
		
		if { $cnt == 2} {
			return $i;
		}
		
	}
	puts "WARNING: From getNode, there is no node in region $Region_ID with X=$X and Y=$Y.\n Please check again or modify the default tolerance (1e-4)";
	
}

###################################################################################################
#          MATERIALS											  
###################################################################################################

proc addMaterial { matID} {
	upvar #0 ::region::matTags mats;
	foreach m $mats {
		if {$m==$matID} {
			return 0;
		}
	}
	lappend mats $matID;
	return $matID;
}

proc getMaterialID {matTag} {
	upvar #0 ::region::matTags mats;
	for {set i 0} {$i<[llength $mats]} {incr i} {
		if { [lindex $mats $i] == $matTag } {
			return $i;
		}
	}
	return -1;
}


proc addMatProperties {matTag matType nonLinProp E A NrdP NrdN} {
	set i [getMaterialID $matTag];
	if {$i ne -1} {
		upvar #0 ::region::matProperties matProp;
		sub_lappend_mod matProp $i $matTag $matType $nonLinProp $E $A $NrdP $NrdN;
	}	else {
		error_clean "Material with tag $matTag does not exist";
	}
	
	
}

proc printMaterials {} {
	upvar #0 ::region::matProperties matProp;
	
	puts "==================== Printing Materials ====================";
	foreach m $matProp {
		puts "-------Element:";
		foreach m_sub $m {
			puts "$m_sub";
		}
		puts "-------\n";
		
	}
	puts "============================================================\n";
	

}


