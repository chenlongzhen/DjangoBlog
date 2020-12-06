#!/bin/bash

S_PATH=$(cd $(dirname $0);pwd)

NAME="DjangoBlog"
DJANGODIR=$S_PATH #Django project directory
USER=clz # the user to run as
GROUP=staff # the group to run as
NUM_WORKERS=1 # how many worker processes should Gunicorn spawn
DJANGO_SETTINGS_MODULE=DjangoBlog.settings # which settings file should Django use
DJANGO_WSGI_MODULE=DjangoBlog.wsgi # WSGI module name

echo "Starting $NAME as `whoami`"

# Activate the virtual environment
cd $DJANGODIR
#source /home/server/python/env/djangoblog/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

# Create the run directory if it doesn't exist
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)
#exec /home/server/python/env/djangoblog/bin/gunicorn  ${DJANGO_WSGI_MODULE}:application \
exec gunicorn  ${DJANGO_WSGI_MODULE}:application \
--name $NAME \
--workers $NUM_WORKERS \
--user=$USER --group=$GROUP \
--log-level=debug \
--log-file=-
