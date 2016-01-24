# Fish Shell config files (fishshell.com) with Oh-My-Fish (https://github.com/oh-my-fish/)

#Custom functions (autoloaded from '~/.config/fish/functions/'), also 'aliases' are treated as a function
  #f.fish                                               #Search for case insensitive file in or below current directory
  #gpl.fish                                             #Prints a pretty git log
  #l.fish                                               #A shortcut to ls -al –color=always
  #mkd.fish                                             #Create a directory CD to it
  #r.fish                                               #Search for text in all files in or below current folder
  #update.fish                                          #Update everything (Homebrew + packages, Oh-My-Fish)
  #z.fish                                               #Add frequently used folder list

#Oh-My-Fish packages (installed through 'omf install X')
  #foreign-env or bass                                  # wrapper for bash scripts
  #nvm.fish                                             # wrapper for Node Version Manager in fish
  #rbenv                                                # wrapper for rbenv

source ~/.config/env.fish                               # Add environment variables
set -gx OMF_PATH "/Users/eugenesv/.local/share/omf"     # Path to Oh My Fish install, `-g` global, `-x` export=make it env
set -gx OMF_CONFIG "/Users/eugenesv/.config/fish/omf"   # Customize Oh My Fish configuration path
source $OMF_PATH/init.fish                              # Load oh-my-fish configuration
#top themes: trout (check rbenv version), l, clearance (master changes color in addition to signs)
#other themes: gnuykeaj, jacaetevha (2-line), Zish (exit code on right), flash (orange colors)

#Some extra info
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
  #Unquoted   set world earth;                            Supports all types of parameter expantion,
  #           echo hello $world prints "hello earth"      including C-style backslash expantion, etc.
  #single     set world earth;                            No parameter expantion is performed and the only
  #           echo 'hello $world' prints "hello $world"   special character that is recognized is the ' (single quote).
  #Double     set world earth;                            Only variable expantion is performed.
  #           echo "hello $world" prints "hello earth"    Expanded variable arrays only result in a single argument.
  #cheatography.com/myounkin/cheat-sheets/fish-shell/

#The short summary is that if $VAR is not set, then test -n $VAR is equivalent to test -n, and POSIX requires that we just check if that one argument (the -n) is not null.
  #1. if test -n "$SSH_CLIENT" # You can fix it by quoting, which forces an argument even if it's empty:
  #2. test -n (EXPRESSION; or echo "")
  #3. use count
