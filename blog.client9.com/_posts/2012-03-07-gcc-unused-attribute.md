---
layout: post
updated: 2012-03-07
alias: /2012/03/gcc-unused-attribute.html
title: gcc unused attribute
---
<P>Dusting off my C skills and wanted to silence some benign used parameter warnings<br />
</P><pre>warning: unused parameter ‘len’ [-Wunused-parameter]
</pre><p>Props to <a href="http://sourcefrog.net/weblog/software/languages/C/unused.html">Martin Pool's blog</a> for this nice macro:<br />
</p><pre>#ifdef UNUSED 
#elif defined(__GNUC__) 
# define UNUSED(x) UNUSED_ ## x __attribute__((unused)) 
#elif defined(__LCLINT__) 
# define UNUSED(x) /*@unused@*/ x 
#else 
# define UNUSED(x) x 
#endif
</pre><p>Use it as such:<br />
</p><pre>int foobar(int a, int UNUSED(b))
</pre><p>It's nothing fancy or unique or even not commonly known, but I had to look it up. And so I'm giving Martin some SEO love.</p>