# Simple template for a TCL file, openSEES oriented!
# ---------RunGravityAnalysis.tcl----------------------------------------------------------------
# Will simply run a basic Gravity (Load Control) Analysis with all the load patterns defined up to this time
# This routine should work for practically anything
#
proc RunGravityAnalysis {{GravSteps 10}} {
  
# Gravity-analysis: load-controlled static analysis
	set Tol 1.0e-6;							# convergence tolerance for test
	constraints Transformation
	numberer RCM;							# renumber dof's to minimize band-width (optimization)
	system BandGeneral;						# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	test NormDispIncr $Tol 6;				# determine if convergence has been achieved at the end of an iteration step
	algorithm Newton;						# use Newton's solution algorithm: updates tangent stiffness at every iteration
	set NstepGravity 10;					# apply gravity in 10 steps
	set DGravity [expr 1.0/$NstepGravity];	# load increment
	integrator LoadControl $DGravity;		# determine the next time step for an analysis
	analysis Static;						# define type of analysis: static or transient
	
  puts "Applying gravity loads..."
  # run gravity analysis
  set ok [analyze $GravSteps]
  # keep gravity load and restart time -- lead to lateral-load analysis
  loadConst -time 0.0

  if {$ok!=0} {
    # this should be extremely rare!!!
    error_clean "Gravity Analysis Failed!"
  }
  puts "Gravity loads applied successfully!";
  return $ok
}