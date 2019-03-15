#!/bin/bash
prog=foreman
RETVAL=0
FOREMAN_PORT=${FOREMAN_PORT:-3000}
FOREMAN_USER=${FOREMAN_USER:-foreman}
FOREMAN_HOME=${FOREMAN_HOME:-/usr/share/foreman}
export HOME=$FOREMAN_HOME
FOREMAN_ENV=${FOREMAN_ENV:-production}
DB_PORT=${DB_PORT:-5432}

if [[ -f /usr/share/foreman/tmp/pids/server.pid ]]; then
  rm /usr/share/foreman/tmp/pids/server.pid;
fi

if [[ ! -z "${DB_HOSTNAME}" ]]; then
  echo "test database connection ${DB_HOSTNAME}:${DB_PORT}"
  while ! nc -z ${DB_HOSTNAME} ${DB_PORT};
  do
    echo "wait for database";
    sleep 1;
  done;
  echo "connected";
fi
echo -n $"Starting $prog: "
cd ${FOREMAN_HOME}
/usr/bin/tfm-ruby ${FOREMAN_HOME}/bin/rails s -p ${FOREMAN_PORT} -e ${FOREMAN_ENV} -b 0.0.0.0
