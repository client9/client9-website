<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>{{ page.title }}</title>
<link rel="icon" href="/favicon.ico" />
<link rel="alternate" type="application/atom+xml" title="RSS Feed for client9.com"  href="/atom.xml" />
<meta property="og:site_name" content="client9" />
<meta property="og:type" content="article" />
<meta property="og:url" content="http://www.client9.com{{ page.id }}/" />
<meta property="og:title" content="{{ page.title }}" />
<meta property="og:description" content="{{ page.summary }}" />
{% if page.og-image %}<meta property="og:image" content="http://www.client9.com{{ page.og-image }}" />{% endif %}
<meta name="twitter:card" content="summary">
<meta name="twitter:creator" content="@ngalbreath" />
<style>
body { color: #000;  font-family: proxima-nova, proxima-nova-1, proxima-nova-2, HelveticaNeue, 'Helvetica Neue', Helvetica, Arial, sans-serif; }

body { color: #000; font-family: georgia, "times new roman", times, serif; }


a {text-decoration: none; color: black }
a:active { text-decoration: underline }
a:hover { text-decoration: underline }

h1 { margin-top: 0px; margin-bottom: 0px; }
blockquote { font-size: small; }

.date {
 margin-top: 0px;
 margin-bottom: 0px;
 font-size:small;
 color:grey;
 font-family: arial
}
#page { width: 900px; margin-left:auto; margin-right:auto; padding-left:5pm; padding-right: 5px; }
#left { float: left; width: 590px; padding-right: 5px; }
#right { float: left;width: 290px; padding-left: 5px;}
#footer { clear: both; }
#footer ul { margin: 0; text-align:center;}
#footer ul li {display: inline }
#disqus_thread { margin:10px; padding: 10px}


#header { margin: 0px; }
#header h1 { float:left; font-size: 300%; margin: 0px }
#header ul { float: left; margin: 0; padding: 0px}
#header ul li { display: inline; float: left;
  margin-left: 0px; margin-right: 5px; padding: 0px}

#post a { text-transform: underline; color: #004276; }

.readmore {text-transform: uppercase; font-size: x-small; font-family: arial; color: #004276; }

#post-pagination { font-family: arial; text-transform: uppercase; margin-bottom: 30px; font-size:small}

.previous { display: inline; float:left; margin-top: 0px; margin-left: 20px }
.next  { display: inline; float:right; margin-top: 0px; margin-right: 20px; }
.disabled   { color: #AAA; }
.pagination { margin-bottom: 20px; }

#mc_embed_signup{background:#fff; clear:left; font:14px Helvetica,Arial,sans-serif; }
</style>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-33553605-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
</head>
<body>
<div id="page">

