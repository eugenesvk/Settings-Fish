function fish_user_key_bindings -d 'Fish keybindings'
  # bind -k sleft 	'backward-bigword'	#[backward-bigword] ⇧← move one word left without stopping on punctuation (stop at whitespace)
  # bind -k sright	'forward-bigword' 	#[forward-bigword]  ⇧→
  bind '\cf'      	'forward-bigword' 	#[forward-char]  ^→ move one word right without stopping on punctuation (stop at whitespace), greate for autocompletion (https://github.com/fish-shell/fish-shell/issues/1505)
  # - @key{Alt,&larr;,Left} and @key{Alt,&rarr;,Right} move the cursor one word left or right (to the next space or punctuation mark), or moves forward/backward in the directory history if the command line is empty. If the cursor is already at the end of the line, and an autosuggestion is available, @key{Alt,&rarr;,Right} (or @key{Alt,F}) accepts the first word in the suggestion.
  # bind \cf	 'accept-autosuggestion'	#  ^→ move one word right without stopping on punctuation (stop at whitespace), greate for autocompletion (https://github.com/fish-shell/fish-shell/issues/1505)
  bind '\ei'	 'accept-autosuggestion'	# Alt-i to accept autosuggestion completely

  bind '\e\[3\;5~' 	'kill-word'         	# ^Del kill word on the right
  bind '\x1F'      	'backward-kill-word'	# ^BS kill word on the left
  #bind '\e\x7f'   	'backward-kill-word'	# ⌥BS kill word on the left
  bind '\ck'       	'kill-whole-line'   	# ^k clears the input line regardless of cursor pos
  bind '\cq'       	'exit'              	# ^Q Quit Fish
  bind '\e\[1\;10A'	'fzf-history-widget'	# ⌥⇧↑ (Ctrl-R default) Paste the selected command from history
  bind '\e\[1\;4A' 	'fzf-history-widget'	# ⌥⇧↑ in Linux
  #bind '\e\e\[A'  	'fzf-history-widget'	# ⌥↑ in macOS
  #bind '\e\[1\;3A'	'fzf-history-widget'	# ⌥↑ in Linux
  bind '\e\[1\;5A' 	'fzf-history-widget'	# ^↑
  bind '\eh'       	'fzf-history-widget'	# ⌥H (Ctrl-R default) Paste the selected command from history
  bind '\ef'       	'fzf-file-widget'   	# ⌥F (Ctrl-T default) Paste the selected files and directories
  bind '\ez'       	'fzf-cd-widget'     	# ⌥Z (Alt-C default) cd into the selected directory
  bind '\e\[1\;5B' 	'fzf-cd-widget'     	# Ctrl-Down
  if bind -M 'insert' > /dev/null 2>&1
    #bind -M insert \ct fzf-file-widget
    bind -M 'insert' '\eh' 'fzf-history-widget'
    #bind -M insert \ec fzf-cd-widget
  end
  #unbound keys qerio[]asgjk;'\zxvnm,
  # fzf_key_bindings
  #Alt-based key bindings are case sensitive and Control-based key bindings are not
  #fishshell.com/docs/current/commands.html#bind
  #github.com/fish-shell/fish-shell/blob/master/share/functions/fish_default_key_bindings.fish#L85
  #github.com/fish-shell/fish-shell/blob/master/share/functions/__fish_shared_key_bindings.fish
  #\e\[1\;5A Ctrl-Up
  #\e\[1\;5B Ctrl-Down
end
