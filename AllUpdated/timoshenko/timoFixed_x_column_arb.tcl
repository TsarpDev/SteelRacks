proc_ref timoFixed_x_column_arb { forceDist P Region_ID filename  Es  A_col  I_col  A_br  A_beam   Geom_TransID  massX  {N_col 2} *heights  {h0 1} {x0 0}    {big_x 0} {Node_ID 1000} {Ele_ID 1000}   } {


	set TrussMatID $Region_ID;		# define a material ID
	
	uniaxialMaterial Elastic $TrussMatID $Es;		# define truss material
	
	set fname "TimoshenkoEquivs";
	
	static [file mkdir $fname]; 						# create output folder
		
	x_column_arb	$Region_ID  $Es  $A_col  $I_col  $A_br  $A_beam  $TrussMatID  $Geom_TransID  $massX  $N_col heights  $h0 $x0 $big_x  $Node_ID $Ele_ID; 
	
	
	set topHeight [lindex $heights end];	
	
	lineX_rollers $Region_ID $topHeight;
	
	set topNode [getNode $Region_ID $x0 $topHeight];
	
	
	set recName "$fname/equiv$Region_ID.out"
	
	recorder Node -file $recName -time -node $topNode -dof 1 disp;
	
	
	
	if { $forceDist == "topPointLoad" } {
		pattern Plain $Region_ID Linear {			
			lineX_forces $Region_ID $topHeight $P;
		}
		
	}	elseif { $forceDist == "triangLoad"} {
	
		error_clean "ERROR: Expression is too complicated. It is necessary to know a priori the nodes for the load\n";
	} else {
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
		set totP [expr $P*2];
		set L $topHeight;
		set d_ $topDisp;
		set keq [expr -4*$Es*$Ieff*($totP*$L*$L*$L-3*$Es*$Ieff*$d_)/($totP*$L*$L*$L*$L-12*$Es*$Ieff*$d_*$L)];
		puts "Linear solver found k = $keq N !";
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
		
		puts "$d_";
	} elseif { $forceDist == "triangLoad"} {
		
	} 



}
