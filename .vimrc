set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'thoughtbot/vim-rspec'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-signify'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'Kshitij-Banerjee/Formatted-Commit'
Plugin 'ngmy/vim-rubocop'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'sjl/vitality.vim'
call vundle#end()

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "!spin push {spec}"

set number
set nowrap
set t_Co=256
set title
set list
set listchars=tab:\|\
set cursorline
set noswapfile

"2 space indentings
set expandtab
set shiftwidth=2
set softtabstop=2

syntax on
set foldmethod=syntax

set nocompatible      " We're running Vim, not Vi!
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Highlight after 80 characters
"highlight overlength ctermbg=red ctermfg=white guibg=#592929
"match overlength /\%81v.\+/

execute pathogen#infect()

function F(name)
execute "Ggrep \"".a:name."\""
  cw
endfunction

set runtimepath^=~/.vim/bundle/ctrlp.vim
nmap <F5> :NERDTreeToggle<CR>
nnoremap <C-f> "zyiw :Ggrep <C-R>z <CR>:cw<CR><CR>
if &diff
  colorscheme github-dark
end

"Hate the trailing spaces
match ErrorMsg '\s\+$'
"Removes trailing spaces
nnoremap rtw :%s/\s\+$//e<CR>
set encoding=utf-8

"colorscheme github-dark
colorscheme ir_black

nmap <S-h> <C-o>
nmap <S-l> <C-i>
nmap <C-h> ^
nmap <C-l> $
nmap <C-j> <C-d>
nmap <C-k> <C-u>
nmap <F8> :TagbarToggle <CR>
set background=dark
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2
set noshowmode
set encoding=utf-8
set term=xterm-256color
inoremap <S-CR> <Esc>
let g:vimrubocop_config = '~/flipkart/rubocop.yml'
