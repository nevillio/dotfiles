# set editor to neovim
export EDITOR="nvim"

# create alias for vim (lazygit)
alias vim='nvim --listen /tmp/nvim-server.pipe'

# set fzf default command
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="fd -tf --strip-cwd-prefix -hidden --follow --exclue .git"
export FZF_ALT_C_COMMAND="fd -td --strip-cwd-prefix -hidden --follow --exclue .git"

# set fzf default options
export FZF_DEFAULT_OPTS="\
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

alias connect_bluetooth="bluetoothctl connect $(get_bluetooth_config 'NIRVANA_ION')"
