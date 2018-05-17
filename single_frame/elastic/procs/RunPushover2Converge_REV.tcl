

proc RunPushover2Converge {IDctrlDOF maxU dU {dof 1}} {
    set tol 1.0e-8
test EnergyIncr $tol 100 1 
system UmfPack
constraints Transformation
algorithm KrylovNewton 
numberer RCM

integrator DisplacementControl $IDctrlDOF $dof $dU 1 $dU $dU 
analysis Static 
 
set ok 0; 
set controlDisp 0.0; 
    while {$controlDisp < $maxU && $ok == 0} {    
	    
   	   set ok [analyze 1]; 
 
   	   set controlDisp [nodeDisp $IDctrlDOF $dof]; 
 
puts "Pushover. Control Disp=[nodeDisp $IDctrlDOF $dof]"

   	   if {$ok != 0} { 
   	      puts " Newton failed .. Trying Newton with Initial Tangent .." 
		  test EnergyIncr $tol   100   1 
		  algorithm Newton -initial 
		  set ok [analyze 1] 
		  test EnergyIncr $tol   100      1 
		  algorithm KrylovNewton  
		  if {$ok == 0} {puts " that worked .. "} 
			puts "Pushover. Control Disp=[nodeDisp $IDctrlDOF $dof]"

		} 
	 
   	   if {$ok != 0} { 
		  puts " that failed .. Trying NewtonWithLineSearch .." 
		  algorithm NewtonLineSearch .8 
		  set ok [analyze 1] 
		  algorithm KrylovNewton 
		  if {$ok == 0} {puts " that worked .. "} 
			puts "Pushover. Control Disp=[nodeDisp $IDctrlDOF $dof]"
		   
		} 
	 
   	   if {$ok != 0} { 
		  puts " that failed .. Lets cut the step-size by a factor of 10 .." 
		  set dUt [expr $dU * 10.0] 
		  integrator DisplacementControl $IDctrlDOF $dof $dUt 1 $dUt $dUt 
		  set ok [analyze 1] 
		  integrator DisplacementControl $IDctrlDOF $dof $dU 1 $dU $dU 
		  if {$ok == 0} {puts " that worked .. "} 
			puts "Pushover. Control Disp=[nodeDisp $IDctrlDOF $dof]"
   	   } 
	 
   	   if {$ok != 0} { 
		  puts " that failed .. smaller step-size with initial tangent .." 
		  set dUt [expr $dU / 10.0] 
		  integrator DisplacementControl $IDctrlDOF $dof $dUt 1 $dUt $dUt 
		  algorithm KrylovNewton 
		  set ok [analyze 1] 
		  integrator DisplacementControl $IDctrlDOF $dof $dU 1 $dU $dU 
		  algorithm KrylovNewton 
		  if {$ok == 0} {puts " that worked .. "} 
			puts "Pushover. Control Disp=[nodeDisp $IDctrlDOF $dof]"

   	   } 
 
   	   if {$ok != 0} { 
		  puts " that failed .. smaller step-size with line search .." 
		  set dUt [expr $dU / 10.0] 
		  integrator DisplacementControl $IDctrlDOF $dof $dUt 1 $dUt $dUt 
		  algorithm NewtonLineSearch .8 
		  set ok [analyze 1] 
		  integrator DisplacementControl $IDctrlDOF $dof $dU 1 $dU $dU 
		  algorithm KrylovNewton 
		  if {$ok == 0} {puts " that worked .. "} 
			puts "Pushover. Control Disp=[nodeDisp $IDctrlDOF $dof]"

   	   } 
   	} 
}


