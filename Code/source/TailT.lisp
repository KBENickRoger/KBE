(in-package :gdl-user)

(define-object TailT (tailConventional)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")

  :computed-slots
	(
	(horizontalPlacement 1)
	(horizontalBack (- (the verticalTail sweepOffset) (the verticalTail chordTip)))
	)
  
 )