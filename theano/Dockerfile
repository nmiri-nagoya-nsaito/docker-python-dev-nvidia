FROM nmirinagoyansaito/python-base
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>

USER root
RUN pip install --upgrade pip && \
    pip install theano
RUN conda update --prefix /opt/conda anaconda && \ 
    conda install pygpu
ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64/stubs:$LD_LIBRARY_PATH

USER $USER_NAME
WORKDIR /workdir

# Set up .theanorc for CUDA
RUN echo "[global]\ndevice=cuda\nfloatX=float32\noptimizer_including=cudnn\n[lib]\ncnmem=0.1\n[nvcc]\nfastmath=True" > $USER_HOME/.theanorc
