#!/bin/bash

DATE=$(date +'%m-%d-%H-%M')
SERVICE="service.backup"
ROOT=/backup
DIR=$ROOT/$DATE/$SERVICE

backup() 
{
    if [ ! -f $DIR ]; then
        mkdir -p $DIR || return 1
    fi
    if [ $? == 0 ]; then
        tar -zcvf $DIR/check-weather.tar.gz /scripts/weather/ || return 1
        chmod 400 $DIR/check-weather.tar.gz || return 1
    fi
}

clean_older() 
{
    cd $ROOT || return 1
    rm -rf `ls -t | awk 'NR>10'` &>/dev/null || return 1
}

backup

if [ $? != 0 ]; then
    echo "Backup failed, notify" && exit 1
else
    clean_older || exit 1
fi

