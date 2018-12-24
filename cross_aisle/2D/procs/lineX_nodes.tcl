proc lineX_nodes {Region_ID Y_coord {Negligible 1e-3} } {
	set bound [getBoundaryNode $Region_ID];
	set start [lindex $bound 0];
	set end [lindex $bound 1];
	
	set lineX {};

	
	for {set i $start} {$i<=$end} {incr i} {
	
		set y_i [expr [nodeCoord $i 2]];
		if {[abs [expr $y_i-$Y_coord] ] <= $Negligible } {
			lappend lineX $i;
		}
	}
	
	if {$lineX ne ""} {
		return $lineX;
	} else {
		error_clean "ERROR: Region $Region_ID does not have nodes with Y_coord=$Y_coord";
	}

}


proc lineX_forces {Region_ID Y_coord Fx {Negligible 1e-3} } {

	kill_if_2D "ERROR: lineX_forces is only for 3D analysis. Change analysis type.";

	set nodes [lineX_nodes $Region_ID $Y_coord $Negligible];
	
	foreach a $nodes {
		load $a $Fx 0.0 0.0 0.0 0.0 0.0;
	}
	
}

proc lineX_forces2D {Region_ID Y_coord Fx {Negligible 1e-3} } {

	kill_if_3D "ERROR: lineX_forces2D is only for 2D analysis. Change analysis type.";

	set nodes [lineX_nodes $Region_ID $Y_coord $Negligible];
	
	foreach a $nodes {
		load $a $Fx 0.0 0.0;
	}
	
}

#proc lineX_rollers {Region_ID Y_coord {Negligible 1e-3} } {
#	set nodes [lineX_nodes $Region_ID $Y_coord $Negligible];
	
#	foreach a $nodes {
#		fix $a 0 1 0;
#	}
#}



proc lineX_delete {Region_ID Y_coord type {Negligible 1e-3} } {

	set nodes [lineX_nodes $Region_ID $Y_coord $Negligible];
	
	set pos [getRegionPosition $Region_ID];	
	upvar #0 ::region::start_ele s_ele;
	upvar #0 ::region::end_ele e_ele;
	set sub_start [lindex $s_ele $pos];
	set sub_end [lindex $e_ele $pos];
	
	set N [llength [lindex $sub_start 0]];
	
	set flag 0;
	for {set j 0} {$j<$N} {incr j} {
		set typ [lindex [lindex $sub_start 0] $j];
		if { $typ == $type} {
			incr flag;
			break;
			
		}
	}
	
	if {!$flag} {
		error_clean "Element type $type in Region $Region_ID does not exist";
	}
	
	
	set startEle [lindex [lindex $sub_start 1] $j];
	set endEle [lindex [lindex $sub_end 1] $j];
	
	
	
	puts "Removing elements in Region $Region_ID...";
	fforeach a $::element_connectivity::filename {
		
		set ele_tag [lindex $a 0];
		
		if { $ele_tag >= $startEle && $ele_tag <= $endEle } {
			set ele_i [lindex $a 1];
			set ele_j [lindex $a 2];
			
			
			
			foreach n $nodes {
				if {$ele_i == $n || $ele_j == $n} {
					puts "removing element $ele_tag";
					remove element $ele_tag;
					addRemovedElement $Region_ID $ele_tag;
					break;
				}
			}
		}
	}
	puts "done removing elements!\n";

}

