FROM python-base
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>

###
### update packages and install TensorFlow (as root)
###
USER root
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y --no-install-recommends && \
    pip install tensorflow-gpu && \
    eval echo 'export LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64/stubs:${LD_LIBRARY_PATH}' >> /etc/profile.d/tensorflow.sh && \
    ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1

USER $USER_NAME
WORKDIR $USER_HOME
