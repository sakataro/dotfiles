set encoding=utf-8
set number
set ruler
set cursorline
set cursorcolumn
set cindent 
set expandtab
set sw=4
set ts=4
set sts=0
syntax on
highlight Normal ctermbg=black ctermfg=grey
highlight StatusLine term=none cterm=none ctermfg=black ctermbg=grey
highlight CursorLine term=none cterm=none ctermfg=none ctermbg=darkgrey

"set my custom key bind
inoremap <silent> jj <ESC>

if has('vim_starting')
    set nocompatible
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install neobundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
let g:neobundle_defaule_git_protocol='https'
NeoBundleFetch 'Shungo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'

NeoBundle 'Shougo/vimfiler'

NeoBundle 'Shougo/vimproc',{
    \'build': {
    \   'windows' : 'make -f make_mingw32.mak',
    \   'cygwin' : 'make -f make_cygwin.mak',
    \   'mac' : 'make -f make_mac.mak',
    \   'unix' : 'make -f make_unix.mak',
    \   },
    \}

NeoBundle 'thinca/vim-quickrun'
    let g:quickrun_config = get(g:, 'quickrun_config',{})
    let g:quickrun_config._ = {
        \ 'runner'    : 'vimproc',
        \ 'rnner/vimproc/updatetime' : 60,
        \ 'outputter' : 'error',
        \ 'outputter/error/success' : 'buffer',
        \ 'outputter/error/error'   : 'quickfix',
        \ 'outputter/buffer/split'  : ':rightbelow 8sp',
        \ 'outputter/buffer/close_on_empty'  : 1,
        \}
    au FileType qf nnoremap <silent><buffer>q :quit<CR>
    let g:quickrun_no_default_key_mappings = 1
    nnoremap \r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
    xnoremap \r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>
    nnoremap <Leader>q :<C-u>bw! \[quickrun\ output\]<CR>

NeoBundle 'Shougo/neocomplete.vim'
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    "inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    echo
    imap <expr> <CR> pumvisible() ? 
        \ neocomplete#close_popup() : "\<Plug>(smartinput_CR)"
    function! s:my_cr_function()
      return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    imap <expr><C-h> neocomplete#smart_close_popup()
    imap <expr><BS> neocomplete#smart_close_popup()."\<Plug>(smartinput_BS)"
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
     
NeoBundle 'kana/vim-smartinput'
NeoBundle 'Shougo/neosnippet.vim'
" Plugin key-mappligs.
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \"\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-n>" : "<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \"\<Plug>(neosnippet_expand_or_jump)"
            \: "<TAB>"
" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle "honza/vim-snippets"
NeoBundle 'mattn/emmet-vim'
let g:user_emmet_leader_key='<c-t>'
NeoBundleCheck
call neobundle#end()
filetype plugin indent on
call smartinput#map_to_trigger('i','<Plug>(smartinput_BS)', '<BS>', '<BS>')
call smartinput#map_to_trigger('i','<Plug>(smartinput_C-h)','<BS>','<C-h>')
call smartinput#map_to_trigger('i','<Plug>(smartinput_CR)','<Enter>','<Enter>')


