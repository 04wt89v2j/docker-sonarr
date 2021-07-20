#!/usr/bin/with-contenv bash

cd /app/sonarr/bin || exit

exec \
    mono --debug Sonarr.exe \
    -nobrowser -data=/config
