#!/bin/bash

MQTT_HOST="192.168.2.6"
MQTT_USER="hass"
MQTT_PASS="hass"

MQTT_TOPIC="voltage/$HOSTNAME"

linex="Program starting"
printf "$linex\n"
echo $linex | mosquitto_pub -l -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASS -t $MQTT_TOPIC &


tail -f /var/log/kern.log | while read line
#tail -f ./junk.log | while read line

do
#   printf "$line\n"

   if [[ "$line" =~ "oltage" ]]; then

      echo "$line" | awk '{ print $1, $2, $3, $4, $7, $8, $9 }' \
        | mosquitto_pub -l -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASS -t $MQTT_TOPIC &

#      echo "$line" | awk '{ print $1, $2, $3, $4, $7, $8, $9 }'

fi

done
   
