# docker-python-nvidia

これは NVIDIA GPU 搭載マシンで Python や各種ディープラーニングのフレームワークを利用する環境のための Dockerプロジェクトです．
Ubuntu 16.04 (Xenial) + CUDA8.0 + cuDNN 6.0 + pyenv + python 3.6.x + anaconda をベースにしています．

## 使い方

DockerHubからイメージを直接ダウンロードして利用することもできますが，実行する際はオプションで指定する項目が多くなるため docker-compose を利用するのが楽です．そのためのスクリプトをここで用意してありますので，それを利用する手順を示します．
https://github.com/nmiri-nagoya-nsaito/docker-python-dev-nvidia

1. GitHubから関連スクリプトのダウンロード

   以下のコマンドを実行するとカレントディレクトリに docker-python-dev-nvidia という名称のディレクトリができますので，そこに移動します．

    ```
    git clone https://github.com/nmiri-nagoya-nsaito/docker-python-dev-nvidia.git
    cd docker-python-dev-nvidia
    ```

1. イメージをダウンロードする

    ```
    docker-compose pull tensorflow-nv
    ```
    
    イメージをDockerHubからダウンロードします．ダウンロードが完了すると，実行を開始できます．

1. コンテナのシェルに入る

    コンテナのシェルに入る場合，そのためのスクリプトが用意してありますのでそれを使います．スクリプトの引数として， どのイメージを利用するか（python-dev-nvidia　とか　tensorflow-nv とか）を指定します．

    ```
    ./start_shell tensorflow-nv
    ```
    
    シェルから抜けるには exit コマンドを使います．シェルから抜けると，コンテナも停止します．

1. tensorflowのコンテナを起動する．

    ```
    ./start_tensorflow.sh
    Creating network "dockerpythondevnvidia_default" with the default driver
    Creating dockerpythondevnvidia_tensorflow-nv_1 ... 
    Creating dockerpythondevnvidia_tensorflow-nv_1 ... done
                    Name                     Command    State                        Ports                      
    ------------------------------------------------------------------------------------------------------------
    dockerpythondevnvidia_tensorflow-nv_1   /bin/bash   Up      0.0.0.0:32817->6006/tcp, 0.0.0.0:32816->8888/tcp
    ```

    tensorflow-nv イメージからコンテナを開始し，　その中の　Jupyter Notebook と Tensorboard を起動します．　それらはコンテナ内でWebサーバとして動作し，利用する場合はホストのWebブラウザからURLを指定してアクセスします．

    上の例の場合，
    * コンテナの8888番ポートがホストの32816番ポートに，　コンテナの6006番がホストの32817番に割り当てられている
    * Jupyter Notebook のサーバは http://0.0.0.0:32816 というURLでアクセスする
    * Tensorboard のサーバは http://0.0.0.0:32817 というURLでアクセスする

# 補足

Ctrl-P が detach 操作に割り当てられているため，シェル作業でそれを利用することができません．それが困る場合は ```~/.docker/config.json``` ファイルに次のような項目を追記します．

```
{
	"detachKeys": "ctrl-\\"
}
```
上の例では detach を "ctrl-\" に割り当て直すことで Ctrl-P を使えるようにしていますが，お好みで別のキーに割り当てることもできます．
