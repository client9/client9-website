---
layout: post
updated: 2008-11-24
alias: /2008/11/minimal-http-file-server-in-python.html
title: Minimal HTTP File Server in Python
---
<p>
At the bottom is a deminimus HTTP file server in Python.  Why?  perhaps you are on a virtual or remote machine  want to look a file in your native web browser, or do a quick file transfer without setting up 1,000 ssh tunnels,  and you don't want to install Apache.
</p>
<ul>
<li>Requests are limited to within the 'root' directory for security.</li>
<li>Mime types correctly handled</li>
<li>Directory listings</li>
<lI>No daemonization, once you log out, it's gone.</li>
</ul>

<pre>
#!/usr/bin/env python
# http://blog.modp.com/2008/11/minimal-http-file-server-in-python.html
# v1.0 23-Nov-2008 Nick Galbreath
# PUBLIC DOMAIN, but it would be nice if you gave me credit ;-)                      
import os, os.path, mimetypes, wsgiref.simple_server

port = 8003  # anything
root = os.path.expanduser('/home/YOU/YOURDIR')

def makelink(dir, file):
    link = (os.path.join(dir,file))[len(root):]
    return '&lt;a href="%s"&gt;%s&lt;/a&gt;&lt;br&gt;\n' % (link, file)
def run(environ, start_response):
    cmd = environ['PATH_INFO']
    filename = os.path.abspath(os.path.join(root,cmd[cmd.find('/')+1:]))
    data = ''
    mtype = 'text/plain'
    if not filename.startswith(root):
        status = '403 Forbidden'
        data = 'Request outside of root directory\n'
    else:
        status = '200 OK'
        try:
            if os.path.isdir(filename):
                mtype = 'text/html'
                files = sorted(os.listdir(filename))
                links = [makelink(filename,f) for f in files]
                data = '&lt;html&gt;&lt;head&gt;&lt;title&gt;' + filename + \
                    '&lt;/title&gt;&lt;/head&gt;&lt;body&gt;\n' + makelink(filename, '..')+ \
                    ''.join(links) + '&lt;/body&gt;&lt;/html&gt;\n'
            else:
                f = open(filename); data = f.read(); f.close()
                m = mimetypes.guess_type(filename)
                if m[0] is not None: mtype = m[0]
        except IOError,e:
            data = str(e) + '\n'
            status = "404 Not Found"
    start_response(status, [('Content-Type', mtype)])
    return [ data ]
if __name__ == '__main__':
    httpd = wsgiref.simple_server.make_server('', port, run)
    sa = httpd.socket.getsockname()
    httpd.serve_forever()
</pre>

*****
Comment 2009-10-26 by None

Well, this one-liner has served me well for this purpose:<br /><br />python -mSimpleHTTPServer
