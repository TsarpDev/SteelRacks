################################## DISTANCE ##################################
set m 1.0;
set m2 1.0;
set m3 1.0;
set m4 1.0;

set cm [expr $m*0.01];
set cm2 [expr $cm*$cm];
set cm3 [expr $cm2*$cm];
set cm4 [expr $cm3*$cm];
set mm [expr $m*0.001];
set mm2 [expr $mm*$mm];
set mm3 [expr $mm2*$mm];
set mm4 [expr $mm3*$mm];


################################## FORCE ##################################
set N 1.0;

set kN [expr $N*1000.0];
set MN [expr $kN*1000.0];


################################## STRESS ##################################
set kPa [expr $kN/$m];
set MPa [expr $kPa*1000.0];
set GPa [expr $MPa*1000.0];


################################## MASS ##################################
set kg 1.0;
set ton [expr 1000*$kg];

################################## MASS TO FORCE ##################################
proc conv_mass_to_force { {mass_tmp} {g 9.81 } } {
	return [expr $mass_tmp*$g]
}

set g 9.81;