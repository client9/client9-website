---
layout: post
updated: 2008-12-14
alias: /2008/12/retrieving-compiler-predefined-macros.html
title: Retrieving Compiler Predefined Macros for gcc
---
<p>What does <code><a href="http://gcc.gnu.org/">gcc</a></code> define as  a macro before you even start compiling?</p>

<pre>
gcc -E -dM - < /dev/null | sort
</pre>

<p>I learned this trick from Steven Engelhardt on this blog <a href="http://www.deez.info/sengelha/2006/01/29/retrieving-compiler-predefined-macros-for-gcc/">here</a> by .   I "reused" his original title in hopes his page will rank higher.</p>