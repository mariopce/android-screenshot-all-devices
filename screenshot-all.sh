#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "please put  "-l" for landscape mode"
fi
MODE=""
MODENAME="portrait"
if [ "$1" = "-l" ]; then
    MODE="-l"
    MODENAME="landscape"
else 
    MODE=""
fi

for i in `adb devices| cut -f1| grep -v List `; 
do
DEV_NAME=`adb -s $i shell getprop ro.product.model | tr -d " \r\n"`
DATE=`date +%H%M%S`
FILE_NAME=$DEV_NAME-$DATE.png
./screenshot $MODE -s $i $FILE_NAME
SIZE=`identify -format '%w' $FILE_NAME | tr -d '\r'`
mv $FILE_NAME $DEV_NAME-$SIZE-$DATE-$MODENAME.png
done
