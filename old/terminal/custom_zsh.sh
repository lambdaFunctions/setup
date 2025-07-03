################# CUSTOM ZSH

function set_dir_path() {
  # echo ${COLOR_DIR}$(set_dir_path)
  # echo %3~
  echo ${COLOR_DIR}'%25<...<%~%<<'
}

function set_git_info() {
  function parse_git_branch() {
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]];
      then
        :
      else
        echo '['$branch']'
    fi
  }

  function parse_git_last_commit() {
    if [ -d .git ];
      then
        git log -1 --pretty=oneline | cut -c -8
    fi
  }

  echo ${COLOR_GIT}$(parse_git_last_commit) ${COLOR_GIT}$(parse_git_branch)
}

function set_symbol() {
  echo 'λ'
}

function set_bash_prompt() {
  COLOR_DEF=$'%f'
  COLOR_USR=$'%f'
  COLOR_DIR=$'%F{36}'
  COLOR_GIT=$'%f'
  setopt PROMPT_SUBST

export PROMPT='${COLOR_USR}%n $(set_dir_path) $(set_git_info)
${COLOR_DEF}$(set_symbol) '
}

set_bash_prompt


################# NEOVIM

export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

################# PYTHON

# PYENV
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Poetry
export PATH="/Users/paulo/.local/bin:$PATH"
