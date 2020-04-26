set encoding=utf-8
set number
set ruler
set cindent
set expandtab
set sw=4
set ts=4
set sts=0
set clipboard+=unnamed
set hlsearch
syntax on

"set path
let $PATH = "~/.pyenv/shims:".$PATH

augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.vue set filetype=vue.html.javascript.css
    au BufNewFile,BufRead *.yml set filetype=yaml
    au BufNewFile,BufRead *.js set filetype=javascript
augroup END

"set dictionary files
autocmd FileType php,ctp :set dictionary=~/.vim/dict/php.dict
autocmd FileType yaml setlocal ts=2 sw=2
autocmd FileType javascript setlocal ts=2 sw=2

au FileType plantuml command! OpenUml :!open -a /Applications/Google\ Chrome.app %

"set my custom key bind
let mapleader="\<Space>"
inoremap <silent> jj <ESC>
inoremap <silent> っｊ <ESC>
map <leader>j <C-f>
map <leader>k <C-b>


augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | execute "%!xxd -r" | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END

if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug',
        \ {'dir': '~/.vim/plugged/vim-plug/autoload'}

Plug 'scrooloose/nerdtree'

Plug 'kana/vim-smartinput'

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<c-t>'

Plug 'bronson/vim-trailing-whitespace'

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1

"vim-go
Plug 'fatih/vim-go'

"color scheme
Plug 'tomasr/molokai'

"sql
Plug 'vim-scripts/dbext.vim'

"vue syntax
Plug 'posva/vim-vue'

if has('nvim')
  Plug 'Shougo/deoplete.nvim'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1


Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>

" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>

" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>

" Show brief information about the symbol under the cursor
nmap <Leader>K :call phpactor#Hover()<CR>

" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>

" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>

" Extract expression from selection
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

Plug 'kristijanhusak/deoplete-phpactor'

"Asynchronous Lint Engine
Plug 'w0rp/ale'
let g:ale_linters = {
      \ 'php':['phpcs', 'php'],
      \ 'html': [],
      \ 'css': ['stylelint'],
      \ 'javascript': ['eslint'],
      \ 'python': ['flake8'],
      \ 'vue': ['eslint'],
      \ 'yaml': ['yamllint']
      \ }
let g:ale_linter_aliases = {'vue': 'css'}
let g:ale_fixers = {
      \ 'javascript': ['eslint']
      \ }
let g:ale_phpcs_executable = '/usr/local/bin/phpcs'
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_php_phpcs_use_global = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

Plug 'aklt/plantuml-syntax'

call plug#end()

autocmd Filetype php setlocal omnifunc=phpactor#Complete

filetype plugin indent on
call smartinput#map_to_trigger('i','<Plug>(smartinput_BS)', '<BS>', '<BS>')
call smartinput#map_to_trigger('i','<Plug>(smartinput_C-h)','<BS>','<C-h>')
call smartinput#map_to_trigger('i','<Plug>(smartinput_CR)','<Enter>','<Enter>')

colorscheme molokai
