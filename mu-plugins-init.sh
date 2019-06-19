#!/bin/bash

# MU Plugins Init - Wp Pro Club
# by DimaMinka (https://dimaminka.com)
# https://github.com/wp-pro-club/init

source ${PWD}/lib/app-init.sh

version=""
zip="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/([^\/:]+)\/([^\/:]+)\/(.+).zip$"
# Get all single plugins and run install by type
for i in "${!conf_app_mu_plugins__name[@]}"
do
    printf "${GRN}======================================================${NC}\n"
    printf "${GRN}Installing plugin ${conf_app_mu_plugins__name[$i]}${NC}\n"
    printf "${GRN}======================================================${NC}\n"
done
