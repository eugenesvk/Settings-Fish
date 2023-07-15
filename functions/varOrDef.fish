function varOrDef -d "var DefaultValue: Returns variable value if it's set, otherwise returns second argument (Default Value)"
	set -q $argv[1]; and echo $$argv[1]; or echo $argv[2]
end
