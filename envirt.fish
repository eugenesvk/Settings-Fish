# Virtual Environment
# Initialise Python, Ruby, Perl and Java environments if installed
if status -i
  if command -q pyenv                      	; source (pyenv  init --path|psub); source (pyenv init -|psub)	; end
  if command -q pyenv-virtualenv-init      	; source (pyenv  virtualenv-init -|psub)                      	; end
  #if command -q "$HOME/.asdf/shims/direnv"	; eval (asdf exec direnv hook fish)                           	; end
  if command -q rbenv                      	; source (rbenv  init -|psub)                                 	; end
  if command -q nodenv                     	; source (nodenv init -|psub)                                 	; end
  # if command -q plenv                    	; source (plenv  init -|psub)                                 	; end
  # if command -q jenv                     	; source (jenv   init -|psub)                                 	; end
  if command -q zoxide                     	; source (zoxide init fish|psub)                              	; end
end


#$HOME/.nvm/versions/node/v5.0.0/bin
#set -x WORKON_HOME=$HOME/.virtualenvs
#set -x PROJECT_HOME=$HOME/Projects
#source /usr/local/bin/virtualenvwrapper.sh
