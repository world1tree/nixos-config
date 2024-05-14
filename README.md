1. sudo nix run --extra-experimental-features 'nix-command flakes' github:world1tree/nixos-config#create-keys
2. sudo nix run --extra-experimental-features 'nix-command flakes' github:world1tree/nixos-config#check-keys
3. sudo nix run --extra-experimental-features 'nix-command flakes' init -t github:world1tree/nixos-config#starter-with-secrets
