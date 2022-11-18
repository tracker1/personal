#########################################
# Add original .bashrc content first
source ~/.bashrc.default

#########################################
# Update this to your email address here.
export EMAIL=YOUR.NAME@email.domain


#########################################
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
  chmod -R +x $HOME/bin/*
fi


#########################################
# dotnet
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools


#########################################
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


#########################################
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#########################################
# go
# export PATH=$PATH:/usr/local/go/bin


#########################################
# rust/cargo
# source "$HOME/.cargo/env"


#########################################
# starship
function set_win_title(){
    echo -ne "\033]0; Ubuntu: $PWD \007"
}
starship_precmd_user_func="set_win_title"
eval "$(starship init bash)"


#########################################
# Add Helpful Aliases Last
source ~/.bashrc.aliases