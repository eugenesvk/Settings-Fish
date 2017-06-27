function setenv -d 'Fixes "Too many arguments" issue described in github.com/fish-shell/fish-shell/issues/4103'
    set -gx $argv
end
