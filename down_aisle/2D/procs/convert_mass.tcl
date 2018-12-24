proc convert_massX {} {
	kill_if_2D "ERROR: convert_massX is only for 3D analysis. Change analysis type.";
	fforeach a $::node_with_mass::filename {
		set tag [lindex $a 0];
		set massX [lindex $a 1];
		set forceY [expr -1*[conv_mass_to_force $massX] ];
		load $tag 0.0 $forceY 0.0 0.0 0.0 0.0;
	
	}
}

proc convert_massX2D {} {
	kill_if_3D "ERROR: convert_massX2D is only for 2D analysis. Change analysis type.";
	fforeach a $::node_with_mass::filename {
		set tag [lindex $a 0];
		set massX [lindex $a 1];
		set forceY [expr -1*[conv_mass_to_force $massX] ];
		load $tag 0.0 $forceY 0.0;
	
	}
}