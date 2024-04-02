# DOCUMENTAÇÃO DO PROCESSO  DE DESENVOLVIMENTO DA ATIVIDADE 1 - ESTÁGIO COMPASS

## Parte 2 : Linux

### Instalar pacotes

- Execute os comandos:

- Entrar em modo root para executar as configurações:
```
sudo su -
```
- Atualizar o sistema
```
yum update -y
```
- Instalar o servidor Apache
```
yum install httpd -y
```
- Habilitar o apache para subir na inicialização
```
systemctl enable httpd
```
- Iniciar o apache
```
systemctl start httpd
``` 
- Verificar status do apache
```
systemctl status httpd
```

### Montar NFS usando EFS

- Pacote sugerido para instalação pela documentação AWS

```
amazon-efs-utils
```

- Criar diretório de montagem na EC2 cliente 

```
mkdir /mnt/nfs
```

- Comando para montar o EFS como NFS

```
mount -t nfs4  nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport <ip_efs>:/ /mnt/nfs
```

- Verificar se o diretório está montado

```
df -h -t nfs4
``` 

 - Saída esperada do comando

![Saída esperada paro o comando df -h -t nfs4](./assets/saida_df_h_t_nfs4.png)

- Editar arquivo /etc/fstab - Para montar o disco automáticamente ao inicilizar o servidor

```
ip_efs:/ /mnt/nfs nfs4 nofail,_netdev,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport   0 0
```
- Opções - Recomendadas pela documentação:
  - nofail : Se falhar a montagem não atrapalha a inicialização
  - _netdev : Indica que é uma unidade na rede e deve esperar subir a rede para montar
  - rsize e wsize : Indica o tamanho do blocos de leitura e escrita
  - hard : se não conseguir montar o NFS, deve tentar novamente segundo as opções timeo e retrans
  - timeo : tempo até uma nova tentativa
  - retrans : número de tentativas
  - noresvport : Facilita a reconexão após uma desconexão
- Criar diretório dos arquivos de log
```
mkdir /mnt/nfs/adenilson
```

### Script

- Criar Diretório do Script.

```
mkdir /script
```
- Crar o arquivo do script dentro do diretório.
- Dixar script executável para o dono do arquivo, nesse caso será executado como root.

```
chmod u+x script.sh
```

- Agendar tarefa no /etc/crontab para executar a cada 5 minutos
 
```
*/5 * * * * root /script/script.sh
```
- Script foi montado sobre da saída do comando systemctl status httpd
- Linha de log esperada do script (no caso, quando onlne):
  
`
26/03/24 15:05:01 - The Apache HTTP Server - Total requests: 3; Idle/Busy workers 100/0;Requests/sec: 0.000704; Bytes served/sec:   2 B/sec - Servidor Online a:  1h 11min 
`
