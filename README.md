# Dotfiles

This repostory holds all of my "." prefix configuration files

## Installation

### Bare git repo
If you don't wish to do symbolic links everywhere, then follow these instructions

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

### Linking

Otherwise run link_them.sh after cloning the repository.

### Devcontainers

Visual Studio Code (vscode) offers the ability to create containers for code development.
This presents a beautiful opportunity to create catered IDE profile that can presist.

Thus one can add the following to their devcontainer.json in order to conistant shell accross all projects.

```json
	"settings": {
		"terminal.integrated.defaultProfile.linux": "zsh",
		"dotfiles.repository": "snregales/dotfiles",
		"dotfiles.targetPath": "~/dotfiles",
		"dotfiles.installCommand": "devcontainer.sh",
        ...
    }
```

