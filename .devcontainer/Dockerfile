FROM rust:1.75.0-slim-bullseye AS base

# required args, see README
ARG user
ARG userid

RUN test -n "$user"
RUN test -n "$userid"

# add same user
RUN groupadd -r $user && useradd -r -m -u $userid -g $user $user

RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get -y install git sudo locales-all
# [日本語が使えるようにDockerfileでロケール関連の設定をする #Docker - Qiita](https://qiita.com/yuri_t/items/a927744770d0be9f7aca)
ENV LANG ja_JP.UTF-8


# Update check
RUN rustup self update
RUN rustup update

# コンポーネントの追加
# [インストール後にrustupを使ってすること｜WindowsでRustの開発環境を構築する(not on WSL)/おまけのみ有料](https://zenn.dev/suauiya/books/ef2d2c67c546361e4518/viewer/4bc94a19cf74da37bf8f)
# clippy: rust公式リンター。変数名のルールとかdocコメント抜けとかいろいろチェックしてくれます。
# rls: rust language server. VSCodeでrust-analyzer拡張を使う場合はいらないと思います。No longer supported - つまりもうサポートされていないのですが、念のため。
# rust-analysis: 標準ライブラリのメタデータ、らしい
# rust-src: Rustにおける標準ライブラリのソースコードのローカルコピー。rust-analyzerとかrlsで使用される。
# rust-docs: 公式のRustドキュメンテーションのローカルコピー。要するに、これを入れておくとrustup docコマンドからローカルで公式ドキュメントが開ける。
# rustfmt: fmtという語尾の通り、フォーマッタ。
# rust-analyzer: 新しいrustのlanguage serverです。VSCode以外でいる場合に備えて追加しておくといいかと。
# コマンドで一覧を見ることができます:rustup component list --installed
RUN rustup component add clippy rls rust-analysis rust-src rust-docs rustfmt rust-analyzer

RUN echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $user
