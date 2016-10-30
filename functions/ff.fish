function ff -d "Search for case insensitive file in or below current directory"
  if test (count $argv) -lt 2
    find . -iname "*$argv[1]*"
  else
    set argv1 $argv[1]                #save first parameter
    set -e argv[1]                    #delete first parameter
    find . -iname "*$argv1*" $argv
  end
end

#    find . -iname "*"{"$argv"}"t*"   #{brace expansion in "quotes" to pass empty string for empty var and single space-concactenated value for arrays}
