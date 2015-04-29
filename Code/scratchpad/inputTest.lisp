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
 (mapcar 'split dataList))

(defun transData (inputList)
  (list (make-keyword (first inputList)) (parser (first (last inputList)))
))

(defun plistCreator (dataList)
  (mapcan 'transData dataList)
)

(define-object inputTest ()

  :input-slots
  ((dataFolder *dataFolder*)
   (dataFileName "inputData.dat"))

  :computed-slots
  ((dataFilePath (merge-pathnames (the dataFileName)
				  (the dataFolder)))
  (data (readData(the dataFilePath)))
  (dataSplit (splitData(the data)))
   (dataTest (first (the dataSplit)))
   (dataTest2 (first (the dataTest)))
   (dataTest3 (first (rest (the dataTest))))
   (dataKeyTest (make-keyword (the dataTest2)))
   (dataReadTest (parser (the dataTest3)))
  (dataTrans (plistCreator(the dataSplit)))
  (wingspan (getf (the dataTrans) :wingspan)))

)

(defun parser (string) 
 (let ((*read-eval* nil)) (with-input-from-string (stream string) (read stream)))
)
