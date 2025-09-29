# Use a base image; Ubuntu 22.04 is a good choice
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools and dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
      software-properties-common \
      build-essential \
      wget \
      curl \
      gnupg \
      ca-certificates \
      unzip \
      git \
      pkg-config \
      libssl-dev \
      libreadline-dev \
      libffi-dev \
      zlib1g-dev \
      libbz2-dev \
      libncurses5-dev \
      libsqlite3-dev \
      libgdbm-dev \
      liblzma-dev \
      uuid-dev \
      openssl \
      squashfs-tools \
      libgpgme-dev \
      openjdk-17-jdk \
      && rm -rf /var/lib/apt/lists/*

# Install Python 3.12 via deadsnakes PPA
RUN add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      python3.12 \
      python3.12-venv \
      python3.12-dev \
      python3-pip \
      && rm -rf /var/lib/apt/lists/*

# Ensure python3.12 is available as python3, optionally python
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1 && \
    # Optionally set python alias to python3
    ln -s /usr/bin/python3 /usr/bin/python || true

# Install Node.js & npm (LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Nextflow
ENV NXF_VERSION=25.07.0-edge
RUN curl -fsSL https://get.nextflow.io | bash && \
    mv nextflow /usr/local/bin/ && \
    chmod +x /usr/local/bin/nextflow

# Install Apptainer (formerly Singularity)
ENV APPTAINER_VERSION=1.4.2
RUN apt-get update && apt-get install -y --no-install-recommends wget && \
    cd /tmp && \
    wget https://github.com/apptainer/apptainer/releases/download/v${APPTAINER_VERSION}/apptainer_${APPTAINER_VERSION}_amd64.deb && \
    dpkg -i apptainer_${APPTAINER_VERSION}_amd64.deb || apt-get -f install -y && \
    rm apptainer_${APPTAINER_VERSION}_amd64.deb && \
    wget https://github.com/apptainer/apptainer/releases/download/v${APPTAINER_VERSION}/apptainer-suid_${APPTAINER_VERSION}_amd64.deb && \
    dpkg -i apptainer-suid_${APPTAINER_VERSION}_amd64.deb || apt-get -f install -y && \
    rm apptainer-suid_${APPTAINER_VERSION}_amd64.deb && \
    rm -rf /var/lib/apt/lists/*


RUN npm install -g @anthropic-ai/claude-code

WORKDIR /workspace

ENV PATH="/usr/local/bin:${PATH}"

CMD [ "bash" ]

