This is an FFI wrapper for [MurmurHash3](http://code.google.com/p/smhasher/wiki/MurmurHash3), a general-purpose hash function. MurmurHash3 is suitable for use in data structures which need a hash function but NOT for
cryptographic use.

In order to use this package, the MurmurHash3 C function must be built as a shared library, which can be done with the included Makefile.

## Contract
```
(murmur-hash data [seed]) → fixnum?
  data : (or/c string? bytes?)
  seed : exact-nonnegative-integer? = 0
```

Calls a MurmurHash3 function chosen based on fixnum size – 32-bit version on 32-bit machines and 128-bit version on 64-bit machines. One fixnum’s worth of bits are taken from the result.

## Examples
```
> (murmur-hash "hello, world!")
2382026736043989338

> (murmur-hash "hello, world!" 12648430)
-1035544952122395943
```