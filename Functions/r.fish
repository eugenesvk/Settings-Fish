function r -d "Search for text in all files in or below current folder"
  if test (count $argv) -lt 2
    grep $argv[1] -R .                #recursive and following symbolic links
  else
    set argv1 $argv[1]                #save first parameter
    set -e argv[1]                    #delete first parameter
    grep $argv1 $argv -R .
  end
end
