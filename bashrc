. ~/bin/dotfiles//bash/env
. ~/bin/dotfiles/bash/config
. ~/bin/dotfiles/bash/aliases
export PATH="/usr/local/bin:$PATH"
# rvm installer added line:
if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi
[[ -s "/Users/johanneshamel/.rvm/scripts/rvm" ]] && source "/Users/johanneshamel/.rvm/scripts/rvm"  # This loads RVM into a shell session. 
