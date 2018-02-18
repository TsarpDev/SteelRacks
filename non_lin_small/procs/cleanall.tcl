proc cleanall {} {
	
	
	
	upvar #0 ::spaces::namespaces names;
	
	
	::element_connectivity::close_write;

	::node_with_mass::close_write;

	::removed_elements::close_write;

	
	
	foreach a $names {
			namespace delete $a;
	}
	
	
	wipe all;
	
}

proc error_clean {{message ERROR}}  {
	
	
	set caller "";
	
	set calls [lindex [info level] 0];
	
	for {set i 1} {$i<$calls} {incr i} {
		append caller "::[lindex [info level $i] 0]";
	}
	
	
	puts "$message";
	if {$caller ne ""} { 
		puts "Path$caller";
	} else {
		puts "Path::Level 0";
	}
	
	cleanall;
	error {};
	
}