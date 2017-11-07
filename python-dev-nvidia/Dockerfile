FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        sudo git wget curl bzip2 vim ca-certificates \
        make build-essential libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev \
        xz-utils tk-dev

###
### create user(as root)
###
ARG USER
ENV user=${USER:-"developer"}
RUN echo ${user}
RUN adduser --gecos ",,," --disabled-password ${user} \
    && passwd -d ${user} \
    && usermod -G sudo ${user} \
    && echo ${user} ALL=NOPASSWD: ALL > /etc/sudoers.d/${user}

###
### setup pyenv (as user)
###
USER ${user}
ENV HOME_USER=/home/${user}
WORKDIR ${HOME_USER}
ENV PYENV_ROOT="${HOME_USER}/.pyenv" \
    _PROFILE=${HOME_USER}/.profile \
    _BASHRC=${HOME_USER}/.bashrc
ENV PATH=${PYENV_ROOT}/bin:${PATH}
RUN git clone https://github.com/yyuu/pyenv.git ${PYENV_ROOT} \
    && eval echo 'export PYENV_ROOT=${PYENV_ROOT}' >> ${_PROFILE} \
    && echo 'export PATH="${PYENV_ROOT}/bin:$PATH"' >> ${_PROFILE} \
    && echo 'if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi' >> ${_PROFILE}

###
### setup default python environment(anaconda) (as user)
###
RUN eval "$(pyenv init -)" \
    && ANACONDA_VERSION=$(pyenv install --list | grep anaconda3 | sort -t . -n | tail -n 1 | sed -e 's/[ \f\n\r\t]//g') \
    && pyenv install ${ANACONDA_VERSION} \
    && pyenv global ${ANACONDA_VERSION} \
    && pyenv rehash \
    && conda update conda \
    && eval echo 'alias conda-activate=\"source ${PYENV_ROOT}/versions/${ANACONDA_VERSION}/bin/activate\"' >> ${_BASHRC} \
    && eval echo 'alias conda-deactivate=\"source ${PYENV_ROOT}/versions/${ANACONDA_VERSION}/bin/deactivate\"' >> ${_BASHRC} \
    && echo 'alias activate=conda-activate' >> ${_BASHRC} \
    && echo 'alias deactivate=conda-deactivate' >> ${_BASHRC} \
    && echo echo \"In this environment, use \\\"\(de\)activate\\\" or \\\"conda-\(de\)activate\\\" instead of \\\"source \(de\)activate\\\"\" >> ${_BASHRC}

###
### configuration for jupyter notebook(as user)
###
RUN mkdir ${HOME}/.jupyter \
    && touch ~/.jupyter/jupyter_notebook_config.py \
    && echo c.NotebookApp.token = \'\' >> ${HOME_USER}/.jupyter/jupyter_notebook_config.py \
    && echo c.NotebookApp.password = \'\' >> ${HOME_USER}/.jupyter/jupyter_notebook_config.py \
    && echo c.NotebookApp.open_browser = False >> ${HOME_USER}/.jupyter/jupyter_notebook_config.py
