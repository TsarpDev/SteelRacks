geomTransf	 Corotational 1
geomTransf	 PDelta 2
geomTransf	 Linear 3

set nIntPt 3
set maxIters 20
set tolIter 1.e-8



# uprights
#uprights FILA 1
element nonlinearBeamColumn   1   101   102 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
puts "$RHS120x80x10xS355"
element nonlinearBeamColumn   2   102   103 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
puts "$RHS120x80x10xS355"
element nonlinearBeamColumn   3   103   104 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   4   104   105 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   5   105   106 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   6   106   107 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   7   107   108 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   8   108   109 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   9   109   1010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   10   1010   1011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   11   1011   1012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   12   1012   1013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   13   1013   1014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   14   1014   1015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   15   1015   1016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   16   1016   1017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   17   1017   1018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   18   1018   1019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   19   1019   1020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   20   1020   1021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
#
##uprights FILA 2
element nonlinearBeamColumn   21   201   202 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   22   202   203 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   23   203   204 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   24   204   205 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   25   205   206 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   26   206   207 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   27   207   208 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   28   208   209 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   29   209   2010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   30   2010   2011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   31   2011   2012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   32   2012   2013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   33   2013   2014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   34   2014   2015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   35   2015   2016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   36   2016   2017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   37   2017   2018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   38   2018   2019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   39   2019   2020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   40   2020   2021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
#
##uprights FILA 4
element nonlinearBeamColumn   41   401   402 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   42   402   403 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   43   403   404 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   44   404   405 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   45   405   406 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   46   406   407 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   47   407   408 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   48   408   409 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   49   409   4010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   50   4010   4011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   51   4011   4012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   52   4012   4013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   53   4013   4014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   54   4014   4015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   55   4015   4016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   56   4016   4017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   57   4017   4018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   58   4018   4019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   59   4019   4020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   60   4020   4021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 5
element nonlinearBeamColumn   61   501   502 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   62   502   503 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   63   503   504 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   64   504   505 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   65   505   506 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   66   506   507 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   67   507   508 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   68   508   509 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   69   509   5010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   70   5010   5011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   71   5011   5012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   72   5012   5013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   73   5013   5014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   74   5014   5015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   75   5015   5016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   76   5016   5017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   77   5017   5018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   78   5018   5019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   79   5019   5020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   80   5020   5021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 6
element nonlinearBeamColumn   81   601   602 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   82   602   603 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   83   603   604 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   84   604   605 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   85   605   606 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   86   606   607 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   87   607   608 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   88   608   609 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   89   609   6010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   90   6010   6011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   91   6011   6012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   92   6012   6013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   93   6013   6014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   94   6014   6015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   95   6015   6016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   96   6016   6017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   97   6017   6018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   98   6018   6019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   99   6019   6020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   100   6020   6021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 8
element nonlinearBeamColumn   101   801   802 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   102   802   803 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   103   803   804 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   104   804   805 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   105   805   806 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   106   806   807 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   107   807   808 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   108   808   809 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   109   809   8010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   110   8010   8011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   111   8011   8012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   112   8012   8013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   113   8013   8014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   114   8014   8015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   115   8015   8016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   116   8016   8017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   117   8017   8018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   118   8018   8019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   119   8019   8020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   120   8020   8021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#
##uprights FILA 9
element nonlinearBeamColumn   121   901   902 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   122   902   903 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   123   903   904 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   124   904   905 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   125   905   906 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   126   906   907 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   127   907   908 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   128   908   909 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   129   909   9010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   130   9010   9011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   131   9011   9012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   132   9012   9013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   133   9013   9014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   134   9014   9015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   135   9015   9016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   136   9016   9017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   137   9017   9018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   138   9018   9019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   139   9019   9020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   140   9020   9021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 10
element nonlinearBeamColumn   141   1001   1002 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   142   1002   1003 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   143   1003   1004 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   144   1004   1005 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   145   1005   1006 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   146   1006   1007 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   147   1007   1008 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   148   1008   1009 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   149   1009   10010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   150   10010   10011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   151   10011   10012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   152   10012   10013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   153   10013   10014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   154   10014   10015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   155   10015   10016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   156   10016   10017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   157   10017   10018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   158   10018   10019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   159   10019   10020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   160   10020   10021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 12
element nonlinearBeamColumn   161   1201   1202 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   162   1202   1203 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   163   1203   1204 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   164   1204   1205 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   165   1205   1206 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   166   1206   1207 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   167   1207   1208 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   168   1208   1209 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   169   1209   12010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   170   12010   12011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   171   12011   12012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   172   12012   12013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   173   12013   12014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   174   12014   12015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   175   12015   12016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   176   12016   12017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   177   12017   12018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   178   12018   12019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   179   12019   12020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   180   12020   12021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 13
element nonlinearBeamColumn   181   1301   1302 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   182   1302   1303 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   183   1303   1304 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   184   1304   1305 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   185   1305   1306 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   186   1306   1307 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   187   1307   1308 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   188   1308   1309 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   189   1309   13010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   190   13010   13011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   191   13011   13012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   192   13012   13013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   193   13013   13014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   194   13014   13015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   195   13015   13016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   196   13016   13017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   197   13017   13018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   198   13018   13019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   199   13019   13020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   200   13020   13021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 14
element nonlinearBeamColumn   201   1401   1402 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   202   1402   1403 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   203   1403   1404 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   204   1404   1405 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   205   1405   1406 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   206   1406   1407 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   207   1407   1408 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   208   1408   1409 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   209   1409   14010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   210   14010   14011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   211   14011   14012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   212   14012   14013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   213   14013   14014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   214   14014   14015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   215   14015   14016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   216   14016   14017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   217   14017   14018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   218   14018   14019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   219   14019   14020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   220   14020   14021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 16
element nonlinearBeamColumn   221   1601   1602 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   222   1602   1603 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   223   1603   1604 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   224   1604   1605 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   225   1605   1606 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   226   1606   1607 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   227   1607   1608 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   228   1608   1609 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   229   1609   16010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   230   16010   16011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   231   16011   16012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   232   16012   16013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   233   16013   16014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   234   16014   16015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   235   16015   16016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   236   16016   16017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   237   16017   16018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   238   16018   16019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   239   16019   16020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   240   16020   16021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 17
element nonlinearBeamColumn   241   1701   1702 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   242   1702   1703 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   243   1703   1704 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   244   1704   1705 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   245   1705   1706 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   246   1706   1707 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   247   1707   1708 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   248   1708   1709 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   249   1709   17010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   250   17010   17011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   251   17011   17012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   252   17012   17013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   253   17013   17014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   254   17014   17015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   255   17015   17016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   256   17016   17017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   257   17017   17018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   258   17018   17019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   259   17019   17020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   260   17020   17021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 18
element nonlinearBeamColumn   261   1801   1802 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   262   1802   1803 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   263   1803   1804 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   264   1804   1805 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   265   1805   1806 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   266   1806   1807 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   267   1807   1808 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   268   1808   1809 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   269   1809   18010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   270   18010   18011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   271   18011   18012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   272   18012   18013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   273   18013   18014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   274   18014   18015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   275   18015   18016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   276   18016   18017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   277   18017   18018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   278   18018   18019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   279   18019   18020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   280   18020   18021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 20
element nonlinearBeamColumn   281   2001   2002 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   282   2002   2003 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   283   2003   2004 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   284   2004   2005 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   285   2005   2006 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   286   2006   2007 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   287   2007   2008 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   288   2008   2009 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   289   2009   20010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   290   20010   20011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   291   20011   20012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   292   20012   20013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   293   20013   20014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   294   20014   20015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   295   20015   20016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   296   20016   20017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   297   20017   20018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   298   20018   20019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   299   20019   20020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   300   20020   20021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter

#uprights FILA 21
element nonlinearBeamColumn   301   2101   2102 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   302   2102   2103 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   303   2103   2104 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   304   2104   2105 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   305   2105   2106 $nIntPt  $RHS120x80x10xS355  2 -iter $maxIters $tolIter

element nonlinearBeamColumn   306   2106   2107 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   307   2107   2108 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   308   2108   2109 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   309   2109   21010 $nIntPt  $RHS120x80x6xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   310   21010   21011 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   311   21011   21012 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   312   21012   21013 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   313   21013   21014 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   314   21014   21015 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   315   21015   21016 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   316   21016   21017 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   317   21017   21018 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   318   21018   21019 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   319   21019   21020 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter
element nonlinearBeamColumn   320   21020   21021 $nIntPt  $RHS120x80x4xS355  2 -iter $maxIters $tolIter


# beams
element nonlinearBeamColumn   321   10201   20201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   322   40201   50201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   323   50203   60201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   324   80201   90201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   325   90203   100201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   326   120201   130201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   327   130203   140201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   328   160201   170201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   329   170203   180201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   330   200201   210201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   331   10302   20302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   332   40302   50302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   333   50304   60302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   334   80302   90302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   335   90304   100302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   336   120302   130302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   337   130304   140302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   338   160302   170302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   339   170304   180302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   340   200302   210302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   341   10402   20402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   342   40401   50402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   343   50405   60401 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   344   80401   90402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   345   90405   100401 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   346   120401   130402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   347   130405   140401 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   348   160401   170402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   349   170405   180401 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   350   200402   210402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   351   10502   20502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   352   40502   50501 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   353   50502   60502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   354   80502   90501 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   355   90502   100502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   356   120502   130501 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   357   130502   140502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   358   160502   170501 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   359   170502   180502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   360   200502   210502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   361   10602   20602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   362   40601   50602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   363   50605   60601 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   364   80601   90602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   365   90605   100601 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   366   120601   130602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   367   130605   140601 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   368   160601   170602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   369   170605   180601 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   370   200602   210602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   371   10702   20702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   372   40702   50701 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   373   50702   60702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   374   80702   90701 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   375   90702   100702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   376   120702   130701 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   377   130702   140702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   378   160702   170701 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   379   170702   180702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   380   200702   210702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   381   10802   20802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   382   40801   50802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   383   50805   60801 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   384   80801   90802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   385   90805   100801 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   386   120801   130802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   387   130805   140801 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   388   160801   170802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   389   170805   180801 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   390   200802   210802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   391   10902   20902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   392   40902   50901 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   393   50902   60902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   394   80902   90901 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   395   90902   100902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   396   120902   130901 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   397   130902   140902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   398   160902   170901 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   399   170902   180902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   400   200902   210902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   401   101002   201002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   402   401001   501002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   403   501005   601001 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   404   801001   901002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   405   901005   1001001 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   406   1201001   1301002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   407   1301005   1401001 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   408   1601001   1701002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   409   1701005   1801001 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   410   2001002   2101002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   411   101102   201102 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   412   401102   501101 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   413   501102   601102 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   414   801102   901101 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   415   901102   1001102 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   416   1201102   1301101 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   417   1301102   1401102 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   418   1601102   1701101 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   419   1701102   1801102 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   420   2001102   2101102 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   421   101202   201202 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   422   401201   501202 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   423   501205   601201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   424   801201   901202 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   425   901205   1001201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   426   1201201   1301202 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   427   1301205   1401201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   428   1601201   1701202 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   429   1701205   1801201 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   430   2001202   2101202 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   431   101302   201302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   432   401302   501301 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   433   501302   601302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   434   801302   901301 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   435   901302   1001302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   436   1201302   1301301 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   437   1301302   1401302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   438   1601302   1701301 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   439   1701302   1801302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   440   2001302   2101302 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   441   101402   201402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   442   401401   501402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   443   501405   601401 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   444   801401   901402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   445   901405   1001401 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   446   1201401   1301402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   447   1301405   1401401 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   448   1601401   1701402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   449   1701405   1801401 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   450   2001402   2101402 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   451   101502   201502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   452   401502   501501 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   453   501502   601502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   454   801502   901501 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   455   901502   1001502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   456   1201502   1301501 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   457   1301502   1401502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   458   1601502   1701501 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   459   1701502   1801502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   460   2001502   2101502 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   461   101602   201602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   462   401601   501602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   463   501605   601601 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   464   801601   901602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   465   901605   1001601 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   466   1201601   1301602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   467   1301605   1401601 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   468   1601601   1701602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   469   1701605   1801601 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   470   2001602   2101602 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   471   101702   201702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   472   401702   501701 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   473   501702   601702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   474   801702   901701 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   475   901702   1001702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   476   1201702   1301701 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   477   1301702   1401702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   478   1601702   1701701 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   479   1701702   1801702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   480   2001702   2101702 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   481   101802   201802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   482   401801   501802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   483   501805   601801 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   484   801801   901802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   485   901805   1001801 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   486   1201801   1301802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   487   1301805   1401801 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   488   1601801   1701802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   489   1701805   1801801 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   490   2001802   2101802 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   491   101902   201902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   492   401902   501901 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   493   501902   601902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   494   801902   901901 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   495   901902   1001902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   496   1201902   1301901 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   497   1301902   1401902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   498   1601902   1701901 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   499   1701902   1801902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   500   2001902   2101902 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

element nonlinearBeamColumn   501   102002   202002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   502   402001   502002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   503   502005   602001 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   504   802001   902002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   505   902005   1002001 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   506   1202001   1302002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   507   1302005   1402001 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   508   1602001   1702002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   509   1702005   1802001 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   510   2002002   2102002 $nIntPt  $DC80x50x3xS355  3 -iter $maxIters $tolIter

#tence bracings
element nonlinearBeamColumn   511   10202   20301 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   512   10303   20401 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   513   10403   20501 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   514   10503   20601 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   515   10603   20701 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   516   10703   20801 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   517   10803   20901 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   518   10903   201001 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   519   101003   201101 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   520   101103   201201 $nIntPt  $L35x35x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   521   101203   201301 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   522   101303   201401 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   523   101403   201501 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   524   101503   201601 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   525   101603   201701 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   526   101703   201801 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   527   101803   201901 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   528   101903   202001 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   529   102003   202101 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   530   40202   50301 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   531   50204   60301 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   532   40303   50401 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   533   50406   60501 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   534   40503   50601 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   535   50606   60701 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   536   40703   50801 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   537   50806   60901 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   538   40903   501001 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   539   501006   601101 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   540   401103   501201 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   541   501206   601301 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   542   401303   501401 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   543   501406   601501 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   544   401503   501601 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   545   501606   601701 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   546   401703   501801 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   547   501806   601901 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   548   401903   502001 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   549   502006   602101 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   550   80202   90301 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   551   90204   100301 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   552   80303   90401 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   553   90406   100501 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   554   80503   90601 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   555   90606   100701 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   556   80703   90801 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   557   90806   100901 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   558   80903   901001 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   559   901006   1001101 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   560   801103   901201 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   561   901206   1001301 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   562   801303   901401 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   563   901406   1001501 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   564   801503   901601 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   565   901606   1001701 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   566   801703   901801 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   567   901806   1001901 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   568   801903   902001 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   569   902006   1002101 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   570   120202   130301 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   571   130204   140301 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   572   120303   130401 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   573   130406   140501 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   574   120503   130601 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   575   130606   140701 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   576   120703   130801 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   577   130806   140901 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   578   120903   1301001 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   579   1301006   1401101 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   580   1201103   1301201 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   581   1301206   1401301 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   582   1201303   1301401 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   583   1301406   1401501 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   584   1201503   1301601 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   585   1301606   1401701 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   586   1201703   1301801 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   587   1301806   1401901 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   588   1201903   1302001 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   589   1302006   1402103 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   590   160202   170301 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   591   170204   180301 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   592   160303   170401 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   593   170406   180501 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   594   160503   170601 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   595   170606   180701 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   596   160703   170801 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   597   170806   180901 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   598   160903   1701001 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   599   1701006   1801101 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   600   1601103   1701201 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   601   1701206   1801301 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   602   1601303   1701401 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   603   1701406   1801501 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   604   1601503   1701601 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   605   1701606   1801701 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   606   1601703   1701801 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   607   1701806   1801901 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   608   1601903   1702001 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   609   1702006   1802103 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   610   200202   210301 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   611   200303   210401 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   612   200403   210501 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   613   200503   210601 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   614   200603   210701 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   615   200703   210801 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   616   200803   210901 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   617   200903   2101001 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   618   2001003   2101101 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   619   2001103   2101201 $nIntPt  $L35x35x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   620   2001203   2101301 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   621   2001303   2101401 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   622   2001403   2101501 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   623   2001503   2101601 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   624   2001603   2101701 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   625   2001703   2101801 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   626   2001803   2101901 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   627   2001903   2102001 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   628   2002003   2102101 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

##bracings in compression
#bracings between uprights 1 e 2
element nonlinearBeamColumn   629   10301   23121 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   630   23121   23122 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   631   10301   23123 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   632   23123   20202 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   633   10401   34121 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   634   34121   34122 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   635   34122   34123 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   636   34123   20303 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   637   10501   45121 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   638   45121   45122 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   639   45122   45123 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   640   45123   20403 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   641   10601   56121 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   642   56121   56122 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   643   56122   56123 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   644   56123   20503 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   645   10701   67121 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   646   67121   67122 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   647   67122   67123 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   648   67123   20603 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   649   10801   78121 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   650   78121   78122 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   651   78122   78123 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   652   78123   20703 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   653   10901   89121 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   654   89121   89122 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   655   89122   89123 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   656   89123   20803 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   657   101001   910121 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   658   910121   910122 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   659   910122   910123 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   660   910123   20903 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   661   101101   1011121 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   662   1011121   1011122 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   663   1011122   1011123 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   664   1011123   201003 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   665   101201   1112121 $nIntPt  $L35x35x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   666   1112121   1112122 $nIntPt  $L35x35x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   667   1112122   1112123 $nIntPt  $L35x35x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   668   1112123   201103 $nIntPt  $L35x35x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   669   101301   1213121 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   670   1213121   1213122 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   671   1213122   1213123 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   672   1213123   201203 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   673   101401   1314121 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   674   1314121   1314122 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   675   1314122   1314123 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   676   1314123   201303 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   677   101501   1415121 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   678   1415121   1415122 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   679   1415122   1415123 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   680   1415123   201403 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   681   101601   1516121 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   682   1516121   1516122 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   683   1516122   1516123 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   684   1516123   201503 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   685   101701   1617121 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   686   1617121   1617122 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   687   1617122   1617123 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   688   1617123   201603 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   689   101801   1718121 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   690   1718121   1718122 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   691   1718122   1718123 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   692   1718123   201703 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   693   101901   1819121 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   694   1819121   1819122 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   695   1819122   1819123 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   696   1819123   201803 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   697   102001   1920121 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   698   1920121   1920122 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   699   1920122   1920123 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   700   1920123   201903 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   701   102101   2021121 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   702   2021121   2021122 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   703   2021122   2021123 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   704   2021123   202003 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
#
##bracings between uprights 4-5-6
element nonlinearBeamColumn   705   40301   23451 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   706   23451   23452 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   707   23452   23453 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   708   23453   50202 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   709   50303   23561 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   710   23561   23562 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   711   23562   23563 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   712   23563   60202 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   713   50404   34561 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   714   34561   34562 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   715   34562   34563 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   716   34563   60303 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   717   40501   45451 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   718   45451   45452 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   719   45452   45453 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   720   45453   50403 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   721   50604   56561 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   722   56561   56562 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   723   56562   56563 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   724   56563   60503 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   725   40701   67451 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   726   67451   67452 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   727   67452   67453 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   728   67453   50603 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   729   50804   78561 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   730   78561   78562 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   731   78562   78563 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   732   78563   60703 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   733   40901   89451 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   734   89451   89452 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   735   89452   89453 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   736   89453   50803 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   737   501004   910561 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   738   910561   910562 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   739   910562   910563 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   740   910563   60903 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   741   401101   1011451 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   742   1011451   1011452 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   743   1011452   1011453 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   744   1011453   501003 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   745   501204   1112561 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   746   1112561   1112562 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   747   1112562   1112563 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   748   1112563   601103 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   749   401301   1213451 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   750   1213451   1213452 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   751   1213452   1213453 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   752   1213453   501203 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   753   501404   1314561 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   754   1314561   1314562 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   755   1314562   1314563 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   756   1314563   601303 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   757   401501   1415451 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   758   1415451   1415452 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   759   1415452   1415453 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   760   1415453   501403 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   761   501604   1516561 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   762   1516561   1516562 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   763   1516562   1516563 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   764   1516563   601503 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   765   401701   1617451 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   766   1617451   1617452 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   767   1617452   1617453 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   768   1617453   501603 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   769   501804   1718561 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   770   1718561   1718562 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   771   1718562   1718563 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   772   1718563   601703 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   773   401901   1819451 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   774   1819451   1819452 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   775   1819452   1819453 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   776   1819453   501803 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   777   502004   1920561 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   778   1920561   1920562 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   779   1920562   1920563 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   780   1920563   601903 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   781   402103   2021451 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   782   2021451   2021452 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   783   2021452   2021453 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   784   2021453   502003 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

#bracings between uprights 8-9-10
element nonlinearBeamColumn   785   80301   23891 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   786   23891   23892 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   787   23892   23893 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   788   23893   90202 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   789   90303   239101 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   790   239101   239102 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   791   239102   239103 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   792   239103   100202 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   793   90404   349101 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   794   349101   349102 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   795   349102   349103 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   796   349103   100303 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   797   80501   45891 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   798   45891   45892 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   799   45892   45893 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   800   45893   90403 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   801   90604   569101 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   802   569101   569102 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   803   569102   569103 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   804   569103   100503 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   805   80701   67891 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   806   67891   67892 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   807   67892   67893 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   808   67893   90603 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   809   90804   789101 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   810   789101   789102 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   811   789102   789103 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   812   789103   100703 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   813   80901   89891 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   814   89891   89892 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   815   89892   89893 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   816   89893   90803 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   817   901004   9109101 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   818   9109101   9109102 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   819   9109102   9109103 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   820   9109103   100903 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   821   801101   1011891 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   822   1011891   1011892 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   823   1011892   1011893 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   824   1011893   901003 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   825   901204   11129101 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   826   11129101   11129102 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   827   11129102   11129103 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   828   11129103   1001103 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   829   801301   1213891 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   830   1213891   1213892 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   831   1213892   1213893 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   832   1213893   901203 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   833   901404   13149101 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   834   13149101   13149102 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   835   13149102   13149103 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   836   13149103   1001303 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   837   801501    1415891 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   838   1415891   1415892 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   839   1415892   1415893 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   840   1415893   901403 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   841   901604     15169101 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   842   15169101   15169102 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   843   15169102   15169103 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   844   15169103   1001503 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   845   801701    1617891 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   846   1617891   1617892 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   847   1617892   1617893 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   848   1617893   901603 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   849   901804     17189101 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   850   17189101   17189102 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   851   17189102   17189103 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   852   17189103   1001703 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   853   801901    1819891 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   854   1819891   1819892 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   855   1819892   1819893 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   856   1819893   901803 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   857   902004     19209101 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   858   19209101   19209102 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   859   19209102   19209103 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   860   19209103   1001903 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   861   802103    2021891 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   862   2021891   2021892 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   863   2021892   2021893 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   864   2021893   902003 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

#bracings between uprights 12-13-14
element nonlinearBeamColumn   865   120301     2312131 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   866   2312131    2312132 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   867   2312132    2312133 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   868   2312133    130202 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   869   130303     2313141 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   870   2313141    2313142 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   871   2313142    2313143 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   872   2313143    140202 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   873   130404     3413141 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   874   3413141    3413142 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   875   3413142    3413143 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   876   3413143    140303 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   877   120501     4512131 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   878   4512131    4512132 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   879   4512132    4512133 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   880   4512133    130403 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   881   130604     5613141 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   882   5613141    5613142 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   883   5613142    5613143 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   884   5613143    140503 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   885   120701     6712131 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   886   6712131    6712132 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   887   6712132    6712133 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   888   6712133    130603 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
 
element nonlinearBeamColumn   889   130804     7813141 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   890   7813141    7813142 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   891   7813142    7813143 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   892   7813143    140703 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   893   120901     8912131 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   894   8912131    8912132 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   895   8912132    8912133 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   896   8912133    130803 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   897   1301004     91013141 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   898   91013141    91013142 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   899   91013142    91013143 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   901   91013143    140903 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   902   1201101     101112131 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   903   101112131   101112132 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   904   101112132   101112133 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   905   101112133   1301003 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   906   1301204     111213141 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   907   111213141   111213142 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   908   111213142   111213143 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   909   111213143   1401103 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   910   1201301     121312131 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   911   121312131   121312132 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   912   121312132   121312133 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   913   121312133   1301203 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   914   1301404     131413141 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   915   131413141   131413142 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   916   131413142   131413143 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   917   131413143   1401303 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   918   1201501     141512131 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   919   141512131   141512132 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   920   141512132   141512133 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   921   141512133   1301403 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   922   1301604     151613141 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   923   151613141   151613142 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   924   151613142   151613143 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   925   151613143   1401503 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   926   1201701     161712131 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   927   161712131   161712132 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   928   161712132   161712133 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   929   161712133   1301603 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   930   1301804     171813141 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   931   171813141   171813142 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   932   171813142   171813143 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   933   171813143   1401703 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   934   1201901     181912131 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   935   181912131   181912132 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   936   181912132   181912133 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   937   181912133   1301803 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   938   1302004     192013141 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   939   192013141   192013142 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   940   192013142   192013143 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   941   192013143   1401903 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   942   1202101     202112131 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   943   202112131   202112132 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   944   202112132   202112133 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   945   202112133   1302003 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

#bracings between uprights 16-17-18 
element nonlinearBeamColumn   946   160301     2316171 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   947   2316171    2316172 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   948   2316172    2316173 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   949   2316173    170202 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   950   170303     2317181 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   951   2317181    2317182 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   952   2317182    2317183 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   953   2317183    180202 $nIntPt  $L40x40x4xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   954   170404     3417181 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   955   3417181    3417182 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   956   3417182    3417183 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   957   3417183    180303 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   958   160501     4516171 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   959   4516171    4516172 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   960   4516172    4516173 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   961   4516173    170403 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   962   170604     5617181 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   963   5617181    5617182 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   964   5617182    5617183 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   965   5617183    180503 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   966   160701     6716171 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   967   6716171    6716172 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   968   6716172    6716173 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   969   6716173    170603 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   970   170804     7817181 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   971   7817181    7817182 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   972   7817182    7817183 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   973   7817183    180703 $nIntPt  $RHS30x30x2punto5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   974   160901     8916171 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   975   8916171    8916172 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   976   8916172    8916173 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   977   8916173    170803 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   978   1701004    91017181 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   979   91017181   91017182 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   980   91017182   91017183 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   981   91017183   180903 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   982   1601101      101116171 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   983   101116171    101116172 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   984   101116172    101116173 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   985   101116173    1701003 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   986   1701204      111217181 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   987   111217181    111217182 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   988   111217182    111217183 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   989   111217183    1801103 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   990   1601301      121316171 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   991   121316171    121316172 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   992   121316172    121316173 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   993   121316173    1701203 $nIntPt  $RHS30x30x2punto5xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   994   1701404      131417181 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   995   131417181    131417182 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   996   131417182    131417183 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   997   131417183    1801303 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   998   1601501      141516171 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   999   141516171    141516172 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1001   141516172   141516173 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1002   141516173   1701403 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1003   1701604     151617181 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1004   151617181   151617182 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1005   151617182   151617183 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1006   151617183   1801503 $nIntPt  $RHS30x30x2punto5xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1007   1601701     161716171 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1008   161716171   161716172 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1009   161716172   161716173 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1010   161716173   1701603 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1011   1701804     171817181 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1012   171817181   171817182 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1013   171817182   171817183 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1014   171817183   1801703 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1015   1601901     181916171 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1016   181916171   181916172 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1017   181916172   181916173 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1018   181916173   1701803 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1019   1702004     192017181 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1020   192017181   192017182 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1021   192017182   192017183 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1022   192017183   1801903 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1023   1602101     202116171 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1024   202116171   202116172 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1025   202116172   202116173 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1026   202116173   1702003 $nIntPt  $RHS30x30x2xS235  1 -iter $maxIters $tolIter

#bracings between uprights 20 e 21 
element nonlinearBeamColumn   1027   200301    2320211 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1028   2320211   2320212 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1029   2320212   2320213 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1030   2320213   210202 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1031   200401    3420211 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1032   3420211   3420212 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1033   3420212   3420213 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1034   3420213   210303 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1035   200501    4520211 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1036   4520211   4520212 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1037   4520212   4520213 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1038   4520213   210403 $nIntPt  $L40x40x5xS355  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1039   200601    5620211 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1040   5620211   5620212 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1041   5620212   5620213 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1042   5620213   210503 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1043   200701    6720211 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1044   6720211   6720212 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1045   6720212   6720213 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1046   6720213   210603 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1047   200801    7820211 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1048   7820211   7820212 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1049   7820212   7820213 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1050   7820213   210703 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1051   200901     8920211 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1052   8920211   8920212 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1053   8920212   8920213 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1054   8920213   210803 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1055   2001001     91020211 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1056   91020211   91020212 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1057   91020212   91020213 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1058   91020213   210903 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1059   2001101     101120211 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1060   101120211   101120212 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1061   101120212   101120213 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1062   101120213   2101003 $nIntPt  $L40x40x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1063   2001201     111220211 $nIntPt  $L35x35x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1064   111220211   111220212 $nIntPt  $L35x35x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1065   111220212   111220213 $nIntPt  $L35x35x4xS275  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1066   111220213   2101103 $nIntPt  $L35x35x4xS275  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1067   2001301     121320211 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1068   121320211   121320212 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1069   121320212   121320213 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1070   121320213   2101203 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1071   2001401     131420211 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1072   131420211   131420212 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1073   131420212   131420213 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1074   131420213   2101303 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1075   2001501     141520211 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1076   141520211   141520212 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1077   141520212   141520213 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1078   141520213   2101403 $nIntPt  $L35x35x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1079   2001601     151620211 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1080   151620211   151620212 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1081   151620212   151620213 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1082   151620213   2101503 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1083   2001701     161720211 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1084   161720211   161720212 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1085   161720212   161720213 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1086   161720213   2101603 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1087   2001801     171820211 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1088   171820211   171820212 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1089   171820212   171820213 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1090   171820213   2101703 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1091   2001901     181920211 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1092   181920211   181920212 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1093   181920212   181920213 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1094   181920213   2101803 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1095   2002001     192020211 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1096   192020211   192020212 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1097   192020212   192020213 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1098   192020213   2101903 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

element nonlinearBeamColumn   1099   2002101     202120211 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1100   202120211   202120212 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1101   202120212   202120213 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter
element nonlinearBeamColumn   1102   202120213   2102003 $nIntPt  $L30x30x4xS235  1 -iter $maxIters $tolIter

#truss
##diagonal elements 
element nonlinearBeamColumn   1103   1021     1022 $nIntPt  $DA55x55x4xS355    3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1104   102201   202103 $nIntPt  $DA55x55x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1105   2021     2022 $nIntPt  $DA55x55x4xS355    3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1106   202202   302101 $nIntPt  $DA55x55x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1107   302102   302201 $nIntPt  $DA55x55x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1108   302202   402102 $nIntPt  $DA55x55x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1109   4021     4022 $nIntPt  $DA55x55x4xS355    3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1110   402202   502102 $nIntPt  $DA55x55x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1111   5021     5022 $nIntPt  $DA55x55x4xS355    3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1112   502202   602103 $nIntPt  $DA55x55x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1113   6021     6022 $nIntPt  $DA55x55x4xS355    3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1114   602202   702101 $nIntPt  $DA55x55x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1115   702102   702201 $nIntPt  $DA55x55x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1116   702202   802102 $nIntPt  $DA55x55x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1117   8021     8022 $nIntPt  $DA55x55x4xS355    3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1118   802202   902102 $nIntPt  $DA55x55x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1119   9021     9022 $nIntPt  $DA55x55x4xS355    3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1120   902202   1002103 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1121   10021    10022 $nIntPt  $DA55x55x4xS355   3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1122   1002202  1102101 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1123   1102102  1102201 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1124   1102103  1202202 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1125   12021    12022 $nIntPt  $DA55x55x4xS355   3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1126   1202103  1302202 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1127   13021    13022 $nIntPt  $DA55x55x4xS355   3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1128   1302102  1402202 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1129   14021    14022 $nIntPt  $DA55x55x4xS355   3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1130   1402102  1502202 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1131   1502102  1502201 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1132   1502101  1602202 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1133   16021    16022 $nIntPt  $DA55x55x4xS355   3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1134   1602103  1702202 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1135   17021    17022 $nIntPt  $DA55x55x4xS355   3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1136   1702102  1802202 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1137   18021    18022 $nIntPt  $DA55x55x4xS355   3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1138   1802102  1902202 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1139   1902102  1902201 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1140   1902101  2002202 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1141   20021    20022 $nIntPt  $DA55x55x4xS355   3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1142   2002103  2102201 $nIntPt  $DA55x55x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1143   21021    21022 $nIntPt  $DA55x55x4xS355   3 -iter $maxIters $tolIter

#upper and lower elements 
element nonlinearBeamColumn   1144   102202   202201 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1145   202203   3022 $nIntPt  $DA45x45x4xS355    3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1146   302203   402201 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1147   402203   502201 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1148   502203   602201 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1149   602203   7022 $nIntPt  $DA45x45x4xS355    3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1150   702203   802201 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1151   802203   902201 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1152   902203   1002201 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1153   1002203  11022 $nIntPt  $DA45x45x4xS355   3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1154   1102202  1202203 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1155   1202201  1302203 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1156   1302201  1402203 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1157   1402201  1502203 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1158   15022    1602203 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1159   1602201  1702203 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1160   1702201  1802203 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1161   1802201  1902203 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1162   19022    2002203 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1163   2002201  2102202 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
                                                                               
element nonlinearBeamColumn   1164   102102   202102 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1165   202104   3021 $nIntPt  $DA45x45x4xS355    3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1166   302103   402101 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1167   402104   502101 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1168   502103   602102 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1169   602104   7021 $nIntPt  $DA45x45x4xS355    3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1170   702103   802101 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1171   802104   902101 $nIntPt  $DA45x45x4xS355  3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1172   902103   1002102 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1173   1002104  11021 $nIntPt  $DA45x45x4xS355   3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1174   1102104  1202104 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1175   1202102  1302103 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1176   1302101  1402104 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1177   1402101  1502103 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1178   15021    1602104 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1179   1602102  1702103 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1180   1702101  1802104 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1181   1802101  1902103 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1182   19021    2002104 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter
element nonlinearBeamColumn   1183   2002102  2102102 $nIntPt  $DA45x45x4xS355 3 -iter $maxIters $tolIter

