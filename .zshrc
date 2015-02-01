# Path to your oh-my-zsh installation.  export ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
ZSH_THEME="robbyrussell"
[[ $TERM != "screen" ]] && exec tmux

plugins=(git ruby gem history history-substring-search terminalapp brew )
ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="/Users/kshitij.banerjee/.rvm/gems/ruby-1.9.3-p551/bin:/Users/kshitij.banerjee/.rvm/gems/ruby-1.9.3-p551@global/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/Users/kshitij.banerjee/Desktop:/Users/kshitij.banerjee/.rvm/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias ctags="`brew --prefix`/bin/ctags"
create_tags(){ ctags -R `bundle show --paths` . }

#extract_seconds() { grep -o '[[][0-9]*[.][0-9]*s' | grep -o '[0-9]*[.][0-9]*' }
extract_seconds() { ctl | grep -o '[[][0-9][0-9]*[.][0-9]*s' | grep -o '[0-9][0-9]*[.][0-9]*' }
#extract_mili_seconds() { grep -o ' [0-9]*ms' | grep -o '[0-9][0-9]*' }
extract_mili_seconds() { ctl | grep -o '[0-9][0-9]*[.][0-9][0-9]*ms' }

find_percentile_ms() {
  rm ./temp.txt
  grep_warehouse_d $1 $2 | ctl | extract_mili_seconds | sort -g > ./temp.txt;
  total=`cat ./temp.txt | wc -l`
  m99th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.99) }'`
  m98th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.98) }'`
  m97th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.97) }'`
  m96th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.96) }'`
  m95th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.95) }'`
  m70th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.70) }'`
  m60th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.60) }'`
  m50th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.50) }'`
  echo "99th percentile = "`cat ./temp.txt | head -$m99th | tail -1`
  echo "98th percentile = "`cat ./temp.txt | head -$m98th | tail -1`
  echo "97th percentile = "`cat ./temp.txt | head -$m97th | tail -1`
  echo "96th percentile = "`cat ./temp.txt | head -$m96th | tail -1`
  echo "95th percentile = "`cat ./temp.txt | head -$m95th | tail -1`
  echo "70th percentile = "`cat ./temp.txt | head -$m70th | tail -1`
  echo "60th percentile = "`cat ./temp.txt | head -$m60th | tail -1`
  echo "50th percentile = "`cat ./temp.txt | head -$m50th | tail -1`
  echo "count = "$total
  sum=`cat ./temp.txt | awk '{s+=$1} END {print s}'`
  echo "avg = "`echo $sum/$total | bc -l`
}

find_percentile_s() {
  rm ./temp.txt
  grep_warehouse_d $1 $2 | ctl | extract_seconds | sort -g  > ./temp.txt;
  total=`cat ./temp.txt | wc -l`
  m99th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.99) }'`
  m98th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.98) }'`
  m97th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.97) }'`
  m96th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.96) }'`
  m95th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.95) }'`
  m70th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.70) }'`
  m60th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.60) }'`
  m50th=`echo $total | awk '{  printf "%.0f\n", ($1 * 0.50) }'`
  echo "99th percentile = "`cat ./temp.txt | head -$m99th | tail -1`
  echo "98th percentile = "`cat ./temp.txt | head -$m98th | tail -1`
  echo "97th percentile = "`cat ./temp.txt | head -$m97th | tail -1`
  echo "96th percentile = "`cat ./temp.txt | head -$m96th | tail -1`
  echo "95th percentile = "`cat ./temp.txt | head -$m95th | tail -1`
  echo "70th percentile = "`cat ./temp.txt | head -$m70th | tail -1`
  echo "60th percentile = "`cat ./temp.txt | head -$m60th | tail -1`
  echo "50th percentile = "`cat ./temp.txt | head -$m50th | tail -1`
  echo "count = "$total
  sum=`cat ./temp.txt | awk '{s+=$1} END {print s}'`
  echo "avg = "`echo $sum/$total | bc -l`
}
