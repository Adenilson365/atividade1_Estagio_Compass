# DOCUMENTAÇÃO DO PROCESSO  DE DESENVOLVIMENTO DA ATIVIDADE 1 - ESTÁGIO COMPASS

## Parte 1 : AWS

### Criar instância EC2

![Imagem mostrando o resumo de criação da EC2 onde é possível verificar os requisitos da atividade](./assets/EC2_resumo_criacao.png)

## Parte 2 : Linux

### Instalar pacotes

- Execute os comandos:
  
```sudo su -```

`yum update -y`

`yum install httpd -y`

`systemctl enable httpd`

`systemctl start httpd` 

- Script - Deixar script executável

`chmod o+x script.sh `

- Agendar tarefa no /etc/crontab para executar a cada 5 minutos

`*/5 * * * * root /script/script.sh`
