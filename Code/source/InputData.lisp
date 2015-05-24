(in-package :gdl-user)

(define-object InputData ()

:input-slots
(
;; Main wing parameters
wingSpan 
wingChordRoot 
wingKinkPos 
wingTaper 
wingDihedral
wingConfiguration
wingAirfoil
wingSweepLE

;; Tail parameters
tailType

;; Fuselage parameters 
finenessRatio
fuselageLengthTotal
divergence

;; Propulsion system
engineMounting
engineNumber
engineDiameter
engineLength
)
)
