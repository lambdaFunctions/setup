# SETUP

## TERMINAL

### CUSTOM .zshrc
- Content of `.zshrc`:
```sh
## NEOVIM

export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

alias vim="nvim"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

## PYTHON

# PYENV
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Poetry
export PATH="/Users/paulo/.local/bin:$PATH"

### ALIASES

alias ll="ls -l"
```

### TABBY
###### ref: https://tabby.sh/

- Font: Courier New 14
- Settings: `Appearence -> Allow font ligature`
    > Para mostrar os icones do Yazi
- Color Scheme: Brogrammer
- Notas:
    - Adicionar atalho para resize de splitted windows

### OH MY ZSH
###### ref: https://ohmyz.sh/

- Tema: paulo
- Content of `paulo.zsh-theme` in `~/.oh-my-zsh/themes`:
```sh
function git_last_commit() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    local commit=$(git log -1 --pretty=format:'%h' 2>/dev/null)
    echo "[%{$fg[yellow]%}${commit}%{$reset_color%}]"
  fi
}

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
  PROMPT='%{$fg[green]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%} %{$fg[white]%}%3~%{$reset_color%}$(git_prompt_info)$(git_last_commit)
λ '
    ZSH_THEME_GIT_PROMPT_PREFIX=" [%{$fg[green]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    # display exitcode on the right when >0
    return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

    RPROMPT='${return_code}$(git_prompt_status)%{$reset_color%}'

    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
else
    PROMPT='[%n@%m:%~$(git_prompt_info)]
λ '

    ZSH_THEME_GIT_PROMPT_PREFIX=" on"
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    # display exitcode on the right when >0
    return_code="%(?..%? ↵)"

    RPROMPT='${return_code}$(git_prompt_status)'

    ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
    ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
    ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"
fi
```


## NEOVIM

### Installation and Setup
Just copy the `nvim/` folder to your `~/.config/`

### Plugin Manager
###### ref: https://github.com/junegunn/vim-plug/wiki/tutorial

All the installed plugins are listed in the `init.lua`

#### LSP Details
###### ref: List of LSP server names: https://github.com/mattn/vim-lsp-settings
###### ref: Neovim LSP config doc: https://neovim.io/doc/user/lsp.html
###### ref: List of LSP config for each language: https://github.com/neovim/nvim-lspconfig/blob/master/plugin/lspconfig.lua

**Steps**
- 1: Install the language server in in the machine (`brew install language-server-here` for example)
- 2: Creat the `language-server.lua` file in the `/lsp` folder
- 3: Use the `vim.lsp.enable("language-server-here")

### COLOR SCHEME
The color scheme used is customized by me for VSCode, so to use it in nvim we need to convert it into nvim syntax. Use https://github.com/viniciusmuller/djanho# project for that.

## AEROSPACE
###### ref: https://github.com/nikitabobko/AeroSpace

- Gaps settings:
[gaps]
inner.horizontal = 7
inner.vertical =   7
outer.left =       15
outer.bottom =     5
outer.top =        5
outer.right =      15


## YAZI
###### ref: https://www.josean.com/posts/how-to-use-yazi-file-manager
###### ref: https://www.youtube.com/watch?v=iKb3cHDD9hw

### Global Installation and Setup

```sh
brew install yazi ffmpegthumbnailer ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font
``

Paste in /zshrc:
```sh
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
```

### Theme
Install the theme:
```sh
ya pkg add gosxrgxx/flexoki-dark
```

Paste the theme name in `.config/yazi/theme.toml`:
[flavor]
dark = "flexoki-dark"


## FUZZY FINDER
- fzf: brew install fzf


## DOCKER
- Docker
- Lazydocker: https://github.com/jesseduffield/lazydocker

## GIT
- Git
- Lazygit: https://github.com/jesseduffield/lazygit


## PROGRAMMING
- Pyenv
- Rust


## CHECK LATER
- Neovim:
    - Markdown: https://linkarzu.com/posts/neovim/markdown-setup-2024/
    - Markdown Preview: https://github.com/iamcco/markdown-preview.nvim

