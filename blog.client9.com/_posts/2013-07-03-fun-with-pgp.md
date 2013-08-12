---
layout: post
updated: 2013-07-04
alias: /2013/07/fun-with-pgp.html
title: An Exercise in PGP from cryptome.org
---
By accident I bumped into some interesting tweets by <a href="https://twitter.com/ioerror/">@ioerror</a>:<br />
<br />
<a href="https://twitter.com/ioerror/status/352253686283649024">https://twitter.com/ioerror/status/352253686283649024</a><br />
<blockquote>Fascinating. Tonight @Cryptomeorg posted PGP messages to himself, keys that may belong to #Snowden and @birgittaj : <a ef="http://pastebin.com/Hrvq4bpz">http://pastebin.com/Hrvq4bpz</a><br />
</blockquote><br />
<a href="https://twitter.com/ioerror/status/352260009989636097">https://twitter.com/ioerror/status/352260009989636097</a><br />
<blockquote>It appears that @Cryptomeorg's latest message is to a key for Julian and another for Bradly Manning... cc @wikileaks: <a href="http://pastebin.com/QBTsFYq2">http://pastebin.com/QBTsFYq2</a> <br />
</blockquote><br />
Using twitter to send PGP messages isn't pretty.  A single messages is broken up across tweets.  Thank you @ioerror for cutting and pasting these back and into pastebin. <br />
<br />
There was also some interesting dialog between <a href="https://twitter.com/@cryptomeorg">@Cryptomeorg</a> (ending in something like "don't use cleartext ever. bye").  <a href="http://gawker.com/a-discussion-with-cryptome-514154708">Cryptome.org is known for deleting old tweets</a>, and this is no exception.  Those tweets are gone.  <br />
<br />
I've use PKI recently for <a href="http://blog.client9.com/2013/07/ovpn-udp-vs-tcp.html">VPNs</a> and <a href="http://blog.client9.com/2012/04/using-gpg-to-encrypt-files-and-data.html">data at rest</a>, but I haven't used PGP for communication in a long time.  This seemed like a fun exercise to verify @ioerror's claims and catch up on PKI.<br />
<br />
First let's dump the meta data using <a href="http://www.mew.org/~kazu/proj/pgpdump/en/">pgpdump</a>.   You can build from <a href="https://github.com/kazu-yamamoto/pgpdump">source on github</a>, or it's probably available using whatever package manager you use.  Or you can just use the web interface at <a href="http://www.pgpdump.net">http://www.pgpdump.net</a>.  For this example we are using Message 5.<br />
<br />
<pre>Old: Marker Packet(tag 10)(3 bytes)
 String - ...
New: Public-Key Encrypted Session Key Packet(tag 1)(268 bytes)
 New version(3)
 Key ID - <b><a href="http://pool.sks-keyservers.net:11371/pks/lookup?op=vindex&search=0x1DCD2143132FB7FC&fingerprint=on&exact=on">0x1DCD2143132FB7FC</a></b>
 Pub alg - RSA Encrypt or Sign(pub 1)
 RSA m^e mod n(2048 bits) - ...
  -> m = sym alg(1 byte) + checksum(2 bytes) + PKCS-1 block type 02
New: Public-Key Encrypted Session Key Packet(tag 1)(268 bytes)
 New version(3)
 Key ID - <b><a href="http://pool.sks-keyservers.net:11371/pks/lookup?op=vindex&search=0xAFA27BFACA585F3B&fingerprint=on&exact=on">0xAFA27BFACA585F3B</a></b>
 Pub alg - RSA Encrypt or Sign(pub 1)
 RSA m^e mod n(2047 bits) - ...
  -> m = sym alg(1 byte) + checksum(2 bytes) + PKCS-1 block type 02
New: Symmetrically Encrypted and MDC Packet(tag 18)(103 bytes)
 Ver 1
 Encrypted data [sym alg is specified in pub-key encrypted session key]
  (plain text + MDC SHA1(20 bytes))
</pre><br />
The Key ID is the interesting one.  Looking these up on the key server at <a href="sks-keyservers.net">sks-keyservers.net</a>, gives the following (with emails removed, but you can see the full email using the links above):<br />
<br />
<pre>uid Julian Assange (___@wikileaks.com)
sig  sig3  AC0707E7 2010-03-01 __________ __________ [selfsig]
sig  sig   EDD31E2A 2013-06-11 __________ __________ Michael Vario (____ @gmail.com)

sub  2048R/132FB7FC 2010-03-01            
sig sbind  AC0707E7 2010-03-01 __________ __________ []
</pre><br />
This basically says someone named "Julian Assange" with an email at wikileaks owns this key.  How do we know who this really is?  We don't, but someone named Michael Vario a few weeks ago claimed "this is the correct".  You can click on Michael Vario's name and see who you verified his keys. And so on.  This is how PGP works - there is no central authority. In a fantasy world you could trace your connections all the way to the source.  Think of it as a twenty year-old nerdy version of <a href="https://developers.facebook.com/docs/opengraph/">Facebook's OpenGraph</a>.<br />
<br />
If you go through this exercise, you'll get following:<br />
<table><tr><th>Message</th><th>Key ID</th><th>Owner</th></tr>
<tr><td>1       </td><td><a href="http://pool.sks-keyservers.net:11371/pks/lookup?op=vindex&search=0x4F41F3BBFA6B4592&fingerprint=on&exact=on">0x4F41F3BBFA6B4592</a></td><td>John Young (<a href="http://cryptome.org">cryptome.org</a>)</td></tr>
<tr><td>2       </td><td><a href="http://pool.sks-keyservers.net:11371/pks/lookup?op=vindex&search=0x2814ADCFB25D8926&fingerprint=on&exact=on">0x2814ADCFB25D8926</a></td><td>Ed Snowden (including an email from boozallen.com)</td></tr>
<tr><td>3       </td><td><a href="http://pool.sks-keyservers.net:11371/pks/lookup?op=vindex&search=0x6569227B6F3B623E&fingerprint=on&exact=on">0x6569227B6F3B623E</a></td><td>Ed Snowden (different email address)</td></tr>
<tr><td>4       </td><td><a href="http://pool.sks-keyservers.net:11371/pks/lookup?op=vindex&search=0x457658597859566C&fingerprint=on&exact=on">0x457658597859566C</a></td><td><a href="http://en.wikipedia.org/wiki/Birgitta_Jónsdóttir">Birgitta Jonsdottir</a></td></tr>
<tr><td>5       </td><td><a href="http://pool.sks-keyservers.net:11371/pks/lookup?op=vindex&fingerprint=on&search=0xC1A1F98AAC0707E7">0x1DCD2143132FB7FC</a><td>Julian Assange (wikileaks)</td></tr><br />
<br />
<br />
<tr><td>5       </td><td><a href="http://pool.sks-keyservers.net:11371/pks/lookup?op=vindex&search=0xAFA27BFACA585F3B&fingerprint=on&exact=on">0xAFA27BFACA585F3B</a></td><td>Bradley Manning</td></tr><br />
<br />
<br />
</table><br />
Note that you can create PGP messages <i>without</i> a key ID. But then the receiver needs to be expecting the message, or know about the message from another channel.  (See <code><a href="http://www.gnupg.org/documentation/manuals/gnupg-devel/GPG-Esoteric-Options.html">---throw-keyids</a></code>).<br />
<br />
So what does it all mean?  Who knows, but it appears @ioerror's claims are correct. Perhaps I'll look into this more and post again.  In the meantime, comments are welcome.  <br />
<br />
One thing I learned just reading the dialog associated with these tweets, there is general confusion on how PGP works.  No wonder since I stopped counting the number of options in GPG after 100.  And I'm a bit shocked at how bad the key servers are.  But that's a another post for another time.<br />
<br />
And thanks again to @ioerror and @cryptomeorg for the motivation to re-learn PGP.<br />
<br />
<b>UPDATE: More in <a href="http://blog.client9.com/2013/07/fun-with-pgp-part-2.html">Part 2</a></B><br />
<br />
<h2>The Messages</h2><br />
For reference, here are the messages that were posted on the @Cryptomeorg twitter account.<br />
<br />
<pre>-----BEGIN PGP MESSAGE-----
Version: PGP Desktop 9.6.3 (Build 3017)

qANQR1DBwUwDT0Hzu/prRZIBEACzx3Tb5i1T8VzieF53oTHmNUIUwtN7GPCgdcMi
Gr0jsGBPS9WkFhSspuHTaWf3rtRnhU3bCUEUMSR+CLGq44ruDeNsg8UmHWfj9o1r
thhaUbSSBUs+y38siXr8iMWoLDyA3HzvsZmsq2LtODy4JQpFiqb6FJTE+MO/m/aM
29UWLPwxOM8qlPG8J0knOazbUssWhhBU7nMs1C23ZwR7a/kAFl+G123YqYUzI7AN
B7pt3oFusAV3Xv1qVlm3Zoi29yLzccqFwvkTTzkyH0SinvqUmITKkEjHHTU1LspH
Kh7GTZS+jMy/6Pv2110zjhSX5accTKhJ0uGHPxnkWO2xrFO9mJu6kIjjaZUlV1P4
VIiQztVb5bgZByCkeCSSE6cT/8bHZu2Y2FSIYcfI/5wA7h68/IP3ivpWGzQBug6k
cn+rFrWzf/74R4xTRlPDyVjJvmQHjYn4fufPtEB9LQtnSLrLpXtxwe8c571fsk8+
M5+dBI8D6c0VXR+2iNt4LS+hOp9c7aVfaTrKSjrJcG1WS5N3sFgR9xxBg1vLrxpa
NWtMJu+fqUt3PMfQykuEpxVo0nCj6uPEgFKFicujHzGT8rxPdYYFk58KU92ypB/V
Ce/wlv6MSj6O2CDZf6kuX44Z1nJmVqrVJeHVfbUsRDc6B5xwyhdLxLGXh3M6wniJ
NbnLgtJkAaYHz+MVOm4IcwEsFLODv7k68eNIb6A+gYVsBytM66+c76jEiNO6z16E
o9cq1QbiqF7PPqNcMWqWPyTPuB3NpcHoUHbj/gkkI0acztFwUjGhacrYooHHjKZA
NGYOJfjH0yaPzA===Tupd
-----END PGP MESSAGE-----

-----BEGIN PGP MESSAGE-----
Version: PGP Desktop 9.6.3 (Build 3017)

qANQR1DBwUwDKBStz7JdiSYBD/9N4R3Wfflq8Q86UxOR9aKseC+9cnaXSwIi1t3b
q19J2hmejk3mDbFThwgnxkoyA+Mv2bVmt5ktqA+QwmlQdfrTC1S11UCAtjxGqKjR
rcNIpzfxu0C4tKWTePMogi/Rewx9pl/F8TlCvRJ1q6Y4oTqtnwNpsCyBdeoM5h/0
WiKP3SxWWTTJGMyE79ZbLQ+WZpgc0rrBZoPEz7joRWXTRn+A7wHFhCJ9jgVS1mHi
wC++Y62a7QX43nMloFdDAPr/Jb1AK/9YWJqmrxjIGQCBE2GGJl2cO7EJyi9YPjGI
2eyg31/276VY37NUbUIHn56uDyPem8VAzjFA0Nj0qkaUelqxn2zZDXaTYWqcIip8
gGpomtIh2PQndX91uB6ONOZvwmOlwmQq9uEn5tvzVDfbfGWG8nrDkhYBNYzU6r6G
/deMhtx9Kb5KSHnzytJF//FTNSEEW1gB3UQ/vq14xC3LpB6cHJeylYSTMiUMsT7Q
jM5VTFJv/Cesd7wfePoDlK/pKxT/o3RR3NtH2kNGLGb7XlOEQH2J3zovEYZdqejM
3cP8m3pvQOAw3iO/NFChAE0GqsObwLJsnmGQ2dW5Ptl8MFMohcLqis52IaD+T/Xu
wdZTlFndWr0nO5lwsCbdQ1znHDLAq5sfTjQh7ZZxHIIgwlKcLU65LxXgCuPVKiI9
7UZpwtJiAW7F9fyGblItyV4Po2suGZ/eiiYPrKm+x9ZhgahECKaD1kdhlrwEBz4S
CF6Rv4OEiWBgbBpn7XV+2ljuNDnFDKKtiW63GSUes64YdAdDznJrzrspOBbHOzkm
VhvWcYm/x18==Rzph
-----END PGP MESSAGE-----

-----BEGIN PGP MESSAGE-----
Version: PGP Desktop 9.6.3 (Build 3017)

qANQR1DBwUwDZWkie287Yj4BD/9CVnnBIyfP4ZslYCCIu3Ajs1PuM9fYBQ5oX0tW
QCJOsUQ+CYIRpAtCumQbxSK1ytA2P3TjPotDxiurqo/aJJvZlm88F9WlLFd5jeIr
kyITOArrEWMz4CG1H2f2T+t8FGHy2x08WYxGcq5r+VtYuMMh9gkiVDbMY0UBJeHE
nUA/IB+HXdodLr6HOEKdXwMxPDmoKncg+Usm5WmovXM4xfvbSQKBRBKi1cgsMTJV
3lqXp4i0PNj38V/HskwlVx+luOMqrSM4ukw1qe2ozL+95TqIHGuooT/GB7QpvI64
/vwlpl6KuRVpdf6OIzqa2Cwx0jICWl8Baz0KqqwJp84VdmsWZTcf1qghNr/xyH1t
HvHqb39V+zKcZWRPRHV43ino76FRX9Lb7O9KVD+rDxHpZATvuitvyBWyE1VY7qmw
XYLRriWwVYJ9OsoeU2CUAfxRU4KXaqPwbAXygDyHbM3nubYMBesQUD44ySVPIGqF
oEHKeOCWtDXQEH61liKGwJb66QyEOty2LsK8Zb008tIVlOsFOXIXh+qGN3mpedBK
pkW/fARXutuGlT2a1WQKJvGwrqsxPo7ZNTAWcl5+Gxv1CgG4o/l7/lOxgan6BPlj
8elsDGQjEbzH2Xo8VNOZNu9wc7fqPofqcz9ykud2tW6CS/aVvAvM5lhbtTsO4jK7
qPjVqdJcAUzr4L/h8GcvfZm3M54LXa+UOCzvmdnmrGQiRk/Pvb5vf3P3x9NzwCJK
sAQhooFiO3AHGW9yBAYeuNAbYK/wodJMhwKyCgF/+nG8khTSGSORcemnZeeKRxSp
8i0==SuA4
-----END PGP MESSAGE-----

-----BEGIN PGP MESSAGE-----
Version: PGP Desktop 9.6.3 (Build 3017)

qANQR1DBwUwDRXZYWXhZVmwBD/0SwViWSa5f/WB5YlTnw7VHlNDmVI5vR72VwV9+
qShiWTHz49jr6APsnWHj+Az379JxdeNgwa5LZeDcpFi56LxZfVTX/DeEuVElQxNB
Wu8uwMeJz9J03Z9BGH8EtC4Z4oSVDJGEbJoROagK1so4PQzt7/93GEQcMV5P7JAT
CzjPwUaDRYe6AfgD06ve9uwozn+Tvm3Xwugb6/Ow1R0mrSNyDd83pTtQcl/hopuc
ZJRCAoZlgnfpY8cdlNLX40G3gCjCI8RtjKqqSnpIp4eS3H5zTUwdQM5LwCaN5k5J
AHW6Qm7gE5tRfKN59kOIzQj55dwnA9j/w7yXYfzwXLFud99iLqUM+kwx6fy+LBLg
J8rEvhiLiFqnfNcsCm8JGD5x8gk4qxYc24v7XSFELuoYoHaiNxFq0VOtUql7Ie4S
h12rZqRSYPXm28LY6hBw6sskMUq4Ni8CS967tmmnR6wm2Fn9cIop/iL4ieehnpOq
wnTJcGSbiHXD9RmoyCXQFkN7wAGPvF6KQQoXV/p1SmTipPE3QYHJc0jvzwXJRLeP
OYwcWX4x9tRm7IpGp2c5rqVqlwSX8Iv02lmQaUWhA2JO2XvhEEc46dIQS1gngTj4
TIqst4bzoVCtBxb85kX5fi7+1IY809Oeh+M6/Rrd2f3bzieDgCC9UQqJr2LkWqKZ
Os9DGtJdASHZHGv7Jh4VdpurcpcwsrYELAIYQJsKikJaBrCRv6vNcwD11Mtxiva1
HunTFC1BztSUMafr0VNanUtOQstv0tJsex2ICLyc3St4CTjsWpZrHizE2ZmJuqTv
X90m=J+LV
-----END PGP MESSAGE-----

-----BEGIN PGP MESSAGE-----
Version: PGP Desktop 9.6.3 (Build 3017)

qANQR1DBwEwDHc0hQxMvt/wBCACp+8bHat5w9ucVin63T4oaNXpm/mMn5t6SLct7
GT+5//sYix+y9owJX5gvSVu0p+ofp7ORNwLzq+lcvCV3lRYwtp49eljfIdhws295
ZmFSdCjlVAkMGuP8kyvMkVaphp8e7fAT9lvKu1BEy6nA8SwejTqCNKrNRzlHYGdm
MhSUMozBvs+2IevMtpQ3naD6TffeLCqCK6BYgK7z5eleAG+M2yTTtWv/Tj94dSvf
A23RhQutdfJ6YyvnhLnuw5VJdsy4rNZ1+SUIgtICNtqQsZLAiZARLa2NU3+iq9A8
j/T5M1LafxhWJMYIdgLE36FHCsa+2zI+RQ+9SO6Yc+SEwnW6wcBMA6+ie/rKWF87
AQf/UFV0hZuTLqtjKoBxmDe8zUtmmE08Wfho0a6GCSLLNvrGCm8L78fvPUgJWK34
3cyA8CWVrzcQiRhaQBb8qDzqcNPrpqwMLOBRT/ma0Bko4950hHBjD/LfXzfT5DnQ
ayKunYP72PscKhRRD8NaWs57N6GINPtBvOCYFUv+ya3eHzfodzI89kve/bas6c2u
2m4JFe1HdwZyuOEh/XSZoJdL2Mm3WlM4Sapj6bLRPo15VCuYDuMCMADIBmmVAhko
ZTo841zYY8coYrzOJK6hUNmjVI/X6FepkC9QDcgcy4OlOo6YQR0fwDRB+UUmlszP
txXnAwKRpAVIec1pJngcVVkW5NJnAVVAU0zoi7sRA/lH5tJRd/LlSJw4gMCA2tuH
EqSSBiKGJRdWAnBQhVLz6wd5iB5Wl5f+xsGeBn2gNwaBjpIcZ/cHU6FdZRViiH5C
C8cB1YCdbU8UGFbxGiNMZw/vh0LpKmPcWfVKCw===SsC+
-----END PGP MESSAGE-----
</pre>

*****
<a name="comment1"></a>
Comment 2013-07-03 by Cryptome

You and Jake are getting close to the purpose of the PGP op, it&#39;s
about &quot;metadata&quot; but substantially more than disclosed by
pgpdump. The keyservers are a gold mine of user data and metadata due
to lack of sanitation of legacy connections by signing. The history of
PGP is on the servers and can be easily searched, user-profiled (by
key extraction and key uploading) and siphoned in its
entirety. Current iterations of PGP are not what it was in the
beginning, say up to version 2.6.2, supposedly the last trustworthy
before transformation into a commercial best seller with the attendant
complicity with spies -- gov, com, org -- associated with
success. Metadata of the messages themselves is much more than pgpdump
shows when coupled with mining of the key servers. Content of messages
are not the target, but the connection among users, as the spies
freely admit -- it&#39;s the infrastructure of PGP that is most
valuable. That applies to most comsec tools, perhaps all, whether
crypto, anonymizers, privacy protection policy, the kaboodle. The more
popular a system the more likel compromised. Not my views but that of
the experts which openly discuss comsec vulnerabilities on mail lists
and conferences, among them the founders and principal cryptographers
of PGP.

The PGP op on Twitter was a teaser to suggest the hoarding of
accessible tweets and other SM postings are amassing a huge dumpster
for diving, like the key servers, the anonymizers and ilk. Might be
wise to burn the trash instead of accumulating it. YVT, Cryptome
