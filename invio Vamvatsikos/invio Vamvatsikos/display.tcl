#FILE DI VISUALIZZAZIONE DEL MODELLO
source DisplayPlane.tcl ;
source DisplayModel3D.tcl ; 

set  xPixels 1000;	# height of graphical window in pixels
set  zPixels 1000;	# height of graphical window in pixels
set  xLoc1 0;	# horizontal location of graphical window (0=upper left-most corner)
set  zLoc1 0;	# vertical location of graphical window (0=upper left-most corner)
set dAmp 1.0;	# scaling factor for viewing deformed shape, it depends on the dimensions of the model

DisplayModel3D DeformedShape $dAmp $xLoc1 $zLoc1  $xPixels $zPixels
DisplayPlane DeformedShape $dAmp XY

