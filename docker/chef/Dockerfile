FROM ubuntu:16.04

RUN apt-get update && apt-get -y upgrade 
RUN apt-get -y install build-essential libssl-dev libreadline-dev zlib1g-dev language-pack-ja iputils-ping net-tools sudo dnsutils
RUN apt-get -y install openssh-server ufw curl vim wget git
RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-17.12.1-ce.tgz | tar -xzC /usr/local/bin --strip=1 docker/docker
RUN mkdir /var/run/sshd

RUN useradd -m m-sato && echo "m-sato:m-sato" | chpasswd && gpasswd -a m-sato sudo
RUN chsh -s /bin/bash m-sato
RUN mkdir -p /home/m-sato/.ssh; chown m-sato /home/m-sato/.ssh; chmod 700 /home/m-sato/.ssh
 
CMD /usr/sbin/sshd -D && tail -f /dev/null

# ssh
COPY ./id_rsa /home/m-sato/.ssh/id_rsa
COPY ./id_rsa.pub /home/m-sato/.ssh/id_rsa.pub
RUN chown m-sato /home/m-sato/.ssh/id_rsa;chmod 600 /home/m-sato/.ssh/id_rsa
RUN chown m-sato /home/m-sato/.ssh/id_rsa.pub;chmod 600 /home/m-sato/.ssh/id_rsa.pub

# user
USER m-sato

# ruby
WORKDIR /home/m-sato
ENV PATH "~/.rbenv/shims:$PATH"
RUN git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export PATH="$PATH:~/.rbenv/bin"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
RUN ["/bin/bash", "-c", "source ~/.bash_profile"]
ENV PATH "~/.rbenv/shims:$PATH:~/.rbenv/bin"
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

RUN ["/bin/bash", "-c", "rbenv install 2.3.1 "]
RUN ["/bin/bash", "-c", "rbenv local 2.3.1"]
RUN ["/bin/bash", "-c", "rbenv rehash"]
RUN ["/bin/bash", "-c", "ruby -v"]

# bundle
RUN ["/bin/bash", "-c", "gem install bundler"]
RUN ["/bin/bash", "-c", "bundle -v"]

# chef gitから取得する
#RUN mkdir chef-repo
#WORKDIR /home/m-sato/chef-repo
#RUN ["/bin/bash", "-c", "bundle init"]
#RUN echo 'gem "chef"' >> Gemfile
#RUN echo 'gem "knife-zero"' >> Gemfile
#RUN ["/bin/bash", "-c", "bundle install --path vendor/bundle"]
#RUN mkdir .chef
#RUN echo 'local_mode true' >> .chef/knife.rb

USER root
