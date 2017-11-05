FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo git wget curl bzip2 vim \
        make build-essential libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev \
        xz-utils tk-dev
ARG USER
###
### create user
###
ENV user=${USER:-"developer"}
RUN echo $user
RUN adduser --gecos ",,," --disabled-password $user \
    && passwd -d $user \
    && usermod -G sudo $user \
    && echo $user ALL=NOPASSWD: ALL > /etc/sudoers.d/$user
###
### run custom scripts
###
USER root
WORKDIR /tmp
ADD ./scripts ./
RUN chmod +x setup_root.sh setup_user.sh \
    && chown $user:$user setup_user.sh \
    && sync \
    && ./setup_root.sh
USER $user
WORKDIR /home/$user
RUN /tmp/setup_user.sh
