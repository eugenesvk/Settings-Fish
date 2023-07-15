function rs -w grep -d "Search for text in all files in or below current folder"
  grep -R $argv .                #recursive and following symbolic links
end
