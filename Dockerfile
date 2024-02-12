FROM ubuntu:20.04

# Based on https://github.com/sorbet/sorbet-build-image

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
      apt-get install --no-install-recommends -y autoconf ca-certificates curl debconf-utils file g++ git gpg-agent jq libgmp-dev libreadline-dev libffi-dev libssl-dev libtinfo-dev libxml2 libyaml-dev make moreutils openssh-client patch pkg-config python ruby rubygems software-properties-common unzip wget xxd xz-utils zip zlib1g-dev && \
      curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
      echo "deb https://deb.nodesource.com/node_14.x bionic main" | tee /etc/apt/sources.list.d/nodesource.list && \
      echo "deb-src https://deb.nodesource.com/node_14.x bionic main" | tee -a /etc/apt/sources.list.d/nodesource.list && \
      curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
      curl -sS https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
      echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-9 main" | tee /etc/apt/sources.list.d/llvm.list && \
      apt-get update && \
      apt-get install --no-install-recommends -y nodejs yarn clang-9 && \
      add-apt-repository --yes ppa:ubuntu-toolchain-r/test && \
      apt-get update && \
      apt-get install --yes --only-upgrade libstdc++6
WORKDIR /opt/app
ADD ./build.sh /opt/app/
