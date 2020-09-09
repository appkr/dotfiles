# dotfiles

Recovery flow

- Install xcode
```bash
$ sudo xcodebuild -license
$ xcode-select --install
```

- Copy ssh keys, aws, kubectl, k9s, gradle configurations

- Make git to use ssh
```bash
$ eval "$(ssh-agent -s)"
$ ssh-add -K ~/.ssh/id_rsa
```

- Run the script
```bash
$ bash bootstrap.sh
```
