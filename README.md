# openbox-mozc-docker
Simple日本語デスクトップ Dockerファイル

openboxで日本語を表示するだけではなく日本語入力もちゃんとできる環境を構築するのは
結構面倒な作業です。特にDocker環境で使えるものとなるとなかなか大変だと思います。
このDockerファイルは、日本語入力も出来る最低限のデスクトップ環境を構築します。

#### 基本構成
* Base： ubuntu 16.04
* Display： Xvfb
* Desktop： openbox
* Input Method： fcitx-mozc
* Install tools: net-tools firefox emacs git wget curl htop scrot

#### sudoユーザ
* rootではなく,sudo可能なユーザ('ubuntu')でopenboxが起動します。
mozc_serverがrootユーザでは起動しないためです。
* 初期パスワード：ubuntu （自分のPWに変更してください）

#### openboxキー・マウスバインド設定
* WheelでのDesktop移動は劣悪なので無効に設定
* ウインドウタイリングキーバインドを、W-カーソルとW-A-カーソルの２タイプ追加
* rc.xml参照

#### Emacs
* 日本語入力にemacs-mozcを使うになっています。
* melpaとmarmaladeのパッケージ設定、ASCIIフォントにinconsolataを使う設定も行っています。
* .emacsファイル参照

#### VNC
* x11vncとnoVNCの両方に対応しています。docker run起動時に選択可能です。noVNCではSSLオンリーとなっています。
* vncパスワード：ubuntu （自分のPWに変更してください）

#### 使い方
**イメージ作成**
```
$ cd openbox-mozc-docker
$ docker build -t openbox-mozc-docker .
```
**起動 bashの場合**
```
$ docker run --rm -it -p 5901:5901 openbox-mozc-docker
```
* デフォルトではbashが起動します

**起動 x11vncの場合**
```
$ docker run --rm -it -p 5901:5900 openbox-mozc-docker xvnc
```
VNCクライアントから host-ip-addr:5901 にアクセス

**起動 noVNCの場合**
```
$ docker run --rm -it -p 5901:5901 openbox-mozc-docker novnc
```
Browserから https://(host-ip):5901/vnc.html にアクセス
* noVNCの場合コンテナ側のポートが5901になる点に注意してください。

その他細かいことはファイルを覗いてください。
