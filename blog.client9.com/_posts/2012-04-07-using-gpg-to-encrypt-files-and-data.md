---
layout: post
updated: 2012-04-20
alias: /2012/04/using-gpg-to-encrypt-files-and-data.html
title: Using GPG to Encrypt Files and Data
---
<br />
<a href="http://www.gnupg.org/">GPG</a> is mostly used for securing email. However it can be used to encrypt arbitrary files and data using public-key encryption algorithms.  (It can also encrypt files using symmetric ciphers and passwords, but that is not discussed here.)<br />
<br />
GPG 1.X series is designed more for servers. GPG 2.X series is designed more for desktops and provides <a href="http://en.wikipedia.org/wiki/S/MIME">S/MIME</a> support. They are just different and 2.X is not better than 1.X.  This example uses gpg 1.4.<br />
<br />
<h2>Make the Directory</h2><div>For this example we don't want to mess up your real keys, so we'll make an alternate directory and use it for everything.</div><pre>mkdir ./test
chmod 0700 ./test
</pre><br />
<h2>Generate Keys</h2><div>Since gpg is hyper-paranoid this might be 10 <i>minutes</i>.<br />
</div><pre>gpg --homedir ./test --gen-key
</pre><div>You'll then answer a lot of questions:</div><br />
<ul><li>Algorithm: &nbsp;RSA and RSA</li>
<li>Keysize: for RSA, &nbsp;2048 bits is fine. &nbsp;The NIST says this is good until 2030.</li>
<li>Expiration: Does not expire. &nbsp;I haven't played around with expired keys to see how they work.</li>
<li>Real Name: &nbsp;use something descriptive or your name depending on how you are going to use this "Encryptor Robot" (ok bad example)</li>
<li>Email Address: &nbsp;put something that looks sorta an email &nbsp;"robot@encryptor.town"</li>
<li>Comment: &nbsp;go nuts!</li>
</ul><br />
Finally, it's your choice on if you need a password or not. If this is for bulk encryption, you probably don't want a password.<br />
<br />
Then wait......... &nbsp;If you are using a VM, perhaps login with a different window and/or copy some files in or out of it.<br />
<br />
At the end of this you should be able to list and export the keys<br />
<br />
<pre>$ gpg --home ./test --list-keys
./test/pubring.gpg
------------------
pub   2048R/02A9B20A 2012-04-07
uid                  Encryptor Robot &lt;robot@encryptor.town&gt;
sub   2048R/14C5AD94 2012-04-07
</pre><br />
<h2>Figuring out your parameters</h2><div>GPG has a complicated system of determining the compressions algorithm and level, the preferred symmetric cipher and the preferred hash function. It's designed for email systems where the sender and receiver might have different capabilities and preferences. It could come from the operating system, a personal configuration file, preferences in the key, or from the command line.    For automated systems this can get in the way, and in fact make it difficult to determine what is being used when.  Typing in:</div><br />
<pre>gpg --verbose --version</pre><div>should show something like the following:<br />
</div><pre>Supported algorithms:
Pubkey: RSA, RSA-E, RSA-S, ELG-E, DSA
Cipher: 3DES (S2), CAST5 (S3), BLOWFISH (S4),
        <b>AES (S7)</b>, AES192 (S8), 
        AES256 (S9), TWOFISH (S10),
        CAMELLIA128 (S11), CAMELLIA192 (S12), 
        CAMELLIA256 (S13)
Hash: MD5 (H1), SHA1 (H2), RIPEMD160 (H3), <b>SHA256 (H8)</b>, SHA384 (H9), 
      SHA512 (H10), SHA224 (H11)
Compression: Uncompressed (Z0), ZIP (Z1), ZLIB (Z2), BZIP2 (Z3)
</pre><br />
<p>You can decide what's best for in terms of compression, but as of April 2012, <b>the recommended setup is to use <code>AES</code> and <code>SHA256</code></b>.  There may be specific requirements for your industry that might over-rule this for everything else this is just fine.</p><br />
<p>Now we have two ways to set the preferred algorithms.  The easiest and clearest is doing this explicitly on the command line.   That is shown in the examples below using <code> --cipher-algo AES --digest-algo SHA256</code>.  The other way is by modifying the key's preferences.  Type in <code>gpg --homedir ./test --list-secret-keys</code>.  You get something like this:</p><br />
<pre>./test/secring.gpg
------------------
sec   2048R/<b>02A9B20A</b> 2012-04-07
uid                  Encryptor Robot <robot@encryptor.town>
ssb   2048R/14C5AD94 2012-04-07
</pre><br />
Using that ID in bold, type in <code>gpg --homedir ./test --edit-key 02A9B20A</code>.  Now you'll get an interactive prompt. <br />
<pre># see verbose defaults
showpref

# set short defaults
pref

# set to AES/SHA256/NoCompress
# change NoCompress to whatever you like (Z1,Z2,Z3)
setpref S7 H8 Z0

# see your work
# notice how 3DES and SHA1 and just hardwired in
showpref

# byebye
quit
</pre><br />
<h2>Encrypt and Decrypt</h2><div>The examples below use <code>stdin</code> and <code>stdout</code>.  You can specify an output file using <code>--output</code>.  For input files, just add the filename as the last command line argument.<br />
</div><br />
<pre># encrypt
# --homedir ./test == what key database to use
# -q --no-tty --batch --yes == make gpg be a silent as possible
# -encrypt --armor == encrypt and make nice ascii format
# --trust-model always means to disable the "web of trust" stuff which
#    may or may not make sense in an automated environment
# --recipient == what key to use.
echo "client9.com" | gpg -q --no-tty --batch --yes \
 --homedir ./test \
 --encrypt --armor \
 --trust-model always  \
 --cipher-algo AES \
 --digest-algo SHA256 \
 --compress-algo uncompressed \
 --recipient robot@encryptor.town &gt; /tmp/file.gpg

# decrypt
# This is simpler.  It figures everything out from the message 
# and key database
gpg --homedir ./test -q --no-tty --batch --yes --decrypt &lt; /tmp/file.gpg
</pre><br />
<h2>Export and Import</h2><div>To export and import. I'm not sure what the standard suffix is for keys. I've seen ".gpg" and ".key" used. (Comments welcome.)</div><br />
<pre># export public
gpg --home ./test&nbsp;--armor --export&nbsp;robot@encryptor.town \
    &gt; /tmp/robot-public.gpg
# export private
gpg --home ./test --armor --export-secret-key --armor \
    &gt; /tmp/robot-private.gpg

# in new directory with gpg databases:
gpg --import public-or-private-key.gpg
</pre>