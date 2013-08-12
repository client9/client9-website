---
layout: post
updated: 2008-03-28
alias: /2008/03/why-flash-will-never-be-on-iphone.html
title: Why Flash Will Never Be On The IPhone
---
<p>
Ok, so the madness of Iphone SDK came out a week or two ago.  And the big whoop-de-do was what about Flash on iphone.  Never going to happen.  Well it might if Adobe writes a huge check to Apple.  Otherwise never.
</p>

<p>Ever wonder why the ipod does't have a <i>radio</i> in it?   It would cost nothing, and have no drain on battery.    Same reasons why you'll never see Flash.  Apple makes $0 on radio (or flash), it strengthens the 3rd party (for radio, it improves radio advertising, for iphone it improves Adobe's developer base), and in fact competes with their technology (here radio vs. Itunes, for iphone it's flash vs. standards, a bit of an inversion but you get the idea).
</p>

<p>
But why <i>not</i> flash?  
</p>

<p>
Ok <i>why</i>?
</p>

<p>Ok why use flash at all?  I see a few reaons</p>
<ul>
<li>"rich media" advertisements.  I'm sure AT&amp;T is excited to use their bandwidth for this.  They and Apple make $0 on from this and make the whole page slower.</li>
<lI>"vanity sites" -- the stuff that ad agencies make when a new toothpaste comes out.  Not compelling and orphanware in a week.  Typically completely unusable on desktop let alone the mobile browser.</li>
<li>Video and Audio.  Ok everyone.  <i>Think</i> how ridiculous this is.  You need an abstraction layer (flash) on an abstraction layer (the browser) on an abstraction layer (the OS) to the hardware accelerated codec.  More on this later.</li>
<li>Interesting animations and vector graphics.  Sadly if you want a true cross platform vector graphics, flash is it.  SVG isn't supported very well.  YET.  But the use cases for vector graphics on a web page on a mobile phone are so far low</li>
<li>Actually real applications.   I will admit, the Flex API is pretty nice.   I actually like it a lot.  But anything you write for it will 
not out of the box work on a small screen.</li>
</ul>

<p>
Ok let's go back the audio and video part.   I'll spare you my rants on W3C, and just note that a week before the SDK announcement, Apple (cough, WebKit) put into mainline HTML5 support for video and audio codecs.  Think of it as a restricted activex for media.  You can display any number of image format, why not MP3 and Video too?  Also Safari has really improved their SVG implementation.  They'll pop out Safari 3.2 with improved video, audio, and svg  support and then, really, <i>why</i> do you need flash on the iphone?
</p>


<p>
I don't want to be too hard on flash.  I do think an integrated platform, like the one they provide, is useful.  And with the state of SVG right now, they <i>are</i> the only game in town for complicated <i>desktop</i> graphics.  But the iphone is different.  There is no illusion that if you write something "for mobile" it will work well on all mobile phones.  Plus Apple isn't going to allow alternative browsers on the Iphone.   Flash does play a part here in smoothing over differences in browsers, but again, not the case here.
</p>

<p>So there you go.  You'll never see flash on the iphone.</p>

*****
Comment 2008-03-28 by None

Because of recent Safari developments i now love the iphone, expect more about it in <A HREF="http://svg.startpagina.nl" REL="nofollow">the SVG link resource</A> soon.
