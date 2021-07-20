sed -i "s/8989/$PORT/1" /config/config.xml & mono --debug /usr/lib/sonarr/bin/Sonarr.exe -nobrowser -data=/config & sleep 10s && cat /config/config.xml && echo "$PORT"
