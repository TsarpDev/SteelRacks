proc addMultiElastic {matTag fname} {
	set strains {}
	set stressses {}
	fforeach a $fname {
		lappend strains [lindex $a 0];
		lappend stresses [lindex $a 1];
	}
	
	if { [llength $strains] == 11 } {
		puts "adding 11 point MultiLinear Elastic material..."
		
		for {set i 0} {$i<[llength $strains]} {incr i} {
			set "d$i" [lindex $strains $i]
		}
		
		for {set i 0} {$i<[llength $stresses]} {incr i} {
			set "f$i" [lindex $stresses $i]
		}
		
		uniaxialMaterial ElasticMultiLinear $matTag -strain $d0 $d1 $d2 $d3 $d4 $d5 $d6 $d7 $d8 $d9 $d10\
													-stress	$f0 $f1 $f2 $f3 $f4 $f5 $f6 $f7 $f8 $f9 $f10 
													
		
	} else {
		error_clean "ERROR: Only 11 point MultiLinearElastic material is available"
	}

}
