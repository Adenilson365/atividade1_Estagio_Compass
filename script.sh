#
#!/bin/bash
#
#######################################################
#
# Script para verificar status do serviço Apache
# no escopo da atividade 1 - Estágio Compass Uol 
# 
# Autor: Adenilson Konzelmann Alves
# Atividade 1 - Sprint 4 - AWS + LINUX - Estágio Compass
#
########################################################


#Variáveis 
DIR_LOGS="/script"
STATUS=$(systemctl status httpd | grep Active | awk '{print $2}')
AGO=$(systemctl status httpd | grep Active | cut -d';' -f 2 | systemctl status httpd | grep Active | cut -d';' -f2 | tr -d 'ago')
STATUS_ACCES=$(systemctl status httpd | grep 'Status' | awk -F '"' '{print $2}')
DATE=$(date +"%d/%m/%y %H:%M:%S")
SERVICE=$(systemctl status httpd | head -n1 | cut -d"-" -f2 | awk '{$1=$1}1')
LOG_LINE="$DATE - $STATUS_ACCES - $SERVICE"

# Condicional que verifica  com comando test o status do servidor
# e redireciona para o arquivo de log correspondente.

if [ "$STATUS" = "inactive" ]
then
        echo "$LOG_LINE - Servidor Offline a: $AGO" >> $DIR_LOGS/offline.txt
else
        echo "$LOG_LINE - Servidor Online a: $AGO" >> $DIR_LOGS/online.txt
fi



