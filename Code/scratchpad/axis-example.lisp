(in-package :gdl-user)

(define-object axis-toplevel (base-object axis-system-mixin)

:objects
((my-box :type 'axis-box
	 :length 1
	 :width 1
	 :height 1
	 :center (make-point 1 1 1)
	 :orientation (alignment :top (the (face-normal-vector :top))
				 :front (the (face-normal-vector :left)))
))
)


(define-object axis-box (box axis-system-mixin))
