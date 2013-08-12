---
layout: post
updated: 2008-10-14
alias: /2008/10/duffs-device.html
title: Duff's Device
---
<p>
I previously wrote about <a href="http://blog.modp.com/2008/10/generator-and-coroutines-in-c-part-1.html">Generators and Coroutines</a> (which I'm still not sure how useful it is yet).  The technique was originally based on "Duff's Device"  which involves interlacing switch and a loop.   Here's a modernized version of the  original:
</p>
<pre>
void send(register short *to,
          register short *from,
          register count)
&#123;
 register n = (count + 7) / 8;
 switch (count % 8) &#123;
  case 0: do &#123; *to = *from++;
  case 7:      *to = *from++;
  case 6:      *to = *from++;
  case 5:      *to = *from++;
  case 4:      *to = *from++;
  case 3:      *to = *from++;
  case 2:      *to = *from++;
  case 1:      *to = *from++;
              &#125;  while( --n > 0);
 &#125;
&#125;
</pre>

<p>Here <code>*to</code> is a magic hardware device, so it doesn't need incrementing.  Stare at that for a while, then read the <a href="http://en.wikipedia.org/wiki/Duff's_device">Wikipedia article</a> and the <a href="http://www.lysator.liu.se/c/duffs-device.html">entertaining posts</a> by Duff himself.</p>

<p>While it's very compact, I'm not sure if it's any better than:
</p>
<pre>
 int buckets = count / 8
 for (int i = buckets; i > 0; --i) &#123;
    *to = *from++;
    *to = *from++;
    *to = *from++;
    *to = *from++;
    *to = *from++;
    *to = *from++;
    *to = *from++;
    *to = *from++;
&#125;

switch ( count % 8 ) &#123;
  case 7:      *to = *from++;
  case 6:      *to = *from++;
  case 5:      *to = *from++;
  case 4:      *to = *from++;
  case 3:      *to = *from++;
  case 2:      *to = *from++;
  case 1:      *to = *from++;
  case 0: ;
 &#125;
&#125;
</pre>

<p>Which is a more flexible technique I've used successfully in my <a href="http://code.google.com/p/stringencoders/">stringencoders</a> project.  No weird switch statements, but you the main benefit of 8x less comparisons in the loop body.
</p>

<p>fun stuff regardless</p>