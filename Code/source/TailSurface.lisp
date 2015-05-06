(in-package :gdl-user)

(define-object TailSurface (base-object)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
  
  :input-slots
  ((""
    symmetry nil )
   
   (""
    area nil )
   
   (""
    AR nil )
   
   (""
    airfoil "NACA_0012_xyz.dat" )
   
   (""
   taper nil)
   
   (""
    endOfFuselage (make-point 0 0 0 ) )
	)
  
  
  :computed-slots
  ((""
    chordRoot (/ (the area) (* (the span) (+ 1 (the taper)))) )
   
   (""
    chordTip (* (the chordRoot) (the taper)))
   
   (""
    rootCenter (translate (the endOfFuselage) :front (half (the chordRoot))) )
   
   (""
    span (sqrt (* (the area) (the AR))))
)
  
  
  :objects
  (
  ("" liftingSurface :type 'WingTrunk
  :chordRoot (the chordRoot)
  :chordTip (the chordTip)
  :span (the span)
  :airfoil (the airfoil) 
  :rootPoint (the rootCenter)
  :sweepLE 20
  )
  )
  
  
  :functions
  ())