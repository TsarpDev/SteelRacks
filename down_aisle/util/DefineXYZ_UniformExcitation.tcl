# Using the inputs read from MatIDA_thfile.tcl
# it defines the UniformExcitation loading to prepare for running transient analysis
# This can be used by any of my IDA-running Opensees files, 2D or 3D, bridge or building.
# It will return the NPTS and DT of the the first non-zero component to the calling function.
# 
# Updated, Apr 24, 2005: Added the ability to function even when the X-component is zero.
# Updated, Sep 22, 2005: The paramater ipattern has been added which signals the pattern
#                        id that will be assigned to the first ground motion. The Y,Z motions
#                        get ipattern+1 and ipattern+2.
# Updated, Feb 26, 2011: Added the definition of a TimeSeries object explicitly. In this way
#                        TimeSeries 1,2,3 are associated with X,Y,Z. This facilitates the definition 
#                        of absolute accelerations via the new recorder Node -timeseries functionality


proc DefineXYZ_UniformExcitation {dtsub g GMdir GMfileX GMfileY GMfileZ GMfactorX GMfactorY GMfactorZ npts dt {ipattern 2}} {
  source ../util/ReadSMDFile3.tcl
  # return npts_xyz and dt_xyz as npts and dt, needed for the "analyze" command
  upvar $npts npts_xyz 
  upvar $dt dt_xyz
  set npts_xyz 0
  set dt_xyz 0

  # X-Component, if any
  if {$GMfileX!="" & $GMfactorX!=0} {
    set inFileX $GMdir$GMfileX
    # note that dt,npts are passed by reference here! So you actually get it back.
    ReadSMDFile3 $inFileX dtx nptsx
    set GaccelX "Path 1 -dt $dtx -filePath $inFileX -factor [expr $GMfactorX*$g]"
    eval "timeSeries $GaccelX"
    pattern UniformExcitation $ipattern 1 -accel 1
    puts "X-Component (tag [expr $ipattern+0]): $GMfileX"
    puts "X: DT=$dtx , NPTS= $nptsx --> using [expr $dtx/$dtsub], Scale Factor=$GMfactorX"
    puts $GaccelX
    set npts_xyz $nptsx
    set dt_xyz $dtx
  }  
  # Y-Component, if any
  if {$GMfileY!="" & $GMfactorY!=0} {
    set inFileY $GMdir$GMfileY
    ReadSMDFile3 $inFileY dty nptsy
    set GaccelY "Path 2 -dt $dty -filePath $inFileY -factor [expr $GMfactorY*$g]"
    eval "timeSeries $GaccelY"
    pattern UniformExcitation [expr $ipattern+1] 2 -accel 2
    puts "Y-Component (tag [expr $ipattern+1]): $GMfileY"
    puts "Y: DT=$dty , NPTS= $nptsy --> using [expr $dty/$dtsub], Scale Factor=$GMfactorY"
    puts $GaccelY
    if {$npts_xyz==0} {
      set npts_xyz $nptsy
      set dt_xyz $dty
    }
  }
  # Z-Component, if any
  if {$GMfileZ!="" & $GMfactorZ!=0} {
    set inFileZ $GMdir$GMfileZ
    ReadSMDFile3 $inFileZ dtz nptsz
    set GaccelZ "Path 3 -dt $dtz -filePath $inFileZ -factor [expr $GMfactorZ*$g]"
    eval "timeSeries $GaccelZ"
    pattern UniformExcitation [expr $ipattern+2] 3 -accel 3
    puts "Z-Component (tag [expr $ipattern+2]): $GMfileZ"
    puts "Z: DT=$dtz , NPTS= $nptsz --> using [expr $dtz/$dtsub], Scale Factor=$GMfactorZ"
    puts $GaccelZ
    puts "IF THIS IS A 2D MODEL, THEN YOU HAVE JUST INCLUDED ROTATIONAL EXCITATION!"
    if {$npts_xyz==0} {
      set npts_xyz $nptsz
      set dt_xyz $dtz
    }
  }

}
  