function check_system -d 'Display short system name (OSX, Linux, Win, NA)'
  set -l PATH $PATH /usr/bin
  set -l osname (uname)
  if test "$osname" = Darwin
    echo OSX
  else if begin
      test (echo "$osname" | grep -E MSYS_NT 2>/dev/null)
      or test (echo "$osname" | grep -E MINGW32_NT 2>/dev/null)
      or test (echo "$osname" | grep -E MINGW64_NT 2>/dev/null)
    end
    echo Win
  else if test "$osname" = TESTLINUX
    echo Linux
  else
    echo NA
  end
end
