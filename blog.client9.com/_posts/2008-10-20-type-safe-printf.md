---
layout: post
updated: 2008-10-20
alias: /2008/10/type-safe-printf.html
title: Type safe printf
---
<p>
Current compilers perform checks on "format strings" in <code>printf</code>-style functions, however none, to my knowledge makes them truly type safe.  This can result in program errors and possible core dumps.   The following proposes a pre-processing step that does a minimal (and reversible) program transformation that allows gcc to do strict type checking.    The transformed program is 100% compatible with the original and compiles into a identical binary.  Further enhancements would allow alternative higher performance printf implementations or automatic conversion to C++ streams.
</p>

<p>A sample transformer is at <a href="http://code.google.com/p/typesafeprintf/">http://code.google.com/p/typesafeprintf/</a>
</p>

<hr />

<p>
We all know that <code>printf</code> style functions can have <a href="http://en.wikipedia.org/wiki/Format_string_vulnerabilities">security problems</a>, and the right mismatch or arguments (or lack of them) can cause core dumps  The more horrible cases can be caught using <code>gcc</code> with <code>-Werror -Wformat=2</code>, but this will not catch <i>application</i> errors.  For instance:
</p>

<pre>
#include <stdio.h>

int main() &#123;
  int a = -1;
  printf("%d %u %hhd\n", a, a, a);

  unsigned int b = 512;
  printf("%d %u %hhd\n", b, b, b);

  double c = 2.0;
  printf("%d %f %u %hhd\n", c, c, c, c);

  return 0;
&#125;
</pre>

<p>Running this gives us: </p>

<pre>
$ ./a.out
-1 4294967295 -1
512 512 0
0 0.000000 1073741824 0
</pre>

<p> which is probably not what you would expect.  This is hard to unit test for since the wrong values will only occur with some of the values.</p>

<p>As mentioned <code>gcc</code> has a few options for checking format strings.   It catches some security issues and wrong number of arguments. Unfortunately it doesn't catch sign conversions or shortening conversions (32 bit integer to 8 bit integer). 
</p>
<pre>
$ gcc -Wall -Wextra -Wconversion -Wformat=2 main3.c
main3.c: In function ‘main’:
main3.c:12: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘double’
main3.c:12: warning: format ‘%u’ expects type ‘unsigned int’, but argument 4 has type ‘double’
main3.c:12: warning: format ‘%hhd’ expects type ‘int’, but argument 5 has type ‘double’
</pre>

<p>This only caught the float-to-integer conversion but the others.  Your application may emit wrong data.   in addition, I'm quite sure that the "right combination" of data and incorrect format string will still core dump, especially on 64-bit platforms.  This may be a <code>libc</code> bug and maybe only on some CPUs.</p>

<p>My favorite scenario is some customer logger that uses printf-style varargs, and some error condition happens and starts to log something.  But the format is broken, and core dumps.  Good times.</p>

<p>So how can you make <code>printf</code> style functions truly safe <i>and</i> type-safe?</p>

<h2>Fix the compilers</h2>

<p>I'm not touching GCC, and I'm not sure it can handle shortening conversions due to the way it's parser works.</p>

<p> I took a look at <a href="http://clang.llvm.org/">LLVM clang</a>.  To do this you'll have to re-write the current format checker to really parse format string.  This is somewhat hard.  Also it's not quite so straightforward to figure out the type being passed in.  For instance:
</p>

<pre>
bool foo = ???;
int a = 1;
float b = 100.0;
printf("%d",  foo ? a : b);
</pre>

<p>clang is super-cool but probably won't be ready for a good year for use in production, anyways.</p>


<h2>Switch to C++ streams</h2>

<p> This is clearly not practical for many applications.  And C++ streams come with a lot of baggage.</p>

<h2>Program Transformation </h2>

<p>The fact any of this is a problem at all is a surprise.  At compile time we have the format and the arguments, but yet <code>printf</code> is a <i>regular function</i> that parses the format string every time it is called.  That doesn't seem so smart.   It seems that somehow we could transform the printf function into another form.
</p>

<p>I took a look at <a href="http://www.rosecompiler.org/">Rose Compiler</a> but I could not get it to compile correctly.  It's a monster and seems a bit of overkill for this project</p>

<p>I also took at look at dumping the C syntax tree (the AST) for both gcc and clang, but that was  successful</p>

<p>Full on parsing C or C++ is not trivial at all</p>

<p>However transforming each <code>printf</code> into a individual function will allow the compiler to perform it's normal functional call checks and type information with the flag <code>-Wconversion</code>. 

<pre>
printf("%d", 1);
</pre>

<p>
into
</p>

<pre>
static int printf_1(const char* format,  int a) &#123;
   return printf("%d", a);
&#125;

printf_1("%d", 1);
</pre>

<p>This is easy to "undo" as well.   Using the example from above, our new source file becomes:</p>

<pre>
#include <stdio.h>

/* VARARG TRANSFORMATION START */
/* This is autogenerated */

static void printf_1(const char* format __attribute__((unused)), int a0, unsigned int a1, char a2) &#123;
   printf("%d %u %hhd\n", a0, a1, a2);
&#125;


static void printf_2(const char* format __attribute__((unused)), int a0, unsigned int a1, char a2) &#123;
   printf("%d %u %hhd\n", a0, a1, a2);
&#125;


static void printf_3(const char* format __attribute__((unused)), int a0, double a1, unsigned int a2, 
char a3) &#123;
   printf("%d %f %u %hhd\n", a0, a1, a2, a3);
&#125;
/* VARARG TRANSFORMATION END */

int main() &#123;
  int a = -1;
  printf_1("%d %u %hhd\n", a, a, a);

  unsigned int b = 512;
  printf_2("%d %u %hhd\n", b, b, b);

  double c = 2.0;
  printf_3("%d %f %u %hhd\n", c, c, c, c);

  return 0;
&#125;
</pre>

<p>Compiling this: </p>

<pre>
$ gcc -Wconversion main4.c
main4.c: In function ‘main’:
main4.c:26: warning: passing argument 3 of ‘printf_1’ as unsigned due to prototype
main4.c:26: warning: passing argument 4 of ‘printf_1’ with different width due to prototype
main4.c:29: warning: passing argument 2 of ‘printf_2’ as signed due to prototype
main4.c:29: warning: passing argument 4 of ‘printf_2’ with different width due to prototype
main4.c:32: warning: passing argument 2 of ‘printf_3’ as integer rather than floating due to prototype
main4.c:32: warning: passing argument 4 of ‘printf_3’ as integer rather than floating due to prototype
main4.c:32: warning: passing argument 5 of ‘printf_3’ as integer rather than floating due to prototype
</pre>

<p>Now it catches 100% of the type errors.</p>

*****
Comment 2010-04-11 by None

This is a really cool concept.  Do you mind if I cite this in an article that I&#39;m working on?<br /><br />I&#39;ll probably have some extensions to printf.py.  Would you mind if I submit these as patches to your typesafeprintf project on Google Code?<br /><br />You can contact me at joshkel at gmail dot com.


*****
Comment 2010-04-20 by None

I forgot to mention, another option, is to transform printf functions into code that uses functions that are smarter than printf.<br /><br />Say, like the numtoa code in stringencoders<br />http://code.google.com/p/stringencoders/
