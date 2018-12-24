proc AngleSection {secID matID t3 t2 tf tw } {
# secID - section ID number
# matID - material ID number
# t3 = total height
# t2 = flange width (base width)
# tf = flange thickness
# tw = web thickness
# t2b = with of the bottom flange (for nonsymmetrical I profile only)
# tfb = thikness of the bottom flange (for nonsymmetrical I profile only)
# dis = separation distance between (double angles or double channels only)
# nfdw = number of fibers along web depth (or total height)
# nftw = number of fibers along web thickness
# nfbf = number of fibers along flange width (or base width)
# nftf = number of fibers along flange thickness
set mfw [expr 2.0e-3]
set nft2 [expr int($t2/$mfw)]
set nftw [expr int($tw/$mfw)]
set nft3 [expr int(($t3-$tf)/$mfw)]
set nftf [expr int($tf/$mfw)]
set yg [expr ($t2*$tf*$tf/2+($t3-$tf)*$tw*(($t3-$tf)/2+$tf))/(($t3*$tf)+($t3-$tf)*$tw)]
set y1 [expr pow(2.0,0.5)*$yg]
set y2 [expr $y1-$tf*pow(2.0,0.5)/2]
set y3 [expr $y1-$tf*pow(2.0,0.5)]
set y4 [expr -($t2*pow(2.0,0.5)/2-$y1)]
set y5 [expr $y4-$tf*pow(2.0,0.5)/2]
set z2 [expr ($t2-$tw)*pow(2.0,0.5)/2]
set z1 [expr ($z2+$tf*pow(2.0,0.5)/2)]
set z3 [expr -$z2]
set z4 [expr -$z1]
set z5 [expr -$tf*pow(2.0,0.5)/2]
set z6 [expr 0.0]
section fiberSec $secID {
patch quad $matID $nft3 $nftw $y4 $z4 $y2 $z5 $y3 $z6 $y5 $z3    
patch quad $matID $nft2 $nftf $y1 $z6 $y4 $z1 $y5 $z2 $y2 $z5  
} 
}

