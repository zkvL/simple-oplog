# ═════════════════════════════
# HOOKS
# custom hooks 
# ═════════════════════════════

# Custom hooks for cmd timestamp
simple_oplogs_timestamp_preexec_hook() {
  [[ $SIMPLE_OPLOGS_TIMESTAMP_SHOW == false ]] && return
  
  local 'timestamp_start'
  time_start=$(date +%s)
  if [[ $SIMPLE_OPLOGS_TIMESTAMP_FORMAT != false ]]; then
    timestamp_start="${SIMPLE_OPLOGS_TIMESTAMP_FORMAT}"
  else
    timestamp_start="%D{%Y%m%d_%H%M%S}"
  fi
  # Print start timestamp
  print -P "%F{$SIMPLE_OPLOGS_TIMESTAMP_COLOR}$SIMPLE_OPLOGS_TIMESTAMP_PREFIX_START$timestamp_start$SIMPLE_OPLOGS_TIMESTAMP_SUFFIX_START%f"
}

simple_oplogs_timestamp_precmd_hook() {
  [[ $SIMPLE_OPLOGS_TIMESTAMP_SHOW == false ]] && return

  local 'timestamp_end' 
  time_end=$(date +%s)
  if [[ $SIMPLE_OPLOGS_TIMESTAMP_FORMAT != false ]]; then
    timestamp_end="${SIMPLE_OPLOGS_TIMESTAMP_FORMAT}"
  else
    timestamp_end="%D{%Y%m%d_%H%M%S}"
  fi
  # print end timestamp
  print -P "%F{$SIMPLE_OPLOGS_TIMESTAMP_COLOR}$NEWLINE$SIMPLE_OPLOGS_TIMESTAMP_PREFIX_END$timestamp_end$SIMPLE_OPLOGS_TIMESTAMP_SUFFIX_END%f"
  # add aditional time duration if any
  [[ -z $time_start ]] && return
  time_duration=$(( time_end - time_start ))
  unset time_start
  
  [[ $time_duration -le '1' ]] && return
  print -P "%F{$SIMPLE_OPLOGS_TIMESTAMP_COLOR}  \[ took $time_duration(s) \] %f"
}

update_prompt() {
	# Prompt construction based on robbyrussell
	PROMPT="$NEWLINE$(user)$(dir)$(host) $(git_prompt_info)"
	PROMPT+='$NEWLINE%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}'
	# RPS1='${LYELLOW}[ $(date "+%c") ]%{$reset_color%}'
}