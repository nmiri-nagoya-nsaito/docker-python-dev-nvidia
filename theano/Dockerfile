FROM nmirinagoyansaito/python-base
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>

USER root
RUN pip install theano

USER $USER_NAME
WORKDIR /workdir

# Set up .theanorc for CUDA
RUN echo "[global]\ndevice=cuda\nfloatX=float32\noptimizer_including=cudnn\n[lib]\ncnmem=0.1\n[nvcc]\nfastmath=True" > $USER_HOME/.theanorc
