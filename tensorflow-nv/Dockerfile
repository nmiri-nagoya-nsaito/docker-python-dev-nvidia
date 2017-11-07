FROM nmirinagoyansaito/python-dev-nvidia
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>

###
### update packages(as root)
###
USER root
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y --no-install-recommends

###
### setup python 3.5 environment(as user)
###
USER $user
WORKDIR ${HOME_USER}
RUN eval "$(pyenv init -)" \
    && PY_VERSION=$(pyenv install --list| grep "^ *3.5\." | sort -t . -n | tail -n 1) \
    && pyenv install ${PY_VERSION} \
    && pyenv global ${PY_VERSION} \
    && pyenv rehash \
    && pip install jupyter matplotlib

###
### install TensorFlow (as user)
###
RUN eval "$(pyenv init -)" \
    && pip install tensorflow-gpu \
    && eval echo 'export LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64/stubs:${LD_LIBRARY_PATH}' >> ${_PROFILE} \
    && sudo ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
