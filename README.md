## Rust 開発環境

### 初期設定

`.devcontainer/devcontainer.json`において, remoteUserでユーザ名部分を使用するアカウントに変更しておく。

>    "remoteUser": "ユーザ名",

また環境変数USERIDを設定する。

```
export USERID=`id -u $USER`
```

### Devcontainer

Dockerfileを使ってVSCodeのDevcontainerを構成しています。

### Extensions

下記拡張を`.devcontainer/devcontainer.json`で指定している

+ [CodeLLDB - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb)
+ [crates - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=serayuzgur.crates)
+ [Even Better TOML - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml)
+ [rust-analyzer - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)

### Dockerfile

rust:1.75.0-slim-bullseyeをベースに`clippy`などを導入しています。詳細は`Dockerfile`ないし,次のコマンドで確認してください

```
rustup component list --installed
```

+ locale設定
+ 指定ユーザでのログイン、sudo 環境

### Tips

#### Debug(Linux)

最近のLinuxでは、ASR(アドレス空間レイアウトのランダム化)が有効化されており、スタック、brk ベースのヒープ、メモリーマッピングなどのプロセスの重要な部分のランダム化を行っています。これはデバッグが容易にならないため、VSCode実行前にデバッグ時は無効化を行う。なお下記カーネルパラメータは(ホスト側に準ずる形なので)Dockerコンテナ内では変更できない

```
sudo sysctl -w kernel.randomize_va_space=0
```

有効化は

```
sudo sysctl -w kernel.randomize_va_space=2
```

