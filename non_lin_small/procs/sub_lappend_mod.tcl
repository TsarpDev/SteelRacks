proc sub_lappend_mod {listname idx args} {
    upvar 1 $listname l;
	
	
	
	
	if {[lindex $l $idx] == ""} {

	
		lappend l {};
	}
	
	
	
    set subl [lindex $l $idx];
    lappend subl {*}$args;
    lset l $idx $subl;
}