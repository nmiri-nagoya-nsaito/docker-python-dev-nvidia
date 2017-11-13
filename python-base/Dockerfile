FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        sudo git wget curl bzip2 vim ca-certificates \
        make build-essential libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev \
        xz-utils tk-dev less libhdf5-dev g++ graphviz openmpi-bin

###
### create user(as root)
###
ARG USER
ENV USER_NAME=${USER:-"developer"}
ENV USER_HOME=/home/$USER_NAME

RUN adduser --gecos ",,," --disabled-password $USER_NAME && \
    passwd -d $USER_NAME && \
    usermod -G sudo $USER_NAME && \
    echo $USER_NAME ALL=NOPASSWD: ALL > /etc/sudoers.d/$USER_NAME

###
### setup miniconda(as root)
###
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

WORKDIR /tmp
RUN mkdir -p $CONDA_DIR && \
    chown $USER_NAME $CONDA_DIR -R && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.3.30-Linux-x86_64.sh && \
    echo "0b80a152332a4ce5250f3c09589c7a81 *Miniconda3-4.3.30-Linux-x86_64.sh" | md5sum -c - && \
    /bin/bash Miniconda3-4.3.30-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.3.30-Linux-x86_64.sh

###
### configuration for jupyter notebook(as user)
###
USER $USER_NAME
WORKDIR $USER_HOME

RUN mkdir $USER_HOME/.jupyter && \
    touch $USER_HOME/.jupyter/jupyter_notebook_config.py && \
    echo c.NotebookApp.token = \'\' >> $USER_HOME/.jupyter/jupyter_notebook_config.py && \
    echo c.NotebookApp.password = \'\' >> $USER_HOME/.jupyter/jupyter_notebook_config.py && \
    echo c.NotebookApp.open_browser = False >> $USER_HOME/.jupyter/jupyter_notebook_config.py
