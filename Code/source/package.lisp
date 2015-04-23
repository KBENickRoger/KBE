;;; 
;;; This file defines a package for this project.
;;;
        
(in-package :gdl-user)

;;
;; A simple package is defined here.
;;
;; For more information about defining packages and how to define packages such that you 
;; can use symbols from other packages, see section 5.1 "Defining a Working Package" in
;; the GDL tutorial.
;; 
;; As an example, using the package cl-json would look like this:
;;     ; Load cl-json (this will download it if necessary)
;;     (ql:quickload :cl-json)
;;     ; Define a package with cl-json symbols / operators available
;;     (gdl:define-package :kbe (:use :cl-json))
;;
(gwl:define-package :kbe)