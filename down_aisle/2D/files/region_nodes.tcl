###################################################################################################
#          							Region Nodes 													  
###################################################################################################

namespace eval ::region_nodes {

	addNamespace	[namespace current];
	
	set filename "Region_Output/Region_nodes";
	
	file delete -force -- $filename;

	file mkdir $filename
	
	set fileID_write ""
	
	proc close_write {} {
		
		upvar #0 ::region_nodes::fileID_write id;
		if {"[file channels $id]" ne ""} {
			close $id;
		}
	}
	
}

proc get_region_nodes_FILENAME {Region_ID} {

	upvar #0 ::region_nodes::filename fname;
	
	if [file exists "$fname/Reg$Region_ID.txt"] {
		return "$fname/Reg$Region_ID.txt"
	} else {
		error_clean "ERROR. File $fname/Reg$Region_ID.txt does not exist"
	}
}


proc_ref write_region_nodes { Region_ID Xcanvas Ycanvas *node_tags } {
	
	upvar #0 ::region_nodes::filename fname;
	
	upvar #0 ::region_nodes::fileID_write fileID;
	
	set fileID [open "$fname/Reg$Region_ID.txt" "w"];
	
	
	for {set i 0} {$i<$Ycanvas} {incr i} {
		for {set j 0} {$j<$Xcanvas} {incr j} {
			set pos [expr $i*$Xcanvas+$j]
			puts  -nonewline $fileID "[lindex $node_tags $pos]\t";
		}
		puts $fileID "\n"
	}

	::region_nodes::close_write

}

