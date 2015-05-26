(in-package :gdl-user)

(define-object Aerodynamics ()
  
  :documentation
  (:author "Roger"
   :description "Aerodynamics gradients capability")
  
  :input-slots
  ()
  
  
  :computed-slots
  (	
	("Prandtl-Glauert correction"
    Beta (sqrt((- 1 (^2 (the Mach)))))) 
   
   ("Lift-Gradient wing"
    CLalpha (/ (* 2 pi (the AR)) (+ 2 (sqrt(+ 4 (* (^2 (/ (* (the AspectRatio) (the Beta)) (the Eta))) (+ 1 (/ (^2 (tan (the wingSweep05))) (^2 (the Beta))))))) ) ))
   
   ("Lift gradient with fuselage"
    CLalphaWF (+ (* (the CLalpha) (+ 1 (* 2.15 (/ (the wingSpanNet) (the span)))) (/ (the wingAreaNet) (the wingArea))) (* pi/2 (/ (^2 (the wingSpanNet)) (the wingArea)))) )
   
   ("Velocity deficiency at tail"
    Vh_V (ecase tailType (:1 0.86) (:2 0.95) (:3 1) (:4 0.85) (:5 0.85) (:6 0.85)) )
   
   ("Downwash gradient at tail"
    dEpsdAlph (* (/ (the Keps) (the Keps0)) (the dEpsdAlph2) (/ (the CLalpha) (* pi (the AspectRatio)))) )
	
	("Partial gradient subdivision"
	dEpsdAlph2 (+ (* (the dEpsdAlph21) (the dEpsdAlph22)) (* (the dEpsdAlph23) (the dEpsdAlph24))))
	
	("Subgradient 1"
	dEpsdAlph21 (/ (the tailRDistance) (+ (^2 (the tailRDistance)) (^2 (the tailVDistance)))))
	
	("Subgradient 2" 
	dEpsdAlph22 (/ 0.4876 (sqrt(+ (^2 (the tailRDistance)) 0.6319 (^2 (the tailVDistance))))))
	
	("Subgradient 3"
	dEpsdAlph23 (+ 1 (expt (/ (^2 (the tailRDistance)) (sqrt(+ (^2 (the tailRDistance)) 0.7915 (* 5.0734 (^2 (the tailVDistance)))))) 0.3113)))
	
	("Subgradient 4"
	dEpsdAlph24 (- 1 (sqrt(/ (^2 (the tailVDistance)) (+ 1 (^2 (the tailVDistance)))))))
   
   ("Wingsweep parameter for downwash gradient"
    Keps (+ (/ (+ 0.1124 (* 0.1265 (the sweepLE)) (* 0.1766 (^2 (the sweepLE)))) (^2 (the tailRDistance))) (/ 0.1024 (the tailRDistance)) 2) )
   
   ("Wingsweep parameter for downwash gradient at 0 sweep"
    Keps0 (+ (/ 0.1124 (^2 (the tailRDistance))) (/ 0.1024 (the tailRDistance)) 2) )
	
	("distance tail from wing (not taillength)"
	tailRDistance (/ (* 2 (the tailLength)) (the span)))
   
   ("Half Chord wing sweep"
    wingSweep05 asn(/ (- (+ (the rootChord) (the tipChord)) (* (the span) sin(the sweepLE)))  (the span)) )
   
   (""
    wingAreaNet nil #|todo|# )
   
   (""
    wingSpanNet nil #|todo|#)
  
  
  :objects
  ()
  
  
  :functions
  ())

