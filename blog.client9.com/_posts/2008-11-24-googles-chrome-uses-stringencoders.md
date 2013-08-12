---
layout: post
updated: 2008-11-24
alias: /2008/11/googles-chrome-uses-stringencoders.html
title: Google's Chrome uses stringencoders!
---
<p>
It looks like Google's <a href="http://www.google.com/chrome">Chrome browser</a> is using my  base64 encoding algorithm from <a href="http://code.google.com/p/stringencoders/">stringencoders</a>.  I haven't tracked where they are using it yet, but it's in their repository.
</p>
<p>
Proof is <a href="http://src.chromium.org/viewvc/chrome/trunk/src/third_party/modp_b64/">here</a>.  They had to jump through some <a href="http://src.chromium.org/viewvc/chrome/trunk/src/third_party/modp_b64/README.google?revision=19&view=markup">hoops</a> to make it work on Windows due to different headers and whatnot.  
</p>
<p>Props to sjk for the heads up</p>

<p>UPDATE: it looks like <a href="http://code.google.com/p/gears/source/browse/trunk/gears/third_party/?r=1354#third_party/modp_b64">Google Gears</a> uses it too</p>