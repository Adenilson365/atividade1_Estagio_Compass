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

#Armazena o caminho para o diretório de destino dos logs
DIR_LOGS="/script"
#Verifica se apartir do systemctl se o Apache está online ou offline
STATUS_ON_OFF=$(systemctl status httpd | grep Active | awk '{print $2}')
#Verifica a quanto tempo está no status atual (Online ou Offline)
STATUS_UPTIME=$(systemctl status httpd | grep Active | cut -d';' -f 2 | systemctl status httpd | grep Active | cut -d';' -f2 | tr -d 'ago')
#Retorna a Linha de status do systemctl
STATUS_ACCES=$(systemctl status httpd | grep 'Status' | awk -F '"' '{print $2}')
DATE=$(date +"%d/%m/%y %H:%M:%S")
NAME_SERVICE=$(systemctl status httpd | head -n1 | cut -d"-" -f2 | awk '{$1=$1}1')
#Concatena as variáveis para montar a linha de log 
LOG_LINE="$DATE - $STATUS_ACCES - $NAME_SERVICE"

# Condicional que verifica  com comando test o status do servidor
# e redireciona para o arquivo de log correspondente.

if [ "$STATUS_ON_OFF" = "inactive" ]
then
        echo "$LOG_LINE - Servidor Offline a: $STATUS_UPTIME" >> $DIR_LOGS/offline.txt
else
        echo "$LOG_LINE - Servidor Online a: $STATUS_UPTIME" >> $DIR_LOGS/online.txt
fi



