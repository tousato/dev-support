FROM ubuntu:16.04

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install build-essential libssl-dev libreadline-dev zlib1g-dev iputils-ping net-tools sudo dnsutils locales
RUN apt-get -y install openssh-server ufw curl vim wget git monit
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-17.12.1-ce.tgz | tar -xzC /usr/local/bin --strip=1 docker/docker

# ssh
RUN mkdir /var/run/sshd
RUN useradd -m m-sato && echo "m-sato:m-sato" | chpasswd && gpasswd -a m-sato sudo
RUN chsh -s /bin/bash m-sato
RUN echo "m-sato ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/m-sato
RUN mkdir -p /home/m-sato/.ssh; chown m-sato /home/m-sato/.ssh; chmod 700 /home/m-sato/.ssh
COPY ./id_rsa.pub /home/m-sato/.ssh/authorized_keys
RUN chown m-sato /home/m-sato/.ssh/authorized_keys; chmod 600 /home/m-sato/.ssh/authorized_keys

# postgres
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get -y install postgresql-9.4

RUN locale-gen ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP
ENV LANG ja_JP.UTF-8
#RUN pg_createcluster 9.4 main --start

# monit
RUN sed -i.bak 's/^#\( *set httpd port 2812 and\)/ \1/;s/^#\( *use address localhost\)/ \1/;s/^#\( *allow localhost\)/ \1/;s/^#\( *allow admin:monit\)/ \1/' /etc/monit/monitrc
COPY ./monit/* /etc/monit/conf.d/
CMD service monit start && tail -f /dev/null

