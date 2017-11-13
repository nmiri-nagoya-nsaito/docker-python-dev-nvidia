# Start with cuDNN base image
FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>

# Install git, wget, python-dev, pip, BLAS + LAPACK and other dependencies
RUN apt-get update && apt-get install -y \
    gfortran \
    git \
    wget \
    liblapack-dev \
    libopenblas-dev \
    python3-dev \
    python3-pip \
    python3-nose \
    python3-numpy \
    python3-scipy

# Set CUDA_ROOT
ENV CUDA_ROOT /usr/local/cuda/bin

# Install CMake 3
RUN cd /root && wget http://www.cmake.org/files/v3.8/cmake-3.8.1.tar.gz && \
    tar -xf cmake-3.8.1.tar.gz && cd cmake-3.8.1 && \
    ./configure && \
    make -j "$(nproc)" && \
    make install

# Install Cython
RUN pip3 install Cython

# Clone libgpuarray repo and move into it
RUN cd /root && git clone https://github.com/Theano/libgpuarray.git && cd libgpuarray && \
    mkdir Build && cd Build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr && \
    make -j"$(nproc)" && \
    make install
# Install pygpu
RUN cd /root/libgpuarray && \
    python3 setup.py build_ext -L /usr/lib -I /usr/include && \
    python3 setup.py install

# Install bleeding-edge Theano
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade six
RUN pip3 install --upgrade --no-deps git+https://github.com/Theano/Theano.git
# Set up .theanorc for CUDA
RUN echo "[global]\ndevice=cuda\nfloatX=float32\noptimizer_including=cudnn\n[lib]\ncnmem=0.1\n[nvcc]\nfastmath=True" > /root/.theanorc
