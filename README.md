基于ubuntu 16.04集成tomcat7 jre8

tomcat7 以apr模式运行

ssh 用户名 root 密码 root

预装以下命令
1. vim
2. ping
3. telnet
4. curl

开放 22及8080 端口

运行:
docker run -d -p 10022:22 -p18080:8080 --name tsshdtest --cap-add SYS_PTRACE lmspay/tomcat-sshd:7-jre8-3
