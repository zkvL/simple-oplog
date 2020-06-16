#
# Simple Oplogs Prompt
# ZSH Theme
# 
# author	: Yael - @zkvL7
# github 	: https://github.com/zkvL7/simple-oplogs-prompt
# license	: MIT
# version 	: 0.9-beta
#
# adding two hooks internals, based on:
# https://github.com/ohmyzsh/ohmyzsh/wiki/Customization#overriding-and-adding-themes

# ═════════════════════════════
# INITIAL STEPS
# ═════════════════════════════
# Determine working dir based on powerlevel theme
# https://github.com/Powerlevel9k/powerlevel9k
if [[ -z "$SIMPLE_OPLOGS_DIR" ]]; then
  if [[ "${(%):-%N}" == '(eval)' ]]; then
    if [[ "$0" == '-antigen-load' ]] && [[ -r "${PWD}/simple-oplogs.zsh-theme" ]]; then
      # Antigen uses eval to load things so it can change the plugin (!!)
      # https://github.com/zsh-users/antigen/issues/581
      export SIMPLE_OPLOGS_DIR=$PWD
    else
      print -P "%F{red}You must set SIMPLE_OPLOGS_DIR to work from within an (eval).%f"
      return 1
    fi
  else
    # Get the path to file this code is executing in; then
    # get the absolute path and strip the filename.
    # See https://stackoverflow.com/a/28336473/108857
    export SIMPLE_OPLOGS_DIR=${${(%):-%x}:A:h}
  fi
fi

# ═════════════════════════════
# CONFIGURATION
# ═════════════════════════════
# Define some variables for later use
WHITE="%F{255}"
RED="%F{001}"
BLUE="%F{006}"
YELLOW="%F{003}"
LYELLOW="%F{011}"
GREEN="%F{002}"
LGREY="%F{015}"

# New line separator
NEWLINE='
'

# Load custom hooks for timestamping
source "$SIMPLE_OPLOGS_DIR/lib/hooks.zsh"


# Default configuration for timestamping based on Spaceship API
# https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/API.md
SIMPLE_OPLOGS_TIMESTAMP_SHOW="${SIMPLE_OPLOGS_TIMESTAMP_SHOW=false}"
SIMPLE_OPLOGS_TIMESTAMP_FORMAT="${SIMPLE_OPLOGS_TIMESTAMP_FORMAT=false}"
SIMPLE_OPLOGS_TIMESTAMP_COLOR="${SIMPLE_OPLOGS_TIMESTAMP_COLOR="015"}"

SIMPLE_OPLOGS_TIMESTAMP_PREFIX_START="${SIMPLE_OPLOGS_TIMESTAMP_PREFIX_START="┌─[ "}"
SIMPLE_OPLOGS_TIMESTAMP_SUFFIX_START="${SIMPLE_OPLOGS_TIMESTAMP_SUFFIX_START=" - Start ]"}"
SIMPLE_OPLOGS_TIMESTAMP_PREFIX_END="${SIMPLE_OPLOGS_TIMESTAMP_PREFIX_END="└─[ "}"
SIMPLE_OPLOGS_TIMESTAMP_SUFFIX_END="${SIMPLE_OPLOGS_TIMESTAMP_SUFFIX_END=" - End   ]"}"

# Start / Stop timestamp function
alias SIMPLE_OPLOGS_TIMESTAMP_ON='SIMPLE_OPLOGS_TIMESTAMP_SHOW=true && source ~/.zshrc'
alias SIMPLE_OPLOGS_TIMESTAMP_OFF='SIMPLE_OPLOGS_TIMESTAMP_SHOW=false && source ~/.zshrc'

# ═════════════════════════════
# PROMPT CREATION
# ═════════════════════════════
user() {
    if [[ $USER == 'root' ]]; then
      print -P "%{%B%}$RED%n%{%b%}%{$reset_color%}"
    else
      print -P "%{%B%}$YELLOW%n%{%b%}%{$reset_color%}"
    fi
}

host() {
    if [[ -n $SSH_CONNECTION ]]; then
      print -P "%{$reset_color%} at %{%B%}$BLUE%m%{$reset_color%}%{%b%}"
    else
      print -P "%{$reset_color%} at %{%B%}$GREEN%m%{$reset_color%}%{%b%}"
    fi
}

dir() {
	print -P "%{$reset_color%} in %{%B%}$BLUE%c%{$reset_color%}%{%b%}"
}

prompt_setup() {
	# Add hooks for execution
	autoload -Uz add-zsh-hook
	add-zsh-hook preexec simple_oplogs_timestamp_preexec_hook
  	add-zsh-hook precmd simple_oplogs_timestamp_precmd_hook

  	add-zsh-hook chpwd update_prompt

  	# Prompt construction based on robbyrussell
	PROMPT="$NEWLINE$(user)$(dir)$(host) $(git_prompt_info)"
	PROMPT+='$NEWLINE%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}'
	# RPS1='${LYELLOW}[ $(date "+%c") ]%{$reset_color%}'

	ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}on%{$fg_bold[blue]%} git:(%{$fg[red]%}"
	ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
	ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
	ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
}

# ═════════════════════════════
# ENTRY POINT
# ═════════════════════════════

prompt_setup "$@"