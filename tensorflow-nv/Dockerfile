FROM nmirinagoyansaito/python-dev-nvidia
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>
###
### update packages(as root)
###
USER root
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
###
### install TensorFlow (as user)
###
USER $user
WORKDIR /home/$user
RUN eval "$(pyenv init -)" \
    && pyenv global $(pyenv versions --bare | grep "^ *3\.6\.") \
    && pyenv rehash \
    && pip install tensorflow
