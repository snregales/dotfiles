# Dotfiles

This repostory holds all of my "." prefix configuration files

## Installation

Before cloning the repo do the following

```bash
git init --bare ${HOME}/dotfiles
alias dotfiles='/usr/bin/git --git-dir=${HOME}/dotfiles/ --work-tree=${HOME}'
```

From here on out you will use the alias to trigger git for this repo.
this alias is later added to the files that you pulled such as .bash_aliases 

```bash
dotfiles config --local status.showUntrackedFiles no
dotfiles remote add origin https://github.com/snregales/dotfiles.git
dotfiles pull origin/main
```