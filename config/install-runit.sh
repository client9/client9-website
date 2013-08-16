#!/bin/bash

mkdir -p /package
chmod 1755 /package
cd /package
wget http://smarden.org/runit/runit-2.1.1.tar.gz
gunzip runit-2.1.1.tar
tar -xpf runit-2.1.1.tar
rm runit-2.1.1.tar
cd admin/runit-2.1.1

if [ "`uname`" = "Darwin" ]; then
  echo 'cc -Xlinker -x' > src/conf-ld
  cp src/Makefile src/Makefile.old
  sed -e 's/ -static//' <src/Makefile.old >src/Makefile
fi

package/install
package/install-man
