---
layout: page
title: stringencoders
summary: "stringencoders home page: a c library of high-speed string transformations"
---


A collection of high performance c-string transformations, frequently
2x faster than standard implementations (if they exist at all).

* base64, standard
* base64, web/url safe, with configurable alphabet
* base85 (good for http cookies)
* base16 (hex)
* base2 (ascii binary)
* url escaping
* javascript string escaping
* fast number to string conversion, 4-22x faster than sprintf!
* fast ascii upper/lower case conversion, 2-66x faster than stdlib! (yes, 66x faster)
* fast, memory-free  query string parsing

And it's all wrapped up in a bow for you to use:

* BSD License -- do what you want with it.
* Standard clean ANSI C, will also compile as C99 and C++
* C++ wrappers for std::string
* Standard install: configure && make && make install
* Extensive unit tests provided with >98% coverage.
* Endian safe.
* Performance test framework -- don't take my word, run it your self
* Lots of in-code documentation

Current hosted at code.google.com.

### [http://code.google.com/p/stringencoders/](http://code.google.com/p/stringencoders/) ###

