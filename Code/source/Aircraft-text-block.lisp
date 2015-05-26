(in-package :gdl-user)

(define-object Aircraft-text-block (typeset-block)

:input-slots
((margins)
 (width)
 (length)
 (inputList))

:computed-slots
((keys (plist-keys (the inputList))))

:functions
 (
 (content
    ()
    (tt:compile-text (:font "Helvetica" :font-size 12.0)
      (tt:vspace 100)

      (tt:paragraph () "Aircraft Data")
      (let ((width (- (the width) (the margins))))
	(tt:table (:col-widths (list (* 2/3 width) (* 1/3 width)))
	  (dolist (slot (the keys))
	    (tt:row ()
	      (tt:cell (:background-color "#FFFFFF") (tt:put-string (format nil "~a" (string-capitalize slot))))
	      (tt:cell () 
		(tt:paragraph (:h-align :center) (tt:put-string (format nil "~a" (getf (the inputList) slot)))))))))))
)

)
