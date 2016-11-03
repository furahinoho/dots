#!/usr/bin/sh
for f in $(ls -1 -Iinstall.sh -Iinit.sh .) ; do
  ln --symbolic --backup --no-dereference `pwd`/${f} $HOME/.${f}
done
