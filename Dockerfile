# ベースイメージの指定
FROM python:3.10

# 作業ディレクトリの指定
WORKDIR /home/ec2-user

# SSHキーファイルのコピー
COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub


# SSH設定ファイルの更新
RUN chmod 600 /root/.ssh/id_rsa
RUN chmod 644 /root/.ssh/id_rsa.pub
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# SSHエージェントの起動
RUN eval $(ssh-agent -s) && \
    ssh-add /root/.ssh/id_rsa

# GitHubからのクローン
RUN git clone git@github.com:atsushimemet/boxing-gym-exper-lesson-reserve-sys.git
WORKDIR /home/ec2-user/boxing-gym-exper-lesson-reserve-sys

# local_settings.pyのコピー
COPY config/local_settings.py ./config/local_settings.py

# poetryインストール
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    # シンボリックによるpathへのpoetryコマンドの追加
    cd /usr/local/bin && \
    ln -s /root/.local/bin/poetry && \
    # 仮想環境を作成しない設定(コンテナ前提のため，仮想環境を作らない)
    poetry config virtualenvs.create false

# ライブラリインストール
RUN poetry install --no-dev

# Django migrate
RUN python manage.py makemigrations
RUN python manage.py migrate

# Djangoサーバーの起動
CMD python manage.py runserver 3.112.19.213:80
