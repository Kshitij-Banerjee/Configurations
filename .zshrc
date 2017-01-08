# Path to your oh-my-zsh installation.  export ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
ZSH_THEME="jonathan"
 #[[ $TERM != "screen" ]] && exec tmux

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
export PATH="/Users/kshitij.banerjee/.rvm/gems/ruby-1.9.3-p551/bin:/Users/kshitij.banerjee/.rvm/gems/ruby-1.9.3-p551@global/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/Users/kshitij.banerjee/Desktop:/Users/kshitij.banerjee/.rvm/bin:$HOME/.tmuxifier/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
eval "$(tmuxifier init -)"

alias ctags="`brew --prefix`/bin/ctags"
create_tags(){ ctags -R `bundle show --paths` . }

alias rzsh='source ~/.zshrc'
alias b2b='mysql.server start; PADRINO_ENV=development SUPPLY_CHAIN_COMPANY=b2b DEPLOY_ENV=localhost DB_NAME=warehouse_b2b_development NO_AUTH=Y bundle exec padrino start -p 36081'
alias b2c='MOCK=Y PADRINO_ENV=development SUPPLY_CHAIN_COMPANY=b2c ENABLE_REQ_RESP_LOGGING=true NO_AUTH=Y bundle exec padrino start -p 35081'
alias b2b_ui='WH_frontend.command'
alias b2c_ui='RAILS_ENV=development SUPPLY_CHAIN_COMPANY=b2c NO_AUTH=Y bundle exec rails server -p 35080'
alias doc='cd ../sc-doc ;rvm use jruby-1.6.7;bundle install;export JRUBY_OPTS=--1.9;NO_AUTH=y bundle exec rake ar:create ar:migrate seed; NO_AUTH=y SUPPLY_CHAIN_COMPANY=b2b ENABLE_REQ_RESP_LOGGING=true PADRINO_ENV=development bundle exec padrino start -p 36101'
alias console='DEPLOY_ENV=localhost MOCK=Y PADRINO_ENV=development SUPPLY_CHAIN_COMPANY=b2b ENABLE_REQ_RESP_LOGGING=true NO_AUTH=Y bundle exec padrino console'
alias console_test='DEPLOY_ENV=localhost PADRINO_ENV=test SUPPLY_CHAIN_COMPANY=b2c ENABLE_REQ_RESP_LOGGING=true NO_AUTH=Y bundle exec padrino console'
alias console_dev_db='MOCK=Y PADRINO_ENV=test SUPPLY_CHAIN_COMPANY=b2b ENABLE_REQ_RESP_LOGGING=true DB_NAME=warehouse_b2b_development NO_AUTH=Y bundle exec padrino console'
alias migration_dcm='DEPLOY_ENV=localhost PADRINO_ENV=test NO_AUTH=Y bundle exec rake ar:drop ar:create ar:migrate --trace'
alias migration_cm='DEPLOY_ENV=localhost PADRINO_ENV=test NO_AUTH=Y bundle exec rake ar:create ar:migrate --trace'
alias migration_m='DEPLOY_ENV=localhost PADRINO_ENV=test NO_AUTH=Y bundle exec rake ar:migrate --trace'
alias run_all_tests="DB_NAME=warehouse_b2c_test migration_dcm ; DB_NAME=warehouse_b2c_test NO_AUTH=Y bundle exec rake spec"
alias run_tests="DB_NAME=warehouse_b2c_test migration_dcm ; NO_AUTH=Y DB_NAME=warehouse_b2c_test bundle exec rake spec:only"
alias run_mysql="mysql.server start;mysql -uroot"
check_version() { cd ~/Downloads/capistrano; CMD='dpkg -l | grep warehouse' PATTERN=warehouse-$1 cap run_cmd_on_prod 2>&1 | grep 'fk-sc-warehouse' | cut -d'@' -f2}
alias x='exit'
clean_tmux(){
  for i in `tmux list-sessions | grep -v 'attached' | cut -d':' -f1 | xargs echo`
  do
    tmux kill-session -t $i
  done
  }

cd ~/flipkart/ekart-seller-service-cms
rvm use 1.9.3
bindkey -v
tac () { awk '1 { last = NR; line[last] = $0; } END { for (i = last; i > 0; i--) { print line[i]; } }' }

ctl() { sed -E "s/"$'\E'"\[([0-9]{1,2}(;[0-9]{1,2})*)?m//g" }
machines() { grep -o 'warehouse-.*-[0-9]*.nm.flipkart.com' | sort | uniq }
slow() {  ctl | grep "[4-9][0-9]*[.][0-9]*[s]" }

grep_b2b() { old_dir=`pwd`;trap "cd $old_dir" 2;cd ~/Downloads/capistrano;CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-w*/production.log" PATTERN=warehouse-b2b cap run_cmd_on_prod 2>&1 } 
grep_b2b_d() { old_dir=`pwd`;trap "cd $old_dir" 2;cd ~/Downloads/capistrano;CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-w*/production.log$2" PATTERN=warehouse-b2b cap run_cmd_on_prod 2>&1 }
grep_b2b_all() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-w*/*.log*" PATTERN=warehouse-b2b cap run_cmd_on_prod 2>&1 }
grep_b2b_ui() { old_dir=`pwd`; trap "cd $old_dir" 2; cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-w*/production.log" PATTERN=warehouse-ui-b2b cap run_cmd_on_prod 2>&1 }
grep_b2b_ui_d() { old_dir=`pwd`; trap "cd $old_dir" 2; cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-w*/production.log$2" PATTERN=warehouse-ui-b2b cap run_cmd_on_prod 2>&1 }
grep_b2b_ui_all() { old_dir=`pwd`; trap "cd $old_dir" 2; cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-w*/*.log*" PATTERN=warehouse-ui-b2b cap run_cmd_on_prod 2>&1 }
grep_warehouse_d() { old_dir=`pwd`; trap "cd $old_dir" 2; cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-w*/production.log$2" PATTERN=warehouse cap run_cmd_on_prod 2>&1 }
cmd_warehouse_d() { old_dir=`pwd`; trap "cd $old_dir" 2; cd ~/Downloads/capistrano; CMD=$1" /var/log/flipkart/supply-chain/fk-sc-w*/production.log$2" PATTERN=warehouse cap run_cmd_on_prod 2>&1 }
cmd_b2b() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD=$1" /var/log/flipkart/supply-chain/fk-sc-w*/production.log" PATTERN=warehouse-b2b cap run_cmd_on_prod 2>&1 }
cmd_parallel_b2b() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD=$1" /var/log/flipkart/supply-chain/fk-sc-w*/production.log" PATTERN=warehouse-parallel-b2b cap run_cmd_on_prod 2>&1 }
cmd_search_b2b() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD=$1" /var/log/flipkart/supply-chain/fk-sc-w*/production.log" PATTERN=warehouse-search-b2b cap run_cmd_on_prod 2>&1 }
cmd_b2c() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD=$1" /var/log/flipkart/supply-chain/fk-sc-w*/production.log" PATTERN=warehouse-b2c cap run_cmd_on_prod 2>&1 }
cmd_b2b_ui() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD=$1" /var/log/flipkart/supply-chain/fk-sc-w*/production.log" PATTERN=warehouse-ui-b2b cap run_cmd_on_prod 2>&1 }
cmd_b2c_ui() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD=$1" /var/log/flipkart/supply-chain/fk-sc-w*/production.log" PATTERN=warehouse-ui-b2c cap run_cmd_on_prod 2>&1 }
cmd_b2b_all() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD=$1" /var/log/flipkart/supply-chain/fk-sc-w*/*.log*" PATTERN=warehouse-b2b cap run_cmd_on_prod 2>&1 }
grep_b2c() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-w*/production.log" PATTERN=warehouse-b2c cap run_cmd_on_prod 2>&1 }
grep_b2c_all() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-w*/*.log*" PATTERN=warehouse-b2c cap run_cmd_on_prod 2>&1 }
grep_b2c_ui() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-w*/production.log" PATTERN=warehouse-ui-b2c cap run_cmd_on_prod 2>&1 }
grep_b2c_ui_all() { old_dir=`pwd`; trap "cd $old_dir" 2;cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-w*/production.log*" PATTERN=warehouse-ui-b2c cap run_cmd_on_prod 2>&1 }
grep_doc() { old_dir=`pwd`; trap "cd $old_dir" 2; cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-doc-b2b/production.log" PATTERN=doc-b2b cap run_cmd_on_prod 2>&1 }
grep_doc_b2c() { old_dir=`pwd`; trap "cd $old_dir" 2; cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-doc-b2c/production.log" PATTERN=doc-b2c cap run_cmd_on_prod 2>&1 }
grep_doc_b2c_all() { old_dir=`pwd`; trap "cd $old_dir" 2; cd ~/Downloads/capistrano; CMD="grep "$1" --color=always /var/log/flipkart/supply-chain/fk-sc-doc-b2c/*.log*" PATTERN=doc-b2c cap run_cmd_on_prod 2>&1 }
cmd_b2b_doc() { old_dir=`pwd`; trap "cd $old_dir" 2; cd ~/Downloads/capistrano; CMD=$1" /var/log/flipkart/supply-chain/fk-sc-doc-b2b/production.log" PATTERN=doc-b2b cap run_cmd_on_prod 2>&1 }
cmd_b2c_doc() { old_dir=`pwd`; trap "cd $old_dir" 2; cd ~/Downloads/capistrano; CMD=$1" /var/log/flipkart/supply-chain/fk-sc-doc-b2c/production.log" PATTERN=doc-b2c cap run_cmd_on_prod 2>&1 }


open_relayers() { cd ~/Downloads/csshX-0.74; ./csshX --login kshitij.banerjee kshitij.banerjee --remote_command "tail -f /var/log/flipkart/supply-chain/fk-sc-relayer/production_warehouse_b2b_relayer.log" flo-warehouse-b2b-25.nm.flipkart.com flo-warehouse-b2b-26.nm.flipkart.com flo-warehouse-b2b-27.nm.flipkart.com flo-warehouse-b2b-28.nm.flipkart.com flo-warehouse-b2b-29.nm.flipkart.com flo-warehouse-b2b-30.nm.flipkart.com }
open_deployment_set_1() { cd ~/Downloads/csshX-0.74; ./csshX --login kshitij.banerjee kshitij.banerjee flo-warehouse-b2b-3.nm.flipkart.com flo-warehouse-b2b-4.nm.flipkart.com flo-warehouse-b2b-5.nm.flipkart.com flo-warehouse-b2b-6.nm.flipkart.com flo-warehouse-b2b-7.nm.flipkart.com flo-warehouse-b2b-11.nm.flipkart.com }
open_deployment_set_2() { cd ~/Downloads/csshX-0.74; ./csshX --login kshitij.banerjee kshitij.banerjee flo-warehouse-b2b-8.nm.flipkart.com flo-warehouse-b2b-9.nm.flipkart.com flo-warehouse-b2b-10.nm.flipkart.com flo-warehouse-b2b-12.nm.flipkart.com flo-warehouse-b2b-13.nm.flipkart.com flo-warehouse-b2b-14.nm.flipkart.com flo-warehouse-b2b-15.nm.flipkart.com flo-warehouse-b2b-16.nm.flipkart.com }
open_deployment_set_3() { cd ~/Downloads/csshX-0.74; ./csshX --login kshitij.banerjee kshitij.banerjee flo-warehouse-b2b-17.nm.flipkart.com flo-warehouse-b2b-18.nm.flipkart.com flo-warehouse-b2b-19.nm.flipkart.com flo-warehouse-b2b-20.nm.flipkart.com flo-warehouse-b2b-23.nm.flipkart.com flo-warehouse-b2b-24.nm.flipkart.com flo-warehouse-b2b-30.nm.flipkart.com }
open_deployment_set_4() { cd ~/Downloads/csshX-0.74; ./csshX --login kshitij.banerjee kshitij.banerjee flo-warehouse-b2b-21.nm.flipkart.com flo-warehouse-b2b-22.nm.flipkart.com flo-warehouse-b2b-25.nm.flipkart.com flo-warehouse-b2b-26.nm.flipkart.com flo-warehouse-b2b-27.nm.flipkart.com flo-warehouse-b2b-28.nm.flipkart.com flo-warehouse-b2b-29.nm.flipkart.com flo-infra10.nm.flipkart.com }
open_all_b2b_machines() { cd ~/Downloads/csshX-0.74; ./csshX --login kshitij.banerjee kshitij.banerjee flo-warehouse-b2b-1.nm.flipkart.com flo-warehouse-b2b-2.nm.flipkart.com flo-warehouse-b2b-3.nm.flipkart.com flo-warehouse-b2b-4.nm.flipkart.com flo-warehouse-b2b-5.nm.flipkart.com flo-warehouse-b2b-6.nm.flipkart.com flo-warehouse-b2b-7.nm.flipkart.com flo-warehouse-b2b-11.nm.flipkart.com flo-warehouse-b2b-8.nm.flipkart.com flo-warehouse-b2b-9.nm.flipkart.com flo-warehouse-b2b-10.nm.flipkart.com flo-warehouse-b2b-12.nm.flipkart.com flo-warehouse-b2b-13.nm.flipkart.com flo-warehouse-b2b-14.nm.flipkart.com flo-warehouse-b2b-15.nm.flipkart.com flo-warehouse-b2b-16.nm.flipkart.com flo-warehouse-b2b-17.nm.flipkart.com flo-warehouse-b2b-18.nm.flipkart.com flo-warehouse-b2b-19.nm.flipkart.com flo-warehouse-b2b-20.nm.flipkart.com flo-warehouse-b2b-23.nm.flipkart.com flo-warehouse-b2b-24.nm.flipkart.com flo-warehouse-b2b-30.nm.flipkart.com flo-warehouse-b2b-21.nm.flipkart.com flo-warehouse-b2b-22.nm.flipkart.com flo-warehouse-b2b-25.nm.flipkart.com flo-warehouse-b2b-26.nm.flipkart.com flo-warehouse-b2b-27.nm.flipkart.com flo-warehouse-b2b-28.nm.flipkart.com flo-warehouse-b2b-29.nm.flipkart.com flo-infra11.nm.flipkart.com  }
open_deployment_set_b2c_1() { cd ~/Downloads/csshX-0.74; ./csshX --login kshitij.banerjee kshitij.banerjee flo-warehouse-b2c-1.nm.flipkart.com flo-warehouse-b2c-3.nm.flipkart.com flo-warehouse-b2c-5.nm.flipkart.com flo-warehouse-b2c-7.nm.flipkart.com flo-warehouse-b2c-9.nm.flipkart.com flo-warehouse-b2c-11.nm.flipkart.com }
open_deployment_set_b2c_2() { cd ~/Downloads/csshX-0.74; ./csshX --login kshitij.banerjee kshitij.banerjee flo-warehouse-b2c-2.nm.flipkart.com flo-warehouse-b2c-4.nm.flipkart.com flo-warehouse-b2c-6.nm.flipkart.com flo-warehouse-b2c-8.nm.flipkart.com flo-warehouse-b2c-8.nm.flipkart.com flo-warehouse-b2c-10.nm.flipkart.com flo-warehouse-b2c-12.nm.flipkart.com }

#extract_seconds() { grep -o '[[][0-9]*[.][0-9]*s' | grep -o '[0-9]*[.][0-9]*' }
extract_seconds() { ctl | grep -o '[[][0-9][0-9]*[.][0-9]*s' | grep -o '[0-9][0-9]*[.][0-9]*' }
#extract_mili_seconds() { grep -o ' [0-9]*ms' | grep -o '[0-9][0-9]*' }
extract_mili_seconds() { ctl | grep -o '[0-9][0-9]*[.][0-9][0-9]*ms' }
extract_percentage() { ctl | grep -o '(.*%)' | grep -o '[0-9]*[.][0-9]*' }
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


check_db_connections() {
  sudo netstat -atWple | egrep mysql | awk '{print $5}' | cut -d":" -f1 | sort | uniq -c | sort -nr
}

create_plot(){
  cat $1 | grep clients | awk '{ print $7 }' > clients.dat;
  cat $1 | grep 'select\|count\|insert\|update' | awk '{ print $5 }' > qps.dat;
  paste clients.dat qps.dat > clients_qps.dat;
  rm clients.dat;
  rm qps.dat;
}

run_rubocop() {
  g s | awk '{print $2}' | grep -v 'app.rb' | grep -v 'Gemfile' | xargs  rubocop -a
}

#alias ls='ls -ltahG'
alias eclipse="sudo /opt/homebrew-cask/Caskroom/eclipse-java/4.5.2/Eclipse.app/Contents/MacOS/eclipse"
