#!/usr/bin/env bash
set -eo pipefail
[ ! -z ${BASH_DEBUG} ] && set -x

steam_check_updates () {
  echo "Initiating Steam update check..."
  ~/Steam/steamcmd.sh \
    +@sSteamCmdForcePlatformType linux \
    +force_install_dir /data \
    +login anonymous \
    +app_update 2394010 \
    +quit
}

# check for updates if wanted, then launch game
[[ ${STEAM_UPDATE_CHECK} == "true" ]] && steam_check_updates
exec /data/PalServer.sh EpicApp=PalServer -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS
