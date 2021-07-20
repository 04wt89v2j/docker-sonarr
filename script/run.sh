mono --debug /usr/lib/sonarr/bin/Sonarr.exe -nobrowser -data=/config & sleep 10s && cat /config/config.xml && echo "$PORT"
