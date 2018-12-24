

proc DoubleAngleSection {secID matID t3 t2 tf tw t2b tfb dis} {
# secID - section ID number
# matID - material ID number
# t3 = total height
# t2 = flange width (base width or total width for double channel)
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
set nft2 [expr int(($t2-$dis)/2/$mfw)]
set nftw [expr int($tw/$mfw)]
set nft3 [expr int(($t3-$tf)/$mfw)]
set nftf [expr int($tf/$mfw)]
set y1 [expr (($t2-$dis)/2*$tf*2*$tf/2+($t3-$tf)*$tw*2*(($t3-$tf)/2+$tf))/(2*(($t2-$dis)/2*$tf+($t3-$tf)*$tw))]
set y2 [expr $y1-$tf]
set y3 [expr  -($t3-$y1)]
set z1 [expr $t2/2]
set z2 [expr (0.5*$dis+$tw)]
set z3 [expr $dis/2]
set z4 [expr -$z3]
set z5 [expr -$z2]
set z6 [expr -$z1]

section fiberSec $secID {
patch quad $matID $nftf $nft2 $y1 $z1 $y2 $z1 $y2 $z3 $y1 $z3     
patch quad $matID $nft3 $nftw $y2 $z2 $y3 $z2 $y3 $z3 $y2 $z3    
patch quad $matID $nftf $nft2 $y1 $z4 $y2 $z4 $y2 $z6 $y1 $z6     
patch quad $matID $nft3 $nftw $y2 $z4 $y3 $z4 $y3 $z5 $y2 $z5     
}
}