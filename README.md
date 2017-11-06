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

1. コンテナのシェルに入る

    コンテナのシェルに入る場合，そのためのスクリプトが用意してありますのでそれを使います．
    スクリプトの引数として， どのイメージを利用するか（python-dev-nvidia　とか　tensorflow-nv とか）を指定します．

    ```
    ./start_shell tensorflow-nv
    ```
    
    シェルから抜けるには exit コマンドを使います．シェルから抜けると，コンテナも停止します．

1. コンテナのデフォルト処理を起動する．

    ```
    docker-compose up -d nmirinagoyansaito/tensorflow-nv
    ```

    イメージによってはコンテナのデフォルト処理を設定しているものがあり，その場合の起動方法です．　例えば tensorflow-nv の場合，　Jupyter Notebookが起動するように設定されています．それはコンテナ内でWebサーバとして動作しているため，利用する場合はWebブラウザからURLを指定してアクセスします．URLは以下のように確認します．

    ```
    $ docker-compose ps
                Name                               Command               State            Ports         
    --------------------------------------------------------------------------------------------------------
    dockerpythondevnvidia_tensorflow-nv_1   bash -c source /home/$user ...   Up      0.0.0.0:32778->8888/tcp
    docker-compose logs
    $ docker-compose logs
    Attaching to dockerpythondevnvidia_tensorflow-nv_1
    （中略）
    tensorflow-nv_1      | [I 09:00:08.819 NotebookApp] The Jupyter Notebook is running at:
    tensorflow-nv_1      | [I 09:00:08.819 NotebookApp] http://0.0.0.0:8888/?   token=7ae9e1bad56071170779dbe3851529c0d8e19b1669faffc4
    （中略）
    tensorflow-nv_1      |     Copy/paste this URL into your browser when you connect for the first time,
    tensorflow-nv_1      |     to login with a token:
    tensorflow-nv_1      |         http://0.0.0.0:8888/?token=7ae9e1bad56071170779dbe3851529c0d8e19b1669faffc4
    ```

    以上からわかることは
    * コンテナの8888番ポートがホストの32778番ポートに割り当てられていること
    * Jupyter Notebook のサーバは http://0.0.0.0:8888/?token=7ae9e1bad56071170779dbe3851529c0d8e19b1669faffc4 というURLで待ち受けていること
    です．　ホスト側のWebブラウザからアクセスするには上記URLの8888番の部分を32778に置き換えます．


# 補足

Ctrl-P が detach 操作に割り当てられているため，シェル作業でそれを利用することができません．それが困る場合は ```~/.docker/config.json``` ファイルに次のような項目を追記します．

```
{
	"detachKeys": "ctrl-\\"
}
```
上の例では detach を "ctrl-\" に割り当て直すことで Ctrl-P を使えるようにしていますが，お好みで別のキーに割り当てることもできます．
