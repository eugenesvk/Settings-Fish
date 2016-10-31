function check_system -d 'Display short system name (OSX, Linux, Win, NA)'
  set -l osname (uname | tr '[:upper:]' '[:lower:]' 2>/dev/null); or set -l osname (fish -c "uname | tr '[:upper:]' '[:lower:]'"); or set -l osname (/usr/bin/uname | tr '[:upper:]' '[:lower:]' 2>/dev/null)
  # fix for lacking MSYS2 path; 2nd needed for WSL as regular commands fails (bug https://github.com/Microsoft/BashOnWindows/issues/1210)
  if test "$osname" = darwin
    echo OSX
  else if begin
      test (echo "$osname" | grep -E msys_nt 2>/dev/null)
      or test (echo "$osname" | grep -E mingw32_nt 2>/dev/null)
      or test (echo "$osname" | grep -E mingw64_nt 2>/dev/null)
    end
    echo Win
  else if test "$osname" = linux
    echo Linux
  else
    echo NA
  end
end
