<div id="recent">
<h4>Recent Posts</h4>
<ul style="list-style: none; margin-left: 0; font-size: small; padding-left: 1em;   text-indent: -1em;">
{% for post in site.posts limit:10 %}
<li><a href="{{ post.url }}">{{ post.title }}</a></li>
{% endfor %}
</ul>
</div><!-- end recent -->
