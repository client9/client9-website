---
layout: post
updated: 2007-09-11
alias: /2007/09/drawing-circles-and-stars-on-google.html
title: Drawing circles and stars on Google Earth with KML
---
<p>
So I'm sure you were wondering what the <a href="http://blog.modp.com/2007/09/rotating-point-around-vector.html">last post</a> was about.  Here are the fruits of my labor.
</p>

<p>I created a new googlecode project <a href="http://kmlcircle.googlecode.com/">kmlcircle</a> that will generate the appropriate <a href="http://earth.google.com/">Google Earth</a> <a href="http://code.google.com/apis/kml/documentation/">KML</a> snippet for circles, regular polygons and stars.  Check out the examples:
</p>


<img src="http://kmlcircle.googlecode.com/svn/trunk/images/circles.jpg" alt="circles" />

<img src="http://kmlcircle.googlecode.com/svn/trunk/images/stars.jpg" alt="circles" />

*****
Comment 2009-04-02 by None

Hi Nick,<BR/><BR/>I've been using your KML Circle code. It's awesome.<BR/><BR/>I'd like to contribute back to your project... I have the following to add:<BR/><BR/>* Translated to VB.NET<BR/>* Arcs<BR/>* An incomplete move from a spherical Earth model towards WGS84


*****
Comment 2009-04-02 by None

hi there... send me an email to nickg ---at----<BR/>client9 DOT com<BR/><BR/>and I can make you a 'project owner' and then you can  hack away!


*****
Comment 2009-06-19 by None

Greetings,<br /><br /> Thanks for the code and i agree with frankv. It is awesome. It has given me good insight into Python and KML, however, i have hit a snag when i try to plot near the poles. I suspect you have knowledge of this.<br /> Example:<br />   Plot 5 equi-distant circles between lat 0 degs to lat 90 degs(-90 degs) with radius of 500000 meters.<br /><br /> The plots near the equator are fine but as you near the poles the circles shrink, ultimately disappearing at the poles.  Any attempt by me to isolate the radius calcs ends with disappointment. I understand the calcs are intrinsically tied to the center/origin coordinates but my very limited maths abilities has left me unable to extract anything, worthwhile. <br /> The solution on this site -- http://dev.bt23.org/keyhole/circlegen/output.phps -- works but is written in PHP.  I enjoy/like Python and would like to complete my project in this language. An attempt by me to translate left me with a sore head. I deemed installing PHP and adding a hook to the code as unappealing, almost obscene.<br /> As you are the author, it seemed obvious the best place to start before i went too far afield, so any information,observation, assistance, advice, updates will be warmly appreciated.<br /><br />  many thanks,


*****
Comment 2009-06-29 by None

Sorry,<br />my bad. This site http://dev.bt23.org/keyhole/circlegen/output.phps<br />doesn&#39;t work.Not enough research on my part.Now realise there is problem in google code. Apologies
