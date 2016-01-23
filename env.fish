# Owner
set -x USER_NAME eugenesv
set -x DEFAULT_USER eugenesv
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

#Initialise Python, Ruby, Perl environment if installed
if which pyenv > /dev/null; status --is-interactive; and . (pyenv init -|psub); end
if which rbenv > /dev/null; status --is-interactive; and . (rbenv init -|psub); end
if which plenv > /dev/null; status --is-interactive; and . (plenv init -|psub); end

# Aliases in `fish` are left for compatibility, but otherwise are all defined as functions; `functions` for a full list)
alias py      "python"
alias cls     "clear"
alias del     "rmtrash"                         # Remove to trash
alias zshcfg  "subl ~/.zshrc"
alias ohmyzsh "subl ~/.config/.oh-my-zsh"       # Better to define aliases within ZSH_CUSTOM; `alias` for a full list
alias fishcfg "subl ~/.config/fish/config.fish"
alias envcfg  "subl ~/.config/env.fish"
alias bashcfg "subl ~/.bashrc"

# Color stderr output in red
set err_bold (tput bold; tput md)
set err_red (tput setaf 1)
set -x STDERRED_ESC_CODE (echo -e "$err_bold$err_red")
  #set -x STDERRED_BLACKLIST "^(bash|test.*)$"            #blacklist bash, and all programs with names starting with "test"
set -x DYLD_INSERT_LIBRARIES    /usr/local/lib/stderred/libstderred.dylib       #color errors in red; originally had
  #additional command ${DYLD_INSERT_LIBRARIES:+:$DYLD_INSERT_LIBRARIES} in the end, but seems like a duplicate

# PATH
set -x EDITOR         "subl -w"
set -x PYENV_ROOT     $HOME/.pyenv
set -x PYREPO_ROOT    $PYENV_ROOT/versions/3.5.0/lib/python3.5/site-packages
set -gx NVM_DIR        ~/.nvm
set -x CoreUtils_Root /usr/local/opt/coreutils/libexec
set -x MANPATH        $CoreUtils_Root/gnuman /usr/local/share/man $MANPATH
set -x SSH_KEY_PATH   ~/.ssh/rsa_id
set -x HOMEBREW_GITHUB_API_TOKEN XXXXXXXXXXXXXXXXXXXX               #removed
set -x PATH $CoreUtils_Root/gnubin /usr/local/sbin $PATH
#$PYENV_ROOT/bin $HOME/.rbenv/bin $HOME/.plenv/bin                  # not needed since binaries are in Homebrew

#set -gx RBENV_ROOT #path custo RBENV for
#$PYENV_ROOT/shims $HOME/.rbenv/shims $HOME/.plenv/shims $PATH      #get installed through init commands above
#/usr/local/bin /usr/bin /bin /usr/sbin /sbin                       #default in '/private/etc/paths'
#/opt/X11/bin /usr/local/MacGPG2/bin                                #manually added in '/private/etc/paths.d'
