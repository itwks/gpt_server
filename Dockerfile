FROM continuumio/miniconda3:main


COPY ./ /gpt_server

WORKDIR /gpt_server


RUN pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple && \
    sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
    conda config --set show_channel_urls yes && \
    echo "开始安装cudnn" && conda install -y cudnn && \
    # echo "开始安装cudatoolkit" && conda install -y cudatoolkit && \
    pip install -r requirements.txt  && pip cache purge

CMD ["/bin/bash"]