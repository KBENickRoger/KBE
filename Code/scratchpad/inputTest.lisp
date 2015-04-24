(in-package :gdl-user)

(defparameter *dataFolder*
  (make-pathname :name nil
:type nil
:defaults (merge-pathnames "../data/"
#+allegro excl:*source-pathname*
#+lispworks dspec:*source-pathname*
;; in future: (glisp:source-pathname)
)))

(defun readData (fileName)
  (with-open-file (in fileName)
    (let (result)
      (do ((line (read-line in nil nil) (read-line in nil nil)))
	  ((or (null line)(string-equal line ""))(nreverse result))
	(push line result))
)))

(defun splitData (dataList)
 (mapcan 'split dataList))

(define-object inputTest ()

  :input-slots
  ((dataFolder *dataFolder*)
   (dataFileName "inputData.dat"))

  :computed-slots
  ((dataFilePath (merge-pathnames (the dataFileName)
				  (the dataFolder)))
  (data (readData(the dataFilePath)))
  (dataSplit (splitData(the data))))

)


  
