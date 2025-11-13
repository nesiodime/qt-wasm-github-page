#!/usr/bin/env bash
set -e

source /opt/emsdk/emsdk_env.sh

mkdir -p build
cd build
/qtbase/bin/qt-cmake .. -DCMAKE_INSTALL_PREFIX=/artifacts
cmake --build . --parallel $(nproc)
