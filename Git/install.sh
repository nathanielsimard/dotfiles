git config --global alias.st status
git config --global alias.ch checkout
git config --global alias.co commit
git config --global alias.aa 'add --all'
git config --global alias.rh 'reset --hard'
git config --global alias.update 'pull --rebase'
git config --global alias.rewrite 'commit --amend --no-edit'
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset' --abbrev-commit --date=relative --all"
git config --global credential.helper 'cache --timeout 28800'
