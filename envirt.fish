# Virtual Environment
#Initialise Python, Ruby, Perl and Java environment if installed
if command -v pyenv > /dev/null; status --is-interactive; and . (pyenv init -|psub); end
if command -v pyenv-virtualenv-init > /dev/null; status --is-interactive; and . (pyenv virtualenv-init -|psub); end
if command -v rbenv > /dev/null; status --is-interactive; and . (rbenv init -|psub); end
if command -v nodenv > /dev/null; status --is-interactive; and . (nodenv init -|psub); end
if command -v plenv > /dev/null; status --is-interactive; and . (plenv init -|psub); end
#if command -v jenv > /dev/null; status --is-interactive; and . (jenv init -|psub); end	#not working
if command -v jenv > /dev/null; fenv 'eval "$(jenv init -)"'; end

#$HOME/.nvm/versions/node/v5.0.0/bin
#set -x WORKON_HOME=$HOME/.virtualenvs
#set -x PROJECT_HOME=$HOME/Projects
#source /usr/local/bin/virtualenvwrapper.sh
