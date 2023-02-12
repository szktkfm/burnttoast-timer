#!/bin/bash
set -ue


toast_later(){
    sleep $1
    powershell.exe -command New-BurntToastNotification -Text $2
}

convert_args() {
    local time=$1
    case $time in
    *s)
        echo ${time%s};;
    *sec)
        echo ${time%sec};;
    *m)
        expr ${time%m} '*' 60;;
    *min)
        expr ${time%min} '*' 60;;
    *h)
        expr ${time%h} '*' 60 '*' 60;;
    esac
}


if [ $# -eq 0 ]; then
    echo "pass time arg, such as 30s or 30m"
    exit 1
fi

sleep_time=$(convert_args ${1})

toast_later $sleep_time "Pomo"&

while :
do
    sleep 1;
    sleep_time=$((${sleep_time} - 1))
    mm=$(( ${sleep_time} / 60 ))
    ss=$(( ${sleep_time} - ${mm} * 60 ))
    if [ $mm -eq 0 ];then
        printf "\r%d" ${ss}
    else
        printf "\r%d:%d" ${mm} ${ss}
    fi

    if [ $sleep_time -eq 0 ];then
        break
    fi
done

