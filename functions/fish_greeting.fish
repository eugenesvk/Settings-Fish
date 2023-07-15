function fish_greeting -d 'Prints a greeting on each login'
  set -l system (check_system)
  if test "$system" = "OSX"                                	# macOS greeting
    echo -n (_col blue)"update"(_col_res)                  	"homebrew+OMF"
    echo -n (_col blue) "fish_config"(_col_res)            	","
    echo -n (_col blue) "omf theme"(_col_res)              	","
    echo -n (_col blue) "brew uses --installed X"(_col_res)	","
    echo -n (_col blue) "brew deps X"(_col_res)            	","
    echo -n (_col blue) "brew list --pinned"(_col_res)     	""
    echo ''
  end
  if test "$system" = "Win"
    echo -e "\e[9999;1H"  # scroll to the end of screen buffer to display xterm-256 colors in ConEmu
    echo -n "Update:"                              	""
    echo -n "1."(_col blue) "update-core"(_col_res)	"RESTART!"
    echo -n " 2."(_col blue) "pacman -Su"(_col_res)	""
    echo -n "3."(_col blue) "update"(_col_res)     	"(OMF) ,"
    echo -n     (_col blue) "fish_config"(_col_res)	","
    echo -n     (_col blue) "omf theme"(_col_res)  	""
    echo ''
    echo -n "Search:"                         	""
    echo -n (_col blue)"pacsearch X"(_col_res)	"local/remote with colors"
    echo -n (_col blue) "-Ss"(_col_res)       	"remote(sync)"
    echo -n (_col blue) "-Qs"(_col_res)       	"local"
    echo -n (_col blue) "-Qq╎-Q"(_col_res)    	"list local"
    echo ''
    echo -n "Delete:"                   	""
    echo -n (_col blue)"-Rs X"(_col_res)	"X with stray dependencies"
    echo -n (_col blue) "-Sc"(_col_res) 	"Clean cache"
    echo -n (_col blue) "-Scc"(_col_res)	"inc installed"
    echo ''
    echo -n "Fish:"                      	""
    echo -n (_col blue)"z foo"(_col_res) 	"cd to frecent dir foo"
    echo -n (_col blue) "zi"(_col_res)   	"~ interactively"
    echo -n (_col blue) "sd╎sf"(_col_res)	"interactive dir╎file seletion"
    echo -n (_col blue) "d╎f╎a"(_col_res)	"list frecent dirs╎files╎any"
    echo -n (_col blue) "s"(_col_res)    	"show/search/select"
    echo ''
    echo -n "Node.js version check doesn't work for some reason"	""
    echo ''
    echo -n "Bash:"                     	""
    echo -n (_col blue)"^L"(_col_res)   	"clear screen"
    echo -n "; Mintty:"                 	""
    echo -n (_col blue)"⌥F2"(_col_res)  	"new window"
    echo -n (_col blue) "⌥F3"(_col_res) 	"search text"
    echo -n (_col blue) "⌥F11"(_col_res)	"fullscreen"
    echo ''
  end
  if test "$system" = "Linux"
    echo ''
  end
  if test "$system" = "WinLinux"
   echo ''
  end
  if test "$system" = "OSX" -o "$system" = "WinLinux" -o "$system" = Linux
    echo -n (_col blue)'z foo'(_col_res) 	'cd to frecent dir foo'
    echo -n (_col blue)' zi'(_col_res)   	'~ interactively'
    echo -n (_col blue)' sd╎sf'(_col_res)	'interactive dir╎file seletion'
    echo -n (_col blue)' d╎f╎a'(_col_res)	'list frecent dirs╎files╎any'
    echo -n (_col blue)' s'(_col_res)    	'show/search/select'
    echo ''
    # echo -n (_col blue)'j foo'(_col_res)        	'jump to frecent dir containing foo'
    # echo -n (_col blue)' jc foo'(_col_res)      	'child dir'
    # echo -n (_col blue)' jo/jco music'(_col_res)	'open in a file man (/child dir)'
    # echo -n (_col blue)' j work in'(_col_res)   	'multiple dirs'
    # echo -n (_col blue)' j -s'(_col_res)        	'show DB'
    # echo ''
    echo -n -s (_col blue)'pyenv migrate V1 V2'(_col_res)	','
    echo -n -s (_col blue)' ff'(_col_res)                	' find files in/below'
    echo ''
    echo -n 'fzf: '(_col blue)'**'(_col_res)    	'trigger'
    echo -n (_col blue)' ⌥z╎^↓'(_col_res)       	'cd'
    echo -n (_col blue)' ⌥f'(_col_res)          	'paste dir'
    echo -n (_col blue)' ⌥⇧↑'(_col_res)         	'history'
    echo -n (_col blue)' ^╎.md\$'(_col_res)     	'pre╎suf-fix'
    echo -n (_col blue)" 'exact'"(_col_res)     	''
    echo -n (_col blue)" !fire╎!.md\$"(_col_res)	'inverse'
    echo ''
  end
  if test "$system" = NA
   echo ''
  end
end

function _col -d "Set Color, 'name b u' bold, underline"
  set -l col; set -l bold; set -l under
  if [ -n "$argv[1]" ];       set col   $argv[1]; end
  if [ (count $argv) -gt 1 ]; set bold  "-"(string replace b o $argv[2] 2>/dev/null); end
  if [ (count $argv) -gt 2 ]; set under "-"$argv[3]; end
  set_color $bold $under $argv[1]
end
function _col_res -d "Rest background and foreground colors"
  set_color -b normal
  set_color normal
end
