#!/bin/bash

set -ue

cd sorbet
./bazel build //main:sorbet --config=release-linux --copt=-march=native
cp ./bazel-bin/main/sorbet /opt/app/out
