# アセンブリ言語でUEFIアプリケーションを作成する


## 起動USBメモリをFAT32でフォーマット
```bash
sudo fdisk -l                                                                           # ターゲットUSBのパーティションを確認
sudo umount /dev/[ターゲットUSBのパーティション]
sudo mkfs.vfat -F 32 /dev/[ターゲットUSBのパーティション]
sudo mount /dev/[ターゲットUSBのパーティション] [ターゲットUSBをマウントするフォルダのパス]
```

## 必要なパッケージをインストール

```bash
sudo apt install nasm binutils-mingw-w64-x86-64
```

## アセンブリファイルをアセンブルする
```bash
nasm -f win64 hello.asm -o hello.obj
```

## リンカでEFIファイルを作成する
```bash
x86_64-w64-mingw32-ld \
    -nostdlib \
    -dll \
    --subsystem 10 \
    --image-base 0 \
    -e efi_main \
    -o BOOTX64.EFI \
    hello.obj
```

- `-nostdlib`       : 標準ライブラリをリンクしない  
- `-dll`            : DLL形式で出力する  
- `--subsystem 10`  : UEFIアプリケーションとして指定  
- `--image-base 0`  : イメージベースアドレスを0に設定  
- `-e efi_main`     : エントリーポイント(メイン関数)を`efi_main`に指定  
- `-o BOOTX64.EFI`  : 出力ファイル名をBOOTX64.EFIに指定  

# EFIファイルを指定位置に配置する
```bash
mkdir -p EFI/BOOT
mv BOOTX64.EFI EFI/BOOT/
```

## BIOS設定
- セキュアブート無効化(又はPKを削除)
