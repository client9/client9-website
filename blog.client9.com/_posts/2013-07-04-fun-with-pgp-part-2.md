---
layout: post
updated: 2013-07-05
alias: /2013/07/fun-with-pgp-part-2.html
title: An Exercise in PGP from cryptome.org part 2
---
Yesterday, I posted a <a
href="/2013/07/03/fun-with-pgp.html#comment1">quick analysis of some
mystery PGP messages</a> posted by <a
href="http://cryptome.org">cryptome.org</a> on <a href="">twitter</a>
(They are gone now.  Look at the part 1 to see copies.).  Following up
on <a
href="http://blog.client9.com/2013/07/fun-with-pgp.html?showComment=1372897633035#c8120371658948592065">a
reply from cryptome.org</a>, let's look a bit more today at the
metadata that's available on public keyservers for these messages.


First some PGP updates:

* <code>gpg --list-packets</code> does more or less the same thing as
  <code>pgpdump</code>.  It doesn't require you to configure a key or
  anything, it just dumps info.
* [sks-keyservers.net](http://sks-keyservers.net) is really
  problematic.  It uses DNS for load balancing.  Except many of the
  servers are down, so then everything appears down.  For today I'm
  using the key server at [key-server.nl](http://key-server.nl/).
  Your millage may vary.


Ok, now the messages!


Message 1
--------------------------

It's a message to John Young.  Assuming <a href="https://cryptome.org/">cryptome.org</a> controls <a href="https://twitter.com/Cryptomeorg">@Crytomeorg</a>, it's a message to himself.  Ok!


Message 3, 4 and 5
--------------------------

These messages are to one of <a href="http://key-server.nl/pks/lookup?op=vindex&search=0x6569227b6f3b623e&fingerprint=on&exact=on">Ed Snowden</a> accounts, <a href="http://key-server.nl/pks/lookup?op=vindex&search=0x457658597859566c&fingerprint=on&exact=on">Birgitta Jonsdottir</a> and <a href="http://key-server.nl/pks/lookup?op=vindex&search=0x1dcd2143132fb7fc&fingerprint=on">Julian Assange</a>. On 2013-06-11, <a href="http://key-server.nl/pks/lookup?op=vindex&search=0x4B74E38AEDD31E2A&fingerprint=on">Michael Vario</a> key-signed all three accounts.  They did not countersign Michael Vario's keys.  According to the <a href="http://www.guardian.co.uk/world/2013/jun/23/edward-snowden-nsa-files-timeline">The Guardian</a>, Mr. Snowden checked out of his hotel in Hong Kong on 2013-06-10.

My understanding is that, you can sign anyone's key and re-upload it to the public keyservers. Perhaps there was some communication with the four people that day.  Or perhaps, Michael Vario just found their public keys on keyserver and designed to sign and re-upload them.  Perhaps the key upload was unintentional and done automatically by the PGP software.  Or none.  Or all three.   I'm rusty on key-signing so please correct me if I made an error here.

A quick search has <a
href="https://plus.google.com/104285003536194921645/about">Michael
Vario</a> on Google+ showing the same public key fingerprint in his
profile.

Message 2
---------------

This is the other <a
href="http://key-server.nl/pks/lookup?op=vindex&search=0x4DB8A08821B7141F&fingerprint=on&exact=on">Ed
Snowden </a>account with emails at <code>boozallen.com</code>,
<code>hushmail.com</code>, and a few others.  These are all
self-signed, i.e., this one was <i>not signed</i> by Michael Vario.
The earliest is 2013-03-24, and the last is 2013-04-24.  This is
around the time Edward Snowden started at Booz Allen.

The other key, with an email address at <a href="http://lavabit.com/">lavabit.com</a> was self-signed in 2010, and had no key-signing activity until June 11 (as mentioned).


If you were doing a search for 'Edward Snowden' on keyservers, wouldn't you pick out the one with <code>boozallen.com</code> in it? And <code><a href="http://www.hushmail.com">hushmail.com</a></code> is also known for encrypted email services.  Pretty obvious, huh?  But that one was <i>not</i> key signed by Michael Vario (whatever his connection is).   One could speculate that the first key is a honey pot, designed to catch crypto-spam (just made up that word) or perhaps it was created by someone else.  hmmm.

Message 5
------------------

Message 5 actually has two recipients, Julian Assange, as mentioned
above, and also <a
href="http://key-server.nl/pks/lookup?op=vindex&search=0xafa27bfaca585f3b&fingerprint=on">Bradley
Manning</a>. It was solely signed by <a
href="http://key-server.nl/pks/lookup?op=vindex&search=0x24D32BF9AA95C349&fingerprint=on">Daniel
JB Clark</a> (or Danny Clark) on Jan 29, 2010.

According to <a
href="http://www.bradleymanning.org/learn-more/timeline-of-events">BradleyManning.org</a>
that's about 3 months into being deployed in Iraq.

And according to <a href="http://www.wired.com/threatlevel/2011/03/manning-timeline/">wired</a>:

<blockquote>
Manning allegedly downloaded the War Logs between December 31, 2009
and January 8, 2010, and leaked them on or before February 5 — at
least 10 days before leaking Collateral Murder
</blockquote>

This is well known, and <a
href="http://cryptome.org/0001/manning-wl-pgp.htm">discussed before on
cryptome.org</a>.  You can search for "Bradley Manning Danny Clark"
and see more details.

Question: did the key signing metadata actually help law enforcement?
Not sure, I'm not that familiar with the details of the case, but it's
hard to imagine this wasn't useful.

* * *

With more time and some better timelines of events for Edward Snowden
and Brandley Manning you could probably make some more interesting
connections. Certainly making a graph of all the parties involved but
be interesting as well. And all of this is just from a few messages!

Now the fun part. So maybe you clicked on few links above.  Your IP
and your request is now somewhere on one of these shitty public key
servers.  It's probably sitting underneath someone's desk and hasn't
had a update in 10 years.  The odds of these <i>not</i> being
compromised is about 0.  When I get time, I'll write about the sorry
state keyservers are in.  In the meantime, I'm pretty sure, more than
a few "agencies" have recorded my queries. It's actually worse, as I
suspect most PGP apps refresh their keys periodically, providing a
nice tracking beacon for exactly the people who do not want to be
tracked.

So what did we learn?  PGP might be ok for commerce and intranet
applications, but PGP is really bad for leaks.  So bad, even <a
href="http://wikileaks.org/wiki/WikiLeaks:PGP_Keys">wikileaks appears
to ban PGP</a>.  If I were to take a guess what cryptome.org's
messages are, it would be "stop reading this using PGP!"

Keys
======

Since key servers are so flakey, the output is here:

0x4db8a08821b7141f
------------------

<pre>
Search results for '0x4db8a08821b7141f'

Type bits/keyID     cr. time   exp time   key expir
pub  4096R/21B7141F 2013-03-24
      Fingerprint=98E6 3244 07FA 26AD B358  7C95 4DB8 A088 21B7 141F

uid Ed Snowden &lt;edsnowden@hushmail.com&gt;
sig  sig3  21B7141F 2013-03-24 __________ __________ [selfsig]

uid Edward Snowden &lt;edsnowden@hushmail.com&gt;
sig  sig3  21B7141F 2013-03-24 __________ __________ [selfsig]

uid Edward Snowden &lt;edward_snowden@bah.com&gt;
sig  sig3  21B7141F 2013-04-12 __________ __________ [selfsig]

uid Edward Snowden &lt;esnowden@boozallen.com&gt;
sig  sig3  21B7141F 2013-03-24 __________ __________ [selfsig]
sig  sig3  21B7141F 2013-04-16 __________ __________ [selfsig]

sub  4096R/B25D8926 2013-03-24
sig sbind  21B7141F 2013-03-24 __________ __________ []
</pre>

0x6569227b6f3b623e
-------------------

<pre>
Search results for '0x6569227b6f3b623e'

Type bits/keyID     cr. time   exp time   key expir
pub  4096R/E423698A 2010-01-26
      Fingerprint=562B 2A84 F775 221E A4FD  7149 08B7 3AE9 E423 698A

uid Ed Snowden &lt;ed_snowden@lavabit.com&gt;
sig  sig3  E423698A 2010-01-26 __________ __________ [selfsig]
sig  sig   EDD31E2A 2013-06-11 __________ __________ Michael Vario &lt;mvario@gmail.com&gt;

sub  4096R/6F3B623E 2010-01-26
sig sbind  E423698A 2010-01-26 __________ __________ []
</pre>

<a name="comments"></a>
Comments
================


*****
Comment 2013-07-05 by  Michael Vario

oh the lulz


*****
Comment 2013-07-06 by Michael Vario

&quot;Or perhaps, Michael Vario just found their public keys on
keyserver and designed to sign and re-upload them&quot;<br /><br
/>That.<br /><br />So are you saying throw out the GPG/PGP baby along
with the meta bath water?  Why?<br /><br />PGP was never about
protecting against traffic analysis or protecting metadata, it is
about protecting content. Key servers don&#39;t have to be used. The
data itself can be sent, for example, via Tor to a digital dead-drop
like PasteBin.  PGP/GPG is pretty proven and does what it was intended
to do well.  To say stop encrypting because PGP doesn&#39;t hide your
metadata is like saying stop driving because your car doesn&#39;t fly.

*****
Comment 2013-07-09 by Cryptome

Tor and Pastbin can be mined like the keyservers. &quot;Proven&quot;
is misleading as if automobiles do not kill thousands per year,
pollute the environment, overburden expensive infrastructure, enrich
the petroleum industry, fatten media advertising, foster urban and
ex-urban spread, although these shortcomings are applicable to
over-promoted, dangerous comsec. In small doses, among private
parties, PGP may be reliable so long as key servers are avoided. The
global keyservers are easy pickings for global spies -- come to think
of it, just like global armaments promise to protect citizens. Comsec
has become as duplicitous as national security. Promoters of both have
joined hands to frighten the public into submission with promises of
protection. Vario&#39;s infectious key signing spreads a disease of an
untrustworthy web of trust.

*****
Comment 2013-07-09 by Cryptome

Promiscuous signing of keys is vandalism, reflecting not trust but
deliberate damage. Check the keys of early proponents of PGP, few of
those knowledgeable cryptographers and comsec expert rarely if ever
sign keys any more. They know better, quietly discuss what is hidden
by NDAs, emit low signals of caution about popular comsec -- the most
popular and widely used, the highly recommended, the most trustworthy
-- are likely compromised due to their esteemed reputation. No greater
target for spies than such. Sure, there are die-hard fans, like Vario,
who are determined to perpetuate their blind faith rather than stay
alert, learning new methods of protection, creating new methods if not
too lazy and ignorant to do so, milking the hard work of others
instead. That is what fans are expected to do to prop up has-beens
against newcomesr, swarming in great multitudes for picking off the
weak, the mavericks, the outriders helping predators find targets by
signing their keys, logging their tweets, amassing their likes and
dislikes, harvesting their Tumblers, Reddits, Tor usage, OTR chats,
dissent-speaking tours, encrypted emails to ensnare unwary, posting
tattooed selfies of lulz, lol, etc.


*****
Comment 2013-07-09 by Michael Vario

So let me get this straight

1) Using key servers is bad because the data is mined

2) No one who knows anything
about security uses them, or even signs keys anymore.

3) Me signing keys of people I don&#39;t personally know is bad
because, um, my car analogy was bad?  You got me, points 1 and 2 would
seem to indicate that me signing a few keys shouldn&#39;t matter.

Of course if no one should use key servers, and no one who knows
anything uses keys servers, then what purpose remains? Mining data? In
that case, signing keys where no relationship exists doesn&#39;t have
an adverse affect, except to make data mined less accurate.

In that case everyone should start signing keys of folks they
don&#39;t have relationships with so the mined data becomes worthless,
since according to you key servers have no other value any more.

*****
Comment 2013-07-09 by nickg

To clarify, I&#39;m not suggesting &quot;throwing the baby out with
the bathwater&quot;, but I am saying using PGP for &quot;leaking&quot;
(data exfiltration, whistle blowing, theft, whatever you want to call
it), and to send this data to 3rd party you haven&#39;t had any
previous contact with is a use case PGP in it&#39;s current form
isn&#39;t well equipped to handle.  I thought this was the original
point cryptome.org was making with his original PGP posts to twitter.

Anyways, here&#39;s why I don&#39;t recommend PGP for &quot;leakers&quot;:

1. It&#39;s hard to encrypt.

PGP works best when the parties involved already have some degree of
trust and communication, and then exchange keys.  Getting started with
PGP into your workflow is challenging since there are the number of
bad clients, bad information on the web, and inaccessibility in
general web-mails and mobile phones apps. The recent article by
Freedom of the Press Foundation [1] is a good start. For enterprise
use, you&#39;ll probably need help in setting it up, and will require
training.

Once you have PGP working correctly for yourself, you then have to
find the correct public key for the receiver.  In an enterprise,
that&#39;s not a problem, but for the leaker, it&#39;s more
complicated. I just looked at a few major news sites.  I couldn&#39;t
find the PGP key for anyone.  So then you might go to public
keyservers, but that&#39;s giving away your IP address and search
query. The current state of public keyservers is ridiculous, but
that&#39;s another story.

2. Metadata matters

For &quot;leaking&quot;, that metadata matters.  It appears many
people aren&#39;t aware of the metadata or have incorrect
expectations. For Danny Clark, his keysigning and uploading to public
keyservers is probably going to be entered as evidence in the Manning
case (note I&#39;m not following this case carefully and could be
wrong here).  I&#39;m sure this wasn&#39;t Danny&#39;s
intention. Likewise, the &quot;Snowden&quot; keys (if real, and if not
a honeypot), show an interesting timeline, that I&#39;m sure is useful
for legal proceedings. Plus, some keyservers have recorded the IP
address of the key upload. This is certainly useful for someone trying
to track the source of the leak.

3. It&#39;s hard to decrypt

Assuming the message got to your receiver, then they have to be able
to read it. @ggreenwald couldn&#39;t figure it out for quite some time
(if at all). With @cryptomeorg &#39;s messages that started all this,
@birgittaj didn&#39;t understand what was going on, lost her password,
regenerated her key-pair, and then failed to re-upload the key.  I see
PGP problems regularly on twitter (wrong key is being used etc).  If
the receiver can&#39;t read your message, what&#39;s the point?

For enterprise use of PGP, these issues either don&#39;t matter or can
be controlled. It&#39;s possible that PGP could be made to work for
leaking, but someone else is going to have to write the HOWTO on it.
In the meantime, it remains problematic for &#39;leaking.&#39; Perhaps
due to these reasons, Wikileaks decided against using PGP for external
communication [2]

&quot;Do not use PGP to contact us. We have found that people use it in a dangerous manner. Further one of the Wikileaks key on several key servers is FAKE. &quot;

[1] https://pressfreedomfoundation.org/whitepapers/encryption-works-how-protect-your-privacy-age-nsa-surveillance#pgp
[2] http://wikileaks.org/wiki/WikiLeaks:PGP_Keys


*****
Comment 2013-07-09 by Michael Vario

  &quot;...Anyways, here&#39;s why I don&#39;t recommend PGP for &quot;leakers&quot;...&quot;<br /><br />So it sounds like you are saying that leakers should not encrypt, or do you know of a better encryption method than OpenPGP?

I have to disagree.  I do not think encryption is the answer all by
itself, yes metadata matters. A lot.  It really needs to be used via
an anonymizing agency such as TOR.  And as you infer, it has to be
used intelligently, which means spending some time to learn how to do
it.  And, yes, journalists have been wanting in making avenues for
leaking accessible.  They need to embrace these technologies because
telephone calls and postal mail don&#39;t cut it any more. They need
to post encryption keys on their sites. Also, set up onion sites for
anonymous communication.

Snowden seemed to have some idea of what he was doing and the
capabilities he was up against and he thought PGP was useful. I still
do not see the problem with PGP/GnuPG, the problem is that more people
need to use it.


*****
Comment 2013-07-10 by None

Probably a combination of TOR, (pre-encrypted with PGP if you&#39;re
really paranoid) and then both sender and receiver on Hushmail would
be the best. Since Hushmail states that they can be forced to hand
over e-mails (under British Columbia law), pre-encryting may not be a
bad thing. As for complexity, I&#39;m sorry. Just figure it out.
