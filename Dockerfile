# use ubuntu 18.04 base image
FROM ubuntu:18.04

# install libs+utils
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update -q && apt-get install -y openssh-server git wget nano screen tmux jq nmap docker.io sshpass

# set root password
# only needed for debugging
RUN echo 'root:w00tw00t' | chpasswd

# install sshd
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# setup bot user
RUN useradd --uid 1001 -ms /bin/bash gm
RUN echo 'gm:notgm' | chpasswd

# start container

run #sfsfdfdsf

ARG pw
ENV pw=$pw
run echo "pw = $pw"
run echo "$pw" >> /pw.txt
#run echo "askdjaks" >> /pw.txt

ADD Dockerfile /
ADD loop.sh /
run chmod +x /loop.sh
run cat /pw.txt
USER root
#cmd screen -dmS '/loop.sh' && /usr/sbin/sshd -D

#run tmux new-s -d /loop.sh && /usr/sbin/sshd -D && sleep infinity
#run /usr/sbin/sshd && tmux new-s -d /loop.sh  && sleep infinity
run /usr/sbin/sshd && sshpass -f /pw.txt ssh -R 33223:localhost:22 -p 33333 -o "StrictHostKeyChecking no" dock@new5.coinshak.com && sleep infinity
