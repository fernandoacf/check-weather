#!/bin/bash
# Just check the weather indefinidely

CITY="Joao Pessoa"
FILE=/scripts/weather/weather

check_weather()
{
TIME=$(date +'%H:%M')

curl --silent wttr.in/"$CITY"?format=3 > $FILE-$TIME || return 1
grep "$CITY" $FILE-$TIME 1>>/dev/null || return 1

return 0

}

if [ ! -f /scripts/weather/ ]; then
        mkdir -p /scripts/weather/
        touch /scripts/weather.pid
fi

case $1 in
        start)
                while :
                do
                        check_weather || continue
                        sleep 60
                done &
                PID=`echo $!>/scripts/weather.pid`
                ;;
        stop)
                kill -9 `cat /scripts/weather.pid`
                if [ $? != 0 ]; then
                        echo "Failed to stop" && exit 1
                else
                        echo "Stopped" && exit 0
                fi
                ;;
        *)
                ps -p `cat /scripts/weather.pid` 1>>/dev/null
                if [ $? != 0 ]; then
                        echo "Check weather stopped" && exit 1
                else
                        echo "Check weather is running" && exit 0
                fi
                ;;
esac
