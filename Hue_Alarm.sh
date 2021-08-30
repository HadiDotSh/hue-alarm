#!/bin/bash
# By @HadiDotSh

hueToken=""
hubIp=""
light=""
telegramToken=""
telegramChatID=""

send_message() {
	message=$( echo "$1" | sed 's/\\n/%0A/g' )
	curl -s -o /dev/null "https://api.telegram.org/bot${telegramToken}/sendMessage?chat_id=${telegramChatID}&parse_mode=HTML&text=$message"
}

if [[ $(curl -s -X GET "${hubIp}/api/${hueToken}/lights/${light}" | jq | grep '"on":' | sed 's/    "on": //g' | sed 's/,//g') == "true" ]];then
	send_message "💡 <b>HueAlarm :</b>\nSomeone turned the light ON\n\n<i>${date}</i>"
fi