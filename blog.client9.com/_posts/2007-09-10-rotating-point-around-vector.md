---
layout: post
updated: 2008-12-08
alias: /2007/09/rotating-point-around-vector.html
title: Rotating a point around a vector
---
<p>Well, you'd think it would be easy: rotate a point (<i>x</i>,<i>y</i>,<i>z</i>) around a vector (<i>u</i>,<i>v</i>,<i>w</i>), by a certain angle &lambda;.   You'd think this would be in every elementary graphics textbook, but no.</p>

<p> For true 3-D applications, you'd probably want to use a transformation 4x4 matrix and perhaps quaternions (<a href="http://www.google.com/search?q=Rotation+About+an+Arbitrary+Axis+&ie=utf-8&oe=utf-8" >seach</a>) This is for quick and dirty, "I need to rotate-something-now" type of work where you don't have a matrix library laying around.  Like in javascript, or python.  An application of this is to be able to draw circles on Google Earth (posting to come).</p>

<p>
<a href="http://www.mines.edu/~gmurray/">Glen Murray</a> solved this in the <a href="http://www.mines.edu/~gmurray/ArbitraryAxisRotation/ArbitraryAxisRotation.html">most general case</a> with the new point being:
</p>

<div>
<a onblur="try &#123;parent.deselectBloggerImageGracefully();&#125; catch(e) &#123;&#125;" href="http://3.bp.blogspot.com/_5gQC8GTAxnY/RuWDrTZyBQI/AAAAAAAAAA0/zWBPD51-0IU/s1600-h/rot_point_vector.png"><img style="cursor:pointer; cursor:hand;" src="http://3.bp.blogspot.com/_5gQC8GTAxnY/RuWDrTZyBQI/AAAAAAAAAA0/zWBPD51-0IU/s320/rot_point_vector.png" border="0" alt=""id="BLOGGER_PHOTO_ID_5108634132287718658" /></a>
</div>

<p>
Which is not so bad.  However if we assume the vector is a unit vector, (and there is no reason not to assume this since we always do a little translation and scaling), the result is much simpler:
</p>

<div>
<a onblur="try &#123;parent.deselectBloggerImageGracefully();&#125; catch(e) &#123;&#125;" href="http://4.bp.blogspot.com/_5gQC8GTAxnY/RuWDdjZyBPI/AAAAAAAAAAs/3QezsQdXb4I/s1600-h/rot_point_unitvector.png"><img style="cursor:pointer; cursor:hand;" src="http://4.bp.blogspot.com/_5gQC8GTAxnY/RuWDdjZyBPI/AAAAAAAAAAs/3QezsQdXb4I/s320/rot_point_unitvector.png" border="0" alt=""id="BLOGGER_PHOTO_ID_5108633896064517362" /></a>
</div>

<p>I'll post the derivation shortly.</p>

*****
Comment 2007-12-08 by None

Or, in other words, the rotated vector is equal to<BR/><BR/>U times (U dot X)(1 - cos lambda) + (U cross X) times (sin lambda)<BR/><BR/>where U is the normalized form of (u,v,w) and X is (x,y,z). Thanks though :)


*****
Comment 2008-04-02 by None

Aha! I was delighted to find this "vector" solution posted here, but when I tried it gave the wrong answer. I Googled and found the correct form of this "Rodrigues" equation posted on Wikipedia:<BR/><BR/>X times (cos lambda) + U times (U dot X)(1 - cos lambda) + (U cross X) times (sin lambda)<BR/><BR/>Notice the additional first term. But thanks, stijn, for pointing me in the right direction to solve my geometry problem.


*****
Comment 2008-07-20 by None

I have to agre with the one that anonymous posted. If you visualize it, it makes sense. The first two use cosine to interpolate between X and where X would be if rotated 180 using U truncated (by the dot) as the center point. The last term shifts it on the perpendicular axis using sine. Beautiful! However, when I searched wikipedia for Rodrigues equation I got nothing like this.


*****
Comment 2008-07-30 by None

I am the "anonymous" that said Wikipedia had Rodrigues equation defined. You can see it at http://en.wikipedia.org/wiki/Rodrigues%27_rotation_formula. I didn't bother going through the proof on that page but simply used the equation at the top of the page. Incidentally, I figured out the notation (u,v) in the third term to the right of the equal sign means dot-product.
