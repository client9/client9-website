---
layout: post
updated: 2009-11-10
alias: /2009/11/more-is-less.html
title: More is Less
---
<p>
For C/C++ nerds out there, Felix von Letiner wrote a very interesting paper on <a href="http://www.linux-kongress.org/2009/slides/compiler_survey_felix_von_leitner.pdf">Source Code Optimization</a>.  This will only apply for very specific cases (think string algorithms, hash code generation, numerical loops), but the conclusion is: write more readable code, it will run in less time.  It's tough to outsmart the newer GCC versions:
</p>

<blockquote>
People often write less readable code because they think it will
produce faster code. Unfortunately, in most cases, the code will not
be faster. Warning: advanced topic, contains assembly language code.
</blockquote>