nixとhome-managerをがんばって入れる

```
cd ~
git clone https://github.com/miyamoen/nixfiles.git
ln -s ~/nixfiles/nixpkgs ~/.config/nixpkgs
ln -s ~/nixfiles/nix ~/.config/nix
home-manager switch
```