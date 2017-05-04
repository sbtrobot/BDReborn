#!/bin/bash
COUNTER=1
while(true) do
./beyond.sh
curl "https://api.telegram.org/botتوکن/sendmessage" -F "chat_id=223395979" -F "text=#NEWCRASH-#Telemega-Reloaded-${COUNTER}-times"
let COUNTER=COUNTER+1 
done
