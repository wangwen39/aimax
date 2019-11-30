﻿From ${Base_Image}

RUN apt-get update && apt-get install -y --no-install-recommends build-essential make cmake \
    vim wget openssh-server software-properties-common \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY ssh/sshd_config /etc/ssh/sshd_config
COPY ssh/ssh-start-chpasswd.sh /usr/sbin/ssh-start-chpasswd.sh
RUN chmod 500 /usr/sbin/ssh-start-chpasswd.sh

#Set tini 
COPY tini /tini
ENTRYPOINT ["/tini", "--"]
RUN mkdir /var/run/sshd
EXPOSE 22
