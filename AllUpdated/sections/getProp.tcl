proc RunAnalysis {{GravSteps 10}} {
  puts "Analysis...."
  system UmfPack
  constraints Transformation
  test NormDispIncr 1.0e-8 20 0
  algorithm Newton 
  numberer RCM
  integrator LoadControl [expr 1./$GravSteps] 1 [expr 1./$GravSteps] [expr 1./$GravSteps] 
  analysis Static
  #initialize;

  # run gravity analysis
  set ok [analyze $GravSteps]
  # keep gravity load and restart time -- lead to lateral-load analysis


  if {$ok!=0} {
    # this should be extremely rare!!!
    puts "Analysis Failed!"
  }
  return $ok
}



proc getProp {sectionTag E {type "fiber"} {length 1.0} {P 1.0} {nIntPt 3} {maxIters 20} {tolIter 1.e-8} {slopeTol 1e-3} } {
	
	################# Test for A #################
	
	node 1 0.0 0.0
	node 2 0.0 $length

	
	
	if {$type=="fiber"} {
		element nonlinearBeamColumn   1  	1  2 $nIntPt  $sectionTag  0 -iter $maxIters $tolIter
			
	}
	
	fix 1 1 1 1
	

	
	puts "Testing section with tag $sectionTag for A"
	
	set dispName "forA.txt"
	
	recorder Node -file $dispName -time -node 2 -dof 2 disp;
	
	
	pattern Plain 200 Linear {			
		 load 2 0.0 $P 0.0
	}
	
	
	RunAnalysis 10
	
	remove recorders
	
	set disps {}
	set forces {}
	fforeach a "$dispName" {
		lappend forces [lindex $a 0]
		lappend disps [lindex $a 1]
	}
	set Tot [llength $disps];
	set slopes {}
	for {set i 1} {$i<$Tot} {incr i} {
		set dy [expr [lindex $forces $i] - [lindex $forces [expr $i-1]]]
		set dx [expr [lindex $disps $i] - [lindex $disps [expr $i-1]]]
		lappend slopes [expr $dy/$dx]
	}
	
	
	

	
	for {set i 1} {$i<[expr $Tot-1]} {incr i} {
		if {[expr 1-[abs [expr [lindex $slopes $i]/[lindex $slopes [expr $i-1]]]]] > $slopeTol} {
			error_clean "ERROR: in calculating A. [expr 1-[abs [expr [lindex $slopes $i]/[lindex $slopes [expr $i-1]]]]] > $slopeTol"
		}
	}
	
	set lastDisp [lindex $disps [expr $Tot-1]]
	
	
	set A [expr $P*$length/($E*$lastDisp)];
	
	puts "A = [expr $A*10000] e-4"
	
	
	################# Test for I #################

	
	puts "Testing section with tag $sectionTag for I"
	
	set dispName "forI.txt"
	
	recorder Node -file $dispName -time -node 2 -dof 1 disp;
	
	
	pattern Plain 201 Linear {			
		 load 2 $P 0.0 0.0
	}
	
	
	RunAnalysis 10
	
	remove recorders
	
	set disps {}
	set forces {}
	fforeach a "$dispName" {
		lappend forces [lindex $a 0]
		lappend disps [lindex $a 1]
	}
	set Tot [llength $disps];
	set slopes {}
	for {set i 1} {$i<$Tot} {incr i} {
		set dy [expr [lindex $forces $i] - [lindex $forces [expr $i-1]]]
		set dx [expr [lindex $disps $i] - [lindex $disps [expr $i-1]]]
		lappend slopes [expr $dy/$dx]
	}
	
	
	

	
	for {set i 1} {$i<[expr $Tot-1]} {incr i} {
		if {[expr 1-[abs [expr [lindex $slopes $i]/[lindex $slopes [expr $i-1]]]]] > $slopeTol} {
			error_clean "ERROR: in calculating I. [expr 1-[abs [expr [lindex $slopes $i]/[lindex $slopes [expr $i-1]]]]] > $slopeTol"
		}
	}
	
	set lastDisp [lindex $disps [expr $Tot-1]]
	
	
	set I [expr $P*$length*$length*$length/($E*$lastDisp)];
	
	puts "I = [expr $A*10000] e-4"
	
	wipeAnalysis
}

