---
layout: post
updated: 2007-11-06
alias: /2007/11/string-compare-whitespace-insensitive.html
title: String Compare, Whitespace Insensitive
---
<p>
In the process of writing some unit tests, I needed to compare the output string with the expected output (.  Except the strings are XML snippets, and I didn't want the tests to break if I changed the formatting.  So I need to write up a simple "string compare, whitespace insensitive" function (e.g " f o o " == "foo").  Very handy, but not built into any programming language that I can recall.
</p>

<p>
Writing this function is a good simple programming, weed-out question for interviewing.  It works for any programming language, too.  The higher level languages will have a few ways to do it.   If the interviewee can't come up with something, well, it will be a short interview.
</p>