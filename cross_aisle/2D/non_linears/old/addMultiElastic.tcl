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
		
		
		
		#uniaxialMaterial ElasticMultiLinear $matTag -strain -0.02 -0.01 $d2 $d3 $d4 $d5 $d6 $d7 $d8 $d9 0.01 0.01 0.02\
		#											-stress	 -1.0 -1.0   $f2 $f3 $f4 $f5 $f6 $f7 $f8 $f9 $f9 1.0 1.0
		#uniaxialMaterial ElasticMultiLinear $matTag -strain -0.02 -0.01 $d2 $d3 $d4 $d5 $d6 $d7 $d8 0.01 0.01 0.02\
		#											-stress	-1.0  -1.0  $f2 $f3 $f4 $f5 $f6 $f7 $f8 $f8  1.0 1.0
													
		#uniaxialMaterial ElasticMultiLinear $matTag -strain -0.02 $d2 $d2 $d3 $d4 $d5 $d6 $d7 $d8 0.01 0.01 0.02\
		#											-stress	-1.0  -1.0  $f2 $f3 $f4 $f5 $f6 $f7 $f8 $f8  1.0 1.0
		
		#uniaxialMaterial ElasticMultiLinear $matTag -strain -0.01 $d3 $d3 $d4 $d5 $d6 $d7     $d8 0.01  0.01 0.02\
		#											      -stress -1.0 -1.0  $f3 $f4 $f5 $f6 $f7    $f8 $f8  1.0  1.0
		
		#uniaxialMaterial ElasticMultiLinear $matTag -strain -0.02 -0.01 $d3 $d4 $d5 $d6 $d7     $d8 0.01  0.01 0.02\
		#											      -stress -1.0 -1.0  $f3 $f4 $f5 $f6 $f7    $f8 $f8  1.0  1.0
		
		
		#uniaxialMaterial ElasticMultiLinear $matTag -strain $d0 $d1 $d2 $d3 $d4 $d5 $d6 $d7     $d8 0.05  0.05 0.1\
													      -stress $f0 $f1 $f2  $f3 $f4 $f5 $f6 $f7    $f8 $f8  1.0  1.0
		
		
		
		if 1 {
		uniaxialMaterial Pinching4 $matTag \
		     $f6 $d6 $f7 $d7 [expr $f7+ (5.0/100.0)*($f7-$f6)*(0.1-$d7)/($d7-$d6)] 0.1 [expr $f8*0.01] 0.1\
			 $f4 $d4 $f3 $d3 $f2 $d2 [expr -$f8*0.001] -0.1\
					0.3 0.6 0.0 \
		            0.3 0.6 0.0 \
					0.0 0.0 0.0 0.0 0.0 \
		            0.0 0.0 0.0 0.0 0.0 \
					0. 0. 0. 0. 0. \
		10. "energy" 
		}					
		
		
	} else {
		error_clean "ERROR: Only 11 point MultiLinearElastic material is available"
	}

}
