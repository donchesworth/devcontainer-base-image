ARG PYTHON_VERSION=38
ARG OS_PLATFORM=ubi8
FROM registry.redhat.io/${OS_PLATFORM}/python-${PYTHON_VERSION}

# Labels
LABEL org.opencontainers.image.authors="Don Chesworth <donald.chesworth@gmail.com>"
LABEL org.opencontainers.image.url="https://github.com/donchesworth/devcontainer-base-image"
LABEL org.opencontainers.image.source="https://github.com/donchesworth/devcontainer-base-image"
LABEL org.opencontainers.image.version="py38-ubi8"

# Install gcc, postgres, conda
ENV PATH="/opt/conda/envs/py38/bin:/opt/conda/bin:$PATH"
RUN yum install -y wget gcc gcc-c++ glibc-devel make postgresql-devel && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    chmod +x ~/miniconda.sh &&  ~/miniconda.sh -b -p /opt/conda && conda update conda

# conda package installs
RUN conda create -n py38 python=3.8 && \

# Setup working dir
WORKDIR /opt/py38
RUN chgrp -R 0 /opt/py38/ && \
    chmod -R g+rwX /opt/py38/

