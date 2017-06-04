# Path to your oh-my-zsh installation.  export ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
ZSH_THEME="jonathan"


plugins=(git ruby gem history history-substring-search terminalapp brew zsh-syntax-highlighting )

  # For history substring search ---- START
  zmodload zsh/terminfo
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down

  # bind UP and DOWN arrow keys (compatibility fallback
  # for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  # bind k and j for VI mode
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
  # For history substring search ---- END

ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="/Users/ksbanerj/.rvm/gems/ruby-1.9.3-p551/bin:/Users/ksbanerj/.rvm/gems/ruby-1.9.3-p551@global/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/Users/ksbanerj/Desktop:/Users/ksbanerj/.rvm/bin:$HOME/.tmuxifier/bin:/opt/local/Homebrew/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#eval "$(tmuxifier init -)"
alias ctags="`brew --prefix`/bin/ctags"
create_tags(){ ctags -R `bundle show --paths` . }

alias rzsh='source ~/.zshrc'
alias x='exit'
clean_tmux(){
  for i in `tmux list-sessions | grep -v 'attached' | cut -d':' -f1 | xargs echo`
  do
    tmux kill-session -t $i
  done
}

cd ~/visa

bindkey -v
tac () { awk '1 { last = NR; line[last] = $0; } END { for (i = last; i > 0; i--) { print line[i]; } }' }
ctl() { sed -E "s/"$'\E'"\[([0-9]{1,2}(;[0-9]{1,2})*)?m//g" }

run_rubocop() {
  g s | awk '{print $2}' | grep -v 'app.rb' | grep -v 'Gemfile' | xargs  rubocop -a
}

alias vim=/opt/local/Homebrew/bin/vim
 [[ $TERM != "screen" ]] && exec tmux -2
