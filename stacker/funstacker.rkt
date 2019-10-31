#lang br/quicklang

(define (read-syntax path port)
  (define src-lines (port->lines port))
  (define src-datums (format-datums '~a src-lines))
  (define module-datum `(module stacker-mod "funstacker.rkt" (handle-args ,@src-datums)))
  (datum->syntax #f module-datum))
(provide read-syntax)

;(define (handle [a #f]) (print a))
(define-macro (fun-stacker-module-begin HANDLE-ARGS-EXPR)
  #'(#%module-begin (display (first HANDLE-ARGS-EXPR))))
(provide (rename-out [fun-stacker-module-begin #%module-begin]))


(define (handle-args . args)
  (for/fold
   ([stack empty])
   ([arg (in-list args)] #:unless (void? arg))
  (cond
    [(number? arg) (cons arg stack)]
    [(or (equal? + arg) (equal? * arg))
     (define op-result (arg (first stack) (second stack)))
     (cons op-result (drop stack 2))])))

(provide handle-args)
(provide + *)