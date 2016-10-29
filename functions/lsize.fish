function lsize -d 'Show a list of folders, sorted by size'
  sudo du -sh */ 2>/dev/null | sort -hr
end
