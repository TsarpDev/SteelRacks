proc lineY_nodes {Region_ID X_coord {Negligible 1e-3} } {
	set bound [getBoundaryNode $Region_ID];
	set start [lindex $bound 0];
	set end [lindex $bound 1];
	
	set lineY {};
	
	for {set i $start} {$i<=$end} {incr i} {
	
		set x_i [expr [nodeCoord $i 1]];
		if {[abs [expr $x_i-$X_coord] ] <= $Negligible } {
			lappend lineY $i;
		}
	
	}
	if {$lineY ne ""} {
		return $lineY;
	} else {
		error_clean "Region $Region_ID does not have nodes with X_coord=$X_coord";
	}

}



proc SPO_x_eigen {Region_ID X_coord Fx_top {Negligible 1e-3} } {

	set nodes [lineY_nodes $Region_ID $X_coord];
	
	set eigenvec1 {}
	
	foreach a $nodes {
		lappend eigenvec1 [expr [nodeEigenvector $a 1 1]];
	}
	
	set norm_eigenvec1 {}
	foreach e $eigenvec1 {
		lappend norm_eigenvec1 $e;
	}
	
	set cnt 0;
	foreach a $nodes {
		load $a [expr [lindex $norm_eigenvec1 $cnt]*$Fx_top] 0.0 0.0;
		incr cnt;
	}
	
	
}


