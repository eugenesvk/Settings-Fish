function ssh-keys-list -d 'Lists all private ssh keys (no extension) in a given folder'
  set -l KEY_PATH
  if test -z $argv    # no arguments
		echo "No path given, will look in ~/.ssh"
		set KEY_PATH $SSH_KEY_PATH
	else
		set KEY_PATH $argv
	end
	set -gx SSH_KEY_LIST (find $KEY_PATH -type f ! -name "*.*" ! -name "*_old*" -name "*id_*")
end
