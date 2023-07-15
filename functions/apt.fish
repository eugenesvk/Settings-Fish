function apt -w apt -d "Aliases for Linux apt function, simplifying syntax"
	# set argv_accepted a i u r a p as af ainfo alu ali
	# if contains -- "$argv[1]" $argv_accepted     # -- to finish accepting -a arguments
		# set -e $argv[1]
	# end
	# echo $argv_accepted
	# $argv[2..-1] returns all arguments from the second to the last.
	# -w wraps in another command, inheriting completions
	set argv_c (count $argv)
	if test $argv_c -lt 2 # zero or 1 argument
		if      test -z "$argv"       	; /usr/bin/apt
		else if test "$argv[1]" = "u" 	; echo "Update & Upgrade" 	; sudo /usr/bin/apt update; sudo /usr/bin/apt upgrade
		else if test "$argv[1]" = "r" 	; echo "Autoremoving"     	; sudo /usr/bin/apt autoremove
		else if test "$argv[1]" = "lu"	; echo "List upgradeable:"	;      /usr/bin/apt list --upgradeable
		else if test "$argv[1]" = "li"	; echo "List installed:"  	;      /usr/bin/apt list --installed
		else; /usr/bin/apt $argv # pass arguments through
		end
	else if test $argv_c -ge 2 # 2 or more arguments
		if      test "$argv[1]" = "a"  	; echo "Install $argv[2..-1]"	; sudo /usr/bin/apt install	$argv[2..-1]	# match first argument
		else if test "$argv[1]" = "i"  	; echo "Install $argv[2..-1]"	; sudo /usr/bin/apt install	$argv[2..-1]
		else if test "$argv[1]" = "r"  	; echo "Remove $argv[2..-1]" 	; sudo /usr/bin/apt remove 	$argv[2..-1]
		else if test "$argv[1]" = "p"  	; echo "Purge $argv[2..-1]"  	; sudo /usr/bin/apt purge  	$argv[2..-1]
		else if test "$argv[1]" = "s"  	; echo "Search $argv[2..-1]" 	;      /usr/bin/apt search 	$argv[2..-1]
		else if test "$argv[1]" = "f"  	; echo "Search $argv[2..-1]" 	;      /usr/bin/apt search 	$argv[2..-1]
		else if test "$argv[1]" = "inf"	; echo "Show $argv[2..-1]"   	;      /usr/bin/apt show   	$argv[2..-1]
		else; /usr/bin/apt $argv # pass arguments through
		end
	end
end
