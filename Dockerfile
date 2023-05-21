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

# poetryインストール
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    # シンボリックによるpathへのpoetryコマンドの追加
    cd /usr/local/bin && \
    ln -s /root/.local/bin/poetry && \
    # 仮想環境を作成しない設定(コンテナ前提のため，仮想環境を作らない)
    poetry config virtualenvs.create false

# Djangoサーバーの起動
RUN poetry install --no-dev
CMD python manage.py runserver 0.0.0.0:8000
