#!/bin/sh
# entrypoint for container

# prepare sqllite for session store (Alternative: use application database)
touch /tmp/sqlitedatabase.sq3
chown 33:33 /tmp/sqlitedatabase.sq3

/usr/sbin/apache2ctl -D FOREGROUND