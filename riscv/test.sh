touch hello.cpp

cat <<EOF >hello.cpp
#include <iostream>
int main() {
  int a = 101;
  int b = 2;
  int c = a + b;
  std::cout << "c: " << c << "\n";

  std::cout << "Hello World!\n";
  return 0;
}
EOF

clang++ \
  --gcc-toolchain=$RISCV \
  --target=riscv64 -march=rv64gc hello.cpp

# or
# riscv64-unknown-elf-c++ hello.cpp

spike pk a.out
