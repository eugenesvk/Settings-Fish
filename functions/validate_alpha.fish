# This function is intended to be used as a validation command for individual option specifications given to the `argparse` command. It checks that the argument is a single alphabetic character and optionally whether it is in a reasonable range
function validate_alpha --no-scope-shadowing
  # Note that we can't use ourself to validate the arguments to the --min and --max flags this function recognizes.
  set -l options 'm-min=' 'x-max='
  argparse -n _argparsevalidate_alpha $options -- $argv
  or return

  if not string match -qr '^-?[a-z]$' -- $_flag_value
    set -l msg (_ "%s: Value '%s' for flag '%s' is not a single alphabetic character\n")
    printf $msg $_argparse_cmd $_flag_value $_flag_name
    return 1
  end

  if set -q _flag_min
    and not string match -qr '^-?['"$_flag_min"'-z]$' -- $_flag_value
    set -l msg (_ "%s: Value '%s' for flag '%s' less than min allowed of '%s'\n")
    printf $msg $_argparse_cmd $_flag_value $_flag_name $_flag_min
    return 1
  end

  if set -q _flag_max
    and not string match -qr '^-?[a-'"$_flag_max"']$' -- $_flag_value
    set -l msg (_ "%s: Value '%s' for flag '%s' greater than max allowed of '%s'\n")
    printf $msg $_argparse_cmd $_flag_value $_flag_name $_flag_max
    return 1
  end

  return 0
end
