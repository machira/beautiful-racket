;#lang reader stacker-demo/stacker
;4
;8
;+
;3
;*

#lang br/quicklang

(define (read-syntax path port)
  (define src-lines (port->lines port))
  (datum->syntax #f '(module lucy br 42)))
(provide read-syntax)