## 常用命令
1. sudo nix run --extra-experimental-features 'nix-command flakes' github:world1tree/nixos-config#create-keys
2. sudo nix run --extra-experimental-features 'nix-command flakes' github:world1tree/nixos-config#check-keys
3. sudo nix flake --extra-experimental-features 'nix-command flakes' init -t github:world1tree/nixos-config#starter-with-secrets
4. sudo nix run --extra-experimental-features 'nix-command flakes' github:world1tree/nixos-config#install-with-secrets
5. sudo nixos-rebuild switch --flake .#x86_64-linux --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"


## 手动安装

1. 下载template到home目录下 
``nix flake --extra-experimental-features 'nix-command flakes' init -t github:world1tree/nixos-config#starter``

2. 使用disko进行分区并挂载
``sudo nix run --extra-experimental-features nix-command --extra-experimental-features flakes \
    github:nix-community/disko -- --mode zap_create_mount ./modules/nixos/disk-config.nix``

3. 生成配置文件
``sudo nixos-generate-config --no-filesystems --root /mnt``

4. 安装系统
``cd /mnt/etc/nixos``
``sudo nix flake --extra-experimental-features 'nix-command flakes' init -t github:world1tree/nixos-config#starter``
``sudo nixos-install --flake .#x86_64-linux``
