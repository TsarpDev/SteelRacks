# Simple template for a TCL file, openSEES oriented!
# ------------GetPeriodSetDamping.tcl---------------------------------------
#
# determine Natural Period, Frequency & damping parameters for MDOF system
#
# ksi  damping ratio (0.02-0.05-typical)
# EXAMPLE: 
#   Compute $Ndof modes and apply 5% damping at 1st and 3rd nodes of the bridge. 
#   GetPeriodSetDamping $Ndof 0.05 1 3 "G7BridgePeriods.out"
# NOTE: 
#   if Neigen is 0 then I will assume that the user has already calculated 
#   wi, wj and he is willing to supply the w1^2, w2^2 in the variables "i" and "j".
#   The order of wi,wj does not matter. They are sorted by the routine anyway!
#
#  Updated 29/Jul/05: Added the ability to directly supply the two lambdas needed when
#                    specifying Neigen=0.  
#  Updated 28/Nov/2006: Now it returns the period values to the calling procedure.
#  Updated 26/Feb/2007: Now it allows the designation of alternate eigensolvers!
#                       specifically the symmBandLapack. The only problem with this one 
#                       is that it is not fast, and you must have a non-singular mass matrix.
#                       Therefore, you need to specify a negligible mass in all dofs that would
#                       otherwise have zero mass. For 2D systems, replace
#                       "mass 231 1.0 0 0" with "mass 231 1.0 $sm $sm", where e.g., $sm=0.001. 

proc GetPeriodSetDamping {Neigen {ksi 0} {i 1} {j 2} {outfilename ""} {eigensolver 1}} {

if {$Neigen!=0} {
  if {$Neigen<$i} {set Neigen $i}
  if {$Neigen<$j} {set Neigen $j}
  # calculate the eigenvalues! Solve the generalized eigenvalue problem (other options: standard, frequency)
  # Generalized is the default by the way.
  if {$eigensolver==1} {
    # use BandArPack solver

    set lambda [eigen $Neigen]

  } else {
    # use symmBandLapack solver (undocumented feature, good for small systems mostly)
    puts "Using SymmBandLapack, all unrestrained dofs must have mass"
    set lambda [eigen "generalized" -symmBandLapack $Neigen]
  }
} else {
  puts "Damping set using EXTERNALLY supplied eigenvalues"
  # Sort the w2 from lower to higher!
  if {$i>$j} {
    set lambda "$j $i"
  } else {
    set lambda "$i $j"	
  }
  set Neigen 2
  set i 1
  set j 2
}

set pi [expr 2.*asin(1.0)];

for {set k 0} {$k<=$Neigen-1} {incr k} { 
  set lambdak [lindex $lambda $k]
  
  set omega($k) [expr pow($lambdak,0.5)]
  set T($k) [expr 2*$pi/$omega($k)]
 # puts "T[expr $k+1] = [expr 2*$pi/$omega($k)] sec"
}

# we will use mass and initial stiffness-proportional damping. According to Chopra's book (pg. 419)
# we have: alpha0=alphaM=ksi*(2*omegai*omegaj)/(omegai+omegaj)
#          betaKinit=ksi*2/(omegai+omegaj)
# usually I would set 2-5% damping on the 1st and 2nd or 3rd mode. 
# the rest modes will get higher damping than ksi and the modes between i and j will get 
# a bit less.
# The damping that is now associated with each mode-k is :
#        alphaM/(2.*omega($k)) + betaKinit * omega($k)/2


  if {$ksi>0} {
    # since omega-array starts from zero, reduce by one (so i=1--> first mode is omega(0))
    set i0 [expr $i-1]
    set j0 [expr $j-1]
    # stiffness-prop. RAYLEIGH damping parameter; D = alphaM*M
    set alphaM [expr $ksi*(2*$omega($i0)*$omega($j0))/($omega($i0)+$omega($j0))] 
    # tangent stiffness proportional damping; +beatK*KCurrent
    set betaK 0 
    # last commited stiffness RAYLEIGH damping parameter; +betaKcomm*KlastCommitt
    set betaKcomm 0 
    # initial-stiffness proportional damping +beatKinit*Kini
    set betaKinit [expr $ksi*2/($omega($i0)+$omega($j0))] 
    rayleigh $alphaM $betaK $betaKinit $betaKcomm
    for {set k 0} {$k<=$Neigen-1} {incr k} { 
      set dampk [expr $alphaM/(2.*$omega($k)) + $betaKinit * $omega($k)/2.]
      puts "T[expr $k+1] = $T($k) sec, ksi=$dampk"
      }
  } else {
    for {set k 0} {$k<=$Neigen-1} {incr k} { 
      puts "T[expr $k+1] = $T($k) sec, no damping assigned"
    }
  }
  if {$outfilename!=""} {
    set outfile [open $outfilename "w"]
    for {set k 0} {$k<=$Neigen-1} {incr k} {
       puts $outfile $T($k)
    }
    close $outfile
  }
  # create a list with all the periods
  foreach name [lsort [array names T]] {
    lappend Tlist $T($name) 
  }
  return $Tlist
}