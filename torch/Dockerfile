FROM python-base
MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>

USER root

# Install git, apt-add-repository and dependencies for iTorch
RUN apt-get update && apt-get install -y libssl-dev libzmq3-dev

USER $USER_NAME
WORKDIR $USER_HOME

# Run Torch7 installation scripts
RUN git clone https://github.com/torch/distro.git torch --recursive && cd torch && \
  bash install-deps && \
  ./install.sh

# Export environment variables manually
ENV LUA_PATH='/$USER_HOME/.luarocks/share/lua/5.1/?.lua;/$USER_HOME/.luarocks/share/lua/5.1/?/init.lua;/$USER_HOME/torch/install/share/lua/5.1/?.lua;/$USER_HOME/torch/install/share/lua/5.1/?/init.lua;./?.lua;/$USER_HOME/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua'
ENV LUA_CPATH='/$USER_HOME/.luarocks/lib/lua/5.1/?.so;/$USER_HOME/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'
ENV PATH=/$USER_HOME/torch/install/bin:$PATH
ENV LD_LIBRARY_PATH=/$USER_HOME/torch/install/lib:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH=/$USER_HOME/torch/install/lib:$DYLD_LIBRARY_PATH
ENV LUA_CPATH='/$USER_HOME/torch/install/lib/?.so;'$LUA_CPATH

# Set ~/torch as working directory
WORKDIR /$USER_HOME/torch
