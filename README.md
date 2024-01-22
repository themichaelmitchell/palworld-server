# Overview
This project is meant to quickly get a Palworld server up and running. Caution: The game is buggy and I provide even less support than PocketPair

# Requirements
- [Docker](https://docs.docker.com/engine/install/)

# Usage
- Clone repo:
  `git clone https://github.com/themichaelmitchell/palworld-docker`
- Build image (~5 mins in my tests):
  `cd palworld-docker && ./build.sh`
- Launch server:
  `docker compose up -d`

## Auto updates
If an update to Palworld server is released, simply restart the container to have steam update the app. You can disable auto updates by setting `STEAM_UPDATE_CHECK` to `false` in [the docker-compose.yml file](docker-compose.yml)

## Editing server config
Launch the server once to generate configs, then make adjustments to `./Saved/Config/LinuxServer/PalWorldSettings.ini`. To apply config changes, restart the container via `docker restart palwatch-server`
