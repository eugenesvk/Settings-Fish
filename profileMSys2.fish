# System-wide profile file

# Some resources...
# Customizing Your Shell  http //www.dsl.org/cookbook/cookbook_5.html#SEC69
# Consistent BackSpace and Delete Configuration
#   http //www.ibb.net/~anne/keyboard.html
# The Linux Documentation Project  http //www.tldp.org/
# The Linux Cookbook  http //www.tldp.org/LDP/linuxcookbook/html/
# Greg's Wiki http //mywiki.wooledge.org/

# Setup some default paths. Note that this order will allow user installed software to override 'system' software. Modifying these default path settings can be done in different ways

set -gx XDG_RUNTIME_DIR "/tmp/fish.$USER/"  # required for older versions, otherwise fish can't create files in its own temp
echo "=============================Fish profile is executed============================="
set -gx MSYS2_PATH  /usr/local/bin /usr/bin /bin
set -gx MANPATH     /usr/local/man /usr/share/man /usr/man /share/man {$MANPATH}
set -gx INFOPATH    /usr/local/info /usr/share/info /usr/info /share/info {$INFOPATH}
set -gx MINGW_MOUNT_POINT ""
if [ -n "$MSYSTEM" ]
  if test "$MSYSTEM" = "MINGW32"
    set -gx MINGW_MOUNT_POINT /mingw32
    set -gx PATH              {$MINGW_MOUNT_POINT}/bin {$MSYS2_PATH} {$PATH}
    set -gx PKG_CONFIG_PATH   {$MINGW_MOUNT_POINT}/lib/pkgconfig {$MINGW_MOUNT_POINT}/share/pkgconfig
    set -gx ACLOCAL_PATH      {$MINGW_MOUNT_POINT}/share/aclocal /usr/share/aclocal
    set -gx MANPATH           {$MINGW_MOUNT_POINT}/share/man {$MANPATH}
  else if test "$MSYSTEM" = "MINGW64"
    set -gx MINGW_MOUNT_POINT /mingw64
    set -gx PATH              {$MINGW_MOUNT_POINT}/bin {$MSYS2_PATH} {$PATH}
    set -gx PKG_CONFIG_PATH   {$MINGW_MOUNT_POINT}/lib/pkgconfig {$MINGW_MOUNT_POINT}/share/pkgconfig
    set -gx ACLOCAL_PATH      {$MINGW_MOUNT_POINT}/share/aclocal /usr/share/aclocal
    set -gx MANPATH           {$MINGW_MOUNT_POINT}/share/man {$MANPATH}
  else if test "$MSYSTEM" = "MSYS"
    set -gx PATH            {$MSYS2_PATH} /opt/bin {$PATH}
    set -gx PKG_CONFIG_PATH /usr/lib/pkgconfig /usr/share/pkgconfig /lib/pkgconfig
  else
    set -gx PATH  {$MSYS2_PATH} {$PATH}
  end
else
  set -gx PATH  {$MSYS2_PATH} {$PATH}
end

set -gx MAYBE_FIRST_START false
if test -n {$SYSCONFDIR}
  set -gx SYSCONFDIR  /etc
end

# TMP and TEMP as defined in the Windows environment must be kept for windows apps, even if started from msys2. However, leaving them set to the default Windows temporary directory or unset can have unexpected consequences for msys2 apps, so we define our own to match GNU/Linux behaviour
set -gx ORIGINAL_TMP  "$TMP"
set -gx ORIGINAL_TEMP "$TEMP"
set -e TMP; set -e TEMP
set -gx tmp   (cygpath -w "$ORIGINAL_TMP" 2>/dev/null)  # cygpath converts names Win←→Linux
set -gx temp  (cygpath -w "$ORIGINAL_TEMP" 2>/dev/null)
set -gx TMP   "/tmp"
set -gx TEMP  "/tmp"

# Define default printer
set p '/proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows NT/CurrentVersion/Windows/Device'
if [ -e {$p} ]
  read PRINTER < {$p}
  set -gx PRINTER {$PRINTER%%,*}
end
set -e p

# function print_flags
  # (( $1 & 0x0002 )); and echo -n "binary"; or echo -n "text"
  # (( $1 & 0x0010 )); and echo -n ",exec"
  # (( $1 & 0x0040 )); and echo -n ",cygexec"
  # (( $1 & 0x0100 )); and echo -n ",notexec"
# end

# Shell dependent settings
function profile_d
  set -l file
  for file in (set -gx LC_COLLATE C; echo /etc/profile.d/*.$1)
    [ -e {$file} ]; and . {$file}
  end

  if [ -n {$MINGW_MOUNT_POINT} ]
    for file in (set -gx LC_COLLATE C; echo {$MINGW_MOUNT_POINT}/etc/profile.d/*.$1)
      [ -e {$file} ]; and . {$file}
    end
  end
end

for postinst in (set -gx LC_COLLATE C; echo /etc/post-install/*.post)
  [ -e {$postinst} ]; and . {$postinst}
end

# if [ ! "x{$BASH_VERSION}" = "x" ]
#   set -gx HOSTNAME  "(/usr/bin/hostname)"
#   profile_d sh
#   [ -f "/etc/bash.bashrc" ];and source "/etc/bash.bashrc"
# else if [ ! "x{$KSH_VERSION}" = "x" ]
#   typeset -l HOSTNAME "(/usr/bin/hostname)"
#   profile_d sh
#   set -gx PS1 (print '\033]0;{$PWD}\n\033[32m{$USER}@{$HOSTNAME} \033[33m{$PWD/{$HOME}/~}\033[0m\n> ')
# else if [ ! "x{$ZSH_VERSION}" = "x" ]
#   set -gx HOSTNAME  "(/usr/bin/hostname)"
#   profile_d zsh
#   set -gx PS1 '(%n@%m)[%h] %~ %% '
# else if [ ! "x{$POSH_VERSION}" = "x" ]
#   set -gx HOSTNAME  "(/usr/bin/hostname)"
#   set -gx PS1       "> "
# else
#   set -gx HOSTNAME  "(/usr/bin/hostname)"
#   profile_d sh
#   set -gx PS1 "> "
# end

set -gx TERM  xterm-256color
set -e PATH_SEPARATOR

if [ "$MAYBE_FIRST_START" = "true" ]
  sh /usr/bin/regen-info.sh

  if [ -f "/usr/bin/update-ca-trust" ]
    sh /usr/bin/update-ca-trust
  end

  clear
  echo
  echo
  echo "###################################################################"
  echo "#                                                                 #"
  echo "#                                                                 #"
  echo "#                   C   A   U   T   I   O   N                     #"
  echo "#                                                                 #"
  echo "#                  This is first start of MSYS2.                  #"
  echo "#       You MUST restart shell to apply necessary actions.        #"
  echo "#                                                                 #"
  echo "#                                                                 #"
  echo "###################################################################"
  echo
  echo
end
set -e MAYBE_FIRST_START
