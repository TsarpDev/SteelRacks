

proc Angle {secID matID t3 t2 tf tw t2b tfb dis} {
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
set mfw 2.0
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

proc DoubleAngle {secID matID t3 t2 tf tw t2b tfb dis} {
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
set mfw 2.0
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

proc DoubleChannel {secID matID t3 t2 tf tw t2b tfb dis} {
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
set mfw 2.0
set nft2 [expr int(($t2-$dis)/2/$mfw)]
set nftw [expr int($tw/$mfw)]
set nft3 [expr int(($t3-2*$tf)/$mfw)]
set nftf [expr int($tf/$mfw)]
set y1 [expr $t3/2]
set y2 [expr ($t3-2*$tf)/2]
set y3 [expr -$y2]
set y4 [expr -$y1]
set z1 [expr $t2/2]
set z2 [expr ($dis/2+$tw)]
set z3 [expr $dis/2]
set z4 [expr -$z3]
set z5 [expr -$z2]
set z6 [expr -$z1]
section fiberSec $secID {
patch quad $matID $nftf $nft2 $y1 $z1 $y2 $z1 $y2 $z3 $y1 $z3     
patch quad $matID $nft3 $nftw $y2 $z2 $y3 $z2 $y3 $z3 $y2 $z3    
patch quad $matID $nftf $nft2 $y3 $z1 $y4 $z1 $y4 $z3 $y3 $z3    
patch quad $matID $nftf $nft2 $y1 $z4 $y2 $z4 $y2 $z6 $y1 $z6     
patch quad $matID $nft3 $nftw $y2 $z4 $y3 $z4 $y3 $z5 $y2 $z5      
patch quad $matID $nftf $nft2 $y3 $z4 $y4 $z4 $y4 $z6 $y3 $z6     
}
}

proc RHS {secID matID t3 t2 tf tw t2b tfb dis} {
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
set mfw 2.0
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



#--------------------------------------------------------------------------
# PROCEDURA PER IL CALCOLO DELLA RIGIDEZZA A TAGLIO E TORSIONE
#--------------------------------------------------------------------------
proc TorsProc { VymatID VzmatID TmatID Jt Avy Avz G } {
# VymatID - material ID for Vy
# VzmatID - material ID for Vz
# TmatID - material ID for T
# Jt - Torsional Constant o anche momento di inerzia di torsione (m^4)
# Avy - Shear area for shear in the local y-axis direction.
# Avz - Shear area for shear in the local z-axis direction.
# G - Shear modulus

set Kvy [expr $Avy*$G]
set Kvz [expr $Avz*$G]
set Kvt [expr $Jt*$G]
uniaxialMaterial Elastic $VymatID $Kvy
uniaxialMaterial Elastic $VzmatID $Kvz
uniaxialMaterial Elastic $TmatID $Kvt
}
