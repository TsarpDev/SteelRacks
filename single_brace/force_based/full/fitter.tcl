proc fitter {analysisType length {tensTol 0.5} } {
if {$analysisType == "compression"} {
		set dataDir Concentrated-Compression-Output;	# name of output folder

} elseif {$analysisType == "tension"} {
	set dataDir Concentrated-Tension-Output;	# name of output folder

}

set Nname "$dataDir/N.out"
set Dname "$dataDir/Disp.out"

source files/fforeach.tcl


set N {};
set d {};

if {$analysisType == "compression"} {
	fforeach a $Nname {
		lappend N [expr -$a]
	}
} elseif {$analysisType == "tension"} {
	fforeach a $Nname {
		lappend N [expr -$a]
	}
	
}

fforeach a $Dname {
		lappend d [expr $a/$length]
}


################## MAX FORCE ##################

	
if {$analysisType == "compression"} {
	set previousMax 0;
	set i 0;
	foreach el $N {
		if {$el>$previousMax} {
			set previousMax $el;
			set MaxPos $i;
		} else {
			break;
		}
		
		incr i;
	}
	
	set LastStep [expr [llength $N] - 1 ]
	
	
	
	set stress1 [lindex $N [expr $MaxPos/2]]
	set strain1 [lindex $d [expr $MaxPos/2]]
	
	set stress2 [lindex $N $MaxPos]
	set strain2 [lindex $d $MaxPos]
	
	set stress3 [lindex $N [expr ($LastStep-$MaxPos)/3 + $MaxPos] ]
	set strain3 [lindex $d [expr ($LastStep-$MaxPos)/3 + $MaxPos] ]
	
	set stress4 [lindex $N $LastStep]
	set strain4 [lindex $d $LastStep]
	
	
	set stress "$stress1 $stress2 $stress3 $stress4";
	
	set strain "$strain1 $strain2 $strain3 $strain4";
	
	
	set fileID_write [open "fittedC.txt" "w"];
	
	for {set i 0} {$i<[llength $strain]} {incr i} {
		puts   $fileID_write "[lindex $strain $i] [lindex $stress $i]";
	}
	
	close $fileID_write;
	
	puts "Fit in compression done!"

} elseif {$analysisType == "tension"} {

	set initSlope [expr [lindex $N 0]/[lindex $d 0]]
	
	set slopes {}
	for {set i 1} {$i<[llength $N]} {incr i} {
		set dy [expr [lindex $N [expr $i]] - [lindex $N [expr $i-1]]]
		set dx [expr [lindex $d [expr $i]] - [lindex $d [expr $i-1]]]
		
		lappend slopes [expr $dy/$dx]
	}
	

	
	for {set i 0} { $i<[llength $slopes] } {incr i} {
		
		if {[lindex $slopes $i] < [expr (1-$tensTol)*$initSlope]} {
			set yieldPos [expr $i+1]
			break;
		} 
		
	}
	
	
	set LastStep [expr [llength $N] - 1 ]
	
	
	
	set stress1 [lindex $N [expr $yieldPos/2]]
	set strain1 [lindex $d [expr $yieldPos/2]]
	
	set stress2 [lindex $N $yieldPos]
	set strain2 [lindex $d $yieldPos]
	
	set stress3 [lindex $N [expr ($LastStep-$yieldPos)/2 + $yieldPos] ]
	set strain3 [lindex $d [expr ($LastStep-$yieldPos)/2 + $yieldPos] ]
	
	set stress4 [lindex $N $LastStep]
	set strain4 [lindex $d $LastStep]
	
	
	set stress "$stress1 $stress2 $stress3 $stress4";
	
	set strain "$strain1 $strain2 $strain3 $strain4";
	
	
	set fileID_write [open "fittedT.txt" "w"];
	
	for {set i 0} {$i<[llength $strain]} {incr i} {
		puts   $fileID_write "[lindex $strain $i] [lindex $stress $i]";
	}
	
	close $fileID_write;
	
	puts "Fit in tension done! "

}
	


}