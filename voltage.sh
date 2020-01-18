#!/bin/bash

<< !!!
multi line comment in bash - neat huh!

18 January 2020 - gswann

definition of the vcgen bits:
 0: under-voltage
 1: arm frequency capped
 2: currently throttled 
 3: Soft temperature limit active
 16: under-voltage has occurred
 17: arm frequency capped has occurred
 18: throttling has occurred
 19: Soft temperature limit has occurred

 https://harlemsquirrel.github.io/shell/2019/01/05/monitoring-raspberry-pi-power-and-thermal-issues.html
 https://www.raspberrypi.org/documentation/configuration/config-txt/overclocking.md
 
 you can also run this command to see the current state of the system throttle  
 vcgencmd get_throttled

!!!

MQTT_HOST="192.168.2.6"
MQTT_USER="hass"
MQTT_PASS="hass"

MQTT_TOPIC="voltage/$HOSTNAME"
PROG_VERSION="1.2"

linex="Program version $PROG_VERSION starting"
printf "$linex\n"
echo $linex | mosquitto_pub -l -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASS -t $MQTT_TOPIC &


tail -F /var/log/kern.log | while read line
#tail -f ./junk.log | while read line

do
#   printf "$line\n"

   if [[ "$line" =~ "oltage" ]]; then

      echo "$line" | awk '{ print $1, $2, $3, $4, $7, $8, $9 }' \
        | mosquitto_pub -l -h $MQTT_HOST -u $MQTT_USER -P $MQTT_PASS -t $MQTT_TOPIC &

#      echo "$line" | awk '{ print $1, $2, $3, $4, $7, $8, $9 }'

   fi

done
   

