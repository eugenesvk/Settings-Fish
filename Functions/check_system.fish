function check_system -d 'Display short system name (OSX, Linux, Win, NA)'
  set -l osname (uname)
  if test $osname = Darwin return OSX
  else if
    begin
      test (echo $osname | grep -E MSYS_NT 2>/dev/null)
      or test (echo $osname | grep -E MINGW32_NT 2>/dev/null)
      or test (echo $osname | grep -E MINGW64_NT 2>/dev/null)
    end
    return Win
  end
  else if test $osname = TESTLINUX return Linux	# adjust for proper test
  else return NA
end
