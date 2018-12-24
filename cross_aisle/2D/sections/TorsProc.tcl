
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
