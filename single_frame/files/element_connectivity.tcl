###################################################################################################
#          							Element Connectivity													  
###################################################################################################

namespace eval ::element_connectivity {
	addNamespace	[namespace current];
	
	set filename "element_connectivity.txt";
	file delete $filename;
	
	
	set fileID_write [open $filename "w"];
	
	proc close_write {} {
		upvar #0 ::element_connectivity::fileID_write id;
		if {"[file channels $id]" ne ""} {
			close $id;
		}
	}
	
}

proc end_of_element_definitions {} {
	::element_connectivity::close_write;
	::node_with_mass::close_write;
}


proc write_element { ele_ID node_i node_j} {
	
	upvar #0 ::element_connectivity::fileID_write ID;
	
	
	
	if {"[file channels $ID]" == ""} {
		upvar #0 ::element_connectivity::filename fn;

		set ID [open $fn "w"];
	}
	
	puts  -nonewline $ID "$ele_ID $node_i $node_j\n";


}



proc write_element_CHECK { ele_ID node_i node_j} {
	
	upvar #0 ::element_connectivity::fileID_write ID;
	
	fforeach a $::element_connectivity::filename {
			set cnt 0;
			set ele_i [lindex $a 1];
			set ele_j [lindex $a 2];
			if { $ele_i==$node_i } {
			incr cnt;
			}
			if { $ele_j==$node_j } {
			incr cnt;
		}
		if {$cnt==2} {
				puts "WARNING!!! Element with nodes $node_i , $node_j already exists!!!"
						
		} 
	}
	
	
	
	if {"[file channels $ID]" == ""} {
		upvar #0 ::element_connectivity::filename fn;

		set ID [open $fn "w"];
	}
	
	puts  -nonewline $ID "$ele_ID $node_i $node_j\n";


}
