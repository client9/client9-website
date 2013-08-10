---
layout: page
title: Better Random Numbers in PHP with /dev/urandom
summary: "Prevent and fix problems with PHP's random number generations by using /dev/urandom."
alias: "20120719"
---

Originally posted on Etsy's Code as Craft blog: [Better Random Numbers
in PHP using /dev/urandom](http://codeascraft.etsy.com/2012/07/19/better-random-numbers-in-php-using-devurandom/). Slight edited and reposted here as an learning excercise in using markdown.

* * * *

The design of PHP’s basic random number generators [`rand`](http://php.net/manual/en/function.rand.php) and it’s newer
variant [`mt_rand`](http://php.net/manual/en/function.mt-rand.php) is based off the [C Standard Library](http://www.gnu.org/software/libc/manual/html_node/ISO-Random.html). For better or
worse, both use a single global state and this can be reset using
[`srand`](http://php.net/manual/en/function.srand.php) (or [`mt_srand`](http://php.net/manual/en/function.mt-srand.php)). This means anyone (a developer, a third party
module, a library) could set the state to a fixed value and every
random number following will be the same for every request. Sometimes
this is the desired behavior but this can also have disastrous
consequences. For instance, everyone’s password reset code could end
up being the same.

Recently, Argyros and Kiayias in [_I Forgot Your Password: Randomness
Attacks Against PHP
Applications_](http://crypto.di.uoa.gr/CRYPTO.SEC/Randomness_Attacks_files/paper.pdf)
suggests there might be more fundamental problems in how PHP
constructs the state of the random number generator. Just by seeing
the output of a few calls to rand or mt_rand, one can predict the next
output. With this, and certain password reset implementations, an
attacker could perform account takeover. (This version of this paper
is also going to be presented on [July 25 at Black Hat
USA](https://www.blackhat.com/html/bh-us-12/bh-us-12-briefings.html#Argyros)).

Quite some time ago, Etsy switched over to a different way of
generating random numbers by using [`/dev/urandom`](http://en.wikipedia.org/wiki//dev/urandom) that prevents both
issues. `/dev/urandom` is a special psuedo-file on unix-like operating
systems that generates “mostly random” bytes and is
non-blocking. [`/dev/random`](http://en.wikipedia.org/wiki//dev/random) (with no “u“) is for truly cryptographic
applications such as key generation and is blocking. Once you exhaust
it’s supply of randomness it blocks until it distills new randomness
from the environment. Therefore, you don’t want to use `/dev/random` in
your web application. To see why, connect to a (non-production!)
remote machine and type in:

    cat /dev/random > /dev/null

and the in another window try to log in. You won’t be able to, since SSH can’t
read from `/dev/random` and therefore can’t complete the connection.

A pedagogical replacement of `rand`, `mt_rand` with `/dev/urandom` using the
[`mcrypt` module](http://php.net/manual/en/function.mcrypt-create-iv.php) might be:

    // equiv to rand, mt_rand
    // returns int in *closed* interval [$min, $max]
    function devurandom_rand($min = 0, $max = 0x7FFFFFFF) {
      $diff = $max - $min;
      if ($diff < 0 || $diff > 0x7FFFFFFF) {
        throw new RuntimeException("Bad range");
      }
      $bytes = mcrypt_create_iv(4, MCRYPT_DEV_URANDOM);
      if ($bytes === false || strlen($bytes) != 4) {
        throw new RuntimeException("Unable to get 4 bytes");
      }
      $ary = unpack("Nint", $bytes);
      $val = $ary['int'] & 0x7FFFFFFF;   // 32-bit safe
      $fp = (float) $val / 2147483647.0; // convert to [0,1]
      return round($fp * $diff) + $min;
    }


A long time ago, Etsy didn’t even have `mcrypt` installed and so we read
directly from `/dev/urandom` using
[fopen](http://php.net/manual/en/function.fopen.php) and
[fread](http://php.net/manual/en/function.fread.php) (see also
[stream_set_read_buffer](http://php.net/manual/en/function.stream-set-read-buffer.php)).

Note that the above code converting bytes to an integer will
demonstrate a slight bias with very large ranges, so we can’t use for
it with Etsy’s monte-carlo long-range simulation forecasting hand-made
supercomputer but for all the other (non-cryptographic) web
applications likely to be. For other algorithms and details on this
topic, the main reference is Knuth’s Art of Computer Programming:
Seminumerical Algorithms. A more modern treatment can be found in any
of the Numerical Recipes books. The Java source code for
java.util.Random is also a good reference. Enjoy!