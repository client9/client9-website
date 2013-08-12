---
layout: post
updated: 2008-11-29
alias: /2008/11/c99-cpp-vararg-macros-to-add-file-and.html
title: C99, CPP vararg macros to add file and line number for debug,trace
---
<p>
Excuse the horrible title, it's every keyword I can think of that describes this.
</p>

<p>Here's the problem: You want to define a macro for logging, debugging or tracing that adds file and line number to a printf-style function, for instance <code>LOGIT("The count is %d", count);</code> to "output" <code> [Myfile.c:123] The count is 123"</code>
</p>

<p>I forgot the syntax for vararg macros in C99/CPP, so did a search and got back horrible bloated answers that involved new C++ classes or things that use fixed size buffers.   The simple way is to do something like this:
</p>

<pre>
#define SYSLOG_TRACE(FMT, ARGS...) syslog(LOG_DEBUG, "[%s:%d] " FMT, __FILE__, __LINE__, ##ARGS)
#define LOG_STDERR(FMT,ARGS...) fprintf(stderr, "[%s:%d] " FMT, __FILE__, __LINE__, ##ARGS)
</pre>

<p>
Some quick notes:  Recall, if two quoted strings are next to each  such as <code>"a" "b"</code> is considered to be one single string <code>"ab"</code>.  I think that is standard C.    The only GCC-ism is the <code>##</code> which means "if there are <i>no</i> args, then remove that comma beforehand".   If you aren't using GCC, I think you just need to define two macros, one with args, and one without.
</p>

<p>Enjoy</p>