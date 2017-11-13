FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    python3-dev \
    python3-pip && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

RUN pip3 install --upgrade pip && \
    pip3 install setuptools && \
    pip3 install cupy==3.0.0a1 chainer==4.0.0a1
