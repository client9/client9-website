---
layout: post
updated: 2008-11-10
alias: /2008/11/google-c-style-guide.html
title: The Google C++ Style Guide
---
<p>
I'm not quite sure how I bumped into this but the kindly engineers at Google posted their <a href="http://code.google.com/p/google-styleguide/">C++ style guide</a>.  It's a good one.  It lists the rule, followed by the pros and cons, and the more explanation on the final decision.  Some "highlights":
</p>

<ul>
<li>No RTTI.  No shocker here.  Does anyone actually use this "feature"?</li>
<li><code>printf</code> preferred over streams!  Not sure I agree with this one but they make some good points</li>
<li>No <code>exceptions</code>!   Certainly an <i>API</i> shouldn't have exceptions.  Internally however?  They make a good point that <i>one</i> missed <code>catch</code> and your application coredumps</li>
<li>Use <code>int</code> and only <code>int</code>, unless of course you can't.  Thank god someone else knows that the unsigned and short types dont' do what you think they do!</li>
<li>Use of the Boost libraries is restricted to <a href="http://www.boost.org/libs/utility/compressed_pair.htm">CompressedPair</a>, <a href="http://www.boost.org/libs/ptr_container/">PtrContainer</a>, <a href="http://www.boost.org/libs/array/">Array</a>, <a href="http://www.boost.org/libs/property_map/">PropertyMap</a>, part of <a href="http://www.boost.org/libs/iterator/">Iterator</a> and <a href="http://www.boost.org/libs/graph/">The Boost Graph Library</a>.  It's not clear if the boost libraries which are part of <a href="http://en.wikipedia.org/wiki/Technical_Report_1">TR1</a> are allowed or not.  I've spoken to quite a few companies that have restricted the use of Boost, since many of the libraries are so way out and overdone.</li>
</ul>

<p>The rest is sensible and a good read for novice and experienced C++ developers alike.</p>

*****
Comment 2008-11-12 by None

I wish they released this earlier.  :)
