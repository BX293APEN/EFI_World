sudo apt install nasm binutils-mingw-w64-x86-64


nasm -f win64 hello.asm -o hello.obj


x86_64-w64-mingw32-ld \
  -nostdlib \
  -dll \
  --subsystem 10 \
  --image-base 0 \
  -e efi_main \
  -o BOOTX64.EFI \
  hello.obj
  
  
mkdir -p EFI/BOOT
mv BOOTX64.EFI EFI/BOOT/


FAT32
セキュアブート無効化
