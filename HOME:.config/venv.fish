# Virtual Environment
#Initialise Python, Ruby, Perl and Java environment if installed
if which pyenv > /dev/null; status --is-interactive; and . (pyenv init -|psub); end
if which pyenv-virtualenv-init > /dev/null; status --is-interactive; and . (pyenv virtualenv-init -|psub); end
if which rbenv > /dev/null; status --is-interactive; and . (rbenv init -|psub); end
if which plenv > /dev/null; status --is-interactive; and . (plenv init -|psub); end
#if which jenv > /dev/null; status --is-interactive; and . (jenv init -|psub); end	#not working
if which jenv > /dev/null; fenv 'eval "$(jenv init -)"'; end

#$HOME/.nvm/versions/node/v5.0.0/bin
#set -x WORKON_HOME=$HOME/.virtualenvs
#set -x PROJECT_HOME=$HOME/Projects
#source /usr/local/bin/virtualenvwrapper.sh
