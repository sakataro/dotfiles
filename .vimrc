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

augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.vue set filetype=vue.html.javascript.css
    au BufNewFile,BufRead *.yml set filetype=yaml
    au BufNewFile,BufRead *.js set filetype=javascript
    au BufNewFile,BufRead *.blade.php set filetype=html
    au BufRead,BufNewFile *.ts set filetype=typescript
augroup END

"set dictionary files
autocmd FileType php,ctp :set dictionary=~/.vim/dict/php.dict
autocmd FileType yaml setlocal ts=2 sw=2
autocmd FileType javascript setlocal ts=2 sw=2
autocmd FileType typescript setlocal ts=2 sw=2
autocmd FileType html setlocal ts=2 sw=2
autocmd FileType json setlocal ts=2 sw=2

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

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'kana/vim-smartinput'

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<c-t>'

Plug 'bronson/vim-trailing-whitespace'

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1

"color scheme
Plug 'tomasr/molokai'

"language server protocol(lsp) settings
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

"completion by lsp
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"


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
let g:ale_phpcs_executable = '/usr/local/bin/phpcs'
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_php_phpcs_use_global = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

Plug 'aklt/plantuml-syntax'

Plug 'jparise/vim-graphql'

Plug 'hashivim/vim-terraform'

Plug 'jwalton512/vim-blade'
let g:terraform_fmt_on_save = 1

"保存時に自動でフォーマット
autocmd BufWritePre <buffer> LspDocumentFormatSync

Plug 'leafgarland/typescript-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

Plug 'elmcast/elm-vim'

call plug#end()

colorscheme molokai
