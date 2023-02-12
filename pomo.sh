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
