#!/bin/bash

# WPI MU-Plugins
# by DimaMinka (https://dima.mk)
# https://github.com/wpi-pw/app

# Get config files and put to array
wpi_confs=()
for ymls in wpi-config/*
do
  wpi_confs+=("$ymls")
done

# Get wpi-source for yml parsing, noroot, errors etc
source <(curl -s https://raw.githubusercontent.com/wpi-pw/template-workflow/master/wpi-source.sh)

#cur_env=$(cur_env)

# Create array of plugin list and loop
mapfile -t mu_plugins < <( wpi_yq 'plugins.must_use.[*].name' )
# Get all mu plugins and run install
for i in "${!mu_plugins[@]}"
do
    printf "${GRN}==========================================================${NC}\n"
    printf "${GRN}Installing mu plugin $(wpi_yq plugins.must_use.[$i].name) ${NC}\n"
    printf "${GRN}==========================================================${NC}\n"
    # define var for mu plugin path
    mu_plugins_path=${PWD}
    # Check workflow type
    if [ "$(wpi_yq init.workflow)" == "wp-cli" ]; then
      # mu plugins path
      mu_plugins_path=${PWD}/web/wp-content/mu-plugins
      # Check if mu-directory don't exist
      if [ ! -d "$mu_plugins_path" ]; then
        # mu plugins directory making
        mkdir $mu_plugins_path
      fi
    elif [ "$(wpi_yq init.workflow)" == "bedrock" ]; then
      # mu plugins path
      mu_plugins_path=${PWD}/web/app/mu-plugins
      # Check if mu-directory don't exist
      if [ ! -d "$mu_plugins_path" ]; then
        # mu plugins directory making
        mkdir $mu_plugins_path
      fi
    fi
    # get mu-plugin via php_url and renaming
    curl --silent $(wpi_yq plugins.must_use.[$i].php_url) > $mu_plugins_path/$(wpi_yq plugins.must_use.[$i].name).php
done
