

proc RunPushover2Converge {IDctrlDOF maxU dU {dof 1}} {

set t0 [clock clicks -millisec]


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
	
	puts stderr "[expr {([clock clicks -millisec]-$t0)/1000.}] sec" ;# RS
}


# ---------RunTransient2Converge.tcl----------------------------------------------------------------
#  Based on RunPushover2Converge.tcl, it tries everything possible to run
#  the transient analysis and make it converge! It will return the "ok" value
# (0 if analysis is successful) and will also write this "ok" to a file 
# whose name is provided (unless the filename is empty).
proc RunTransient2Converge {Nsteps dt {errorFileName "ncerror.out"}} {
  set ok 0
  set tFinal [expr $Nsteps*$dt]
  set tCurrent 0
  test NormDispIncr 1.0e-8 20 0
  #--------------------------------------------
  # Run analysis
  while { $ok == 0 && $tCurrent<$tFinal} {
     set ok [analyze 1 $dt]
	 
	 
	 puts "Dynamic. tCurrent=$tCurrent / $tFinal"
	 
     if {$ok != 0} {
        puts "Trying ModifiedNewton with Initial Tangent .."
        test NormDispIncr 1.0e-8 2000 0
        algorithm ModifiedNewton -initial
        set ok [analyze 1 $dt]
        test NormDispIncr 1.0e-8 20 0
        if {$ok != 0} {
           puts "Trying Broyden .."
           algorithm Broyden 8
           set ok [analyze 1 $dt]
           if {$ok != 0} {
              puts "Trying NewtonWithLineSearch .."
              algorithm NewtonLineSearch .8
              set ok [analyze 1 $dt]
            } ; # end if
        } ; # end if
     algorithm Newton
     } ; # end if
    set tCurrent [getTime] 
  }; # end while loop
  #-----------------------------------------
  # output success/failure results to a file
  if {$errorFileName!=""} {
    set errorFileID [open $errorFileName w]
    puts $errorFileID $ok
    close $errorFileID
  }
  #-----------------------------------------
  # output success/failure result to screen
  if {$ok != 0} {
    puts "Transient Analysis FAILED"
    #puts "Do you wish to continue y/n ?"; # include if want to pause at analysis failure
    #gets stdin ans; # not recommended in parameter study
    #if {$ans == "n"} done; # as it interrupts batch file  
  } else {
    puts "Transient Analysis SUCCESSFUL"
  }

  return $ok
}


