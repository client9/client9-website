---
layout: post
title: GCC -fstackprotector and valgrind failure
---

I got a [report on a buffer overread](https://github.com/client9/libinjection/issues/56) (reading past static buffer boundry) in [libinjection](https://libinjection.client9.com/).  It's clear that it exists (around line 910):

```c
st_assign(sf->current, TYPE_BAREWORD, pos, wlen, cs + pos);
for (i =0; i < sf->current->len; ++i) {
    delim = sf->current->val[i];
    assert(i < MAXSIZE); /* added this later to catch problem */
```

I assign somethng to a buffer, which truncates the input. I then iterate over the *original* length, not the new length, since `current->len` was incorrectly set (this has been fixed).

Here's my `gcc`:

```bash
$ gcc --version
gcc (GCC) 4.7.2 20121109 (Red Hat 4.7.2-8)
```

I tried writing unit tests for it, but I was unable to trigger a core dump (not surprising).  But it's very odd  that [valgrind](http://valgrind.org/) says everything is ok too.

I put an `assert` in the code.  Yes, definitely going past the boundry.  So why isn't valgrind catching this?  It's a static array!

A while back I added `-fstack-protector` to the build process.  Here's [what gcc says about it](http://gcc.gnu.org/onlinedocs/gcc-4.1.0/gcc/Optimize-Options.html)

```
-fstack-protector

Emit extra code to check for buffer overflows, such as stack smashing
attacks. This is done by adding a guard variable to functions with
vulnerable objects. This includes functions that call alloca, and
functions with buffers larger than 8 bytes. The guards are initialized
when a function is entered and then checked when the function
exits. If a guard check fails, an error message is printed and the
program exits.

-fstack-protector-all

Like -fstack-protector except that all functions are protected.
```

Ok, but when I removed `-fstack-protector` from the build, valgrind catches the error.

```
$ valgrind --gen-suppressions=no --read-var-info=yes \
           --error-exitcode=1 --track-origins=yes \
           ./testdriver ../tests/test-tokens-words-022.txt

 Conditional jump or move depends on uninitialised value(s)
    at 0x401B21: parse_word (libinjection_sqli.c:915)
    by 0x402333: libinjection_sqli_tokenize (libinjection_sqli.c:1256)
    by 0x403E23: read_file (testdriver.c:132)
    by 0x403FDB: main (testdriver.c:189)
    Uninitialised value was created by a stack allocation
    at 0x403BC1: read_file (testdriver.c:71)

$ echo $?
1
```

So `-fstack-protector`:

* doesn't seem to be "protecting the stack"
* of if it is silent allows array over reads and lets the application continue
* and silently breaks valgrind, and probably other memory analysis tools

I removed `-fstack-protector` from libinjection but kept in `-Wstack-protector` in
case someone embedding libinjection uses it.

So I don't really know what's it's doing, but I recommend to turn it off when using valgrind.  If you have a better idea on what's going on, send me an email and I'll update this post.

enjoy!

nickg



