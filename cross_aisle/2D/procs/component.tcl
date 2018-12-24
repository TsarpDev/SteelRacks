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
#          TRANSFORMATIONS												  
###################################################################################################
	
	set LinearTransf_FRAME 0;
	set PDeltaTransf_COL 1;
	set LinearTransf_CONN 2;
	set LinearTransf_COL 3
	set CorotTransf 4;

if { $Analysis == "3D" } {	
	geomTransf Linear $LinearTransf_CONN 1 0 0;
	geomTransf Linear $LinearTransf_FRAME 0 0 1;
	geomTransf PDelta $PDeltaTransf_COL 0 0 1; 
	geomTransf Linear $LinearTransf_COL 0 0 1; 
	geomTransf Corotational  $CorotTransf 0 0 1;
} elseif { $Analysis == "2D" }	{
	geomTransf Linear $LinearTransf_FRAME;
	geomTransf PDelta $PDeltaTransf_COL; 
	geomTransf Corotational  $CorotTransf;
} else {
	puts "OVERKILL! analysis must be 3D or 2D. You gave $analysis";
}
	
###################################################################################################
#          CHECK												  
###################################################################################################
proc kill_if_3D { {message "ERROR: Model is 3D!"}	} {
	upvar #0 Analysis an;
	
	if { $an == "3D"} {
		error_clean $message
	}
}


proc kill_if_2D { {message "ERROR: Model is 2D!"}	} {
	upvar #0 Analysis an;
	
	if { $an == "2D"} {
		error_clean $message
	}
}
	
	
###################################################################################################
#          REGIONS													  
###################################################################################################

file delete -force -- Region_Output
file mkdir Region_Output
	
namespace eval ::region {

	set ID_g {};
	set Name_g {};
	set start_node {};
	set end_node {};
	set start_ele {		};
	set end_ele {		};
	
	set start_EXT_node {};
	set end_EXT_node {};
	
	set matTags {};
	set matProperties {};
	
	set elasticTags {};
	set elasticProperties {};
	
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

proc getRegionTotalNodes {RegionID} {
	set bottom [lindex [getBoundaryNode $Region_ID] 0];
	set top	   [lindex [getBoundaryNode $Region_ID] 1];
	return [expr $top-$bottom+1]
}

proc addNodes { start_n end_n } {

	upvar #0 ::region::start_node s_list;
	lappend s_list $start_n;
	
	
	upvar #0 ::region::end_node e_list;
	lappend e_list $end_n;
	
}

proc addExternalNodes {start_e end_e} {
	upvar #0 ::region::start_EXT_node s_list;
	lappend s_list $start_e;
	
	upvar #0 ::region::end_EXT_node e_list;
	lappend e_list $end_e;
	

}

proc getNode {Region_ID X Y Z {Negligible 1e-4}} {
	set bottom [lindex [getBoundaryNode $Region_ID] 0];
	set top	   [lindex [getBoundaryNode $Region_ID] 1];
	
	kill_if_2D "ERROR: getNode is only for 3D analysis. Change analysis type.";
	
	for {set i $bottom} {$i<=$top} {incr i} {
		set cnt 0;
		set x_i [expr [nodeCoord $i 1]];
		
		set y_i [expr [nodeCoord $i 2]];
		
		set z_i [expr [nodeCoord $i 3]];
		
		if {[abs [expr $x_i-$X] ] <= $Negligible } {
			incr cnt;
		}
		
		if {[abs [expr $y_i-$Y] ] <= $Negligible } {
			incr cnt;
		}
		
		if {[abs [expr $z_i-$Z] ] <= $Negligible } {
			incr cnt;
		}
		
		if { $cnt == 3} {
			return $i;
		}
		
	}
	puts "WARNING: From getNode, there is no node in region $Region_ID with X=$X, Y=$Y and Z=$Z.\n Please check again or modify the default tolerance (1e-4)";
	
}


proc getXY_Node {Region_ID X Y {Negligible 1e-4}} {
	set bottom [lindex [getBoundaryNode $Region_ID] 0];
	set top	   [lindex [getBoundaryNode $Region_ID] 1];
	
	kill_if_3D "ERROR: getXY_Node is only for 2D analysis. Change analysis type.";
	
	#### USE WITH CAUTION!
	
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
	#puts "WARNING: From getXY_Node, there is no node in region $Region_ID with X=$X and Y=$Y.\n Please check again or modify the default tolerance (1e-4)";
	return 0;
}

proc getZcoord {Region_ID X Y  {Negligible 1e-4}} {
	set bottom [lindex [getBoundaryNode $Region_ID] 0];
	set top	   [lindex [getBoundaryNode $Region_ID] 1];
	#### USE WITH CAUTION!
	
	kill_if_2D "ERROR: getZcoord is only for 3D analysis. Change analysis type.";
	
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
			return [expr [nodeCoord $i 3]];
		}
		
	}
	puts "WARNING: From getZcoord, there is no node in region $Region_ID with X=$X and Y=$Y .\n Please check again or modify the default tolerance (1e-4)";
	
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


###################################################################################################
#          ELASTIC SECTIONS											  
###################################################################################################


proc addElasticSection { secID} {
	upvar #0 ::region::elasticTags tags;
	foreach t $tags {
		if {$t == $secID} {
			return 0;
		}
	}
	lappend tags $secID;
	return $secID;
}

proc getElasticSectionPos {secTag} {
	upvar #0 ::region::elasticTags tags;
	for {set i 0} {$i<[llength $tags]} {incr i} {
		if { [lindex $tags $i] == $secTag } {
			return $i;
		}
	}
	error_clean "ERROR: Elastic section with tag $secTag does not exist";
}


proc addElasticSectionProperties {secTag E G A Iy Iz J} {

	kill_if_2D "ERROR: addElasticSectionProperties is only for 3D analysis. Change analysis type.";

	set i [getElasticSectionPos $secTag];
	if {$i ne -1} {
		upvar #0 ::region::elasticProperties elasticProp;
		sub_lappend_mod elasticProp $i $secTag $E $G $A $Iy $Iz $J;
	}	else {
		error_clean "Elastic section with tag $secTag does not exist";
	}
	

}

proc printElasticSections {} {
	upvar #0 ::region::elasticProperties elasticProp;
	
	kill_if_2D "ERROR: printElasticSections is only for 3D analysis. Change analysis type.";
	
	puts "==================== Printing Elastic Sections ====================";
	foreach s $elasticProp {
		set secTag [lindex $s 0]
		puts "-------Section: $secTag";
		puts "E = [getElasticE $secTag]"
		puts "G = [getElasticG $secTag]"
		puts "A = [getElasticA $secTag]"
		puts "Iy = [getElasticIy $secTag]"
		puts "Iz = [getElasticIz $secTag]"
		puts "J = [getElasticJ $secTag]"
		puts "-------\n";
		
	}
	puts "============================================================\n";
	
}

proc getElasticE {secTag} {
	kill_if_2D "ERROR: getElasticE is only for 3D analysis. Change analysis type.";
	upvar #0 ::region::elasticProperties elasticProp;
	return [lindex [lindex $elasticProp [getElasticSectionPos $secTag] ] 1];
}

proc getElasticG {secTag} {
	kill_if_2D "ERROR: getElasticG is only for 3D analysis. Change analysis type.";
	upvar #0 ::region::elasticProperties elasticProp;
	return [lindex [lindex $elasticProp [getElasticSectionPos $secTag] ] 2];
}

proc getElasticA {secTag} {
	kill_if_2D "ERROR: getElasticA is only for 3D analysis. Change analysis type.";
	upvar #0 ::region::elasticProperties elasticProp;
	return [lindex [lindex $elasticProp [getElasticSectionPos $secTag] ] 3];
}

proc getElasticIy {secTag} {
	kill_if_2D "ERROR: getElasticIy is only for 3D analysis. Change analysis type.";
	upvar #0 ::region::elasticProperties elasticProp;
	return [lindex [lindex $elasticProp [getElasticSectionPos $secTag] ] 4];
}

proc getElasticIz {secTag} {
	kill_if_2D "ERROR: getElasticIz is only for 3D analysis. Change analysis type.";
	upvar #0 ::region::elasticProperties elasticProp;
	return [lindex [lindex $elasticProp [getElasticSectionPos $secTag] ] 5];
}

proc getElasticJ {secTag} {
	kill_if_2D "ERROR: getElasticJ is only for 3D analysis. Change analysis type.";
	upvar #0 ::region::elasticProperties elasticProp;
	return [lindex [lindex $elasticProp [getElasticSectionPos $secTag] ] 6];
}


###################################################################################################
#          2D SECTIONS									  
###################################################################################################


proc add2DElasticSectionProperties {secTag E A Iz} {

	kill_if_3D "ERROR: add2DElasticSectionProperties is only for 2D analysis. Change analysis type.";

	set i [getElasticSectionPos $secTag];
	if {$i ne -1} {
		upvar #0 ::region::elasticProperties elasticProp;
		sub_lappend_mod elasticProp $i $secTag $E $A $Iz;
	}	else {
		error_clean "Elastic section with tag $secTag does not exist";
	}
	

}

proc print2DElasticSections {} {

	kill_if_3D "ERROR: print2DElasticSections is only for 2D analysis. Change analysis type.";
	
	upvar #0 ::region::elasticProperties elasticProp;
	
	puts "==================== Printing Elastic Sections ====================";
	foreach s $elasticProp {
		set secTag [lindex $s 0]
		puts "-------Section: $secTag";
		puts "E = [get2DElasticE $secTag]"
		puts "A = [get2DElasticA $secTag]"
		puts "Iz = [get2DElasticIz $secTag]"
		puts "-------\n";
		
	}
	puts "============================================================\n";
	
}

proc get2DElasticE {secTag} {
	kill_if_3D "ERROR: get2DElasticE is only for 2D analysis. Change analysis type.";
	upvar #0 ::region::elasticProperties elasticProp;
	return [lindex [lindex $elasticProp [getElasticSectionPos $secTag] ] 1];
}


proc get2DElasticA {secTag} {
	kill_if_3D "ERROR: get2DElasticA is only for 2D analysis. Change analysis type.";
	upvar #0 ::region::elasticProperties elasticProp;
	return [lindex [lindex $elasticProp [getElasticSectionPos $secTag] ] 2];
}


proc get2DElasticIz {secTag} {
	kill_if_3D "ERROR: get2DElasticIz is only for 2D analysis. Change analysis type.";
	upvar #0 ::region::elasticProperties elasticProp;
	return [lindex [lindex $elasticProp [getElasticSectionPos $secTag] ] 3];
}

