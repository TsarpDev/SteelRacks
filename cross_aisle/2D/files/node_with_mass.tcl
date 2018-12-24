
###################################################################################################
#          							Node Mass											  
###################################################################################################


namespace eval ::node_with_mass {
	addNamespace	[namespace current];
	
	set filename "Region_Output/node_with_mass.txt";
	file delete $filename;
	
	set fileID_write [open $filename "w"];
	
	proc close_write {} {
		upvar #0 ::node_with_mass::fileID_write id;
		if {"[file channels $id]" ne ""} {
			close $id;
		}
	}
	
}



proc write_node_with_mass { node_ID massX massY massZ Ix Iy Iz} {

	kill_if_2D "ERROR: write_node_with_mass is only for 3D analysis. Change analysis type.";
	
	upvar #0 ::node_with_mass::fileID_write ID;
	
	if {"[file channels $ID]" == ""} {
		upvar #0 ::node_with_mass::filename fn;
		set ID [open $fn "w"];
	}
	
	puts  -nonewline $ID "$node_ID $massX $massY $massZ $Ix $Iy $Iz\n";

}


proc write_node_with_mass2D { node_ID massX massY Iz} {

	kill_if_3D "ERROR: write_node_with_mass2D is only for 2D analysis. Change analysis type.";
	
	upvar #0 ::node_with_mass::fileID_write ID;
	
	if {"[file channels $ID]" == ""} {
		upvar #0 ::node_with_mass::filename fn;
		set ID [open $fn "w"];
	}
	
	puts  -nonewline $ID "$node_ID $massX $massY $Iz\n";

}