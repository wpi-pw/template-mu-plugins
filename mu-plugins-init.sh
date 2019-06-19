#!/bin/bash

# MU Plugins Init - Wp Pro Club
# by DimaMinka (https://dimaminka.com)
# https://github.com/wp-pro-club/init

source ${PWD}/lib/app-init.sh

# Get all mu plugins and run install
for i in "${!conf_app_mu_plugins__name[@]}"
do
    printf "${GRN}======================================================${NC}\n"
    printf "${GRN}Installing mu plugin ${conf_app_mu_plugins__name[$i]} ${NC}\n"
    printf "${GRN}======================================================${NC}\n"
    # define var for mu plugin path
    mu_plugins_path=${PWD}
    # Check workflow type
    if [ "${conf_app_setup_workflow}" == "wp-cli" ]; then
      # mu plugins path
      mu_plugins_path=${PWD}/web/wp-content/mu-plugins
      # Check if mu-directory don't exist
      if [ ! -d "$mu_plugins_path" ]; then
        # mu plugins directory making
        mkdir $mu_plugins_path
      fi
    elif [[ $conf_app_setup_workflow == *"bedrock"* ]]; then
      # mu plugins path
      mu_plugins_path=${PWD}/web/app/mu-plugins
      # Check if mu-directory don't exist
      if [ ! -d "$mu_plugins_path" ]; then
        # mu plugins directory making
        mkdir $mu_plugins_path
      fi
    fi
    # get mu-plugin via zip and renaming
    wget -c ${conf_app_mu_plugins__zip[$i]} -O $mu_plugins_path/${conf_app_mu_plugins__name[$i]}.php
done
