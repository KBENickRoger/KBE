(in-package :gdl-user)


;;---------------------Attention! Read this first----------------------------------------------------------------------------------------------------------

;; In order to make this example work, you should specify the exact path of the supplied xfoil-program.
;; This program is located in the supplied set of files, with the relative path ~\Xfoil GDL Capability Module\source\Xfoil. You are free to place this code at any place on your hard-drive, as long as you make sure that the parameter *xfoil-folder*, defined below, matches this path.

;; Please update the parameter *xfoil-folder* below as required

(defparameter *xfoil-folder* (merge-pathnames "../source/Xfoil/"
					     (make-pathname :name nil
							    :type nil
							    :defaults excl:*source-pathname*))
)

;;----------------------------------------------------------------------------------------------------------------------------------------



(define-object example-xfoil (base-object)

;; example class to demonstrate the usage of the xfoil capaility module

:objects
(;; a generic example curve is constructed here from a set of b-spline control-points. For the xfoil capability module, any curve object that represents an airfoil can be used as input (-> :curve-in )
 (airfoil-curve-object :type 'b-spline-curve
		       :control-points (list (make-point 1 0 0)
					     (make-point 0.3 0.1 0)
					     (make-point 0 0 0)
					     (make-point 0.3 -0.1 0)
					     (make-point 1 0 0)) )

 
;; xfoil class to obtain a set of polars for one airfoil for a given range of alpha's (Cl-alpha, Cd-alpha, Cm-alpha, Xtr-alpha)
 (xfoil-polar :type 'xfoil-analysis-polar         
	      :curve-in (the airfoil-curve-object) ;; specify the 2D airfoil curve object that you want to analyze: should be defined in x-y plane, 
	                                           ;; chord parallel to x-axis, LE pointing to the negative x-direction
	      
	      :data-folder *xfoil-folder*  ;;specify the location of the xfoil.exe program file
	      :mach-number 0
	      :reynolds-number 10E6
	      :lower-alfa -4                 ;; starting alpha of requested polar, [deg]
	      :upper-alfa 14                 ;; final alpha of requested polar, [deg]
	      :alfa-increment 0.5)          ;; alpha increment of requested polar, [deg]


;; xfoil class to analyse a single operating point of an airfoil at a given alpha (Cl, Cd, Cm, boundary layer properties)
 (xfoil-point :type 'xfoil-analysis-pointBL
	      :curve-in (the airfoil-curve-object)  ;;see above
	      :data-folder *xfoil-folder*           ;;specify the location of the xfoil.exe program file
	      :mach-number 0
	      :reynolds-number 10E6
	      :alfa-in 3)   ;; angle-of-attack for which to analyse airfoil, [deg]
))


