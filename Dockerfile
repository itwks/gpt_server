# FROM docker.1ms.run/506610466/cuda:12.2.2-runtime-ubuntu20.04-uv
FROM 506610466/cuda:12.2.2-devel-ubuntu20.04-uv
# 从基础镜像开始构建，加快构建速度
# FROM 506610466/gpt_server:base
RUN apt-get update -y && apt-get install -y numactl build-essential && rm -rf /var/lib/apt/lists/*
COPY ./ /gpt_server
WORKDIR /gpt_server
# RUN uv sync && uv cache clean
ENV UV_HTTP_TIMEOUT=120 CUDA_HOME=/usr/local/cuda-12.2
RUN uv venv --seed && uv sync && uv cache clean && \
    echo '[[ -f .venv/bin/activate ]] && source .venv/bin/activate' >> ~/.bashrc
ENV PATH=/gpt_server/.venv/bin:$PATH

CMD ["/bin/bash"]