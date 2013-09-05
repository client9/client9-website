---
layout: post
title: Google HTTPS Cipher Suite Preferences
---

It's been widely reported that [Google updated their SSL certificates to 2048 RSA.](http://googleonlinesecurity.blogspot.jp/2013/05/changes-to-our-ssl-certificates.html). Less reported is that they also changed their cipher suite preference.

According to my notes, in 2013-08, Google's cipher suite preference was the following:

```
ECDHE-RSA-AES128-GCM-SHA256
ECDHE-RSA-AES256-GCM-SHA384
ECDHE-RSA-AES128-SHA256
ECDHE-RSA-AES256-SHA384
ECDHE-RSA-RC4-SHA
ECDHE-RSA-AES128-SHA
ECDHE-RSA-AES256-SHA
ECDHE-RSA-DES-CBC3-SHA
AES128-GCM-SHA256
AES256-GCM-SHA384
AES128-SHA256
AES256-SHA256
RC4-SHA
AES128-SHA
AES256-SHA
DES-CBC3-SHA
RC4-MD5
```

This was my notes, but unfortunately they are not in the best form,
 and this could be wrong.  Does anyone else have notes or a snapshot
 from SSLLabs?  Reguardless this order is "reasonable" in that

* TLS 1.2 ciphers are priority
* ECDHE ("forward secrecy") ciphers prefered
* 128-AES is prefered to 256-AES
* Prevents Beast attack.

Here's the probable selection given your client's capability

| # | TLSv1.2  | ECDHE | Primary Cipher |
|---|----------|-------|----------------|
| 1 | yes      | yes   | `ECDHE-RSA-AES128-GCM-SHA256` |
| 2 | yes      | no    | `AES128-GCM-SHA256`           |
| 3 | no       | yes   | `ECDHE-RSA-RC4-SHA` or `ECDHE-RSA-AES128-SHA` |
| 4 | no       | no    | `RC4-SHA`, `AES*-SHA`, `DES-CBC3-SHA`, `RC4-MD5` |

The current order (as of 2013-09-06) is:

```
ECDHE-RSA-AES128-GCM-SHA256
ECDHE-RSA-RC4-SHA
ECDHE-RSA-AES128-SHA
AES128-GCM-SHA256
RC4-SHA
RC4-MD5
ECDHE-RSA-AES256-GCM-SHA384
ECDHE-RSA-AES256-SHA384
ECDHE-RSA-AES256-SHA
AES256-GCM-SHA384
AES256-SHA256
AES256-SHA
ECDHE-RSA-DES-CBC3-SHA
DES-CBC3-SHA
ECDHE-RSA-AES128-SHA256
AES128-SHA256
AES128-SHA
```

Before NSA consipracies start, let's say this order has more
consistent performance characteristics. All defaults remain the same,
and all odd cases, are moved to the bottom.  At Google-Scale that's
important.

| # | TLSv1.2 | ECDHE | Cipher |
|---|-----|-------|----------------|
| 1 | yes | yes   | `ECDHE-RSA-AES128-GCM-SHA256` |
| 2 | yes | no    | `AES128-GCM-SHA256`           |
| 3 | no  | yes   | `ECDHE-RSA-RC4-SHA` or `ECDHE-RSA-AES128-SHA` |
| 4 | no  | no    | `RC4-SHA`, `RC4-MD5`, `AES256-SHA`,`3DES`, `AES128-SHA` |

As mentioned, it's mostly the same in > 99% of the cases.

Other notes:

* Unless you are using a unknown-future client or a an extremely
  old client (think pre Windows-XP or Windows-XP in FIPS mode),
  everything below `RC4-SHA` will never get used.
* I assume `RC4-MD5` is there to support old "feature-phones" (those
  things before iPhone and Android).  There might be a few hundred
  million of those out there.  Comments welcome here.
* No support for `DHE-`, as it's wildly slower than `ECDHE-`.  EC crypto
  may or may not have patent issues and RedHat-based OS do not
  support it.  This means no forward-secrecy for Redhat.
* 256-bit AES support exists, but you'd have to deactivate all 128-bit
  AES and RC4 suites to use it.  Only API users with custom clients
  are likely to be able to do this.
* Yup, 3DES is still around.  It's needed for olders WindowsXP
  configurations.  I'm a bit suprised it's ranked higher than AES as
  it's 10x slower.  But if you get here, it's all a
  micro-optimization with little real-world impact.

In summary, the new configuration just simplifies what happens in 99% of the cases.

Again, if anyone has can confirm my notes on the older Google
configuration, or can confirm why `RC4-MD5` is still around, send me
an email.
