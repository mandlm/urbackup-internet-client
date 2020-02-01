#!/usr/bin/env sh

urbackupclientbackend --loglevel info --restore server-confirms --internet-only &
urbackupclientctl wait-for-backend

urbackupclientctl set-settings -k internet_mode_enabled -v true 
urbackupclientctl set-settings -k internet_server -v $SERVER_NAME 
urbackupclientctl set-settings -k internet_server_port -v 55415 
urbackupclientctl set-settings -k computername -v $CLIENT_NAME 
urbackupclientctl set-settings -k internet_authkey -v $CLIENT_KEY 

urbackupclientctl add-backupdir --path /backup

sleep infinity
