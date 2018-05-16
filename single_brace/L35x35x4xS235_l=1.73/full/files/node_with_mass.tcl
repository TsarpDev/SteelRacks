
###################################################################################################
#          							Node Mass											  
###################################################################################################


namespace eval ::node_with_mass {
	addNamespace	[namespace current];
	
	set filename "node_with_mass.txt";
	file delete $filename;
	
	set fileID_write [open $filename "w"];
	
	proc close_write {} {
		upvar #0 ::node_with_mass::fileID_write id;
		if {"[file channels $id]" ne ""} {
			close $id;
		}
	}
	
}



proc write_node_with_mass { node_ID massX massY Ixy} {
	
	upvar #0 ::node_with_mass::fileID_write ID;
	
	if {"[file channels $ID]" == ""} {
		upvar #0 ::node_with_mass::filename fn;
		set ID [open $fn "w"];
	}
	
	puts  -nonewline $ID "$node_ID $massX $massY $Ixy\n";

}