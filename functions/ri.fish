function ri -d "Search for text in all files in or below current folder (case-insensitive)"
  grep -R -i $argv .             #recursive and following symbolic links, case-insensitive
end
