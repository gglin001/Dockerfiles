# from https://apt.llvm.org/

# one-key install
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# To install a specific version of LLVM:
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 16

# all pkgs
apt-get install clang-format clang-tidy clang-tools clang clangd libc++-dev \
    libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev \
    libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime \
    llvm python3-clang

# mlir
apt-get install libmlir-16-dev mlir-16-tools
apt-get install clang-tools-16

pip install lit
# "MLIR_DIR": "/usr/lib/llvm-16/lib/cmake/mlir",
# "LLVM_EXTERNAL_LIT": "/opt/conda/envs/py38/bin/lit",
