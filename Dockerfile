
FROM ubuntu:20.04
LABEL "Maintainer"="Scott Hansen <firecat4153@gmail.com>"

ARG uid=1000
ARG gid=100
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -qy ca-certificates gnupg software-properties-common wget curl && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2009837CBFFD68F45BC180471F4F90DE2A9B4BF8 && \
    echo "deb https://apt.sonarr.tv/ubuntu focal main" | tee /etc/apt/sources.list.d/sonarr.list && \
	wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-16_all.deb && \
	dpkg -i repo-mediaarea_1.0-16_all.deb && \
	rm repo-mediaarea_1.0-16_all.deb && \
    apt-get update && \
    apt-get install -qy sonarr && \
    sed -i "s/sonarr:x:[0-9]\+:/sonarr:x:$uid:/" /etc/passwd && \
    # Change `users` gid to match the passed in $gid
    [ $(getent group users | cut -d: -f3) == $gid ] || \
            sed -i "s/users:x:[0-9]\+:/users:x:$gid:/" /etc/group && \
    mkdir /config && \
    chown -R sonarr:users /config && \
    apt-get autoremove -qy gnupg software-properties-common wget && \
    rm -rf /var/lib/apt/lists

EXPOSE 8989
USER sonarr
VOLUME ["/config", "/data"]

COPY script/ /
COPY config/ /config/
CMD ["bash", "run.sh"]
