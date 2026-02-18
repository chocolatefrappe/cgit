#!/bin/bash
set -x

chown -R git:git /var/lib/git || true
chmod -R 755 /srv/git || true
