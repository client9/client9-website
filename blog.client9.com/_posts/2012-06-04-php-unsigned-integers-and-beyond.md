---
layout: post
updated: 2012-06-04
alias: /2012/06/php-unsigned-integers-and-beyond.html
title: php unsigned integers and beyond
---
When you have to work with binary data and unsigned integers in PHP, the following routines my be useful.  <code>bytes2bcmath</code> takes a binary string and turns into a <code>bcmath</code> compatible decimal string.<br />
<br />
<pre>// (1&gt;&gt;64)-1 or 0xFFFFFFFFFFFFFFFF
$val = '18446744073709551615';
$bytes = bcmath2bytes($val);  // returns 8 byte string
$dec = bytes2bcmath($bytes);  // and back again
</pre><br />
<pre>    function bytes2bcmath($bytes) &#123;
        $val = '0';
        for ($i = 0; $i &lt; strlen($bytes); $i++) &#123;
            $val = bcadd(bcmul($val, 256), ord($bytes[$i]));
        &#125;
        return $val;
    &#125;

    function bcmath2bytes($dec) &#123;
        $str = '';
        do &#123;
            $byte = bcmod($dec, 256);
            $str .= chr($byte);
            $dec = bcdiv($dec, 256, 0);
        &#125; while ($dec != '0');

        return strrev($str);
    &#125;
</pre>