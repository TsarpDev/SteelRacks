#LE UNITà DI MISURA SONO kN e mm

# materials 

set S235 1 
uniaxialMaterial Steel02 $S235 0.235 210.0 0.0 18 0.925 0.15

set S275 2 
uniaxialMaterial Steel02 $S275 0.275 210.0 0.0 18 0.925 0.15

set S355 3 
uniaxialMaterial Steel02 $S355 0.355 210.0 0.0 18 0.925 0.15

#nfdw is the number of fibers along web depth 
#nftw is the number of fibers along web thickness 
#nfbf is the number of fibers along flange depth 
#nftf is the number of fibers along flange thickness 

#uprights sections 

set RHS120x80x4xS355 4 
 TorsProc 401  402  403  3300000  608  912  80.77
 RHS 400  $S355  80  120  4  4  0  0  0  
section Aggregator $RHS120x80x4xS355 401  Vy  402  Vz  403  T  -section 400  
#set AreaRHS120x80x4 [expr 2*(120*4+(80-4*2)*4)]

set RHS120x80x6xS355 5 
 TorsProc 501  502  503  4680000  888  1332  80.77
 RHS 500  $S355  80  120  6  6  0  0  0  
 section Aggregator $RHS120x80x6xS355 501  Vy  502  Vz  503  T  -section 500  
#set AreaRHS120x80x6 [expr 2*(120*6+(80-6*2)*6)]

set RHS120x80x10xS355 6 
 TorsProc 601  602  603  6880000  1396  2094  80.77
 RHS 600  $S355  80  120  10  10  0  0  0  
 section Aggregator $RHS120x80x10xS355 601  Vy  602  Vz  603  T  -section 600 
#set AreaRHS120x80x10 [expr 2*(120*10+(80-10*2)*10)]

set RHS150x100x4xS355 7 
 TorsProc 701  702  703  6600000  768  1152  80.77
 RHS 700  $S355  100  150  4  4  0  0  0  
 section Aggregator $RHS150x100x4xS355 701  Vy  702  Vz  703  T  -section 700
#set AreaRHS150x100x4 [expr 2*(150*4+(100-4*2)*4)]

set RHS150x100x6xS355 8 
 TorsProc 801  802  803  9460000  1128  1692  80.77
 RHS 800  $S355  100  150  6  6  0  0  0  
 section Aggregator $RHS150x100x6xS355 801  Vy  802  Vz  803  T  -section 800
#set AreaRHS150x100x6 [expr 2*(150*6+(100-6*2)*6)]

set RHS150x100x10xS355 9 
 TorsProc 901  902  903  14320000  1796  2694  80.77
 RHS 900  $S355  100  150  10  10  0  0  0  
 section Aggregator $RHS150x100x10xS355 901  Vy  902  Vz  903  T  -section 900
#set AreaRHS150x100x10 [expr 2*(150*10+(100-10*2)*10)]

#truss elements sections

set DA45x45x4xS355 10 
 TorsProc 1001  1002  1003  3669  360  298.8  80.77
 DoubleAngle 1000  $S355  45  96  4  4  0  0  6  
 section Aggregator $DA45x45x4xS355 1001  Vy  1002  Vz  1003  T  -section 1000
#set AreaDA45x45x4 [expr 2*(45*4+((96-6)/2-4)*4)]

set DA55x55x4xS355 11 
 TorsProc 1101  1102  1103  4523  440  365.2  80.77
 DoubleAngle 1100  $S355  55  116  4  4  0  0  6  
 section Aggregator $DA55x55x4xS355 1101  Vy  1102  Vz  1103  T  -section 1100
#set AreaDA55x55x4 [expr 2*(55*4+((116-6)/2-4)*4)]

#beams

set DC80x50x3xS355 12 
 TorsProc 1201  1202  1203  3029.94  480  600  80.77
 DoubleChannel 1200  $S355  80  105  3  3  0  0  5  
 section Aggregator $DC80x50x3xS355 1201  Vy  1202  Vz  1203  T  -section 1200
#set AreaDC80x50x3 [expr 2*(80*3+2*((105-5)/2-3)*3)]

#bracings

set L30x30x4xS235 13 
 TorsProc 1301  1302  1303  1131.95  120  120  80.77
 Angle 1300  $S235  30  30  4  4  0  0  0  
 section Aggregator $L30x30x4xS235 1301  Vy  1302  Vz  1303  T  -section  1300
#set AreaL30x30x4 [expr (30*4-(30-4)*4)]

set L35x35x4xS235 14 
 TorsProc 1401  1402  1403  1345.28  140  140  80.77
 Angle 1400  $S235  35  35  4  4  0  0  0  
 section Aggregator $L35x35x4xS235 1401  Vy  1402  Vz  1403  T  -section  1400
#set AreaL35x35x4 [expr (35*4-(35-4)*4)]

set L35x35x4xS275 15 
 TorsProc 1501  1502  1503  1345.28  140  140  80.77
 Angle 1500  $S275  35  35  4  4  0  0  0  
 section Aggregator $L35x35x4xS275 1501  Vy  1502  Vz  1503  T  -section  1500

set L40x40x4xS275 16 
 TorsProc 1601  1602  1603  1621  160  160  80.77
 Angle 1600  $S275  40  40  4  4  0  0  0  
 section Aggregator $L40x40x4xS275 1601  Vy  1602  Vz  1603  T  -section  1600
#set AreaL40x40x4 [expr (40*4-(40-4)*4)]

set L40x40x4xS355 17 
 TorsProc 1701  1702  1703  1621  160  160  80.77
 Angle 1700  $S355  40  40  4  4  0  0  0  
 section Aggregator $L40x40x4xS355 1701  Vy  1702  Vz  1703  T  -section  1700

set L40x40x5xS355 18 
 TorsProc 1801  1802  1803  2971.88  200  200  80.77
 Angle 1800  $S355  40  40  5  5  0  0  0  
 section Aggregator $L40x40x5xS355 1801  Vy  1802  Vz  1803  T  -section  1800
#set AreaL40x40x5 [expr (50*5-(50-5)*5)]

set RHS30x30x2xS235 19 
 TorsProc 1901  1902  1903  43904  120  120  80.77
 RHS 1900  $S235  30  30  2  2  0  0  0  
 section Aggregator $RHS30x30x2xS235 1901  Vy  1902  Vz  1903  T  -section 1900
#set AreaRHS30x30x2 [expr 2*(30*2+(30-2*2)*2)]

set RHS30x30x2punto5xS235 20 
 TorsProc 2001  2002  2003  51992.19  150  150  80.77
 RHS 2000  $S235  30  30  2.5  2.5  0  0  0  
 section Aggregator $RHS30x30x2punto5xS235 2001  Vy  2002  Vz  2003  T  -section 2000
#set AreaRHS30x30x2punto5 [expr 2*(30*2.5+(30-2.5*2)*2.5)]

set RHS30x30x2punto5xS275 21 
 TorsProc 2101  2102  2103  51992.19  150  150  80.77
 RHS 2100  $S275  30  30  2.5  2.5  0  0  0  
 section Aggregator $RHS30x30x2punto5xS275 2101  Vy  2102  Vz  2103  T  -section 2100

set RHS30x30x2punto5xS355 22 
 TorsProc 2201  2202  2203  51992.19  150  150  80.77
 RHS 2200  $S355  30  30  2.5  2.5  0  0  0  
 section Aggregator $RHS30x30x2punto5xS355 2201  Vy  2202  Vz  2203  T  -section 2200

