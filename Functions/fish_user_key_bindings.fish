function fish_user_key_bindings -d 'Fish keybindings'
	bind -k sleft 	'backward-word'     	# ⇧←
	bind -k sright	'forward-word'      	# ⇧←
	bind \e\[3\;5~	'kill-word'         	# Ctrl-Del kill word on the right
	bind \x1F     	'backward-kill-word'	# Ctrl-BS kill word on the left
	#bind \e\x7f  	'backward-kill-word'	# Alt-BS kill word on the left
	bind \ck      	'kill-whole-line'   	# Ctrl-k clears the input line regardless of cursor pos
	bind \cq      	'exit'              	# Ctrl-Q Quit Fish
	fzf_key_bindings
	#Alt-based key bindings are case sensitive and Control-based key bindings are not
	#fishshell.com/docs/current/commands.html#bind
	#github.com/fish-shell/fish-shell/blob/master/share/functions/fish_default_key_bindings.fish#L85
end
