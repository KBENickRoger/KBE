(in-package :gdl-user)

(define-object ACCG ()

:input-slots
((centerAC)
(centerAG))

:objects
((AC
:type 'sphere
:center (the centerAC)
:radius 0.2
:display-controls (list :color :red))

(CG
:type 'sphere
:center (the centerCG)
:radius 0.2
:display-controls (list :color :blue))
))