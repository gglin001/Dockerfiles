based on
https://github.com/graphcore/popart/blob/sdk-release-2.4/build_scripts/Dockerfile


cmake config

-DCMAKE_INSTALL_PREFIX=install \
-DBOOST_DIR=/workspace/libs/third-party/boost_1_70_0/install_dir \
-DBoost_INCLUDE_DIR=/workspace/libs/third-party/boost_1_70_0/install_dir/include \
-DCapnProto_ROOT=/workspace/libs/third-party/capnproto-c++-0.7.0/install_dir \
-DONNX_DIR=/workspace/libs/third-party/onnx-1.6.0/install_dir/share/cmake/ONNX \
-DProtobuf_ROOT=/workspace/libs/third-party/protobuf-3.6.1/install_dir \
-DProtobuf_INCLUDE_DIR=/workspace/libs/third-party/protobuf-3.6.1/install_dir/include \
-Dpybind11_ROOT=/workspace/libs/third-party/pybind11-2.6.2/install_dir \
-Dspdlog_ROOT=/workspace/libs/third-party/spdlog-1.8.0/install_dir \
-Dtrompeloeil_ROOT=/workspace/libs/third-party/trompeloeil-35/install_dir \

-DPOPLAR_INSTALL_DIR=${workspaceFolder}/sdk/poplar_sdk/poplar-ubuntu_18_04-3.0.0+6832-93574d0177 \

for
pip install pybind11==2.6.0
-Dpybind11_ROOT=/usr/local/lib/python3.6/dist-packages/pybind11
