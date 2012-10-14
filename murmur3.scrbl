#lang scribble/manual
@(require scribble/eval
          (for-label "murmur3.rkt"))

@title{MurmurHash3}

@defmodule[(planet jrslepak/murmur3)]

This is an FFI wrapper for
@link["http://code.google.com/p/smhasher/wiki/MurmurHash3"]{MurmurHash3}, 
a general-purpose hash function.
MurmurHash3 is suitable for use in data structures which need a hash function
but NOT for cryptographic use.

In order to use this package,
the MurmurHash3 C function must be built as a shared library,
which can be done with the included Makefile.

@defproc[(murmur-hash [data (or/c string? bytes?)]
                      [seed exact-nonnegative-integer? 0])
         fixnum?]
Calls a MurmurHash3 function chosen based on fixnum size -- 
32-bit version on 32-bit machines and 128-bit version on 64-bit machines.
One fixnum's worth of bits are taken from the result.

@(define evaluator (make-base-eval))
@interaction-eval[#:eval evaluator
                         (require "murmur3.rkt")]

@interaction[#:eval evaluator
                         (murmur-hash "hello, world!")]

@interaction[#:eval evaluator
                    (murmur-hash "hello, world!" #xC0FFEE)]
