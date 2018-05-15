#puts "INIZIO ANALISI"

wipe
model BasicBuilder -ndm 2 - ndf 3 

set dataDir "Risultati_02_rev";			# set up name of data directory
set dataDir1 "Risultatinodi_02_rev";
set dataDir2 "Risultatielementitesi_02rev"
set dataDir3 "Risultatielementicompressi_02rev"


file mkdir $dataDir; 							# create data directory
file mkdir $dataDir1; 
file mkdir $dataDir2; 
file mkdir $dataDir3; 



source MODELLO_Nodes.tclsource MODELLO_SectionProcedures.tclsource MODELLO_Section.tclsource MODELLO_Elements.tcl
source MODELLO_JointRestrzerolength.tcl
source display.tcl

source RunPushover2Converge_REV.tcl

#strucural loads

#elements lengths
set x1 [nodeCoord 101 1]
set x2 [nodeCoord 201 1]
set x3 [nodeCoord 3021 1]

set y1 [nodeCoord 101 2] 
set y2 [nodeCoord 102 2] 
set y3 [nodeCoord 103 2]
set y4 [nodeCoord 104 2]
set y19 [nodeCoord 1019 2]
set y20 [nodeCoord 1020 2]
set y21 [nodeCoord 1021 2]
set y1022 [nodeCoord 1022 2]
set y2022 [nodeCoord 2022 2]
set y3022 [nodeCoord 3022 2]
set y4022 [nodeCoord 4022 2]
set y5022 [nodeCoord 5022 2]
set y6022 [nodeCoord 6022 2]
set y7022 [nodeCoord 7022 2]
set y8022 [nodeCoord 8022 2]
set y9022 [nodeCoord 9022 2]
set y10022 [nodeCoord 10022 2]
set y11022 [nodeCoord 11022 2]
 
set Lx1200 [expr $x2-$x1]    
set Lx950 [expr $x3-$x2]

set Ly60 [expr $y2-$y1]
set Ly1000 [expr $y3-$y2]
set Ly1250 [expr $y4-$y3]
set Ly1070 [expr $y20-$y19]
set Ly202221 [expr $y2022-$y21]
set Ly302221 [expr $y3022-$y21]
set Ly402221 [expr $y4022-$y21]
set Ly502221 [expr $y5022-$y21]
set Ly602221 [expr $y6022-$y21]
set Ly702221 [expr $y7022-$y21]
set Ly802221 [expr $y8022-$y21]
set Ly902221 [expr $y9022-$y21]
set Ly1002221 [expr $y10022-$y21]
set Ly1102221 [expr $y11022-$y21]
#
set d12001000 [expr pow((pow($Lx1200,2)+pow($Ly1000,2)),0.5)]
set d12001250 [expr pow((pow($Lx1200,2)+pow(1250,2)),0.5)]
set d12001070 [expr pow((pow($Lx1200,2)+pow($Ly1070,2)),0.5)]
#
#lengths of diagonal elements of the truss 
set d1 [expr pow((pow($Lx1200,2)+pow($Ly1000,2)),0.5)] 
set d2 [expr pow((pow($Lx950,2)+pow($Ly202221,2)),0.5)] 
set d3 [expr pow((pow($Lx950,2)+pow($Ly302221,2)),0.5)] 
set d4 [expr pow((pow($Lx1200,2)+pow($Ly402221,2)),0.5)] 
set d5 [expr pow((pow($Lx1200,2)+pow($Ly502221,2)),0.5)] 
set d6 [expr pow((pow($Lx950,2)+pow($Ly602221,2)),0.5)] 
set d7 [expr pow((pow($Lx950,2)+pow($Ly702221,2)),0.5)] 
set d8 [expr pow((pow($Lx1200,2)+pow($Ly802221,2)),0.5)] 
set d9 [expr pow((pow($Lx1200,2)+pow($Ly902221,2)),0.5)] 
set d10 [expr pow((pow($Lx950,2)+pow($Ly1002221,2)),0.5)]
#
##lengths of the upper elements of the truss
#
set ds1 [expr pow((pow($Lx1200,2)+pow(($Ly202221-$Ly1000),2)),0.5)]
set ds2 [expr pow((pow($Lx950,2)+pow(($Ly302221-$Ly202221),2)),0.5)]
#
##elements cross-areas
#uprights
set AreaRHS120x80x4 [expr 2*(120*4+(80-4*2)*4)]
set AreaRHS120x80x6 [expr 2*(120*6+(80-6*2)*6)]
set AreaRHS120x80x10 [expr 2*(120*10+(80-10*2)*10)]
set AreaRHS150x100x4 [expr 2*(150*4+(100-4*2)*4)]
set AreaRHS150x100x6 [expr 2*(150*6+(100-6*2)*6)]
set AreaRHS150x100x10 [expr 2*(150*10+(100-10*2)*10)]

#truss
set AreaDA45x45x4 [expr 2*(45*4+((96-6)/2-4)*4)]
set AreaDA55x55x4 [expr 2*(55*4+((116-6)/2-4)*4)]

#beams
set AreaDC80x50x3 [expr 2*(80*3+2*((105-5)/2-3)*3)]

#bracings
set AreaL30x30x4 [expr (30*4-(30-4)*4)]
set AreaL35x35x4 [expr (35*4-(35-4)*4)]
set AreaL40x40x4 [expr (40*4-(40-4)*4)]
set AreaL40x40x5 [expr (50*5-(50-5)*5)]
set AreaRHS30x30x2 [expr 2*(30*2+(30-2*2)*2)]
set AreaRHS30x30x2punto5 [expr 2*(30*2.5+(30-2.5*2)*2.5)]

#connection elements between transversal frames 
set AreaC100x50x25x2 [expr (100*2+2*(50-2)*2)+2*(25-2)*2]
set AreaDC100x60x3 [expr 2*(100*3+2*((125-5)/2-3)*3)]

set pesoacciaio [expr 7850*9.81/pow(10,12)]

#weight of elements for unif of length
set pRHS120x80x4 [expr $AreaRHS120x80x4*$pesoacciaio]
set pRHS120x80x6 [expr $AreaRHS120x80x6*$pesoacciaio]
set pRHS120x80x10 [expr $AreaRHS120x80x10*$pesoacciaio]
set pRHS150x100x4 [expr $AreaRHS150x100x4*$pesoacciaio]
set pRHS150x100x6 [expr $AreaRHS150x100x6*$pesoacciaio]
set pRHS150x100x10 [expr $AreaRHS150x100x10*$pesoacciaio]

set pDA45x45x4 [expr $AreaDA45x45x4*$pesoacciaio]
set pDA55x55x4 [expr $AreaDA55x55x4*$pesoacciaio]

set pDC80x50x3 [expr $AreaDC80x50x3*$pesoacciaio]

set pL30x30x4 [expr $AreaL30x30x4*$pesoacciaio]
set pL35x35x4 [expr $AreaL35x35x4*$pesoacciaio]
set pL40x40x4 [expr $AreaL40x40x4*$pesoacciaio]
set pL40x40x5 [expr $AreaL40x40x5*$pesoacciaio]
set pRHS30x30x2 [expr $AreaRHS30x30x2*$pesoacciaio]
set pRHS30x30x2punto5 [expr $AreaRHS30x30x2punto5*$pesoacciaio]

set pC100x50x25x2 [expr $AreaC100x50x25x2*$pesoacciaio]
set pDC100x60x3 [expr $AreaDC100x60x3*$pesoacciaio]


#weight of connection elements between transversal frames
set dtrasv 2000.0
set Qi3se [expr $pC100x50x25x2*$dtrasv]
set Qi3sine [expr $pC100x50x25x2*$dtrasv]
set Qi3sini [expr $pC100x50x25x2*$dtrasv*2]

set Qi4sene [expr ($pC100x50x25x2+$pDC100x60x3)*$dtrasv]
set Qi4seni [expr $pC100x50x25x2*$dtrasv]
set Qi4sine [expr $pC100x50x25x2*$dtrasv]
set Qi4sini [expr $pC100x50x25x2*$dtrasv*2+$pDC100x60x3*$dtrasv]

set Qtrasv21 [expr $pC100x50x25x2*$dtrasv]
set Qtrasv22 [expr 0.158/pow(10,3)*$dtrasv]

#weight of side panels 
set bar [expr 0.50/pow(10,3)]
set Qbar560 [expr $bar*560.0]
set Qbar1125 [expr $bar*1125.0]
set Qbar1250 [expr $bar*1250.0]
set Qbar1160 [expr $bar*1160.0]
set Qbar1070 [expr $bar*1070.0]
set Qbar1035 [expr $bar*1035.0]
set Qbar500 [expr $bar*500.0]

#weight of covering pannel
set cop [expr 0.40/pow(10,3)]
set Qcopds1 [expr $cop*$ds1]
set Qcopds2 [expr $cop*$ds2]

#weight of pallet 
set Qpalletne 6.8
set Qpalletni 13.6

if 0 {
pattern Plain 2000 Linear {

load 101 0 [expr  -($pRHS120x80x10*$Ly60/2)] 0
load 201 0 [expr  -($pRHS120x80x10*$Ly60/2)] 0
load 102 0 [expr -($pRHS120x80x10*($Ly60/2+$Ly1000/2)+$pL40x40x5*$d12001000/2+$pDC80x50x3*$Lx1200/2)-$Qbar560] 0
load 202 0 [expr -($pRHS120x80x10*($Ly60/2+$Ly1000/2)+$pL40x40x5*$d12001000/2+$pDC80x50x3*$Lx1200/2)] 0
load 103 0 [expr -($pRHS120x80x10*($Ly1000/2+1250/2)+$pL40x40x5*$d12001000/2+$pL40x40x5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1125-$Qpalletne] 0
load 203 0 [expr -($pRHS120x80x10*($Ly1000/2+1250/2)+$pL40x40x5*$d12001000/2+$pL40x40x5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 104 0 [expr -($pRHS120x80x10*($Ly1250/2+$Ly1250/2)+$pL40x40x5*$d12001250/2+$pL40x40x5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 204 0 [expr -($pRHS120x80x10*($Ly1250/2+$Ly1250/2)+$pL40x40x5*$d12001250/2+$pL40x40x5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 105 0 [expr -($pRHS120x80x10*($Ly1250/2+$Ly1250/2)+$pL40x40x5*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 205 0 [expr -($pRHS120x80x10*($Ly1250/2+$Ly1250/2)+$pL40x40x5*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 106 0 [expr -($pRHS120x80x10*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 206 0 [expr -($pRHS120x80x10*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 107 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 207 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 108 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 208 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qpalletne] 0
load 109 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 209 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 1010 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 2010 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 1011 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 2011 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 1012 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 2012 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 1013 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 2013 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 1014 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 2014 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 1015 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 2015 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 1016 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 2016 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 1017 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 2017 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 1018 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 2018 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 1019 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1070/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001070/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1160-$Qpalletne] 0
load 2019 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1070/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001070/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 1020 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pRHS120x80x4*$Ly1070/2+$pL30x30x4*$d12001070/2+$pL30x30x4*$d12001070/2+$pDC80x50x3*$Lx1200/2)] 0
load 2020 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pRHS120x80x4*$Ly1070/2+$pL30x30x4*$d12001070/2+$pL30x30x4*$d12001070/2+$pDC80x50x3*$Lx1200/2)] 0


load 401 0 [expr -($pRHS120x80x10*$Ly60/2)] 0
load 501 0 [expr -($pRHS150x100x10*$Ly60/2)] 0
load 601 0 [expr -($pRHS120x80x10*$Ly60/2)] 0
load 402 0 [expr -($pRHS120x80x10*$Ly60/2+$pRHS120x80x10*$Ly1000/2+$pL40x40x4*$d12001000/2+$pDC80x50x3*$Lx1200/2)] 0
load 502 0 [expr -($pRHS150x100x10*$Ly60/2+$pRHS150x100x10*$Ly1000/2+2*$pL40x40x4*$d12001000/2+2*$pDC80x50x3*$Lx1200/2)] 0
load 602 0 [expr -($pRHS120x80x10*$Ly60/2+$pRHS120x80x10*$Ly1000/2+$pL40x40x4*$d12001000/2+$pDC80x50x3*$Lx1200/2)] 0
load 403 0 [expr -($pRHS120x80x10*$Ly1000/2+$pRHS120x80x10*$Ly1250/2+$pL40x40x4*$d12001000/2+$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 503 0 [expr -($pRHS150x100x10*$Ly1000/2+$pRHS150x100x10*$Ly1250/2+2*$pL40x40x4*$d12001000/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 603 0 [expr -($pRHS120x80x10*$Ly1000/2+$pRHS120x80x10*$Ly1250/2+$pL40x40x4*$d12001000/2+$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 404 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 504 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x10*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 604 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 405 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 505 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x10*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 605 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 406 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 506 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 606 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 407 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 507 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 607 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 408 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 508 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 608 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 409 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 509 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 609 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 4010 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 5010 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 6010 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 4011 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 5011 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 6011 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 4012 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 5012 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 6012 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 4013 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 5013 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 6013 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 4014 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 5014 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 6014 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 4015 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 5015 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 6015 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 4016 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 5016 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+2*$pRHS30x30x2*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 6016 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 4017 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 5017 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 6017 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 4018 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 5018 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 6018 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 4019 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1070/2+$pRHS30x30x2*($d12001250/2+$d12001070/2)+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 5019 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1070/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 6019 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1070/2+$pRHS30x30x2*($d12001250/2+$d12001070/2)+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 4020 0 [expr -($pRHS120x80x4*$Ly1070/2+$pRHS120x80x4*$Ly1070/2+$pDC80x50x3*$Lx1200/2)] 0
load 5020 0 [expr -($pRHS150x100x4*$Ly1070/2+$pRHS150x100x4*$Ly1070/2+4*$pRHS30x30x2*$d12001070/2+2*$pDC80x50x3*$Lx1200/2)] 0
load 6020 0 [expr -($pRHS120x80x4*$Ly1070/2+$pRHS120x80x4*$Ly1070/2+$pDC80x50x3*$Lx1200/2)] 0

load 801 0 [expr -($pRHS120x80x10*$Ly60/2)] 0
load 901 0 [expr -($pRHS150x100x10*$Ly60/2)] 0
load 1001 0 [expr -($pRHS120x80x10*$Ly60/2)] 0
load 802 0 [expr -($pRHS120x80x10*$Ly60/2+$pRHS120x80x10*$Ly1000/2+$pL40x40x4*$d12001000/2+$pDC80x50x3*$Lx1200/2)] 0
load 902 0 [expr -($pRHS150x100x10*$Ly60/2+$pRHS150x100x10*$Ly1000/2+2*$pL40x40x4*$d12001000/2+2*$pDC80x50x3*$Lx1200/2)] 0
load 1002 0 [expr -($pRHS120x80x10*$Ly60/2+$pRHS120x80x10*$Ly1000/2+$pL40x40x4*$d12001000/2+$pDC80x50x3*$Lx1200/2)] 0
load 803 0 [expr -($pRHS120x80x10*$Ly1000/2+$pRHS120x80x10*$Ly1250/2+$pL40x40x4*$d12001000/2+$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 903 0 [expr -($pRHS150x100x10*$Ly1000/2+$pRHS150x100x10*$Ly1250/2+2*$pL40x40x4*$d12001000/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1003 0 [expr -($pRHS120x80x10*$Ly1000/2+$pRHS120x80x10*$Ly1250/2+$pL40x40x4*$d12001000/2+$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 804 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 904 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x10*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 1004 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 805 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 905 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x10*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1005 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 806 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 906 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 1006 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 807 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 907 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1007 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 808 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 908 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 1008 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 809 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 909 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1009 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 8010 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 9010 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 10010 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 8011 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 9011 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 10011 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 8012 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 9012 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 10012 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 8013 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 9013 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 10013 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 8014 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 9014 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 10014 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 8015 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 9015 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 10015 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 8016 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 9016 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+2*$pRHS30x30x2*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 10016 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 8017 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 9017 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 10017 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 8018 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 9018 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 10018 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 8019 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1070/2+$pRHS30x30x2*($d12001250/2+$d12001070/2)+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 9019 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1070/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 10019 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1070/2+$pRHS30x30x2*($d12001250/2+$d12001070/2)+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 8020 0 [expr -($pRHS120x80x4*$Ly1070/2+$pRHS120x80x4*$Ly1070/2+$pDC80x50x3*$Lx1200/2)] 0
load 9020 0 [expr -($pRHS150x100x4*$Ly1070/2+$pRHS150x100x4*$Ly1070/2+4*$pRHS30x30x2*$d12001070/2+2*$pDC80x50x3*$Lx1200/2)] 0
load 10020 0 [expr -($pRHS120x80x4*$Ly1070/2+$pRHS120x80x4*$Ly1070/2+$pDC80x50x3*$Lx1200/2)] 0

load 1201 0 [expr -($pRHS120x80x10*$Ly60/2)] 0
load 1301 0 [expr -($pRHS150x100x10*$Ly60/2)] 0
load 1401 0 [expr -($pRHS120x80x10*$Ly60/2)] 0
load 1202 0 [expr -($pRHS120x80x10*$Ly60/2+$pRHS120x80x10*$Ly1000/2+$pL40x40x4*$d12001000/2+$pDC80x50x3*$Lx1200/2)] 0
load 1302 0 [expr -($pRHS150x100x10*$Ly60/2+$pRHS150x100x10*$Ly1000/2+2*$pL40x40x4*$d12001000/2+2*$pDC80x50x3*$Lx1200/2)] 0
load 1402 0 [expr -($pRHS120x80x10*$Ly60/2+$pRHS120x80x10*$Ly1000/2+$pL40x40x4*$d12001000/2+$pDC80x50x3*$Lx1200/2)] 0
load 1203 0 [expr -($pRHS120x80x10*$Ly1000/2+$pRHS120x80x10*$Ly1250/2+$pL40x40x4*$d12001000/2+$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1303 0 [expr -($pRHS150x100x10*$Ly1000/2+$pRHS150x100x10*$Ly1250/2+2*$pL40x40x4*$d12001000/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1403 0 [expr -($pRHS120x80x10*$Ly1000/2+$pRHS120x80x10*$Ly1250/2+$pL40x40x4*$d12001000/2+$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1204 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1304 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x10*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 1404 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1205 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1305 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x10*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1405 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1206 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1306 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 1406 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1207 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1307 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1407 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1208 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1308 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 1408 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1209 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1309 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1409 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 12010 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 13010 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 14010 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 12011 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 13011 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 14011 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 12012 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 13012 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 14012 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 12013 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 13013 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 14013 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 12014 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 13014 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 14014 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 12015 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 13015 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 14015 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 12016 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 13016 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+2*$pRHS30x30x2*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 14016 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 12017 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 13017 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 14017 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 12018 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 13018 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 14018 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 12019 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1070/2+$pRHS30x30x2*($d12001250/2+$d12001070/2)+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 13019 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1070/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 14019 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1070/2+$pRHS30x30x2*($d12001250/2+$d12001070/2)+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 12020 0 [expr -($pRHS120x80x4*$Ly1070/2+$pRHS120x80x4*$Ly1070/2+$pDC80x50x3*$Lx1200/2)] 0
load 13020 0 [expr -($pRHS150x100x4*$Ly1070/2+$pRHS150x100x4*$Ly1070/2+4*$pRHS30x30x2*$d12001070/2+2*$pDC80x50x3*$Lx1200/2)] 0
load 14020 0 [expr -($pRHS120x80x4*$Ly1070/2+$pRHS120x80x4*$Ly1070/2+$pDC80x50x3*$Lx1200/2)] 0

load 1601 0 [expr -($pRHS120x80x10*$Ly60/2)] 0
load 1701 0 [expr -($pRHS150x100x10*$Ly60/2)] 0
load 1801 0 [expr -($pRHS120x80x10*$Ly60/2)] 0
load 1602 0 [expr -($pRHS120x80x10*$Ly60/2+$pRHS120x80x10*$Ly1000/2+$pL40x40x4*$d12001000/2+$pDC80x50x3*$Lx1200/2)] 0
load 1702 0 [expr -($pRHS150x100x10*$Ly60/2+$pRHS150x100x10*$Ly1000/2+2*$pL40x40x4*$d12001000/2+2*$pDC80x50x3*$Lx1200/2)] 0
load 1802 0 [expr -($pRHS120x80x10*$Ly60/2+$pRHS120x80x10*$Ly1000/2+$pL40x40x4*$d12001000/2+$pDC80x50x3*$Lx1200/2)] 0
load 1603 0 [expr -($pRHS120x80x10*$Ly1000/2+$pRHS120x80x10*$Ly1250/2+$pL40x40x4*$d12001000/2+$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1703 0 [expr -($pRHS150x100x10*$Ly1000/2+$pRHS150x100x10*$Ly1250/2+2*$pL40x40x4*$d12001000/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1803 0 [expr -($pRHS120x80x10*$Ly1000/2+$pRHS120x80x10*$Ly1250/2+$pL40x40x4*$d12001000/2+$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1604 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1704 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x10*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 1804 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1605 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1705 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x10*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1805 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x10*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1606 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1706 0 [expr -($pRHS150x100x10*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 1806 0 [expr -($pRHS120x80x10*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1607 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1707 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1807 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1608 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1708 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 1808 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 1609 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 1709 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x6*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 1809 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x6*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 16010 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 17010 0 [expr -($pRHS150x100x6*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 18010 0 [expr -($pRHS120x80x6*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 16011 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 17011 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 18011 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 16012 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 17012 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 18012 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 16013 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 17013 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 18013 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 16014 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 17014 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2punto5*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 18014 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 16015 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 17015 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 18015 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 16016 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 17016 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pRHS30x30x2punto5*$d12001250/2+2*$pRHS30x30x2*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 18016 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 16017 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 17017 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 18017 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+2*$pRHS30x30x2*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 16018 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 17018 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1250/2+4*$pRHS30x30x2*$d12001250/2+2*$pDC80x50x3*$Lx1200/2)-$Qi4sini-$Qpalletni] 0
load 18018 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sine-$Qpalletne] 0
load 16019 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1070/2+$pRHS30x30x2*($d12001250/2+$d12001070/2)+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 17019 0 [expr -($pRHS150x100x4*$Ly1250/2+$pRHS150x100x4*$Ly1070/2+2*$pDC80x50x3*$Lx1200/2)-$Qi3sini-$Qpalletni] 0
load 18019 0 [expr -($pRHS120x80x4*$Ly1250/2+$pRHS120x80x4*$Ly1070/2+$pRHS30x30x2*($d12001250/2+$d12001070/2)+$pDC80x50x3*$Lx1200/2)-$Qi3sine-$Qpalletne] 0
load 16020 0 [expr -($pRHS120x80x4*$Ly1070/2+$pRHS120x80x4*$Ly1070/2+$pDC80x50x3*$Lx1200/2)] 0
load 17020 0 [expr -($pRHS150x100x4*$Ly1070/2+$pRHS150x100x4*$Ly1070/2+4*$pRHS30x30x2*$d12001070/2+2*$pDC80x50x3*$Lx1200/2)] 0
load 18020 0 [expr -($pRHS120x80x4*$Ly1070/2+$pRHS120x80x4*$Ly1070/2+$pDC80x50x3*$Lx1200/2)] 0

load 2101 0 [expr  -($pRHS120x80x10*$Ly60/2)] 0
load 2001 0 [expr  -($pRHS120x80x10*$Ly60/2)] 0
load 2102 0 [expr -($pRHS120x80x10*($Ly60/2+$Ly1000/2)+$pL40x40x5*$d12001000/2+$pDC80x50x3*$Lx1200/2)-$Qbar560] 0
load 2002 0 [expr -($pRHS120x80x10*($Ly60/2+$Ly1000/2)+$pL40x40x5*$d12001000/2+$pDC80x50x3*$Lx1200/2)] 0
load 2103 0 [expr -($pRHS120x80x10*($Ly1000/2+$Ly1250/2)+$pL40x40x5*$d12001000/2+$pL40x40x5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1125-$Qpalletne] 0
load 2003 0 [expr -($pRHS120x80x10*($Ly1000/2+$Ly1250/2)+$pL40x40x5*$d12001000/2+$pL40x40x5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 2104 0 [expr -($pRHS120x80x10*($Ly1250/2+$Ly1250/2)+$pL40x40x5*$d12001250/2+$pL40x40x5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 2004 0 [expr -($pRHS120x80x10*($Ly1250/2+$Ly1250/2)+$pL40x40x5*$d12001250/2+$pL40x40x5*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 2105 0 [expr -($pRHS120x80x10*($Ly1250/2+$Ly1250/2)+$pL40x40x5*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 2005 0 [expr -($pRHS120x80x10*($Ly1250/2+$Ly1250/2)+$pL40x40x5*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 2106 0 [expr -($pRHS120x80x10*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 2006 0 [expr -($pRHS120x80x10*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 2107 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 2007 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 2108 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 2008 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qpalletne] 0
load 2109 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 2009 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x6*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 21010 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 20010 0 [expr -($pRHS120x80x6*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL40x40x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 21011 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 20011 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL40x40x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 21012 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 20012 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 21013 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 20013 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 21014 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 20014 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL35x35x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 21015 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 20015 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL35x35x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 21016 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 20016 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 21017 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1250-$Qpalletne] 0
load 20017 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 21018 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4sene-$Qbar1250-$Qpalletne] 0
load 20018 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1250/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001250/2+$pDC80x50x3*$Lx1200/2)-$Qi4seni-$Qpalletne] 0
load 21019 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1070/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001070/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qbar1160-$Qpalletne] 0
load 20019 0 [expr -($pRHS120x80x4*($Ly1250/2)+$pRHS120x80x4*$Ly1070/2+$pL30x30x4*$d12001250/2+$pL30x30x4*$d12001070/2+$pDC80x50x3*$Lx1200/2)-$Qi3se-$Qpalletne] 0
load 21020 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pRHS120x80x4*$Ly1070/2+$pL30x30x4*$d12001070/2+$pL30x30x4*$d12001070/2+$pDC80x50x3*$Lx1200/2)] 0
load 20020 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pRHS120x80x4*$Ly1070/2+$pL30x30x4*$d12001070/2+$pL30x30x4*$d12001070/2+$pDC80x50x3*$Lx1200/2)] 0

#nodi capriata
load 1021 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pL30x30x4*$d12001070/2+$pDA45x45x4*$Lx1200/2+$pDA55x55x4*$Ly1000/2)-$Qbar1035-$Qtrasv21] 0
load 1022 0 [expr -($pDA45x45x4*$ds1/2+$pDA55x55x4*($Ly1000/2+$d1/2))-$Qbar500-$Qcopds1/2-$Qtrasv22] 0
load 2021 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pL30x30x4*$d12001070/2+$pDA45x45x4*($Lx1200/2+$Lx950/2)+$pDA55x55x4*($Ly202221/2+$d1/2))-$Qtrasv21] 0
load 2022 0 [expr -($pDA45x45x4*($ds1/2+$ds2/2)+$pDA55x55x4*($Ly202221/2+$d2/2))-$Qcopds1/2-$Qcopds2/2-$Qtrasv22] 0
load 3021 0 [expr -($pDA45x45x4*($Lx950/2+$Lx950/2)+$pDA55x55x4*($Ly302221/2+$d2/2))-$Qtrasv21] 0
load 3022 0 [expr -($pDA45x45x4*($ds2/2+$ds2/2)+$pDA55x55x4*($Ly302221/2+$d3/2))-$Qcopds2/2-$Qcopds2/2-$Qtrasv22] 0
load 4021 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pL30x30x4*$d12001070/2+$pDA45x45x4*($Lx1200/2+$Lx950/2)+$pDA55x55x4*($Ly402221/2+$d3/2))-$Qtrasv21] 0
load 4022 0 [expr -($pDA45x45x4*($ds2/2+$ds1/2)+$pDA55x55x4*($Ly402221/2+$d4/2))-$Qcopds2/2-$Qcopds1/2-$Qtrasv22] 0
load 5021 0 [expr -($pRHS150x100x4*($Ly1070/2)+$pDA45x45x4*($Lx1200/2+$Lx1200/2)+$pDA55x55x4*($Ly502221/2+$d4/2))-$Qtrasv21] 0
load 5022 0 [expr -($pDA45x45x4*($ds1/2+$ds1/2)+$pDA55x55x4*($Ly502221/2+$d5/2))-$Qcopds1/2-$Qcopds1/2-$Qtrasv22] 0
load 6021 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pL30x30x4*$d12001070/2+$pDA45x45x4*($Lx1200/2+$Lx950/2)+$pDA55x55x4*($Ly602221/2+$d5/2))-$Qtrasv21] 0
load 6022 0 [expr -($pDA45x45x4*($ds2/2+$ds1/2)+$pDA55x55x4*($Ly602221/2+$d6/2))-$Qcopds2/2-$Qcopds1/2-$Qtrasv22] 0
load 7021 0 [expr -($pDA45x45x4*($Lx950/2+$Lx950/2)+$pDA55x55x4*($Ly702221/2+$d6/2))-$Qtrasv21] 0
load 7022 0 [expr -($pDA45x45x4*($ds2/2+$ds2/2)+$pDA55x55x4*($Ly702221/2+$d7/2))-$Qcopds2/2-$Qcopds2/2-$Qtrasv22] 0
load 8021 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pL30x30x4*$d12001070/2+$pDA45x45x4*($Lx1200/2+$Lx950/2)+$pDA55x55x4*($Ly802221/2+$d7/2))-$Qtrasv21] 0
load 8022 0 [expr -($pDA45x45x4*($ds2/2+$ds1/2)+$pDA55x55x4*($Ly802221/2+$d8/2))-$Qcopds2/2-$Qcopds1/2-$Qtrasv22] 0
load 9021 0 [expr -($pRHS150x100x4*($Ly1070/2)+$pDA45x45x4*($Lx1200/2+$Lx1200/2)+$pDA55x55x4*($Ly902221/2+$d8/2))-$Qtrasv21] 0
load 9022 0 [expr -($pDA45x45x4*($ds1/2+$ds1/2)+$pDA55x55x4*($Ly902221/2+$d9/2))-$Qcopds1/2-$Qcopds1/2-$Qtrasv22] 0
load 10021 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pL30x30x4*$d12001070/2+$pDA45x45x4*($Lx1200/2+$Lx950/2)+$pDA55x55x4*($Ly1002221/2+$d9/2))-$Qtrasv21] 0
load 10022 0 [expr -($pDA45x45x4*($ds2/2+$ds1/2)+$pDA55x55x4*($Ly1002221/2+$d10/2))-$Qcopds2/2-$Qcopds1/2-$Qtrasv22] 0
load 11021 0 [expr -($pDA45x45x4*($Lx950/2+$Lx950/2)+$pDA55x55x4*($Ly1102221/2+$d10/2*2))-$Qtrasv21] 0
load 11022 0 [expr -($pDA45x45x4*($ds2/2+$ds2/2)+$pDA55x55x4*($Ly1102221/2))-$Qcopds2/2-$Qcopds2/2-$Qtrasv22] 0
load 12021 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pL30x30x4*$d12001070/2+$pDA45x45x4*($Lx1200/2+$Lx950/2)+$pDA55x55x4*($Ly1002221/2+$d9/2))-$Qtrasv21] 0
load 12022 0 [expr -($pDA45x45x4*($ds2/2+$ds1/2)+$pDA55x55x4*($Ly1002221/2+$d10/2))-$Qcopds2/2-$Qcopds1/2-$Qtrasv22] 0
load 13021 0 [expr -($pRHS150x100x4*($Ly1070/2)+$pDA45x45x4*($Lx1200/2+$Lx1200/2)+$pDA55x55x4*($Ly902221/2+$d8/2))-$Qtrasv21] 0
load 13022 0 [expr -($pDA45x45x4*($ds1/2+$ds1/2)+$pDA55x55x4*($Ly902221/2+$d9/2))-$Qcopds1/2-$Qcopds1/2-$Qtrasv22] 0
load 14022 0 [expr -($pDA45x45x4*($ds2/2+$ds1/2)+$pDA55x55x4*($Ly802221/2+$d8/2))-$Qcopds2/2-$Qcopds1/2-$Qtrasv21] 0
load 14022 0 [expr -($pDA45x45x4*($ds2/2+$ds1/2)+$pDA55x55x4*($Ly802221/2+$d8/2))-$Qcopds2/2-$Qcopds1/2-$Qtrasv22] 0
load 15021 0 [expr -($pDA45x45x4*($Lx950/2+$Lx950/2)+$pDA55x55x4*($Ly702221/2+$d6/2))-$Qtrasv21] 0
load 15022 0 [expr -($pDA45x45x4*($ds2/2+$ds2/2)+$pDA55x55x4*($Ly702221/2+$d7/2))-$Qcopds2/2-$Qcopds2/2-$Qtrasv22] 0
load 16021 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pL30x30x4*$d12001070/2+$pDA45x45x4*($Lx1200/2+$Lx950/2)+$pDA55x55x4*($Ly602221/2+$d5/2))-$Qtrasv21] 0
load 16022 0 [expr -($pDA45x45x4*($ds2/2+$ds1/2)+$pDA55x55x4*($Ly602221/2+$d6/2))-$Qcopds2/2-$Qcopds1/2-$Qtrasv22] 0
load 17021 0 [expr -($pRHS150x100x4*($Ly1070/2)+$pDA45x45x4*($Lx1200/2+$Lx1200/2)+$pDA55x55x4*($Ly502221/2+$d4/2))-$Qtrasv21] 0
load 17022 0 [expr -($pDA45x45x4*($ds1/2+$ds1/2)+$pDA55x55x4*($Ly502221/2+$d5/2))-$Qcopds1/2-$Qcopds1/2-$Qtrasv22] 0
load 18021 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pL30x30x4*$d12001070/2+$pDA45x45x4*($Lx1200/2+$Lx950/2)+$pDA55x55x4*($Ly402221/2+$d3/2))-$Qtrasv21] 0
load 18022 0 [expr -($pDA45x45x4*($ds2/2+$ds1/2)+$pDA55x55x4*($Ly402221/2+$d4/2))-$Qcopds2/2-$Qcopds1/2-$Qtrasv22] 0
load 19021 0 [expr -($pDA45x45x4*($Lx950/2+$Lx950/2)+$pDA55x55x4*($Ly302221/2+$d2/2))-$Qtrasv21] 0
load 19022 0 [expr -($pDA45x45x4*($ds2/2+$ds2/2)+$pDA55x55x4*($Ly302221/2+$d3/2))-$Qcopds2/2-$Qcopds2/2-$Qtrasv22] 0
load 20021 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pL30x30x4*$d12001070/2+$pDA45x45x4*($Lx1200/2+$Lx950/2)+$pDA55x55x4*($Ly202221/2+$d1/2))-$Qtrasv21] 0
load 20022 0 [expr -($pDA45x45x4*($ds1/2+$ds2/2)+$pDA55x55x4*($Ly202221/2+$d2/2))-$Qcopds1/2-$Qcopds2/2-$Qtrasv22] 0
load 21021 0 [expr -($pRHS120x80x4*($Ly1070/2)+$pL30x30x4*$d12001070/2+$pDA45x45x4*$Lx1200/2+$pDA55x55x4*$Ly1000/2)-$Qbar1035-$Qtrasv21] 0
load 21022 0 [expr -($pDA45x45x4*$ds1/2+$pDA55x55x4*($Ly1000/2+$d1/2))-$Qbar500-$Qcopds1/2-$Qtrasv22] 0

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

# maintain constant gravity loads and reset time to zero
	loadConst -time 0.0
	puts "Model Built"

	
}
recorder Node -file $dataDir/Disp.out -time -node 1022 -dof 1 disp;
		
		
recorder Node -file $dataDir/Vbase.out -node 101 102 401 501 601 801 901 1001 1201 1301 1401 1601 1701 1801 2001 2101   -dof 1 reaction;


pattern Plain 3000 Linear {
	load 1022 0.01 0.0 0.0
}
RunPushover2Converge 1022 130 0.05

