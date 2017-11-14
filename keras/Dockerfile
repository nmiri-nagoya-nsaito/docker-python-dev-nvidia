FROM nmirinagoyansaito/tensorflow

USER root

# Python
RUN pip install https://cntk.ai/PythonWheel/GPU/cntk-2.1-cp35-cp35m-linux_x86_64.whl && \
    pip install theano && \
    pip install keras

USER $USER_NAME
WORKDIR /workdir

# Set up .theanorc for CUDA
RUN echo "[global]\ndevice=cuda\nfloatX=float32\noptimizer_including=cudnn\n[lib]\ncnmem=0.1\n[nvcc]\nfastmath=True" > $USER_HOME/.theanorc

