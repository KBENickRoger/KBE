;; ######################
;; ## FILE DESCRIPTION ##
;; ######################
;;
;; author:      R.E.C. van Dijk (TU Delft)
;; version:     1
;; date:        Friday 08-06-2012 (DD-MM-YYYY) at 13:17:41
;; (c) 2011-2012
;;
;; DESCRIPTION:
;;
;; Definition of axis system

(in-package :gdl-user)

(define-object axis-system-mixin-test (base-object axis-system-mixin))

(define-object axis-system-mixin ()
  :documentation
  (:author "R.E.C. van Dijk (TU Delft)"
   :date "Tuesday 11-22-2011 at 15:28:08"
   :version "1"
   :description "used as mixin, add axis-system as child object.")
  :input-slots
  ((axis-length 1 :settable) 
   (show-axes? t :settable)   
   )
  :objects
  ((axis-system :type 'axis-system
                :hidden? (not (the show-axes?))
                :axis-length (the axis-length) ;; change this?
                :x-vector (the (face-normal-vector :right))
                :y-vector (the (face-normal-vector :rear))
                :z-vector (the (face-normal-vector :top))
                )))

(define-object axis-system (base-object)
  :documentation
  (:author "R.E.C. van Dijk (TU Delft)"
   :date "Tuesday 11-22-2011 at 15:28:08"
   :version "1"
   :description "system with x-axis, y-axis and z-axis")
  :input-slots
  ((axis-length 10 :settable) 
   x-vector y-vector z-vector)
  :objects
  ((x :type 'linear-curve
      :start (the center)
      :end (translate-along-vector (the center) (the x-vector)  (the axis-length))
      :display-controls (merge-display-controls (list :color :green :line-thickness 5)))
   (y :type 'linear-curve
      :start (the center)
      :end (translate-along-vector (the center) (the y-vector)  (the axis-length))
      :display-controls (merge-display-controls (list :color :red :line-thickness 5)))
   (z :type 'linear-curve
      :start (the center)
      :end (translate-along-vector (the center) (the z-vector)  (the axis-length))
      :display-controls (merge-display-controls (list :color :blue :line-thickness 5)))))
