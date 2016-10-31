function read_confirm -d "Ask for confirmation of passed text"
	set -g _read_confirm_prompt $argv
  while true
    read -l -p read_confirm_prompt confirm
    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end

function read_confirm_prompt
  echo "$_read_confirm_prompt [Y/n]"
end
