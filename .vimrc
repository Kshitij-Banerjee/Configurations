set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'ervandew/screen'
Plugin 'scrooloose/nerdtree'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'pangloss/vim-javascript'
Plugin 'godlygeek/tabular'
Plugin 'tfnico/vim-gradle'
Plugin 'plasticboy/vim-markdown'
call vundle#end()
set encoding=utf-8
set term=xterm-256color

" vim-rspec related shorcits for spin
"map <Leader>t :call RunCurrentSpecFile()<CR>
"map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"map <Leader>a :call RunAllSpecs()<CR>
"let g:rspec_command = "!spin push {spec}"

set number
set nowrap
set t_Co=256
set title
set list
set listchars=tab:\|\
set cursorline
set noswapfile
set hlsearch
set wildmenu
set showmatch
set incsearch
set hlsearch

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

let mapleader = " "

"Highlight after 120 characters
highlight Overlength ctermbg=red ctermfg=white guibg=#592929
match Overlength /\%121v.\+/

"NERDTree shortcuts to change to s/v type mapping
let NERDTreeMapOpenSplit='s'
let NERDTreeMapOpenVSplit='v'

"vim-tmux-navigator shortcuts
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h><C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j><C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k><C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l><C-l> :TmuxNavigateRight<cr>

execute pathogen#infect()

function F(name)
execute "Ggrep \"".a:name."\""
  cw
endfunction

set runtimepath^=~/.vim/bundle/ctrlp.vim
nmap <F5> :NERDTreeToggle<CR>
nmap <Space> za
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
inoremap jk <Esc>
let g:vimrubocop_config = '~/flipkart/rubocop.yml'
autocmd QuickFixCmdPost *grep* cwindow

command -nargs=? -complete=shellcmd W  :w | :call ScreenShellSend("load '".@%."';")
map <Leader>c :ScreenShell console_test <CR>
map <Leader>s :w<CR> :call ScreenShellSend("rspec ".@% . ':' . line('.'))<CR>
map <Leader>b :w<CR> :call ScreenShellSend("break ".@% . ':' . line('.'))<CR>
map <Leader>l :call ScreenShellSend(getline('.'))<CR>
nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>, :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nnoremap <silent> <Leader>. :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
"convert the line into a let(:) block
let @l = '^ilet)€kb(:wwhi)wr{A }'
"fix the files #should mistakes
let @s = ':s/%s/should receive/receives/g:%s/should create/creates/g:%s/should raise/raises/g'
" convert the line into a mock expectation
let @m = '^dwdwwi.expects(:ld wi).withj'
" convert the line into a let!(:) block
let @k = '^wwwwyw^ilet!(:pi€kr_expectation) { A }j'
" convert the line to an expect block
let @e = 'k^ywjiexpect( pi ).tt€kbo eq(A )j'
" enclose with print stars
let @p = "Opp '************************************************************************'Vyjpk^ipp "
" newlines after commas
let @c = ":s/,[ ]*/,\r/ggg=GH"
nnoremap <Leader>w :w<CR>
nnoremap <Leader><S-w> :W<cr>


let g:tagbar_type_puppet = {
  \ 'ctagstype': 'puppet',
  \ 'kinds': [
    \'c:class',
    \'s:site',
    \'n:node',
    \'d:definition',
    \'r:resource',
    \'f:default'
  \]
  \}
