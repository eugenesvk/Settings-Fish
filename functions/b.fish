function b -w brew -d "Aliases for macOS/Linux Homebrew brew function, simplifying syntax"
	# $argv[2..-1] returns all arguments from the second to the last.
	# -w wraps in another command, inhereting completions
	set argv_c (count $argv)
	if test $argv_c -lt 2 # zero or 1 argument
		if      test -z "$argv"       	; brew
		else if test "$argv[1]" = "u" 	; echo "Update the formulae and Homebrew itself & Upgrade"	; brew update; brew upgrade
		else if test "$argv[1]" = "c" 	; echo "Cleanup"                                          	; brew cleanup
		else if test "$argv[1]" = "l" 	; echo "List installed:"                                  	; brew list
		else if test "$argv[1]" = "li"	; echo "List installed:"                                  	; brew list
		else if test "$argv[1]" = "lp"	; echo "List pinned:"                                     	; brew list --pinned
		else if test "$argv[1]" = "lv"	; echo "List with versions:"                              	; brew list --versions
		else; brew $argv # pass arguments through
		end
	else if test $argv_c -ge 2 # 2 or more arguments
		if      test "$argv[1]" = "a"  	; echo "Install $argv[2..-1]"	; brew install  	$argv[2..-1]	# match first argument
		else if test "$argv[1]" = "i"  	; echo "Install $argv[2..-1]"	; brew install  	$argv[2..-1]
		else if test "$argv[1]" = "r"  	; echo "Remove $argv[2..-1]" 	; brew uninstall	$argv[2..-1]
		else if test "$argv[1]" = "s"  	; echo "Search $argv[2..-1]" 	; brew search   	$argv[2..-1]
		else if test "$argv[1]" = "f"  	; echo "Search $argv[2..-1]" 	; brew search   	$argv[2..-1]
		else if test "$argv[1]" = "inf"	; echo "Show $argv[2..-1]"   	; brew info     	$argv[2..-1]
		else if test "$argv[1]" = "p"  	; echo "Pin $argv[2..-1]"    	; brew pin      	$argv[2..-1]
		else; brew $argv # pass arguments through
		end
	end
end
