# docker-python-nvidia

これは NVIDIA GPU 搭載マシンで Python や各種ディープラーニングのフレームワークを利用する環境のための Dockerプロジェクトです．

Ubuntu 16.04 (Xenial) + CUDA8.0 + cuDNN 6.0　+ anaconda(Python3.5) をベースにしています（pyenvの利用はやめました）．

## 使い方

ここではDockerHubからイメージダウンロードして利用する手順を示します．

コマンドの説明では docker　を使用していますが nvidia-docker に適宜置き換えてください．

### python-base

NVIDIAより提供される Ubuntu 16.04 (Xenial) + CUDA8.0 + cuDNN 6.0 のイメージをベースに，　Anacondaをインストールし，ユーザ(developer)を追加したものです．　

1. DockerHub からイメージを取得

    ```
    $ docker pull nmirinagoyansaito/python-base
    ```
    
    ローカルでイメージをビルドする場合は　git でこのリポジトリのソースをダウンロードし， docker build コマンドで作成します．

    ```
    $ git clone https://github.com/nmiri-nagoya-nsaito/docker-python-dev-nvidia.git
    $ cd docker-python-dev-nvidia
    $ docker build -t nmirinagoyansaito/python-base python-base
    ```

1. Jupyter　Notebook　を起動

    ```
    $ docker run --name python-base-jupyter -d -p 8888 -v /Users/saito/work/docker-python-dev-nvidia/workdir/python-base:/workdir python-base jupyter notebook --notebook-dir=/workdir --ip=0.0.0.0 --port=8888
    ```
    
    Jupyter　Notebookがコンテナで起動します．　コンテナの 8888番ポートがホストマシンの空いているポート番号に割り当てられます．
    
    対応を確認するにはdocker ps コマンドを使います．
    
    ```
    $ docker ps
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                     NAMES
    237a6f2c7141        python-base         "jupyter notebook ..."   4 seconds ago       Up 3 seconds        0.0.0.0:32772->8888/tcp   python-base-jupyter
    ```
    
    ここではホストの32772番に割り当てられていることがわかりますのでWebブラウザで ```http://0.0.0.0:32772``` にアクセスします．

1. 同じコンテナを使って別コマンドを利用する（bashの例）

    ```
    $ docker exec -it python-base-jupyter bash --login
    ```

1. コンテナの停止，削除，　イメージの削除

    ```
    ＃ コンテナの停止
    $ docker stop python-base-jupyter
    # コンテナの削除
    $ docker rm python-base-jupyter
    # イメージの削除
    $ docker rmi nmirinagyansaito/python-base
    ```

### tensorflow

先の python-base を元に，　tensorflow-gpu を追加したものです．

docker の操作方法については先ほどとほとんど同じです．


```
# DockerHub からイメージ取得
$ docker pull nmirinagoyansaito/tensorflow

# ローカルでビルドしてイメージを作成する場合
$ docker build -t nmirinagoyansaito/tensorflow tensorflow

# イメージからコンテナ（のプログラム，ここでは tensorboard）を実行
$ docker run --name tensorflow-jupyter -d -p 6006 -p 8888 -v /Users/saito/work/docker-python-dev-nvidia/workdir/tensorflow:/workdir nmirinagoyansaito/tensorflow jupyter notebook --notebook-dir=/workdir --ip=0.0.0.0 --port=8888

# 実行中コンテナの確認
$ docker ps
CONTAINER ID        IMAGE                          COMMAND                  CREATED             STATUS              PORTS                     NAMES
8b8ef4ecca99        nmirinagoyansaito/tensorflow   "jupyter notebook ..."   18 seconds ago      Up 17 seconds       0.0.0.0:32775->8888/tcp   tensorflow-jupyter

# 既存コンテナで tensorboard を実行（tensorboardはサーバプログラムのため，終了するまでプロンプトに戻らない）
$ docker exec tensorflow-jupyter tensorboard --logdir=/workdir/tensorboard
# バックグラウンドで実行（コマンド呼び出し後，すぐにプロンプトに戻る）
$ docker exec -d tensorflow-jupyter tensorboard --logdir=/workdir/tensorboard

# 既存コンテナでbash を実行
$ docker exec -it tensorflow-jupyter bash --login

# 停止，削除
$ docker stop tensorflow-jupyter
$ docker rm tensorflow-jupyter
$ docker rmi nmirinagoyansaito/tensorflow
```

### keras

前述の tensorflow イメージをベースに， CNTKやTheanoをインストールしたイメージです．

```
$ dicker pull nmirinagoyansaito/keras
$ docker build -t nmirinagoyansaito/keras keras

$ docker run --name keras-jupyter -d -p 6006 -p 8888 -v /Users/saito/work/docker-python-dev-nvidia/workdir/keras:/workdir nmirinagoyansaito/keras jupyter notebook --notebook-dir=/workdir --ip=0.0.0.0 --port=8888

$ docker ps
CONTAINER ID        IMAGE                          COMMAND                  CREATED             STATUS              PORTS                                              NAMES
3fbced75cfc0        nmirinagoyansaito/keras        "jupyter notebook ..."   3 seconds ago       Up 1 second         0.0.0.0:32778->6006/tcp, 0.0.0.0:32777->8888/tcp   keras-jupyter

$ docker exec -it keras-jupyter bash --login

$ docker stop keras-jupyter
$ docker rm keras-jupyter
$ docker rmi nmirinagoyansaito/keras
```

#### 課題
現状の課題として， Jupyter Notebookから 「!python keras/examples/mnist_mlp.py」のようにPythonスクリプトを実行すると
　　　「ImportError: No module named 'keras'」というエラーが発生します．

Jupyter のセル内で imoprt keras してもエラーは発生しません．

回避策としてJupyter Notebookのセル内（または，　シェル）から以下のように keras をインストールすれば解決します．

```
!sudo /opt/conda/bin/pip install keras
```

4. chainer

python-base イメージを元に， chainer と cupy をインストールしたイメージです．

```
$ dicker pull nmirinagoyansaito/chainer
$ docker build -t nmirinagoyansaito/chainer chainer

$ docker run --name chainer-jupyter -d -p 8888 -v /Users/saito/work/docker-python-dev-nvidia/workdir/chainer:/workdir nmirinagoyansaito/chainer jupyter notebook --notebook-dir=/workdir --ip=0.0.0.0 --port=8888
$ docker ps

$ docker exec -it chainer-jupyter bash --login

$ docker stop chainer-jupyter
$ docker rm chainer-jupyter

$ docker rmi nmirinagoyansaito/chainer
```

5. theano

python-base イメージを元に，　theano および pygpu をインストールしたものです．

```
$ docker pull nmirinagoyansaito/theano
$ docker build -t nmirinagoyansaito/theano theano

$ docker run --name theano-jupyter -d -p 8888 -v /Users/saito/work/docker-python-dev-nvidia/workdir/theano:/workdir nmirinagoyansaito/theano jupyter notebook --notebook-dir=/workdir --ip=0.0.0.0 --port=8888
$ docker ps

$ docker exec -it theano-jupyter bash --login

$ docker stop theano-jupyter
$ docker rm theano-jupyter
$ docker rmi nmirinagoyansaito/theano
```

#### 課題

以下の例外が発生します

```
「ERROR (theano.gpuarray): Could not initialize pygpu, support disabled」
Traceback (most recent call last):
  File "/opt/conda/lib/python3.5/site-packages/theano/gpuarray/__init__.py", line 164, in <module>
    use(config.device)
  File "/opt/conda/lib/python3.5/site-packages/theano/gpuarray/__init__.py", line 151, in use
    init_dev(device)
  File "/opt/conda/lib/python3.5/site-packages/theano/gpuarray/__init__.py", line 60, in init_dev
    sched=config.gpuarray.sched)
  File "pygpu/gpuarray.pyx", line 634, in pygpu.gpuarray.init
  File "pygpu/gpuarray.pyx", line 584, in pygpu.gpuarray.pygpu_init
  File "pygpu/gpuarray.pyx", line 1057, in pygpu.gpuarray.GpuContext.__cinit__
pygpu.gpuarray.GpuArrayException: b'cuInit: H\x85\xc0H\x89\x05\x97\t!: \xa0\x06\x14\xa7\xc9\x7f'
```

GPU非搭載マシンで実行した実行したためかもしれません（調査中）．　おそらくGPU搭載マシンで実行することで解決すると想定しています．



# 補足

Docker の既定設定で Ctrl-P が detach 操作に割り当てられているため，シェル作業でそのキー操作を利用することができません． 

困る場合は ```~/.docker/config.json``` ファイルに次のような項目を追記します．

```
{
	"detachKeys": "ctrl-\\"
}
```
上の例では detach を "ctrl-\" に割り当て直すことで Ctrl-P を使えるようにしていますが，お好みで別のキーに割り当てることもできます．
