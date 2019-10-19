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

# Get all mu plugins and run install
for i in "${!wpi_plugins_mu_plugins__name[@]}"
do
    printf "${GRN}======================================================${NC}\n"
    printf "${GRN}Installing mu plugin ${wpi_plugins_mu_plugins__name[$i]} ${NC}\n"
    printf "${GRN}======================================================${NC}\n"
    # define var for mu plugin path
    mu_plugins_path=${PWD}
    # Check workflow type
    if [ "${wpi_init_workflow}" == "wp-cli" ]; then
      # mu plugins path
      mu_plugins_path=${PWD}/web/wp-content/mu-plugins
      # Check if mu-directory don't exist
      if [ ! -d "$mu_plugins_path" ]; then
        # mu plugins directory making
        mkdir $mu_plugins_path
      fi
    elif [[ $wpi_init_workflow == *"bedrock"* ]]; then
      # mu plugins path
      mu_plugins_path=${PWD}/web/app/mu-plugins
      # Check if mu-directory don't exist
      if [ ! -d "$mu_plugins_path" ]; then
        # mu plugins directory making
        mkdir $mu_plugins_path
      fi
    fi
    # get mu-plugin via php_url and renaming
    curl --silent ${wpi_plugins_mu_plugins__php_url[$i]} > $mu_plugins_path/${wpi_plugins_mu_plugins__name[$i]}.php
done
