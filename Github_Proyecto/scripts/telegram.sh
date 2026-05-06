#!/bin/bash

#Anya Miranda 
#script que manda un mensaje a telegram

source ../.env
#cargamos ID y TOKEN

send_telegram() {
  local mensaje="$1"

curl -s -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "text=$mensaje" > /dev/null
}
  #parametros emiezan con $ seguido del número de parametro que buscamos
  
