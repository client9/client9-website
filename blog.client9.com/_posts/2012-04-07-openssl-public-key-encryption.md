---
layout: post
updated: 2012-04-07
alias: /2012/04/openssl-public-key-encryption.html
title: openssl public key encryption
---
<br />
If one wants to encrypt aribtrary data or a file using public key encryption algorithms, one can use <a href="http://www.openssl.org/" target="_blank">OpenSSL</a> and <a href="http://en.wikipedia.org/wiki/S/MIME" target="_blank">S/MIME</a>.<br />
<br />
<span class="Apple-style-span">For algorithms and key sizes, the</span><span class="Apple-style-span" style="color: #444444; font-family: Arial, Tahoma, Helvetica, FreeSans, sans-serif; font-size: 13px; line-height: 18px;">&nbsp;</span><span class="Apple-style-span" style="color: #444444; font-family: Arial, Tahoma, Helvetica, FreeSans, sans-serif; font-size: 13px; line-height: 18px;"><a href="http://csrc.nist.gov/" style="color: #3778cd; text-decoration: none;" target="_blank">NIST Computer Security Division</a></span><span class="Apple-style-span">&nbsp;says 2048-key for RSA and 128-bit key for AES is just fine until 2030 (</span><span class="Apple-style-span" style="color: #444444; font-family: Arial, Tahoma, Helvetica, FreeSans, sans-serif; font-size: 13px; line-height: 18px;"><a href="http://csrc.nist.gov/publications/nistpubs/800-57/sp800-57-Part1-revised2_Mar08-2007.pdf" style="color: #3778cd; text-decoration: none;" target="_blank">Special Publication 800-57</a>,</span><span class="Apple-style-span" style="color: #444444; font-family: Arial, Tahoma, Helvetica, FreeSans, sans-serif; font-size: 13px; line-height: 18px;">&nbsp;page 66).</span><br />
<br />
The examples below all use <span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">stdin</span> and <span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">stdout</span>. &nbsp;You can use files by using "<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">-in <i>INFILE</i> -out <i>OUTFILE</i></span>" on the command line.<br />
<br />
<br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># create 2048 bit key</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">openssl req -x509 -nodes -newkey rsa:2048 \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp; -keyout PRIVATE1.pem \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp; -out PUBLIC1.pem \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp; -subj '/'</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><br /></span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># encrypt, note that it is different each time</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">echo "client9.com" | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;openssl smime -encrypt -aes128 -binary -outform DEM PUBLIC1.pem | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;base64</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">echo "client9.com" | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;openssl smime -encrypt -aes128 -binary -outform DEM PUBLIC1.pem | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;base64</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><br /></span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># and decrypt</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">echo "client9.com" | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; openssl smime -encrypt -aes128 -binary -outform DEM PUBLIC.pem | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; openssl smime -decrypt -binary -inform DEM -inkey PRIVATE.pem&nbsp;</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><br /></span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># let's create another key</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">openssl req -x509 -nodes &nbsp;-newkey rsa:2048 \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp; -keyout PRIVATE2.pem \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp; -out PUBLIC2.pem \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp; -subj '/'</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><br /></span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">#&nbsp;</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># we can now encrypt with *both public keys*,&nbsp;</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># and then use *either private key* to decrypt</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># (can use as many keys as you want)</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">#</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">echo "client9.com" | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;openssl smime -encrypt -aes128 -binary -outform </span><span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">DEM \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;PUBLIC1.pem PUBLIC2.pem | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;base64</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><br /></span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># let's use key #1 to decrypt</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">echo "client9.com" | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;openssl smime -encrypt -aes128 -binary -outform DEM \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;PublicCert1.pem PublicCert2.pem | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;openssl smime -decrypt -binary -inform DEM &nbsp;-inkey PRIVATE1.pem</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><br /></span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># let's use key #2 to decrypt</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">echo "client9.com" | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;openssl smime -encrypt -aes128 -binary -outform DEM \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;PublicCert1.pem PublicCert2.pem | \</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;openssl smime -decrypt -binary -inform DEM &nbsp;-inkey PRIVATE2.pem&nbsp;</span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><br /></span><br />
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># snazzy!</span><br />
<h2>
<span class="Apple-style-span" style="font-family: inherit; font-size: small;">Using Raw RSA</span></h2>
<div>
<span class="Apple-style-span" style="font-family: inherit; font-size: small;">I wrote this article since the first few Google results for "openssl public key encryption" all used raw RSA. &nbsp;Eeek. &nbsp;If your data is <i>always</i> smaller than the key size (minus some overhead), you <i>could</i>&nbsp;use raw RSA but must make sure you use OAEP padding schemes (the older PKCS padding is <i>probably</i>&nbsp;ok, but maybe not given you have a "small input" probably with a known structure). &nbsp;Do not try and create some RSA-CBC hybrid beast. &nbsp;Use S/MIME instead.</span></div>
<div>
<span class="Apple-style-span" style="font-family: inherit; font-size: small;"><br /></span></div>
<div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># generate keypair</span></div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">openssl genrsa -out private.pem 2048</span></div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><br /></span></div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># extract public key</span></div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">openssl rsa -in private.pem -out public.pem -outform PEM -pubout</span></div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><br /></span></div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># decrypt</span></div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">echo "client9.com" | \</span></div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;openssl rsautl -encrypt -oaep -inkey public.pem -pubin | \</span></div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;">&nbsp; &nbsp;openssl rsautl -decrypt -inkey private.pem</span></div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"><br /></span></div>
<div>
<span class="Apple-style-span" style="font-family: 'Courier New', Courier, monospace;"># please check the maximum input size first!</span></div>
</div>
<br />