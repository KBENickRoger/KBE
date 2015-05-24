(in-package :gdl-user)

(define-object Aerodynamics ()
  
  :documentation
  (:author "Roger"
   :description "Aerodynamics gradients capability")
  
  :input-slots
  ((condition tailType span wingArea sweepLE rootChord tipChord tailLength tailVLength fuselageRadius AR)
  (Eta 0.95))
  
  :computed-slots
  (	
  (sweepLERAD (degrees-to-radians (the sweepLE)))
  
  (Mach (getf (the condition) :mach))
  
	("Prandtl-Glauert correction"
    Beta (sqrt(- 1 (expt (the Mach) 2)))) 
   
   ("Lift-Gradient wing"
    CLalpha (/ (* 2 pi (the AR)) (+ 2 (sqrt(+ 4 (* (expt (/ (* (the AR) (the Beta)) (the Eta)) 2)) (+ 1 (/ (expt (tan (the wingSweep05)) 2) (expt (the Beta) 2)))))) ) )
   
   ("Lift gradient with fuselage"
    CLalphaWF (+ (* (the CLalpha) (+ 1 (* 2.15 (/ (twice (the fuselageRadius)) (the span)))) (/ (the wingAreaNet) (the wingArea))) (half (* pi (/ (expt (twice (the fuselageRadius)) 2) (the wingArea)))))) 
   
   ("Velocity deficiency at tail"
    Vh_V (ecase (the tailType)
				( 1 0.86) 
				( 2 0.95) 
				( 3 1) 
				( 4 0.85) 
				( 5 0.85) 
				( 6 0.85)))
   
   ("Downwash gradient at tail"
    dEpsdAlph (* (/ (the Keps) (the Keps0)) (the dEpsdAlph2) (/ (the CLalpha) (* pi (the AR)))) )
	
	("Partial gradient subdivision"
	dEpsdAlph2 (+ (* (the dEpsdAlph21) (the dEpsdAlph22)) (* (the dEpsdAlph23) (the dEpsdAlph24))))
	
	("Subgradient 1"
	dEpsdAlph21 (/ (the tailRDistance) (+ (expt (the tailRDistance) 2) (expt (the tailVDistance) 2))))
	
	("Subgradient 2" 
	dEpsdAlph22 (/ 0.4876 (sqrt(+ (expt (the tailRDistance) 2) 0.6319 (expt (the tailVDistance) 2)))))
	
	("Subgradient 3"
	dEpsdAlph23 (+ 1 (expt (/ (expt (the tailRDistance) 2) (sqrt(+ (expt (the tailRDistance) 2) 0.7915 (* 5.0734 (expt (the tailVDistance) 2))))) 0.3113)))
	
	("Subgradient 4"
	dEpsdAlph24 (- 1 (sqrt(/ (expt (the tailVDistance) 2) (+ 1 (expt (the tailVDistance) 2))))))
   
   ("Wingsweep parameter for downwash gradient"
    Keps (+ (/ (+ 0.1124 (* 0.1265 (the sweepLERAD)) (* 0.1766 (expt (the sweepLERAD) 2))) (expt (the tailRDistance) 2)) (/ 0.1024 (the tailRDistance)) 2) )
   
   ("Wingsweep parameter for downwash gradient at 0 sweep"
    Keps0 (+ (/ 0.1124 (expt (the tailRDistance) 2)) (/ 0.1024 (the tailRDistance)) 2) )
	
	("distance tail from wing (not taillength)"
	tailRDistance (half (* (the tailLength) (the span))))
	
	(""
	tailVDistance (half (* (the tailVLength) (the span))))
   
   ("Half Chord wing sweep"
    wingSweep05 (asin (/ (+ (- (the tipChord) (the rootChord)) (* (the span) (sin (the sweepLERAD)))) (the span))))
   
   (""
    wingAreaNet (- (the wingArea) (* (twice (the fuselageRadius)) (the rootChord))))
   
   (""
    spanNet (- (the span) (twice (the fuselageRadius))))
  )
  
  :objects
  ()
  
  
  :functions
  ())

