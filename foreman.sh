#!/bin/bash
prog=foreman
RETVAL=0
FOREMAN_PORT=${FOREMAN_PORT:-3000}
FOREMAN_USER=${FOREMAN_USER:-foreman}
FOREMAN_HOME=${FOREMAN_HOME:-/usr/share/foreman}
export HOME=$FOREMAN_HOME
FOREMAN_ENV=${FOREMAN_ENV:-production}


while ! nc -z db 5432;
do
  echo "wait for db";
  sleep 1;
done;
echo "connected";
echo -n $"Starting $prog: "
cd ${FOREMAN_HOME}
/usr/bin/tfm-ruby ${FOREMAN_HOME}/bin/rails s -p ${FOREMAN_PORT} -e ${FOREMAN_ENV} -b 0.0.0.0
