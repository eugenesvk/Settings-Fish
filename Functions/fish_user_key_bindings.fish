function fish_user_key_bindings -d 'Fish keybindings'
	bind -k sleft  	'backward-word'     	# ⇧←
	bind -k sright 	'forward-word'      	# ⇧←
	bind \e\[3\;5~ 	'kill-word'         	# Ctrl-Del kill word on the right
	bind \x1F      	'backward-kill-word'	# Ctrl-BS kill word on the left
	#bind \e\x7f   	'backward-kill-word'	# Alt-BS kill word on the left
	bind \ck       	'kill-whole-line'   	# Ctrl-k clears the input line regardless of cursor pos
	bind \cq       	'exit'              	# Ctrl-Q Quit Fish
	bind \e\[1\;10A	'fzf-history-widget'	# Alt-Shift-Up (Ctrl-R default) Paste the selected command from history
	#bind \e\[1\;5A	'fzf-history-widget'	# Ctrl-Up (Ctrl-R default) Paste the selected command from history
	bind \eh       	'fzf-history-widget'	# Alt-h (Ctrl-R default) Paste the selected command from history
	bind \ef       	'fzf-file-widget'   	# Alt-f (Ctrl-T default) Paste the selected files and directories
	bind \ez       	'fzf-cd-widget'     	# Alt-z (Alt-C default) cd into the selected directory
  if bind -M insert > /dev/null 2>&1
    #bind -M insert \ct fzf-file-widget
    bind -M insert \eh 'fzf-history-widget'
    #bind -M insert \ec fzf-cd-widget
  end
	bind \e\[1\;5B	'fzf-cd-widget'	# Ctrl-Down (Alt-C default) cd into the selected directory
	#unbound keys qerio[]asgjk;'\zxvnm,
	fzf_key_bindings
	#Alt-based key bindings are case sensitive and Control-based key bindings are not
	#fishshell.com/docs/current/commands.html#bind
	#github.com/fish-shell/fish-shell/blob/master/share/functions/fish_default_key_bindings.fish#L85
	#\e\[1\;5A Ctrl-Up
	#\e\[1\;5B Ctrl-Down
end
