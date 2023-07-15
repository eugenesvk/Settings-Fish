function undollar -d 'Remove "$" from pasted cli command examples; end with "^d"'
  source ( sed 's/^\$ //' | read -z | psub)
end
