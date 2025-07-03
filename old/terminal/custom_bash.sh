####################################### CUSTOM PROMPT

# CUSTOM BASH

# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
     ORANGE="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
       CYAN="\[\033[1;36m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
    PROMPT_SYMBOL="${WHITE} λ{COLOR_NONE}"
}

# Determine active Python virtualenv details.
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${WHITE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE}"
  fi
}

# Set Git Branch
parse_git_branch() {
    # GIT_BRANCH="${WHITE}[`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'`]"
    GIT_BRANCH="${WHITE}[`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`]"
}

# Set git HEAD commit hash
parse_rev_parse() {
    GIT_COMMIT_HASH="${WHITE}(`git rev-parse --short HEAD 2>/dev/null`)"
}

# Echo out all the color choices for posterity
function echo_colors() {
    echo -e "${RED}RED${COLOR_NONE}"
    echo -e "${LIGHT_RED}LIGHT_RED${COLOR_NONE}"
    echo -e "${ORANGE}ORANGE${COLOR_NONE}"
    echo -e "${YELLOW}YELLOW${COLOR_NONE}"
	echo -e "${GREEN}GREEN${COLOR_NONE}"
    echo -e "${LIGHT_GREEN}LIGHT_GREEN${COLOR_NONE}"
	echo -e "${BLUE}BLUE${COLOR_NONE}"
	echo -e "${CYAN}CYAN${COLOR_NONE}"
    echo -e "${WHITE}WHITE${COLOR_NONE}"
    echo -e "${LIGHT_GRAY}LIGHT_GRAY${COLOR_NONE}"
}

# Set the full bash prompt.
function set_bash_prompt () {
    # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
    # return value of the last command.
    set_prompt_symbol $?

    # Set the PYTHON_VIRTUALENV variable.
    set_virtualenv

    # Set commit hash HEAD.
    parse_rev_parse

    # Set git branch.
    parse_git_branch

    # Set the bash prompt variable.
    PS1="

${PYTHON_VIRTUALENV} ${GREEN}\u@\h ${CYAN}\w${COLOR_NONE} ${GIT_COMMIT_HASH} ${GIT_BRANCH}
${PROMPT_SYMBOL} "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt

