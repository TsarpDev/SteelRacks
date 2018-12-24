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



proc SPO_x_eigen {Region_ID X_coord Fx_top modeNum  {Negligible 1e-3} } {

	kill_if_2D "ERROR: SPO_x_eigen is only for 3D analysis. Change analysis type.";

	puts "=============================================================="
	puts "Applying Static Pushover Load Pattern in Region $Region_ID..."
	
	set nodes [lineY_nodes $Region_ID $X_coord];
	
	set eigenvec1 {}
	
	foreach a $nodes {
		lappend eigenvec1 [expr [nodeEigenvector $a $modeNum 1]];
	}
	
	puts "~~~ Printing eigenvector $modeNum ~~~"
	foreach e $eigenvec1 {
		puts $e
	}
	puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	
	puts "CAUTION!! For Region $Region_ID, did you check that mode $modeNum is the dominant mode in direction 1? \n Yes (Y), No (N)"
	gets stdin ans
	while { $ans ne "Y" && $ans ne "y" && $ans ne "N" && $ans ne "n"} {
		puts "Invalid answer. Yes (Y), No (N)";
		gets stdin ans
	}
	
	if {$ans ne "Y" && $ans ne "y"} {
		error_clean "Then check again!"
	}
	
	set cnt 0;
	foreach a $nodes {
		load $a [expr [lindex $eigenvec1 $cnt]*$Fx_top] 0.0 0.0 0.0 0.0 0.0;
		incr cnt;
	}
	puts "=============================================================="
	
}


proc SPO_x_eigen2D {Region_ID X_coord Fx_top modeNum  {Negligible 1e-3} } {

	kill_if_3D "ERROR: SPO_x_eigen2D is only for 2D analysis. Change analysis type.";

	puts "=============================================================="
	puts "Applying Static Pushover Load Pattern in Region $Region_ID..."
	
	set nodes [lineY_nodes $Region_ID $X_coord];
	
	set eigenvec1 {}
	
	foreach a $nodes {
		lappend eigenvec1 [expr [nodeEigenvector $a $modeNum 1]];
	}
	
	
	set cnt 0;
	foreach a $nodes {
		load $a [expr [lindex $eigenvec1 $cnt]*$Fx_top] 0.0 0.0;
		incr cnt;
	}
	puts "=============================================================="
	
}


proc SPO_x_uniform {Region_ID X_coord Fx {Negligible 1e-3} } {

	kill_if_2D "ERROR: SPO_x_uniform is only for 3D analysis. Change analysis type.";
	
	set nodes [lineY_nodes $Region_ID $X_coord];
	
	foreach a $nodes {
		load $a $Fx 0.0 0.0 0.0 0.0 0.0;

	}
	
}

proc SPO_x_uniform2D {Region_ID X_coord Fx {Negligible 1e-3} } {

	kill_if_3D "ERROR: SPO_x_uniform2D is only for 2D analysis. Change analysis type.";
	
	set nodes [lineY_nodes $Region_ID $X_coord];
	
	foreach a $nodes {
		load $a $Fx 0.0 0.0 ;

	}
	
}



proc SPO_x_triangular {Region_ID X_coord Fx_top {Negligible 1e-3} } {

	kill_if_2D "ERROR: SPO_x_triangular is only for 3D analysis. Change analysis type.";

	set nodes [lineY_nodes $Region_ID $X_coord];
	
	set Htop [nodeCoord [lindex $nodes end] 2]
	
	foreach a $nodes {
		set Htmp [nodeCoord $a 2]
		load $a [expr $Fx_top*$Htmp/$Htop] 0.0 0.0 0.0 0.0 0.0;

	}
	
}

proc SPO_x_triangular2D {Region_ID X_coord Fx_top {Negligible 1e-3} } {

	kill_if_3D "ERROR: SPO_x_triangular2D is only for 2D analysis. Change analysis type.";

	set nodes [lineY_nodes $Region_ID $X_coord];
	
	set Htop [nodeCoord [lindex $nodes end] 2]
	
	foreach a $nodes {
		set Htmp [nodeCoord $a 2]
		load $a [expr $Fx_top*$Htmp/$Htop] 0.0 0.0;

	}
	
}

