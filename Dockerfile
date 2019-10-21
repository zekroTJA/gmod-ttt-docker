FROM debian:stretch-slim

RUN set -x &&\ 
    apt-get update &&\
    apt-get install -y --no-install-recommends --no-install-suggests \
        lib32stdc++6 \
        lib32gcc1 \
	wget \
        ca-certificates
    
WORKDIR /etc/steamcmd
RUN wget -qO- 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz' | tar zxf - &&\
    chmod +x ./steamcmd.sh

WORKDIR /var/steam

RUN /etc/steamcmd/steamcmd.sh +login anonymous +force_install_dir gmod +app_update 4020 validate +quit
RUN /etc/steamcmd/steamcmd.sh +login anonymous +force_install_dir content/tf2 +app_update 232250 validate +quit
RUN /etc/steamcmd/steamcmd.sh +login anonymous +force_install_dir content/css +app_update 232330 validate +quit

ENV COLLECTION="1295264802"
ENV GAMEMODE="terrortown"
ENV MAP="ttt_waterworld"
ENV MAX_PLAYERS="16"

CMD /var/steam/gmod/srcds_run -console \
	+host_workshop_collection ${COLLECTION} \
	+gamemode${GAMEMODE} \
	+map ${MAP} \
	+maxplayers ${MAX_PLAYERS}
