# simple-oplog

## Description

simple-oplog is a basic theme for oh-my-zsh which was thought for terminal operators who need to keep track of issued commands timestamps in order to fill in activities logs or for any deconfliction process. It implements some ideas from [Spaceship](https://github.com/denysdovhan/spaceship-prompt.git) & [powerlevel](https://github.com/Powerlevel9k/powerlevel9k.git) (in a very basic form) which are really mature and comprehensive themes to use.

## Install

`oh-my-zsh` must be installed in advance and `$ZSH_CUSTOM` correctly configured

```bash
$ sh -c ""$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$ echo $ZSH_CUSTOM
$HOME/.oh-my-zsh/custom
```

```bash
git clone https://github.com/zkvL/simple-oplog "$ZSH_CUSTOM/themes/simple-oplog"
ln -s "$ZSH_CUSTOM/themes/simple-oplog/simple-oplog.zsh-theme" "$ZSH_CUSTOM/themes/simple-oplog.zsh-theme"

# Set ZSH_THEME="simple-oplog" in your .zshrc & reload terminal
```

## Options

The intent of this theme is to use configuration variables such as Spaceship does. The default ones are:

```bash
SIMPLE_OPLOG_TIMESTAMP_SHOW="${SIMPLE_OPLOG_TIMESTAMP_SHOW=false}"
SIMPLE_OPLOG_TIMESTAMP_FORMAT="${SIMPLE_OPLOG_TIMESTAMP_FORMAT=false}"
SIMPLE_OPLOG_TIMESTAMP_COLOR="${SIMPLE_OPLOG_TIMESTAMP_COLOR="015"}"

SIMPLE_OPLOG_TIMESTAMP_PREFIX_START="${SIMPLE_OPLOG_TIMESTAMP_PREFIX_START="┌─[ "}"
SIMPLE_OPLOG_TIMESTAMP_SUFFIX_START="${SIMPLE_OPLOG_TIMESTAMP_SUFFIX_START=" - Start ]"}"
SIMPLE_OPLOG_TIMESTAMP_PREFIX_END="${SIMPLE_OPLOG_TIMESTAMP_PREFIX_END="└─[ "}"
SIMPLE_OPLOG_TIMESTAMP_SUFFIX_END="${SIMPLE_OPLOG_TIMESTAMP_SUFFIX_END=" - End   ]"}"
```

Plus some color definitions.

When `SIMPLE_OPLOG_TIMESTAMP_FORMAT`is set to false, the default timestamp format is **%Y%m%d_%H%M%S** but it can be adjusted as needed for the operator according to the specific needs by changing the `false `value for the date format.

Finally, the theme offers some little commands for initiate or stop printing timestamps; ` SIMPLE_OPLOG_TIMESTAMP_ON` & ` SIMPLE_OPLOG_TIMESTAMP_OFF`will do the trick.



![](./render/simple-oplog.gif)

