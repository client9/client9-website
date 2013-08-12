---
layout: post
updated: 2007-11-25
alias: /2007/11/ssi-secure-software-test-for-c.html
title: SSI Secure Software Test for C
---
<p>
As mentioned in the last post, the <a href="http://www.sans-ssi.org/">Secure Software Institute</a> is granting Secure Software Programmers certiﬁcation.  i took the C sample test online.  While I can't cut-n-paste from the sample test, the questions for the C/C++ are similar to this:
</p>

<pre>
What line contains a security issue:

1   #include <stdio.h>
2   int main(int argc, char** argv) &#123;
3       printf("%d\n", argc);
4       printf(argv[1]);
5       return 0;
6  &#125;
</pre>

<p> The answer is line 4, since the "format string" is coming from the user.  If the string contains "%d" and "%s" formats in it,  C will start filling in values off the stack which can lead to nastiest.  You want to change line 4 to <code>printf("%s\n", argv[1]);</code>, or in this bad example <code>if (argc > 1) &#123; printf("%s\n", argv[1]); &#125;</code> Ok, so now you know.   The other questions are more obscure.</p>

<p>So are you suppose to go through all your code and make these nit-picky changes?  Like that's going to work.  Like you're going to have <i>time</i> to even do that.    Even if you did "fix your existing" code, new code, patches, changes are constantly coming in.  And humans aren't so good with details -- they'll make mistakes.  Certification in secure programming is just a start in <i>security</i>.</p>

<p>For this example, the issue can be caught automatically with <code>gcc</code>, by adding <code>-Wformat-security</code> or <code>-Wformat=2</code>.   It's <i>not</i> caught with <code>-Wall -Wextra -pedantic</code>
</p>

<pre>
$gcc -v
... gcc version 4.0.1 ...

$ gcc -Wformat=2 -Wall -Wextra -Werror -pedantic foo.c
cc1: warnings being treated as errors
foo.c: In function ‘main’:
foo.c:4: warning: format not a string literal and no format arguments
</pre>

<p>Ok, that does it.  I'm writing a new book on C/C++ and software engineering.  Really.  Stay tuned for details.</p>