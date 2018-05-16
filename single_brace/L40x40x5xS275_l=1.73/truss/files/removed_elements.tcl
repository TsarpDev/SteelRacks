###################################################################################################
#          							Removed Elements 													  
###################################################################################################

namespace eval ::removed_elements {

	addNamespace	[namespace current];
	
	set filename "removed_elements.txt";
	file delete $filename;
	
	
	set fileID_write [open $filename "w"];
	
	proc close_write {} {
		
		upvar #0 ::removed_elements::fileID_write id;
		if {"[file channels $id]" ne ""} {
			close $id;
		}
	}
	
}



proc write_removed_elements { } {
	
	upvar #0 ::removed_elements::fileID_write ID;
	
	
	if {"[file channels $ID]" == ""} {
		upvar #0 ::removed_elements::filename fn;

		set ID [open $fn "w"];
	}
	
	
	upvar #0 ::region::removed_elements l_removed;
	foreach a $l_removed {
		puts  -nonewline $ID "$a\n";
	}
	

	removed_elements::close_write;
	

}