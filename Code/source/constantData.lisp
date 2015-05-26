(in-package :gdl-user)

(define-object ConstantData ()

:input-slots
(
;; General constants

;; Reference aircraft database

;; Tail sizing constants in case of no matching aircraft
tailVolumeHorizontalStandard
tailVolumeVerticalStandard

;; Tail parameters specific to configurations
tailConventional
tailCruciform
tailT
tailV
tailH
tailC
)
)
