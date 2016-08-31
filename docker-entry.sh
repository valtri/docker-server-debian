#! /bin/sh

if [ -d /docker/ssh ]; then
  cp -vp /docker/ssh/* /etc/ssh/
fi

if [ -f /docker/hosts ]; then
  cp -vp /docker/hosts /etc/
fi

if [ -f /docker/resolv.conf ]; then
  cp -vp /docker/resolv.conf /etc/
fi

if [ -f /docker/root/.ssh/authorized_keys ]; then
  mkdir -v /root/.ssh/ 2>/dev/null || :
  cp -vp /docker/root/.ssh/authorized_keys /root/.ssh/
fi

if [ -f /docker/root/.k5login ]; then
  cp -vp /docker/root/.k5login /root/
fi

exec "$@"
