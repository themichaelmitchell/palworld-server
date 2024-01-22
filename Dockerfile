# download palworld server from steam
FROM steamcmd/steamcmd AS game-download
RUN /usr/bin/steamcmd \
    +@sSteamCmdForcePlatformType linux \
    +force_install_dir /data \
    +login anonymous \
    +app_update 2394010 \
    +quit

# final image
FROM ubuntu
RUN apt-get update \
    && apt-get install -y \
      lib32gcc-s1 \
      curl \
      xdg-user-dirs \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd --create-home --shell /bin/bash palworld

COPY --from=game-download --chown=palworld /data /data
USER palworld

# setup steam for update checks
RUN mkdir ~/Steam && cd ~/Steam \
    && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - \
    && ./steamcmd.sh +login anonymous +quit \
    && mkdir -p /home/palworld/.steam/sdk64/ \
    && ln -s /data/linux64/steamclient.so /home/palworld/.steam/sdk64/steamclient.so \
    && mkdir /data/Pal/Saved

WORKDIR /data/
EXPOSE 8211/udp

VOLUME ["/data/Pal/Saved"]
# ENTRYPOINT ["/data/PalServer.sh"]
# CMD ["EpicApp=PalServer", "-useperfthreads", "-NoAsyncLoadingThread", "-UseMultithreadForDS"]

COPY --chmod=655 entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
