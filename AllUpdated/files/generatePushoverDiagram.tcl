proc generatePushoverDiagram { disFName vFName {filename "pushoverDiagram.txt"} } {


	file delete $filename;
	
	set fileID_write [open $filename "w"];
	
	set disp {};
	set force {};
	
	fforeach a $disFName {
		lappend disp [lindex $a end];
	}
	
	
	fforeach a $vFName {
		set f 0;
		foreach b $a {
			set f [expr $f+$b];
		}
		lappend force [abs $f];
	}
	

	
	
	set N [llength $disp];
	for {set i 0} {$i<$N} {incr i} {
		puts  -nonewline $fileID_write "[lindex $disp $i]	[lindex $force $i]\n";
	}
	
	close $fileID_write ;
}


proc traceYield {{filename "pushoverDiagram.txt"} {tol 0.3} } {

	set disp {};
	set force {};
	
	
	
	fforeach a $filename {
		lappend disp [lindex $a 0];
		lappend force [lindex $a 1];
	}
	
	set N [llength $disp];
	
	set slope {};
	
	lappend slope [expr [lindex $force 0]/[lindex $disp 0] ];
	
	for {set i 1} {$i<$N} {incr i} {
		set yvalue [expr [lindex $force $i]-[lindex $force [expr $i-1]]];
		set xvalue [expr [lindex $disp $i]-[lindex $disp [expr $i-1]]];
		
		lappend slope [expr $yvalue/$xvalue];
	}
	
	
	set Ns [llength $slope];
	
	puts "============== Tracing Yield Point ==============";
	puts "Checking method: (S(i+1_-S(i))/S(i) < $tol";
	for {set i 1} {$i<$Ns} {incr i} {
		set check [abs [expr ([lindex $slope $i]-[lindex $slope [expr $i-1]])	/	[lindex $slope [expr $i-1]]	] ];
	
		if { $check > $tol} {
			puts "Detected possible Yield Point!";
			puts "At step [expr $i]\nSlope at this step: [lindex $slope [expr $i-1]]\nSlope at next step: [lindex $slope $i]";
			puts "Vbase = [expr [lindex $force [expr $i-1]]/1000 ] kN";
			puts "=================================================\n"
			return $i;
			
		}
	}
	
	puts "Algorithm didn't found any possible Yield Point.\nPlease check the Pushover output or modify accepted tolerance!";
	puts "=================================================\n"
	return 0;

}



proc traceYieldInit {{filename "pushoverDiagram.txt"} {tol 0.25} } {

	set disp {};
	set force {};
	
	
	
	fforeach a $filename {
		lappend disp [lindex $a 0];
		lappend force [lindex $a 1];
	}
	
	set N [llength $disp];
	
	set slope {};
	
	lappend slope [expr [lindex $force 0]/[lindex $disp 0] ];
	
	for {set i 1} {$i<$N} {incr i} {
		set yvalue [expr [lindex $force $i]-[lindex $force [expr $i-1]]];
		set xvalue [expr [lindex $disp $i]-[lindex $disp [expr $i-1]]];
		
		lappend slope [expr $yvalue/$xvalue];
	}
	
	
	set Ns [llength $slope];
	set s0 [lindex $slope 0];
	
	puts "============== Tracing Yield Point ==============";
	puts "Checking method: (s(i)-s(0))/s(0) < $tol";
	for {set i 1} {$i<$Ns} {incr i} {
		set check [abs [expr ([lindex $slope $i]-$s0)	/	$s0]];
	
		if { $check > $tol} {
			puts "Detected possible Yield Point!";
			puts "At step [expr $i]\nSlope at this step: [lindex $slope [expr $i-1]]\nSlope at step 0: $s0";
			puts "Vbase = [expr [lindex $force [expr $i-1]]/1000 ] kN";
			puts "=================================================\n"
			return $i;
			
		}
	}
	
	puts "Algorithm didn't found any possible Yield Point.\nPlease check the Pushover output or modify accepted tolerance!";
	puts "=================================================\n"
	return 0;

}

proc addReactions { listOfFiles filename  } {

	
	set Nfiles [llength $listOfFiles];
	set Vbase {};
	fforeach l [lindex $listOfFiles 0] {
		lappend Vbase $l;
	}
	
	for {set i 1} { $i < $Nfiles} {incr i} {
		set cnt 0;
		fforeach l [lindex $listOfFiles $i] {
			set Vbase [lreplace $Vbase $cnt $cnt [expr [lindex $Vbase $cnt] + $l]];
			incr cnt;
		}
	}
	
	
	file delete $filename;
	
	set fileID_write [open $filename "w"];
	
	for {set i 0} {$i<[llength $Vbase]} {incr i} {
		puts  $fileID_write "[lindex $Vbase $i]";
	}
	
	close $fileID_write ;
}



















