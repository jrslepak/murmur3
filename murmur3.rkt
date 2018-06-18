#lang racket/base

(require ffi/unsafe
         (rename-in racket/contract/base
                    [-> ->/c]))

(provide (contract-out [murmur-hash (->* ((or/c string? bytes?))
                                         (exact-nonnegative-integer?)
                                         fixnum?)]))

(define murmur-lib (ffi-lib "MurmurHash3"))

(define murmur-hash3-x86-32
  (get-ffi-obj "MurmurHash3_x86_32" murmur-lib
              (_fun _bytes _int _uint _pointer -> _void)))
(define murmur-hash3-x86-128
  (get-ffi-obj "MurmurHash3_x86_128" murmur-lib
              (_fun _bytes _int _uint _pointer -> _void)))
(define murmur-hash3-x64-128
  (get-ffi-obj "MurmurHash3_x64_128" murmur-lib
              (_fun _bytes _int _uint _pointer -> _void)))
  
;; murmur-fixnum : bytes? [uint?] -> fixnum?
(define (murmur-hash data [seed 0])
  (define data* (if (string? data) (string->bytes/locale data) data))
  (define small-fixnum? (<= (ctype-sizeof _fixnum) 4))
  (define hash-result (if small-fixnum?
                          (malloc _byte 4) (malloc _byte 16)))
  (define hash-fun (if small-fixnum?
                       murmur-hash3-x86-32 murmur-hash3-x64-128))
  (hash-fun data* (bytes-length data*) seed hash-result)
  (ptr-ref hash-result _fixnum))

