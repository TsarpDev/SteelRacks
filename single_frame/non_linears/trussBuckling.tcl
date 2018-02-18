proc trussBuckling {eleID	nodeI	nodeJ	matTag	E	A	I	fy	{imp_coeff "c"}} {

	set a_coeff 0.13;
	if {$imp_coeff == "a"} {
		set a_coeff 0.21;
	} elseif {$imp_coeff == "b"} {
		set a_coeff 0.34;
	} elseif {$imp_coeff == "c"} {
		set a_coeff 0.49;
	} elseif {$imp_coeff == "d"} {
		set a_coeff 0.76;
	}
	
	set Xi [expr [nodeCoord $nodeI 1]];
	set Yi [expr [nodeCoord $nodeI 2]];
	set Xj [expr [nodeCoord $nodeJ 1]];
	set Yj [expr [nodeCoord $nodeJ 2]];
	
	set L [expr {sqrt( ($Xi-$Xj)*($Xi-$Xj) + ($Yi-$Yj)*($Yi-$Yj) )}];
	
	set pi 3.14159265358979;
	
	set Ncr [expr $pi*$pi*$E*$I/($L*$L)];
	
	set lambda_bar	[expr sqrt($A*$fy/$Ncr)];
	
	set Phi [expr 0.5*(1+$a_coeff*($lambda_bar-0.2)+$lambda_bar*$lambda_bar)];
	
	set x [expr 1/($Phi+sqrt($Phi*$Phi-$lambda_bar*$lambda_bar))];

	set NrdP [expr $A*$fy];
	
	set NrdN [expr $NrdP*$x];
	
	set epsyP [expr $NrdP/($A*$E)];
	
	set epsyN [expr -$NrdN/($A*$E)];
	
	
	

	if { [addMaterial $matTag]} {
		uniaxialMaterial ElasticPP $matTag $E $epsyP $epsyN;
		addMatProperties $matTag "uniaxialMaterial" "ElasticPP" $E $A $NrdP $NrdN;
	}
	element truss $eleID $nodeI $nodeJ $A $matTag;
	

}


