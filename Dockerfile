FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y \
    wget \
    ca-certificates \
    tar && \
    rm -rf /var/lib/apt/lists/*

ENV HUGO_VERSION=0.146.0

RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    tar -xzf hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    mv hugo /usr/local/bin/hugo && \
    chmod +x /usr/local/bin/hugo && \
    rm -f hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz README.md LICENSE


WORKDIR /app

COPY . .

EXPOSE 1313

ENTRYPOINT ["hugo", "server", "--bind", "0.0.0.0", "--appendPort=false", "--disableFastRender", "--buildDrafts", "--buildFuture", "--buildExpired"]

