#!/bin/bash
CPU_THRESHOLD=80
MEM_THRESHOLD=80
#mette une valeur a laquelle il y aura une alerte si on excede la valeur

while true; do
  #recupere usage CPU (user+system) en pourcentage
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
  cpu_usage=${cpu_usage%.*}

  #recupere usage memoire en pourcentage
  mem_usage=$(free | awk '/Mem/ {printf("%d", $3/$2 * 100)}')

  if [ "$cpu_usage" -ge "$CPU_THRESHOLD" ]; then
    echo -e "\033[0;31mAlerte : CPU > 80% ($cpu_usage%)\033[0m"
  else
    echo "CPU : $cpu_usage%"
  fi

  if [ "$mem_usage" -ge "$MEM_THRESHOLD" ]; then
    echo -e "\033[0;31mALERTE : RAM > 80% ($mem_usage%)\033[0m"
  else
    echo "RAM : $mem_usage%"
  fi

  sleep 2
done
