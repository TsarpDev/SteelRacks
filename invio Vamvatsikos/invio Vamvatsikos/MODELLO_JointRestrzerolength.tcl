fix 101 1 1 0   
fix 201 1 1 0     
fix 401 1 1 0   
fix 501 1 1 0   
fix 601 1 1 0   
fix 801 1 1 0   
fix 901 1 1 0   
fix 1001 1 1 0    
fix 1201 1 1 0   
fix 1301 1 1 0   
fix 1401 1 1 0   
fix 1601 1 1 0   
fix 1701 1 1 0 
fix 1801 1 1 0   
fix 2001 1 1 0 
fix 2101 1 1 0
#
set rigido 101
uniaxialMaterial Elastic $rigido 210000000

set norigido 102
uniaxialMaterial Elastic $norigido 1

#file 1 e 2 
element zeroLength 1184 102 10201      -mat  $rigido $rigido $norigido -dir  1 2 3   
element zeroLength 1185 102 10202      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1186 202 20201      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1187 202 20202      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                                              
element zeroLength 1189 103 10301      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1190 103 10302      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1191 103 10303      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1192 203 20301      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1193 203 20302      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1194 203 20303      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                              
element zeroLength 1196 104 10401      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1197 104 10402      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1198 104 10403      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1199 204 20401      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1200 204 20402      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1201 204 20403      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1203 105 10501      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1204 105 10502      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1205 105 10503      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1206 205 20501      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1207 205 20502      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1208 205 20503      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1210 106 10601      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1211 106 10602      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1212 106 10603      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1213 206 20601      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1214 206 20602      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1215 206 20603      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1217 107 10701      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1218 107 10702      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1219 107 10703      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1220 207 20701      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1221 207 20702      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1222 207 20703      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1224 108 10801      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1225 108 10802      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1226 108 10803      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1227 208 20801      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1228 208 20802      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1229 208 20803      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1231 109 10901      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1232 109 10902      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1233 109 10903      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1234 209 20901      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1235 209 20902      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1236 209 20903      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1238 1010 101001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1239 1010 101002    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1240 1010 101003    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1241 2010 201001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1242 2010 201002    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1243 2010 201003    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1245 1011 101101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1246 1011 101102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1247 1011 101103    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1248 2011 201101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1249 2011 201102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1250 2011 201103    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1252 1012 101201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1253 1012 101202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1254 1012 101203    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1255 2012 201201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1256 2012 201202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1257 2012 201203    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1259 1013 101301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1260 1013 101302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1261 1013 101303    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1262 2013 201301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1263 2013 201302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1264 2013 201303    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1266 1014 101401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1267 1014 101402    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1268 1014 101403    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1269 2014 201401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1270 2014 201402    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1271 2014 201403    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1273 1015 101501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1274 1015 101502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1275 1015 101503    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1276 2015 201501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1277 2015 201502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1278 2015 201503    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1280 1016 101601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1281 1016 101602    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1282 1016 101603    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1283 2016 201601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1284 2016 201602    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1285 2016 201603    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1287 1017 101701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1288 1017 101702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1289 1017 101703    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1290 2017 201701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1291 2017 201702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1292 2017 201703    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1294 1018 101801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1295 1018 101802    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1296 1018 101803    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1297 2018 201801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1298 2018 201802    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1299 2018 201803    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1301 1019 101901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1302 1019 101902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1303 1019 101903    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1304 2019 201901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1305 2019 201902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1306 2019 201903    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1308 1020 102001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1309 1020 102002    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1310 1020 102003    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1311 2020 202001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1312 2020 202002    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1313 2020 202003    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1315 1021 102101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1316 1021 102102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1317 2021 202101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1318 2021 202102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1319 2021 202103    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1320 2021 202104    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1322 1022 102201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1323 1022 102202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1324 2022 202201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1325 2022 202202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1326 2022 202203    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
##fila 3                                                     
element zeroLength 1329 3021 302101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1330 3021 302102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1331 3021 302103    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1332 3022 302201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1333 3022 302202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1334 3022 302203    -mat  $rigido $rigido $norigido -dir  1 2 3 
#                                                             
##file 4, 5 e 6                                              
element zeroLength 1337 402 40201      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1338 402 40202      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1339 502 50201      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1340 502 50202      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1341 502 50203      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1342 502 50204      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1343 602 60201      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1344 602 60202      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1346 403 40301      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1347 403 40302      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1348 403 40303      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1349 503 50301      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1350 503 50302      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1351 503 50303      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1352 503 50304      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1353 603 60301      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1354 603 60302      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1355 603 60303      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1357 404 40401      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1358 504 50401      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1359 504 50402      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1360 504 50403      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1361 504 50404      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1362 504 50405      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1363 504 50406      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1364 604 60401      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1366 405 40501      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1367 405 40502      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1368 405 40503      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1369 505 50501      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1370 505 50502      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1371 605 60501      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1372 605 60502      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1373 605 60503      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1375 406 40601      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1376 506 50601      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1377 506 50602      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1378 506 50603      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1379 506 50604      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1380 506 50605      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1381 506 50606      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1382 606 60601      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1384 407 40701      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1385 407 40702      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1386 407 40703      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1387 507 50701      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1388 507 50702      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1389 607 60701      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1390 607 60702      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1391 607 60703      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1393 408 40801      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1394 508 50801      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1395 508 50802      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1396 508 50803      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1397 508 50804      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1398 508 50805      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1399 508 50806      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1400 608 60801      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1402 409 40901      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1403 409 40902      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1404 409 40903      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1405 509 50901      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1406 509 50902      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1407 609 60901      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1408 609 60902      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1409 609 60903      -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1411 4010 401001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1412 5010 501001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1413 5010 501002    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1414 5010 501003    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1415 5010 501004    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1416 5010 501005    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1417 5010 501006    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1418 6010 601001    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1420 4011 401101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1421 4011 401102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1422 4011 401103    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1423 5011 501101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1424 5011 501102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1425 6011 601101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1426 6011 601102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1427 6011 601103    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1429 4012 401201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1430 5012 501201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1431 5012 501202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1432 5012 501203    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1433 5012 501204    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1434 5012 501205    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1435 5012 501206    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1436 6012 601201    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1438 4013 401301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1439 4013 401302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1440 4013 401303    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1441 5013 501301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1442 5013 501302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1443 6013 601301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1444 6013 601302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1445 6013 601303    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1447 4014 401401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1448 5014 501401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1449 5014 501402    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1450 5014 501403    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1451 5014 501404    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1452 5014 501405    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1453 5014 501406    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1454 6014 601401    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1456 4015 401501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1457 4015 401502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1458 4015 401503    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1459 5015 501501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1460 5015 501502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1461 6015 601501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1462 6015 601502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1463 6015 601503    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1465 4016 401601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1466 5016 501601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1467 5016 501602    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1468 5016 501603    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1469 5016 501604    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1470 5016 501605    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1471 5016 501606    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1472 6016 601601    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1474 4017 401701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1475 4017 401702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1476 4017 401703    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1477 5017 501701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1478 5017 501702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1479 6017 601701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1480 6017 601702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1481 6017 601703    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1483 4018 401801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1484 5018 501801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1485 5018 501802    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1486 5018 501803    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1487 5018 501804    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1488 5018 501805    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1489 5018 501806    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1490 6018 601801    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1492 4019 401901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1493 4019 401902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1494 4019 401903    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1495 5019 501901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1496 5019 501902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1497 6019 601901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1498 6019 601902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1499 6019 601903    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1501 4020 402001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1502 5020 502001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1503 5020 502002    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1504 5020 502003    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1505 5020 502004    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1506 5020 502005    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1507 5020 502006    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1508 6020 602001    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1510 4021 402101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1511 4021 402102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1512 4021 402103    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1513 4021 402104    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1514 5021 502101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1515 5021 502102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1516 5021 502103    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1517 6021 602101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1518 6021 602102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1519 6021 602103    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1520 6021 602104    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1522 4022 402201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1523 4022 402202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1524 4022 402203    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1525 5022 502201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1526 5022 502202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1527 5022 502203    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1528 6022 602201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1529 6022 602202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1530 6022 602203    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
#fila 7                                                  
element zeroLength 1533 7021 702101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1534 7021 702102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1535 7021 702103    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1536 7022 702201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1537 7022 702202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1538 7022 702203    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
#file 8, 9 e 10                                              
element zeroLength 1541 802 80201      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1542 802 80202      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1543 902 90201      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1544 902 90202      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1545 902 90203      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1546 902 90204      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1547 1002 100201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1548 1002 100202    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1550 803 80301      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1551 803 80302      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1552 803 80303      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1553 903 90301      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1554 903 90302      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1555 903 90303      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1556 903 90304      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1557 1003 100301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1558 1003 100302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1559 1003 100303    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1561 804 80401      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1562 904 90401      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1563 904 90402      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1564 904 90403      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1565 904 90404      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1566 904 90405      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1567 904 90406      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1568 1004 100401    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1570 805 80501      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1571 805 80502      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1572 805 80503      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1573 905 90501      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1574 905 90502      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1575 1005 100501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1576 1005 100502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1577 1005 100503    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1579 806 80601      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1580 906 90601      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1581 906 90602      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1582 906 90603      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1583 906 90604      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1584 906 90605      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1585 906 90606      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1586 1006 100601    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1588 807 80701      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1589 807 80702      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1590 807 80703      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1591 907 90701      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1592 907 90702      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1593 1007 100701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1594 1007 100702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1595 1007 100703    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1597 808 80801      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1598 908 90801      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1599 908 90802      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1600 908 90803      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1601 908 90804      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1602 908 90805      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1603 908 90806      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1604 1008 100801    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1606 809 80901      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1607 809 80902      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1608 809 80903      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1609 909 90901      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1610 909 90902      -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1611 1009 100901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1612 1009 100902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1613 1009 100903    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1615 8010 801001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1616 9010 901001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1617 9010 901002    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1618 9010 901003    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1619 9010 901004    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1620 9010 901005    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1621 9010 901006    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1622 10010 1001001  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1624 8011 801101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1625 8011 801102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1626 8011 801103    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1627 9011 901101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1628 9011 901102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1629 10011 1001101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1630 10011 1001102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1631 10011 1001103  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1633 8012 801201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1634 9012 901201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1635 9012 901202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1636 9012 901203    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1637 9012 901204    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1638 9012 901205    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1639 9012 901206    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1640 10012 1001201  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1642 8013 801301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1643 8013 801302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1644 8013 801303    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1645 9013 901301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1646 9013 901302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1647 10013 1001301  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1648 10013 1001302  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1649 10013 1001303  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1651 8014 801401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1652 9014 901401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1653 9014 901402    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1654 9014 901403    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1655 9014 901404    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1656 9014 901405    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1657 9014 901406    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1658 10014 1001401  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1660 8015 801501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1661 8015 801502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1662 8015 801503    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1663 9015 901501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1664 9015 901502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1665 10015 1001501  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1666 10015 1001502  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1667 10015 1001503  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1669 8016 801601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1670 9016 901601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1671 9016 901602    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1672 9016 901603    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1673 9016 901604    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1674 9016 901605    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1675 9016 901606    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1676 10016 1001601  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1678 8017 801701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1679 8017 801702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1680 8017 801703    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1681 9017 901701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1682 9017 901702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1683 10017 1001701  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1684 10017 1001702  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1685 10017 1001703  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1687 8018 801801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1688 9018 901801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1689 9018 901802    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1690 9018 901803    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1691 9018 901804    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1692 9018 901805    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1693 9018 901806    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1694 10018 1001801  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1696 8019 801901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1697 8019 801902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1698 8019 801903    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1699 9019 901901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1700 9019 901902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1701 10019 1001901  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1702 10019 1001902  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1703 10019 1001903  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1705 8020 802001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1706 9020 902001    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1707 9020 902002    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1708 9020 902003    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1709 9020 902004    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1710 9020 902005    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1711 9020 902006    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1712 10020 1002001  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1714 8021 802101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1715 8021 802102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1716 8021 802103    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1717 8021 802104    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1718 9021 902101    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1719 9021 902102    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1720 9021 902103    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1721 10021 1002101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1722 10021 1002102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1723 10021 1002103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1724 10021 1002104  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1726 8022 802201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1727 8022 802202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1728 8022 802203    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1729 9022 902201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1730 9022 902202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1731 9022 902203    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1732 10022 1002201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1733 10022 1002202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1734 10022 1002203  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
#fila 11                                                     
element zeroLength 1737 11021 1102101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1738 11021 1102102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1739 11021 1102103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1740 11021 1102104  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1741 11022 1102201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1742 11022 1102202  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
#file 12, 13 e 14                                            
element zeroLength 1745 1202 120201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1746 1202 120202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1747 1302 130201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1748 1302 130202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1749 1302 130203    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1750 1302 130204    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1751 1402 140201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1752 1402 140202    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1754 1203 120301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1755 1203 120302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1756 1203 120303    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1757 1303 130301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1758 1303 130302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1759 1303 130303    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1760 1303 130304    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1761 1403 140301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1762 1403 140302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1763 1403 140303    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1765 1204 120401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1766 1304 130401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1767 1304 130402    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1768 1304 130403    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1769 1304 130404    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1770 1304 130405    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1771 1304 130406    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1772 1404 140401    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1774 1205 120501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 3000 1205 120502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1775 1205 120503    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1776 1305 130501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1777 1305 130502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1778 1405 140501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1779 1405 140502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1780 1405 140503    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1782 1206 120601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1783 1306 130601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1784 1306 130602    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1785 1306 130603    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1786 1306 130604    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1787 1306 130605    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1788 1306 130606    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1789 1406 140601    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1791 1207 120701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1792 1207 120702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1793 1207 120703    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1794 1307 130701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1795 1307 130702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1796 1407 140701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1797 1407 140702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1798 1407 140703    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1800 1208 120801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1801 1308 130801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1802 1308 130802    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1803 1308 130803    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1804 1308 130804    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1805 1308 130805    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1806 1308 130806    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1807 1408 140801    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1809 1209 120901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1810 1209 120902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1811 1209 120903    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1812 1309 130901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1813 1309 130902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1814 1409 140901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1815 1409 140902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1816 1409 140903    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1818 12010 1201001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1819 13010 1301001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1820 13010 1301002  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1821 13010 1301003  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1822 13010 1301004  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1823 13010 1301005  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1824 13010 1301006  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1825 14010 1401001  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1827 12011 1201101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1828 12011 1201102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1829 12011 1201103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1830 13011 1301101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1831 13011 1301102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1832 14011 1401101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1833 14011 1401102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1834 14011 1401103  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1836 12012 1201201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1837 13012 1301201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1838 13012 1301202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1839 13012 1301203  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1840 13012 1301204  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1841 13012 1301205  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1842 13012 1301206  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1843 14012 1401201  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1845 12013 1201301  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1846 12013 1201302  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1847 12013 1201303  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1848 13013 1301301  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1849 13013 1301302  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1850 14013 1401301  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1851 14013 1401302  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1852 14013 1401303  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1854 12014 1201401  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1855 13014 1301401  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1856 13014 1301402  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1857 13014 1301403  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1858 13014 1301404  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1859 13014 1301405  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1860 13014 1301406  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1861 14014 1401401  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1863 12015 1201501  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1864 12015 1201502  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1865 12015 1201503  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1866 13015 1301501  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1867 13015 1301502  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1868 14015 1401501  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1869 14015 1401502  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1870 14015 1401503  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1872 12016 1201601  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1873 13016 1301601  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1874 13016 1301602  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1875 13016 1301603  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1876 13016 1301604  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1877 13016 1301605  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1878 13016 1301606  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1879 14016 1401601  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1881 12017 1201701  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1882 12017 1201702  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1883 12017 1201703  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1884 13017 1301701  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1885 13017 1301702  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1886 14017 1401701  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1887 14017 1401702  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1888 14017 1401703  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1890 12018 1201801  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1891 13018 1301801  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1892 13018 1301802  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1893 13018 1301803  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1894 13018 1301804  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1895 13018 1301805  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1896 13018 1301806  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1897 14018 1401801  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1899 12019 1201901  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1900 12019 1201902  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1901 12019 1201903  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1902 13019 1301901  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1903 13019 1301902  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1904 14019 1401901  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1905 14019 1401902  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1906 14019 1401903  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1908 12020 1202001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1909 13020 1302001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1910 13020 1302002  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1911 13020 1302003  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1912 13020 1302004  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1913 13020 1302005  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1914 13020 1302006  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1915 14020 1402001  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1917 12021 1202101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1918 12021 1202102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1919 12021 1202103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1920 12021 1202104  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1921 13021 1302101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1922 13021 1302102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1923 13021 1302103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1924 14021 1402101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1925 14021 1402102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1926 14021 1402103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1927 14021 1402104  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1929 12022 1202201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1930 12022 1202202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1931 12022 1202203  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1932 13022 1302201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1933 13022 1302202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1934 13022 1302203  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1935 14022 1402201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1936 14022 1402202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1937 14022 1402203  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
#fila 15 3                                                   
element zeroLength 1940 15021 1502101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1941 15021 1502102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1942 15021 1502103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1943 15022 1502201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1944 15022 1502202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1945 15022 1502203  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
#file 16, 17 e 18                                            
element zeroLength 1948 1602 160201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1949 1602 160202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1950 1702 170201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1951 1702 170202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1952 1702 170203    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1953 1702 170204    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1954 1802 180201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1955 1802 180202    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1957 1603 160301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1958 1603 160302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1959 1603 160303    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1960 1703 170301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1961 1703 170302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1962 1703 170303    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1963 1703 170304    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1964 1803 180301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1965 1803 180302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1966 1803 180303    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1968 1604 160401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1969 1704 170401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1970 1704 170402    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1971 1704 170403    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1972 1704 170404    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1973 1704 170405    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1974 1704 170406    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1975 1804 180401    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1977 1605 160501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1978 1605 160502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1979 1605 160503    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1980 1705 170501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1981 1705 170502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1982 1805 180501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1983 1805 180502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1984 1805 180503    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1986 1606 160601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1987 1706 170601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1988 1706 170602    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1989 1706 170603    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1990 1706 170604    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1991 1706 170605    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1992 1706 170606    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1993 1806 180601    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 1995 1607 160701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1996 1607 160702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1997 1607 160703    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1998 1707 170701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 1999 1707 170702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2000 1807 180701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2001 1807 180702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2002 1807 180703    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2004 1608 160801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2005 1708 170801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2006 1708 170802    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2007 1708 170803    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2008 1708 170804    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2009 1708 170805    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2010 1708 170806    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2011 1808 180801    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2013 1609 160901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2014 1609 160902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2015 1609 160903    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2016 1709 170901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2017 1709 170902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2018 1809 180901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2019 1809 180902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2020 1809 180903    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2022 16010 1601001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2023 17010 1701001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2024 17010 1701002  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2025 17010 1701003  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2026 17010 1701004  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2027 17010 1701005  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2028 17010 1701006  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2029 18010 1801001  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2031 16011 1601101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2032 16011 1601102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2033 16011 1601103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2034 17011 1701101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2035 17011 1701102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2036 18011 1801101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2037 18011 1801102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2038 18011 1801103  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2040 16012 1601201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2041 17012 1701201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2042 17012 1701202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2043 17012 1701203  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2044 17012 1701204  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2045 17012 1701205  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2046 17012 1701206  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2047 18012 1801201  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2049 16013 1601301  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2050 16013 1601302  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2051 16013 1601303  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2052 17013 1701301  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2053 17013 1701302  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2054 18013 1801301  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2055 18013 1801302  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2056 18013 1801303  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2058 16014 1601401  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2059 17014 1701401  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2060 17014 1701402  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2061 17014 1701403  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2062 17014 1701404  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2063 17014 1701405  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2064 17014 1701406  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2065 18014 1801401  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2067 16015 1601501  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2068 16015 1601502  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2069 16015 1601503  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2070 17015 1701501  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2071 17015 1701502  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2072 18015 1801501  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2073 18015 1801502  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2074 18015 1801503  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2076 16016 1601601  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2077 17016 1701601  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2078 17016 1701602  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2079 17016 1701603  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2080 17016 1701604  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2081 17016 1701605  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2082 17016 1701606  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2083 18016 1801601  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2085 16017 1601701  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2086 16017 1601702  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2087 16017 1601703  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2088 17017 1701701  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2089 17017 1701702  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2090 18017 1801701  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2091 18017 1801702  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2092 18017 1801703  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2094 16018 1601801  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2095 17018 1701801  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2096 17018 1701802  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2097 17018 1701803  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2098 17018 1701804  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2099 17018 1701805  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2100 17018 1701806  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2101 18018 1801801  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2103 16019 1601901  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2104 16019 1601902  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2105 16019 1601903  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2106 17019 1701901  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2107 17019 1701902  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2108 18019 1801901  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2109 18019 1801902  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2110 18019 1801903  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2112 16020 1602001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2113 17020 1702001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2114 17020 1702002  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2115 17020 1702003  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2116 17020 1702004  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2117 17020 1702005  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2118 17020 1702006  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2119 18020 1802001  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2121 16021 1602101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2122 16021 1602102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2123 16021 1602103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2124 16021 1602104  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2125 17021 1702101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2126 17021 1702102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2127 17021 1702103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2128 18021 1802101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2129 18021 1802102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2130 18021 1802103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2131 18021 1802104  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2133 16022 1602201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2134 16022 1602202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2135 16022 1602203  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2136 17022 1702201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2137 17022 1702202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2138 17022 1702203  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2139 18022 1802201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2140 18022 1802202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2141 18022 1802203  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
#fila 19                                                     
element zeroLength 2144 19021 1902101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2145 19021 1902102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2146 19021 1902103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2147 19022 1902201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2148 19022 1902202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2149 19022 1902202  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
#file 20 e 21
element zeroLength 2152 2002 200201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2153 2002 200202    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2154 2102 210201    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2155 2102 210202    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2157 2003 200301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2158 2003 200302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2159 2003 200303    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2160 2103 210301    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2161 2103 210302    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2162 2103 210303    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2164 2004 200401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2165 2004 200402    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2166 2004 200403    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2167 2104 210401    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2168 2104 210402    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2169 2104 210403    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2171 2005 200501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2172 2005 200502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2173 2005 200503    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2174 2105 210501    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2175 2105 210502    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2176 2105 210503    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2178 2006 200601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2179 2006 200602    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2180 2006 200603    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2181 2106 210601    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2182 2106 210602    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2183 2106 210603    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2185 2007 200701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2186 2007 200702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2187 2007 200703    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2188 2107 210701    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2189 2107 210702    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2190 2107 210703    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2192 2008 200801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2193 2008 200802    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2194 2008 200803    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2195 2108 210801    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2196 2108 210802    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2197 2108 210803    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2199 2009 200901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2200 2009 200902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2201 2009 200903    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2202 2109 210901    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2203 2109 210902    -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2204 2109 210903    -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2206 20010 2001001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2207 20010 2001002  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2208 20010 2001003  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2209 21010 2101001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2210 21010 2101002  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2211 21010 2101003  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2213 20011 2001101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2214 20011 2001102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2215 20011 2001103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2216 21011 2101101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2217 21011 2101102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2218 21011 2101103  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2220 20012 2001201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2221 20012 2001202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2222 20012 2001203  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2223 21012 2101201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2224 21012 2101202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2225 21012 2101203  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2227 20013 2001301  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2228 20013 2001302  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2229 20013 2001303  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2230 21013 2101301  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2231 21013 2101302  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2232 21013 2101303  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2234 20014 2001401  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2235 20014 2001402  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2236 20014 2001403  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2237 21014 2101401  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2238 21014 2101402  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2239 21014 2101403  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2241 20015 2001501  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2242 20015 2001502  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2243 20015 2001503  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2244 21015 2101501  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2245 21015 2101502  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2246 21015 2101503  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2248 20016 2001601  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2249 20016 2001602  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2250 20016 2001603  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2251 21016 2101601  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2252 21016 2101602  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2253 21016 2101603  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2255 20017 2001701  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2256 20017 2001702  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2257 20017 2001703  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2258 21017 2101701  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2259 21017 2101702  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2260 21017 2101703  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2262 20018 2001801  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2263 20018 2001802  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2264 20018 2001803  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2265 21018 2101801  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2266 21018 2101802  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2267 21018 2101803  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2269 20019 2001901  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2270 20019 2001902  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2271 20019 2001903  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2272 21019 2101901  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2273 21019 2101902  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2274 21019 2101903  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2276 20020 2002001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2277 20020 2002002  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2278 20020 2002003  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2279 21020 2102001  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2280 21020 2102002  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2281 21020 2102003  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2283 20021 2002101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2284 20021 2002102  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2285 20021 2002103  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2286 20021 2002104  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2287 21021 2102101  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2288 21021 2102102  -mat  $rigido $rigido $norigido -dir  1 2 3 
                                                             
element zeroLength 2290 20022 2002201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2291 20022 2002202  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2292 20022 2002203  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2293 21022 2102201  -mat  $rigido $rigido $norigido -dir  1 2 3 
element zeroLength 2294 21022 2102202  -mat  $rigido $rigido $norigido -dir  1 2 3 