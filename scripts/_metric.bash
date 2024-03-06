#!/bin/bash
# shellcheck disable=SC2034
i=$1
c=$2
e=1
sleep_time=5

if [ -z "$1" ] || [ -z "$2" ]; then
  echo usage: "$0" network-interface checkrepeats
  echo e.g. "$0" eth0 10
  exit
fi

while [ "$e" -le "$c"  ]
do
  # Network Interface Load:
  R1=$(cat /sys/class/net/"$1"/statistics/rx_bytes)
  T1=$(cat /sys/class/net/"$1"/statistics/tx_bytes)
  sleep $sleep_time
  R2=$(cat /sys/class/net/"$1"/statistics/rx_bytes)
  T2=$(cat /sys/class/net/"$1"/statistics/tx_bytes)
  TBPS=$(expr $T2 - $T1)
  RBPS=$(expr $R2 - $R1)
  TKBPS=$(expr $TBPS / 1024)
  RKBPS=$(expr $RBPS / 1024)
  CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}') # percentage of CPU in use
  MEM_LOAD=$(free | grep Mem | awk '{print $3/$2 * 100.0}') # percentage of Memory in use
  #echo "$1 tx: $TKBPS kB/s rx: $RKBPS kB/s, $(nproc) CPUs @ $CPU_LOAD load, $MEM_LOAD% Memory in use"

  metric_data="{
    \"interface\": $1,
    \"tx\": \"$TKBPS kB/s\",
    \"rx\": \"$RKBPS kB/s, 
    \"CPUs\": $(nproc),
    \"cpu_load\": $CPU_LOAD, 
    \"mem_load\": $MEM_LOAD
  }"
  
  
  (( e++ ))
  echo $metric_data
done

