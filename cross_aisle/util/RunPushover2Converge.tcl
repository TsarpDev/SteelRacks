# ---------RunPushover2Converge.tcl----------------------------------------------------------------
# Changed into a procedure from Opensees Web-site. Slightly modified
# to stop analyzing if the loadfactor (pseudo-time) falls below zero.
# Also, it accepts an optional input, "dof" which defaults to 1. 
# this is the dof in the POSITIVE OR NEGATIVE direction of which we push.
#-----------------------------------------------------------------------------------------------
# Updated 01/Nov/2005: A new parameter has been added "AllowNegLoad" which is 
#           0 (or false) by default. When set to 1, it disables the checking for
#           negative loads and allows the execution of pushovers in the negative direction.
#           for the same reason I have changed the check 
#           "$controlDisp < $maxU" into "abs($controlDisp) < abs($maxU)"
#           This was also need to allow using procRCyDAns2.tcl, which
#           regularly uses RunPushover2Converge for displacement-control.
# Updated 09/Mar/2010: Added output of "ncerror.out" just like in the RunTransient2Converge.
#           This enables reliable execution of SPO2IDA runs just like IDA runs.

proc RunPushover2Converge {IDctrlNode DmaxPush Nsteps {dof 1} {AllowNegLoad 0}} {
  set ok [analyze $Nsteps]
  set loadf [getTime]
  # if analysis fails, try the following, performance is slowed inside this loop
  if {$ok != 0} {
    set ok 0;
    set maxU $DmaxPush
    set controlDisp 0.0;
    test NormDispIncr 1.0e-8 20 0
    while {abs($controlDisp) < abs($maxU) && $ok == 0 && ($loadf>0 || $AllowNegLoad!=0) } {
      set ok [analyze 1]
      
      if {$ok != 0} {
        puts "Trying Newton with Initial Tangent .."
        test NormDispIncr 1.0e-8 3000 0
        algorithm Newton -initial
        set ok [analyze 1]
        test NormDispIncr 1.0e-8 20 0
        algorithm Newton
      }
      if {$ok != 0} {
        puts "Trying Broyden .."
        algorithm Broyden 8
        set ok [analyze 1]
        algorithm Newton
      }
      if {$ok != 0} {
        puts "Trying NewtonWithLineSearch .."
        algorithm NewtonLineSearch .8
        set ok [analyze 1]
        algorithm Newton
      }
      if {$ok != 0} {
        puts "Trying Newton with Initial Tangent & relaxed convergence.."
        test NormDispIncr 1.0e-5 3000 0
        algorithm Newton -initial
        set ok [analyze 1]
        test NormDispIncr 1.0e-8 20 0
        algorithm Newton
      }
      set controlDisp [nodeDisp $IDctrlNode $dof]
      # recover actual load to check whether it is negative
      set loadf [getTime]
    }; # end while loop
  }; # end original if $ok!=0 loop

  set errorFileName "ncerror.out"
  # output success/failure results to a file
  if {$errorFileName!=""} {
    set errorFileID [open $errorFileName w]
    puts $errorFileID $ok
    close $errorFileID
  }

  if {$ok != 0} {
    puts "DispControl Analysis FAILED"
    #puts "Do you wish to continue y/n ?"; # include if want to pause at analysis failure
    #gets stdin ans; # not recommended in parameter study
    #if {$ans == "n"} done; # as it interrupts batch file
  } else {
    puts "DispControl Analysis SUCCESSFUL"
  }
  if {$loadf<=0 && $AllowNegLoad==0} {
    puts "Stopped because of Load factor below zero: $loadf"
  }
}