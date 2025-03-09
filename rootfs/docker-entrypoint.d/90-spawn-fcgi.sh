#!/bin/bash
rm -f /var/run/fcgiwrap.socket
fcgiwrap -s unix:/var/run/fcgiwrap.socket &
while ! [ -S /var/run/fcgiwrap.socket ]; do sleep .2; done
chown nginx:nginx /var/run/fcgiwrap.socket
