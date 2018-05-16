proc convert_massX {} {
	fforeach a $::node_with_mass::filename {
		set tag [lindex $a 0];
		set massX [lindex $a 1];
		set forceY [expr -1*[conv_mass_to_force $massX] ];
		load $tag 0.0 $forceY 0.0;
	
	}
}