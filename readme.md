# dotfiles

### Things to backup

- project files
- ssh keys, aws, kubectl, k9s, gradle configurations
- docker images, database connections

### Recovery flow

- Install xcode
```bash
$ sudo xcodebuild -license
$ xcode-select --install
```

- Copy files from the backup, including ssh keys

- Make git to use ssh
```bash
$ eval "$(ssh-agent -s)"
$ ssh-add -K ~/.ssh/id_rsa
```

- Clone the repo & run the script
```bash
$ git clone git@github.com:appkr/dotfiles.git
$ bash bootstrap.sh
```

### Trouble shooting

Q. If the following message appears, when running iterm
```bash
[oh-my-zsh] Insecure completion-dependent directories detected:
drwxrwxr-x   7 juwon.kim  admin  224 10  5 21:31 /usr/local/share/zsh
drwxrwxr-x  10 juwon.kim  admin  320 10  5 21:36 /usr/local/share/zsh/site-functions
```
A. Change the permission of the dirs
```bash
$ chmod 755 /usr/local/share/zsh /usr/local/share/zsh/site-functions
```

Q. If the iterm prompt is broken like the following
```bash
~/dotfiles   master 
```
A. Change the font and its size
![](iterm-font.png)
