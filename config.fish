# Fish Shell config files (fishshell.com) with Oh-My-Fish (https://github.com/oh-my-fish/)

set -gx SYSTEM_NAME (check_system)
if test "$SYSTEM_NAME" = Win
  if status -l; source $HOME/.config/fish/profileMSys2.fish; end	# copy of /etc/profile -> fish
  source $HOME/.config/fish/envssh.fish                         	# enable ssh-agent
end
if test "$SYSTEM_NAME" = WinLinux
  source $HOME/.config/fish/envssh.fish # enable ssh-agent
end
if test "$SYSTEM_NAME" = OSX
  source $HOME/.config/fish/envssh-gpg.fish # enable ssh via gpg-agent
end

set -gx OMF_PATH    $HOME/.local/share/omf  # Path to Oh My Fish install, `-g` global, `-x` export=make it env
set -gx OMF_CONFIG  $HOME/.config/fish/omf  # Customize Oh My Fish configuration path
source $HOME/.config/fish/env.fish          # Add environment variables
source $OMF_PATH/init.fish                  # Load oh-my-fish configuration
source $HOME/.config/fish/envirt.fish       # Initialize virtual environments

#Enables fish integration in iTerm2. ** recursive wildcard (search in folders recursively)
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

# Theme-es config
set -g theme_es_show_symbols      'yes'   # [yes]
set -g theme_es_verbose_git_ahead 'yes'   # [yes]
set -g theme_es_show_git_sha      'short' # [short], long
set -g theme_es_show_user         'no'    # [no], yes
set -g theme_es_show_hostname     'yes'   # [yes]
set -g theme_es_notify_duration   10000
#top themes: trout (check rbenv version), l, clearance (master changes color in addition to signs)
#other themes: gnuykeaj, jacaetevha (2-line), Zish (exit code on right), flash (orange colors)

# Extra info
#Custom functions (autoloaded from '~/.config/fish/functions/'), also 'aliases' are treated as a function
  #f.fish                                               #Search for case insensitive file in or below current directory
  #gpl.fish                                             #Prints a pretty git log
  #l.fish                                               #A shortcut to ls -al –color=always
  #mkd.fish                                             #Create a directory CD to it
  #r.fish                                               #Search for text in all files in or below current folder
  #update.fish                                          #Update everything (Homebrew + packages, Oh-My-Fish)
  #z.fish                                               #Add frequently used folder list

#Oh-My-Fish packages (installed through 'omf install X')
  #foreign-env(fenv to use) or bass                     # wrapper for bash scripts
  #nvm.fish                                             # (removed due to use of nodenv) wrapper for NVM in fish
  #rbenv                                                # wrapper for rbenv

# Use function as aliase
  #function ls
  #    command ls --color=auto $argv
  #end
  #NB!
  #Always take care to add the $argv variable to the list of parameters to the wrapped command. This makes sure that if the   user specifies any additional parameters to the function, they are passed on to the underlying command.
  #If the alias has the same name as the aliased command, it is necessary to refix the call to the program with command in  order to tell fish that the unction should not call itself, but rather a command with the same name. ailing to do so will  cause infinite recursion bugs.

#chsh -s /usr/local/bin/fish                            #change default shell to Fish

#STYLE EXAMPLE DESCRIPTION
  #Style      Example                                     Description
  #Unquoted   set world earth;                            Supports all types of parameter expansion,
  #           echo hello $world prints "hello earth"      including C-style backslash expansion, etc.
  #single     set world earth;                            No parameter expansion is performed, the only
  #           echo 'hello $world' prints "hello $world"   special character is the ' (single quote).
  #Double     set world earth;                            Only variable expansion is performed.
  #           echo "hello $world" prints "hello earth"    Expanded variable arrays only result in a single argument.
  #cheatography.com/myounkin/cheat-sheets/fish-shell/

#The short summary is that if $VAR is not set, then test -n $VAR is equivalent to test -n, and POSIX requires that we just check if that one argument (the -n) is not null.
  #1. if test -n "$SSH_CLIENT" # You can fix it by quoting, which forces an argument even if it's empty:
  #2. test -n (EXPRESSION; or echo "")
  #3. use count
