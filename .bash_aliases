# set editor to neovim
export EDITOR="nvim"

# create alias for vim (lazygit)
alias vim='nvim --listen /tmp/nvim-server.pipe'

# set fzf default command
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git,node_modules"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -td --strip-cwd-prefix --hidden --follow --exclude .git,node_modules"

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
  --height 40% \
  --tmux bottom,40% \
"
# Change trigger sequence from ** to ~~
export FZF_COMPLETION_TRIGGER='~~'

alias tmux="tmux -u"
