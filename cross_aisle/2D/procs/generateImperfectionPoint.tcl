proc generate2DImperfectionPoint {nodeI nodeJ {imp 200} {id 9}} {

	kill_if_3D "ERROR: generate2DImperfectionPoint is only for 2D analysis. Change analysis type.";

	set xi [expr [nodeCoord $nodeI 1]];
	set yi [expr [nodeCoord $nodeI 2]];
	
	set xj [expr [nodeCoord $nodeJ 1]];
	set yj [expr [nodeCoord $nodeJ 2]];
	
	
	set xm [expr ($xi+$xj)/2.0];
	set ym [expr ($yi+$yj)/2.0];
	
	set dX [expr $xj-$xi];
	set dY [expr $yj-$yi];
	
	set L [expr sqrt($dX*$dX+$dY*$dY)]
	set slope [expr $dY/$dX];
	
	set imp [expr $L/$imp];
	
	set x [expr -$slope/sqrt(1.0+$slope*$slope) * $imp];
	set y [expr 1.0/sqrt(1.0+$slope*$slope) * $imp];
	
	set ximp [expr $x + $xm]
	set yimp [expr $y + $ym]
	
	set nodeID [expr $nodeI+$id]
	node $nodeID $ximp $yimp
	
	return $nodeID
}

proc generate2DImperfectionPointID {id nodeI nodeJ {imp 200} } {

	kill_if_3D "ERROR: generate2DImperfectionPointID is only for 2D analysis. Change analysis type.";
	

	set xi [expr [nodeCoord $nodeI 1]];
	set yi [expr [nodeCoord $nodeI 2]];
	
	set xj [expr [nodeCoord $nodeJ 1]];
	set yj [expr [nodeCoord $nodeJ 2]];
	
	
	set xm [expr ($xi+$xj)/2.0];
	set ym [expr ($yi+$yj)/2.0];
	
	set dX [expr $xj-$xi];
	set dY [expr $yj-$yi];
	
	set L [expr sqrt($dX*$dX+$dY*$dY)]
	set slope [expr $dY/$dX];
	
	set imp [expr $L/$imp];
	
	set x [expr -$slope/sqrt(1+$slope*$slope) * $imp];
	set y [expr 1/sqrt(1+$slope*$slope) * $imp];
	
	set ximp [expr $x + $xm]
	set yimp [expr $y + $ym]
	
	node $id $ximp $yimp
	
	return $id
}

proc generateImperfectionPointID {id nodeI nodeJ {imp 200} } {

	kill_if_2D "ERROR: generateImperfectionPointID is only for 2D analysis. Change analysis type.";
	

	set xi [expr [nodeCoord $nodeI 1]];
	set yi [expr [nodeCoord $nodeI 2]];
	set zi [expr [nodeCoord $nodeI 3]];
	
	set xj [expr [nodeCoord $nodeJ 1]];
	set yj [expr [nodeCoord $nodeJ 2]];
	set zj [expr [nodeCoord $nodeJ 3]];	
	
	if {$zi ne $zj} {
		error_clean "ERROR: Should: zi==zj (not supported case atm)."
	}
	
	set xm [expr ($xi+$xj)/2.0];
	set ym [expr ($yi+$yj)/2.0];
	
	set dX [expr $xj-$xi];
	set dY [expr $yj-$yi];
	
	set L [expr sqrt($dX*$dX+$dY*$dY)]
	set slope [expr $dY/$dX];
	
	set imp [expr $L/$imp];
	
	set x [expr -$slope/sqrt(1+$slope*$slope) * $imp];
	set y [expr 1/sqrt(1+$slope*$slope) * $imp];
	
	set ximp [expr $x + $xm]
	set yimp [expr $y + $ym]
	
	node $id $ximp $yimp $zi
	
	return $id
}