#!/usr/bin/with-contenv bash

if [ -n "${UMASK_SET}" ] && [ -z "${UMASK}" ]; then
    echo -e "You are using a legacy method of defining umask\nplease update your environment variable from UMASK_SET to UMASK\nto keep the functionality after July 2021"
    umask ${UMASK_SET}
fi

cd /app/sonarr/bin || exit

exec \
    s6-setuidgid abc mono --debug Sonarr.exe \
    -nobrowser -data=/config
