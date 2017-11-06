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
### setup pyenv (as user)
###
USER $user
WORKDIR /home/$user
ENV HOME_USER=/home/$user
ENV PYENV_ROOT="${HOME_USER}/.pyenv" \
    _PROFILE=${HOME_USER}/.profile \
    _BASHRC=${HOME_USER}/.bashrc
ENV PATH=${PYENV_ROOT}/bin:${PATH}
RUN git clone https://github.com/yyuu/pyenv.git ${PYENV_ROOT} \
    && eval echo 'export PYENV_ROOT=${PYENV_ROOT}' >> ${_PROFILE} \
    && echo 'export PATH="${PYENV_ROOT}/bin:$PATH"' >> ${_PROFILE} \
    && echo 'if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi' >> ${_PROFILE}
###
### setup python 3.6 environment(as user)
###
RUN eval "$(pyenv init -)" \
    && PY_VERSION=$(pyenv install --list| grep "^ *3.6\." | sort -t . -n | tail -n 1) \
    && pyenv install ${PY_VERSION} \
    && pyenv global ${PY_VERSION} \
    && pyenv rehash \
    && pip install jupyter matplotlib
###
### setup anaconda environment(as user)
###
RUN eval "$(pyenv init -)" \
    && ANACONDA_VERSION=$(pyenv install --list | grep anaconda3 | sort -t . -n | tail -n 1 | sed -e 's/[ \f\n\r\t]//g') \
    && pyenv install ${ANACONDA_VERSION} \
    && pyenv global ${ANACONDA_VERSION} \
    && pyenv rehash \
    && eval echo 'alias conda-activate=\"source ${PYENV_ROOT}/versions/${ANACONDA_VERSION}/bin/activate\"' >> ${_BASHRC} \
    && eval echo 'alias conda-deactivate=\"source ${PYENV_ROOT}/versions/${ANACONDA_VERSION}/bin/deactivate\"' >> ${_BASHRC} \
    && echo 'alias activate=conda-activate' >> ${_BASHRC} \
    && echo 'alias deactivate=conda-deactivate' >> ${_BASHRC} \
    && echo echo \"In this environment, use \\\"\(de\)activate\\\" or \\\"conda-\(de\)activate\\\" instead of \\\"source \(de\)activate\\\"\" >> ${_BASHRC} \
    && conda update conda
###
### run custom scripts(as root and user)
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
