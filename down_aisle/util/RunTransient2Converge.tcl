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