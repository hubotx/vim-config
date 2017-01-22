" Environment {
"   Basics {
        " Must be first
        set nocompatible            " be iMproved, required
        filetype off                " required
        
        set background=dark         " Assume a dark background
        
        " " On Windows, also use '.vim' instead of 'vimfiles'; this makes
        " " synchronization
        " " across (heterogeneous) systems easier. 
        if has('win32') || has('win64')
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
    "
    " Setup Bundle Support {
        " " The next two lines ensure that the \~/.vim/bundle/ system works
        " " set the runtime path to include Vundle and initialize
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()
        " " alternatively, pass a path where Vundle should install plugins
        " " call vundle#begin('~/some/path/here')
        "
    " }
" }
"
" General {
    set background=dark         " Assume a dark background
    if !has('win32') && !has('win64')
        set term=$TERM          " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " syntax highlighting
    "set mouse=a                " automatically enable mouse usage
    "set autochdir              " always switch to the current file
    " directory.. Messes with some plugins, best left commented out
    " not every vim is compiled with this, use the following line
    " instead
    " If you use command-t plugin, it conflicts with this, comment it
    " out.
    " autocmd BufEnter \* if bufname("") !\~
    " "\^\\[A-Za-z0-9\\]\*://" | lcd %:p:h | endif
    scriptencoding utf-8

    set autowrite               " automatically write a file when
                                " leaving a modified buffer
    set shortmess+=filmnrxoOtT  " abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set virtualedit=onemore     " allow for cursor beyond last character
    set history=1000            " Store a ton of history (default is 20)
    set spell                   " spell checking on
    
    " Setting up the directories {
        set backup              " backups are nice...
        " Moved to function at bottom of the file
        set backupdir=$HOME/.vimbackup//   " but not when they clog.
        set directory=$HOME/.vimswap//     " same for swap files
        set viewdir=$HOME/.vimviews//      " same for view files
        "
        " Creating directories if they don't exist
        silent execute '!mkdir -p $HVOME/.vimbackup'
        silent execute '!mkdir -p $HOME/.vimswap'
        silent execute '!mkdir -p $HOME/.vimviews'
        au BufWinLeave \* silent! mkview    " make vim save view (state) (folds, cursor, etc)
        au BufWinEnter \* silent! loadview  " make vim load view (state) (folds, cursor, etc)
    " }
" }
"
" Vim UI {
    " color solarized                 " load a colorscheme
    set tabpagemax=15               " only show 15 tabs
    set showmode                    " display the current mode

    set cursorline                  " highlight current line
    "hi cursorline guibg=\#333333    " highlight bg color of current line
    "hi CursorColumn guibg=\#333333  " highlight cursor

    if has('cmdline_info')
        set ruler                   " show the ruler
        "set rulerformat=%30(%=\\:b%n%y%m%r%w\\ %l,%c%V\\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
        " selected characters/lines in visual mode
    endif

    if has('statusline')
         set laststatus=2

         " Broken down into easily includeable segments
         set statusline=%<%f\\   " Filename
         set statusline+=%w%h%m%r " Options
         set statusline+=%{fugitive\#statusline()} "  Git Hotness
         "set statusline+=\\ [%{&ff}/%Y]            " filetype
         "set statusline+=\\ [%{getcwd()}]          " current dir
         "set statusline+=\\ [A=\\%03.3b/H=\\%02.2B] " ASCII / Hexadecimal value of char
         "set statusline+=%=%-14.(%l,%c%V%)\\ %p%%  " Right aligned file nav info
     endif

     set backspace=indent,eol,start  " backspace for dummys
     set linespace=0                 " No extra spaces between rows
     set nu                          " Line numbers on
     set showmatch                   " show matching brackets/parenthesis
     set incsearch                   " find as you type search
     set hlsearch                    " highlight search terms
     set winminheight=0              " windows can be 0 line high 
     set ignorecase                  " case insensitive search
     set smartcase                   " case sensitive when uc present
     set wildmenu                    " show list instead of just completing
     set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
     set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
     set scrolljump=5                " lines to scroll when cursor leaves screen
     set scrolloff=3                 " minimum lines to keep above and below cursor
     set foldenable                  " auto fold code
     set gdefault                    " the /g flag on :s substitutions by default
     set list
     set listchars=tab:>.,trail:.,extends:\#,nbsp:. " Highlight problematic whitespace
     set langmenu=en_GB
     let $LANG = 'en_GB'
     source $VIMRUNTIME/delmenu.vim
     source $VIMRUNTIME/menu.vim
     set wildmenu
     set wildmode=full
     set wildcharm=<C-Z>
     map <F4> :emenu <C-Z>
" }
"
" Plugins {
    " " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'
    "
    " " The following are examples of different formats supported.
    " " Keep Plugin commands between vundle#begin/end.
    " " plugin on GitHub repo
    Plugin 'tpope/vim-fugitive'
    " " plugin from http://vim-scripts.org/vim/scripts.html
    Plugin 'L9'
    " " Git plugin not hosted on GitHub
    Plugin 'git://git.wincent.com/command-t.git'
    " " git repos on your local machine
    " " (i.e. when working on your own plugin)
    " Plugin 'file:///home/gmarik/path/to/plugin'
    " " The sparkup vim script is in a subdirectory of this repo called vim.
    " " Pass the path to set the runtimepath properly.
    Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
    " " Install YouCompleteMe for autocompleting syntax
    Plugin 'Valloric/YouCompleteMe'
    " " Autocompletion for PHP
    Plugin 'shawncplus/phpcomplete.vim'
    " " Autocompletion for Java
    Plugin 'artur-shaik/vim-javacomplete2'
    " " Vim skeleton files
    "Plugin 'pgilad/vim-skeletons'
    " Track the engine.
    " Plugin 'SirVer/ultisnips'
    "
    " " Snippets are separated from the engine. Add this if you want them:
    Plugin 'honza/vim-snippets'
    " Autoclose XML tags
    Plugin 'alvan/vim-closetag'
    " File explorer
    Plugin 'scrooloose/nerdtree'
    " Create user interfaces
    "Plugin 'shougo/unite.vim'
    " lcd to the root of the project everytime you BufEnter a file inside a
    " project.
    "Plugin 'amiorin/vim-project'
    " Vim plugin that displays tags in a window, ordered by scope
    Plugin 'majutsushi/tagbar'
    " Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.)
    Plugin 'joonty/vdebug'
    " The fancy start screen for Vim
    Plugin 'mhinz/vim-startify'

    " Startify {
        autocmd VimEnter * Startify
    " }
    
    " Fugitive {
        autocmd QuickFixCmdPost *grep* cwindow
    " }

    " Project {
        " before call project#rc()
        "let g:project_enable_welcome = 1
        " if you want the NERDTree integration.
        "let g:project_use_nerdtree = 1
        "set rtp+=~/.vim/bundle/vim-project/
        "call project#rc("~/Code")
        
        "Project  'scratch'
        
        "Project  'dotfiles'
        "File     'dotfiles/vimrc'                       , 'vimrc'
        "File     'dotfiles/gvimrc'                      , 'gvimrc'
        "File     'dotfiles/zshrc'                       , 'zshrc'
        
        "Project  'gollum'
        "File     'gollum/Todo.md'                       , 'todo'
        "Callback 'gollum'                               , 'RemoveTextWidth'
        
        "function! RemoveTextWidth(...) abort
        "    setlocal textwidth=0
        "endfunction
        
        "Project  'octopress'
        "Project  'gsource'
        "Project  'markup'
        "Project  'glib'
        "Project  'reloadlive'
        "Project  'flashcards'
        "Project  'leitner'
        "Callback 'leitner'                              , ['AddSpecToPath', 'RemoveTextWidth']
        
        "function! AddSpecToPath(tile) abort
        "    setlocal path+=spec
        "endfunction

        "Project  '~/.vim/bundle/vim-fenced-code-blocks' , 'fenced'
        "Project  '~/.vim/bundle/vim-project'            , 'project'
        "Project  '~/.vim/bundle/vim-bookmarks'          , 'bookmarks'
        "Project  '~/.vim/bundle/ctrlp.vim'              , 'ctrlp'
        "Project  '~/.vim/bundle/ctrlp-z'                , 'ctrlp-z'
        "Project  '~/.vim/bundle/vim-eval'               , 'eval'
    " }

    " NerdTree {
        autocmd VimEnter * NERDTree
    " }

    " CloseTag {
        " filenames like *.xml, *.html, *.xhtml, ...
        let g:closetag_filenames = "*.html,*.xhtml,*.htm,*.xml,*.xslt,*.svg,*.phtml"
    " }

    " UltiSnips {
        " " Trigger configuration. Do not use <tab> if you use
        " https://github.com/Valloric/YouCompleteMe.
        "function! g:UltiSnips_Complete()
            "call UltiSnips#ExpandSnippet()
            "if g:ulti_expand_res == 0
                "if pumvisible()
                    "return "\<C-n>"
                "else
                    "call UltiSnips#JumpForwards()
                    "if g:ulti_jump_forwards_res == 0
                        "return "\<TAB>"
                    "endif
                "endif
            "endif
            "return ""
        "endfunction

        "let g:UltiSnipsExpandTrigger = "<tab>"
        "au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
        "let g:UltiSnipsJumpForwardTrigger="<tab>"
        "let g:UltiSnipsListSnippets="<c-e>"
        " this mapping Enter key to <C-y> to chose
        " the current highlight item 
        " and close the selection list, same as other IDEs.
        " CONFLICT with some plugins like tpope/Endwise
        "inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        "
        " " If you want :UltiSnipsEdit to split your window.
        " let g:UltiSnipsEditSplit="vertical"
    " }
    "
    " " Install L9 and avoid a Naming conflict if you've already installed a
    " " different version somewhere else.
    " Plugin 'ascenator/L9', {'name': 'newL9'}
    "
    " " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required
    " " To ignore plugin indent changes, instead use:
    " "filetype plugin on
    " "
    " " Brief help
    " " :PluginList       - lists configured plugins
    " " :PluginInstall    - installs plugins; append `!` to update or just
    " " :PluginUpdate
    " " :PluginSearch foo - searches for foo; append `!` to refresh
    " " local cache
    " " :PluginClean      - confirms removal of unused plugins;
    " append `!` to auto-approve removal
    " "
    " " see :h vundle for more details or wiki for FAQ
    " " Put your non-Plugin stuff after this line
" }
"
" Formatting {
    syntax on                       " set syntax on
    set expandtab                   " set expand tab
    set shiftwidth=4                " set shift width to 4
    set softtabstop=4               " set soft tab stop to 4
    set autoindent                  " set auto indent
    set smartindent                 " set smart indent
    set smarttab                    " set smart tabs
    set cindent                     " set C-style indent
    set backspace=indent,eol,start  " let backspace delete
    set number                      " set number lines
" }
"
" @partial AutoComplete[class Declarations.Commands] {
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
" }
"
" @partial Key (re)Mappings[class Declarations.Many] {
"   " this mapping Enter key to <C-y> to chose the current highlight item 
"   " and close the selection list, same as other IDEs.
"   " CONFLICT with some plugins like tpope/Endwise
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " @partial AutoComplete[class Declarations.Variable] {
        let g:phpcomplete_mappings = {
                    \ 'jump_to_def': '<C-]>',
                    \ 'jump_to_def_split': '<C-W><C-]>',
                    \ 'jump_to_def_vsplit': '<C-W><C-\>',
                    \}
    " }
" }
"
" @partial AutoComplete[class Declarations.Variable] {
    let g:phpcomplete_add_class_extensions = ['mongo']
    let g:phpcomplete_add_function_extensions = ['mongo']
" }
"
" @partial UltiSnips[class Declarations.Variable] {
    let skeletons#autoRegister = 1
    let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/UltiSnips/"
" }
"
" @partial Key (re)Mappings[class KeyMappings.Simple, interface Plugins.JavaComplete] {
    nmap <leader>jI <Plug>(JavaComplete-Imports-AddMissing)
    nmap <leader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
    nmap <leader>ji <Plug>(JavaComplete-Imports-AddSmart)
    nmap <leader>jii <Plug>(JavaComplete-Imports-Add)

    imap <C-j>I <Plug>(JavaComplete-Imports-AddMissing)
    imap <C-j>R <Plug>(JavaComplete-Imports-RemoveUnused)
    imap <C-j>i <Plug>(JavaComplete-Imports-AddSmart)
    imap <C-j>ii <Plug>(JavaComplete-Imports-Add)

    nmap <leader>jM <Plug>(JavaComplete-Generate-AbstractMethods)
    imap <C-j>jM <Plug>(JavaComplete-Generate-AbstractMethods)

    imap <leader>jA <Plug>(JavaComplete-Generate-Accessors)
    nmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
    nmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
    nmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
    nmap <leader>jts <Plug>(JavaComplete-Generate-ToString)
    nmap <leader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
    nmap <leader>jc <Plug>(JavaComplete-Generate-Constructor)
    nmap <leader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)

    imap <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
    imap <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
    imap <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)

    vmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
    vmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
    vmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
" }
"
" @partial Key re(Mappings)[class KeyMappings.Simple, interface Plugins.Many] {
    nmap <F8> :TagbarToggle<CR>
    nmap <F2> :NERDTreeToggle<CR>
" }
