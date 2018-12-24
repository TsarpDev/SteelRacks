

proc RHS_Section {secID matID t3 t2 tf tw t2b tfb dis} {
## secID - section ID number
## matID - material ID number
## t3 = total height
## t2 = flange width (base width)
## tf = flange thickness
## tw = web thickness
## t2b = with of the bottom flange (for nonsymmetrical I profile only)
## tfb = thikness of the bottom flange (for nonsymmetrical I profile only)
## dis = separation distance between (double angles or double channels only)
## nfdw = number of fibers along web depth (or total height)
## nftw = number of fibers along web thickness
## nfbf = number of fibers along flange width (or base width)
## nftf = number of fibers along flange thickness
set mfw [expr 2.0e-3]

set nft2 [expr int(($t2-2*$tw)/$mfw)]
set nftw [expr int($tw/$mfw)]
set nft3 [expr int($t3/$mfw)]
set nftf [expr int($tf/$mfw)]
set y1 [expr ($t3/2)]
set y2 [expr ($t3-2*$tw)/2]
set y3 [expr -$y2]
set y4 [expr -$y1]
set z1 [expr ($t2/2)]
set z2 [expr ($t2-2*$tf)/2]
set z3 [expr -$z2]
set z4 [expr -$z1]

section fiberSec $secID {
patch quad $matID $nft3 $nftw $y1 $z1 $y4 $z1 $y4 $z2 $y1 $z2    
patch quad $matID $nftf $nft2 $y1 $z2 $y2 $z2 $y2 $z3 $y1 $z3 
patch quad $matID $nft3 $nftw $y1 $z3 $y4 $z3 $y4 $z4 $y1 $z4     
patch quad $matID $nftf $nft2 $y3 $z2 $y4 $z2 $y4 $z3 $y3 $z3    

} 
}
