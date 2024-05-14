1. sudo nix run --extra-experimental-features 'nix-command flakes' github:world1tree/nixos-config#create-keys
2. sudo nix run --extra-experimental-features 'nix-command flakes' github:world1tree/nixos-config#check-keys
3. sudo nix run --extra-experimental-features 'nix-command flakes' init -t github:world1tree/nixos-config#starter-with-secrets
4. sudo nix run --extra-experimental-features 'nix-command flakes' github:world1tree/nixos-config#install-with-secrets
5. sudo nixos-rebuild switch --flake .#x86_64-linux --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
