function vim -w nvim -d "Run Neovim and then restore cursor shape to beam"
  nvim $argv
  printf '\033]50;CursorShape=1\x7'
end
