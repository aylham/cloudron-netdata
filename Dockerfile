FROM cloudron/base:4.2.0@sha256:46da2fffb36353ef714f97ae8e962bd2c212ca091108d768ba473078319a47f4

ARG VERSION=1.44.1

RUN apt update && apt upgrade -y
RUN apt install -y --no-install-recommends \
    libmongoc-1.0-0 \
    zlib1g-dev \
    uuid-dev \
    libuv1-dev \
    liblz4-dev \
    libssl-dev \
    libelf-dev \
    libmnl-dev \
    libprotobuf-dev \
    protobuf-compiler \
    gcc \
    g++ \
    make \
    git \
    autoconf \
    autoconf-archive \
    autogen \
    automake \
    pkg-config \
    curl \
    python2 \
    python3 \
    cmake && \
    rm -rf /var/cache/apt /var/lib/apt/lists

RUN git clone https://github.com/netdata/netdata.git --recursive --single-branch --branch v$VERSION
WORKDIR netdata
RUN chmod +x netdata-installer.sh && \
    ./netdata-installer.sh --dont-wait --disable-cloud --dont-start-it --disable-ebpf --install-no-prefix /
RUN mv packaging/docker/run.sh /sbin/ && mv packaging/docker/health.sh /sbin/

COPY start.sh /bin/start.sh
COPY netdata.conf /etc/netdata/netdata.conf

#ENTRYPOINT ["/usr/sbin/run.sh"]
ENTRYPOINT ["/bin/start.sh"]

HEALTHCHECK --interval=60s --timeout=10s --retries=3 CMD /usr/sbin/health.sh
