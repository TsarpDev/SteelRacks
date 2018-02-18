proc_ref timoCanti_x_column_arb { forceDist P Region_ID filename  Es  A_col  I_col  A_br  A_beam   Geom_TransID  massX  {N_col 2} *heights  {h0 1} {x0 0}    {big_x 0} {Node_ID 1000} {Ele_ID 1000}   } {


	set TrussMatID $Region_ID;		# define a material ID
	
	uniaxialMaterial Elastic $TrussMatID $Es;		# define truss material
	
	set fname "TimoshenkoEquivs";
	
	static [file mkdir $fname]; 						# create output folder
		
	x_column_arb	$Region_ID  $Es  $A_col  $I_col  $A_br  $A_beam  $TrussMatID  $Geom_TransID  $massX  $N_col heights  $h0 $x0 $big_x  $Node_ID $Ele_ID; 
	
	set topHeight [lindex $heights end];	
		
	set topNode [getNode $Region_ID $x0 $topHeight];
	
	
	set recName "$fname/equiv$Region_ID.out"
	
	recorder Node -file $recName -time -node $topNode -dof 1 disp;
	
	
	
	if { $forceDist == "topPointLoad" } {
		pattern Plain $Region_ID Linear {			
			lineX_forces $Region_ID $topHeight $P;
		}
		
	}	else {
		error_clean "ERROR: Unknown force distribution";
	}
	

	# Gravity-analysis: load-controlled static analysis
	set Tol 1.0e-6;							# convergence tolerance for test
	constraints Plain;						# how it handles boundary conditions
	numberer RCM;							# renumber dof's to minimize band-width (optimization)
	system BandGeneral;						# how to store and solve the system of equations in the analysis (large model: try UmfPack)
	test NormDispIncr $Tol 6;				# determine if convergence has been achieved at the end of an iteration step
	algorithm Newton;						# use Newton's solution algorithm: updates tangent stiffness at every iteration
	set NstepGravity 10;					# apply gravity in 10 steps
	set DGravity [expr 1.0/$NstepGravity];	# load increment
	integrator LoadControl $DGravity;		# determine the next time step for an analysis
	analysis Static;						# define type of analysis: static or transient
	analyze $NstepGravity;					# apply gravity
	
	wipe all;
	
	set xList {};
	for {set i 1} {$i<=$N_col} {incr i} {
		lappend xList [ expr ($i-1)*$h0 ];
	}
	
	set xCent [expr ($N_col-1)*$h0/2];
	
	set Ieff 0;
	
	for {set i 0} {$i < $N_col} {incr i} {
		set Ieff [expr $Ieff + ([lindex $xList $i]-$xCent)*([lindex $xList $i]-$xCent)*$A_col];
	}
	
	set Atot [expr $N_col*$A_col];
	
	
	
	
	if {$forceDist == "topPointLoad"} {
		fforeach el $recName {
			set topDisp [lindex $el 1];
		}
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
		puts "...Trying to find equivalent linear spring for region $Region_ID";
		set keq [expr -3*$Es*$Ieff/($topHeight-3*$Es*$Ieff*$topDisp/$topHeight/$topHeight/$P)];
		puts "N-R found k = $keq N !";
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
		
		
	} else {
	}





}



#    ///////////////////////////////////////////////////////////////////////////////////////
#   ////////////////////////////////////// SCUMS /////////////////////////////////////////
#  /////////////////////////////////////////////////////////////////////////////////////
if 0 {
proc_ref timoCanti_equivSpring_topPointLoad {*E *I *L *P *delta {k0 1000} {tolerance 1e-4} {maxSteps 10} } {
		
	proc_ref fx {*E *I *L *delta *k *P} {
		set EI [expr $E*$I];
		set L3 [expr $L*$L*$L];
		set L4 [expr $L3*$L];
		set stiff [expr 3*$EI/$L3-9*$EI*$EI/(3*$EI*$L3+$k*$L4)];
		return [expr $P-$stiff*$delta];
	}
	proc_ref dfx {*E *I *L *delta *k} {
		set EI [expr $E*$I];
		set L3 [expr $L*$L*$L];
		set L4 [expr $L3*$L];

		return [expr -$delta*9*$EI*$EI*$L4/(3*$EI*$L3+$k*$L4)/(3*$EI*$L3+$k*$L4)];
	}
	
	
	set k_prev $k0;
	set fx_prev [fx E I L delta k_prev P];
	
	set step 1;
	
	while { [abs $fx_prev] > $tolerance && $step <= $maxSteps } {
		set fx_prev [fx E I L delta k_prev P];
		
		set dfx_prev [dfx E I L delta k_prev];
		
		set k_curr [expr $k_prev - $fx_prev/$dfx_prev];
		
		set k_prev $k_curr;
	
		incr $step;
	}

	rename fx ""
	rename dfx ""
	return $k_curr;
	

} 
}