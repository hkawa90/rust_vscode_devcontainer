## Rust Docker 開発環境

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
    + [User Manual](https://rust-analyzer.github.io/manual.html)

### Dockerfile

`rust:1.75.0-slim-bullseye`をベースに`clippy`などを導入しています。詳細は`Dockerfile`ないし,次のコマンドで確認してください

```
rustup component list --installed
```

+ locale設定
+ 指定ユーザでのログイン、sudo 環境

### Tools

#### Rustfmt

`rustfmt.toml`を参照.

``` title="VSCode設定"
        // formatting
        // "editor.defaultFormatter": "rust-lang.rust-analyzer",
        // "editor.inlayHints.enabled": "off",  
        "editor.formatOnSave": true,
        "editor.formatOnPaste": true,
        "editor.formatOnType": true
```

### VSCode

| Key binding    | Function         |
| -------------- | ---------------- |
| F12            | Go to Definition |
| Ctrl+Shift+F10 | Peek Definition  |
| Shift+F12      | Go to References |
| Shift+Alt+H    | Show Call Hierarchy|
| Ctrl+Shift+O   | Go to Symbol in File|
| Ctrl+T         | Go to Symbol in Workspace|
| Ctrl+.         | Quick Fixes      |
| F2             | Rename Symbol    |
| Ctrl+Shift+I   | Format Document  |
| Ctrl+Shift+P   | Command Palette  |
| Ctrl+,         | Settings editor  |


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

