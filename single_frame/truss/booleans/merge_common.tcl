proc_ref merge_common {	Master_ID Slave_ID 	{ Negligible 1e-3 } } {
	
	
	set master_i [getRegionPosition $Master_ID];
	set slave_i  [getRegionPosition $Slave_ID];
	
	
	
#############################################
#            Some checking                  #
	
		
	if {$master_i == $slave_i} {
		error_clean "ERROR: Cannot merge Master Region $Master_ID with Slave Region $Slave_ID.";
	}
	
	
	
	
#############################################
#            Now merge                      #
	

	
	puts "---------------------------------------------";
	puts "Merging Regions $Master_ID and $Slave_ID...";
	
	
	
	set master_start [lindex [getBoundaryNode $Master_ID] 0];
	set master_end   [lindex [getBoundaryNode $Master_ID] 1];
	set slave_start  [lindex [getBoundaryNode $Slave_ID] 0];
	set slave_end    [lindex [getBoundaryNode $Slave_ID] 1];
	
	
	set found 0;
	set common {  };
	
	for {set i $master_start} {$i<= $master_end } {incr i} {
		set x_master [expr [nodeCoord $i 1]];
		set y_master [expr [nodeCoord $i 2]];
		for {set j $slave_start} {$j<= $slave_end} {incr j} {
			set x_slave [expr [nodeCoord $j 1]];
			set y_slave [expr [nodeCoord $j 2]];
			if { [abs [expr $x_master-$x_slave] ] <= $Negligible  &&  [abs [expr $y_master-$y_slave] ] <= $Negligible  } {
				incr found;
				lappend common  [list $i $j];

	
				#break;
			}
		}
	}
	
	
	if {$found==0} {
		error_clean "Region $Master_ID and $Slave_ID do not have common points";
	} else {
		puts "Found $found common points";
		#puts "$common";
	}
	
	foreach a $common {
		set m [lindex $a 0];
		set s [lindex $a 1];
		equalDOF $m $s 1 2 3;
		puts "Applying equalDof in nodes $m and $s";
	}

#############################################
#          delete common slave element      #
	
	
	
	## waste of time, it should loop only in region elements, should track
	foreach i_ex $common {
		set i [lindex $i_ex 1];
		foreach j_ex $common {
				set j [lindex $j_ex 1];
				fforeach a $::element_connectivity::filename {
					set cnt 0;
					set ele_i [lindex $a 1];
					set ele_j [lindex $a 2];
					if { $ele_i==$i } {
						incr cnt;
					}
					if { $ele_j==$j } {
						incr cnt;
					}
					if {$cnt==2} {
						puts "removing slave element [lindex $a 0]";
						remove element [lindex $a 0];
						addRemovedElement $Slave_ID [lindex $a 0];
						
					}
				}
			
		}
		
	}

	
	add_merged_regions $Master_ID $Slave_ID;
	
	puts "Done merging!";
	puts "---------------------------------------------";
}
