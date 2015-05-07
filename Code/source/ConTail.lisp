(in-package :kbe)

(define-object ConTail (Tail)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
  
  :input-slots
  ((tailTaperHor 0.3 :settable)
    
  (tailSweepV 35 :settable
  ))
  
  
  :computed-slots
  (("Surface areas horizontal tail"
  tailSurfaceAreaHor (/ (* (the tailHorVolume) (the wingSurfaceArea) (the wingRootChord)) (the tailArmH)))
  
  ("Surface areas vertical tail"
  tailSurfaceAreaVer (/ (* (the tailVerVolume) (the wingSurfaceArea) (the wingSpan)) (the tailArmV)))
  
  ("Sweep of the horizontal tail"
  tailSweepHor (+ (the wingSweep) 10))
  
  ("Taper ratio of vertical tail"
  case tailType (:1 (tailTaperVer 0.3)) (:2 (tailTaperVer 0.7)) (:3 (tailTaperVer 0.7)))
  
  ("Aspect ratio of vertical tail"
  case tailType (:1 (tailARVer 1.9)) (:2 (tailARVer 1.2 :settable)) (:3 (tailARVer 1.2 :settable)))
  
  ("Horizontal tail span"
	tailSpanHor (sqrt(* (the tailARhor) (the tailSurfaceAreaHor))))
  
  ("Vertical tail span"
  tailSpanVer (sqrt(* (the tailARVer) (the tailSurfaceAreaVer))))
  
  ("Rootchord Vertical tail"
  tailRootChordVer (/ (* 2 (the tailSurfaceAreaVer)) (* (the tailSpanVer) (+ 1 (the tailTaperVer))))
  )
  
  ("Tip chord Vertical tail"
  tailTipChordVer (* (the tailTaperVer) (the tailTaperVer))
  )
  
  ("Root chord Horizontal tail"
  tailRootChordHor (/ (* 2 (the tailSurfaceAreaHor)) (* (the tailSpanHor) (+ 1 (the tailTaperHor))))
  )
  
  ("Tip chord Horizontal tail"
  tailTipChordHor (* (the tailTaperHor) (the tailTaperHor))
  )
  
 ("vertical placing of horizontal tail")
  case (tailType (:1 ) (:2 ) (:3 )))
  :objects
  ((""
    wingTrunk :type 'WingTrunk))
  
  
  :functions
  ())

