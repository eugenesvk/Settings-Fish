function varAlt -d "var AlternativeValue: Returns alternative value if variable is set, otherwise returns nothing"
	set -q $argv[1]; and echo $argv[2]; or echo ''
end
