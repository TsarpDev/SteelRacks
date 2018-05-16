wipe all

source files/fforeach.tcl

model BasicBuilder -ndm 2 - ndf 3 

set analysisType "compression";

set length 1.732772345;
	



if {$analysisType == "compression"} {
	set stress {}
	set strain {}
	fforeach a "fittedC.txt" {
		lappend strain  [expr -[lindex $a 0]/$length]
		lappend stress [expr -[lindex $a 1]]
	}
	
	set e0 0.0
	set s0 0.0
	
	set e1 [lindex $strain 0]
	set s1 [lindex $stress 0]
	
	set e2 [lindex $strain 1]
	set s2 [lindex $stress 1]
	
	set e3 [lindex $strain 2]
	set s3 [lindex $stress 2]
	
	set e4 [lindex $strain 3]
	set s4 [lindex $stress 3]
	
	puts $strain
	puts $stress
	
	
	uniaxialMaterial ElasticMultiLinear 1 -strain $e4 $e3 $e2 $e1 $e0  -stress $s4 $s3 $s2 $s1 $s0 
	
}


source single_truss.tcl
