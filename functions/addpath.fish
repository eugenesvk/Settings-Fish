function addpath -d 'Add a path permanently to a universal user variable $fish_user_paths'
  contains -- $argv $fish_user_paths
    or set -U fish_user_paths $fish_user_paths $argv
  echo "Updated PATH: $PATH"
end
