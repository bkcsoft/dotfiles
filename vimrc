set nocompatible

set title

set nobackup

syntax on
set fdm=marker
set mouse=a
set nolazyredraw
set number
set numberwidth=5
set autoindent
set smartindent
set copyindent
set smartcase
colorscheme desert

nmap <leader>s :w !share<CR><CR>

" Matrix-Screensaver
nmap m :Matrix<CR>

" NERDTree {{{
nmap <F11> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
" }}}

" Compile
set efm=%f:%l:%c:\ %m
set makeprg=bam\ -a
nmap <F12> :make<CR>

" git {{{
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gd :Gdiff<CR>
" }}}

" Tabs {{{
nmap <C-T>n :tabnew<CR>
nmap <C-T>l :tabnext<CR>
nmap <C-T>h :tabprevious<CR>
nmap <C-T>q :tabclose<CR> 
" }}}

" Buffers {{{
"nmap <C-tab> :bn<CR>
"imap <C-tab> <ESC>:bn<CR>i
"nmap <C-S-tab> :bp<CR>
"imap <C-S-tab> <ESC>:bp<CR>i
" }}}

" hjkl ffs {{{
map <UP> <NOP>
map <DOWN> <NOP>
map <LEFT> <NOP>
map <RIGHT> <NOP>
" }}}

" Word-files {{{
au BufReadPre *.doc set ro
au BufReadPre *.doc set hlsearch!
au BufReadPost *.doc %!antiword "%"
" }}}

" RTF-Files {{{
au BufReadPre *.rtf set ro
au BufReadPre *.rtf set hlsearch!
au BufReadPost *.rtf %!unrtf --text "%"
" }}}

" Sessions {{{
nmap <C-s> :mks 
au VimLeavePre * if v:this_session != '' | exec "mks! " . v:this_session | endif
" }}}

" jQuery-stuff
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

" LaTeX
let g:tex_flavor='latex'
