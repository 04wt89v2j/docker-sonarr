[ -z "$SSH_CLIENT" ] && source <(curl --fail --retry 3 -sSL "$HEROKU_EXEC_URL") & mono --debug /usr/lib/sonarr/bin/Sonarr.exe -nobrowser -data=/config & sleep 10s && ls /config
