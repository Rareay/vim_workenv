" REQUIRED. This makes vim invoke latex-suite when you open a tex file.
filetype plugin on
set tags=tags;
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex" can be called correctly.
set shellslash
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse latex-suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*
" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

nnoremap <silent> <F7> :TlistToggle<CR>

"set encoding=cp936
set fileencoding=euc-cn
set fileencodings=euc-cn,utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1,
"set termencoding=utf-8
"colors morning
"colors torte 
"colors default
colorscheme desert
set nu
syntax on
syntax enable
"wrap text setting
"set wrap
set lbr
"set text width
"set textwidth=100
"in windows,  gvim is with max window at start
autocmd GUIEnter * simalt ~x
"auto change dir
set autochdir 
set ruler
set showcmd
"set foldmethod=syntax
"set foldmethod=indent
"spell checking
set nospell
:map <C-P> "+gP
":map \f \x<CR>\c<CR>\v<CR>
":map \f :!la.bat
"font setting
"set gfn=courier_new:h16
set gfn=Monaco:h20
"word complete
"autocmd BufEnter * call DoWordComplete()
"set fileencodings=utf8
"set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

"autex.vim
autocmd Filetype tex source $VIMRUNTIME/plugin/auctex.vim
au BufRead *.sv setf systemverilog 
au BufRead *.svh setf systemverilog 
au BufNewFile *.sv setf systemverilog 
au BufNewFile *.svh setf systemverilog 

au BufRead *.v set filetype=verilog 
au BufNewFile *.v set filetype=verilog 

"set nobackup
set noundofile
set bdir=~/.vim/tmp
function VlogDriver()
	let word =expand("<cword>")
	let pattern=join(["\\<", word, "\\>.*[^=]=[^=]"], "")
	let match=search(pattern, 's', line("w1"))
        let @/=join(["\\<", word, "\\>"], "")
endfunction
function VlogInstModule()
	let word ="xm_*"
	let match=search(word, 'bs', line("w1"))
endfunction
:map gk :call VlogDriver()<CR>
:map gj g]
:map sx dd
:map gl :call VlogInstModule()<CR><C-]>

"auto declare wire and reg in verilog file
set autoread
"let maplearder = '\'
map <Space> <leader>
map <leader> <C-w>

nnoremap <leader>i :VerilogFollowInstance<CR>
nnoremap <leader>I :VerilogFollowPort<CR>
nnoremap <leader>v :!~/.vim/plugin/print_wire.sh %<CR><CR>
nnoremap <leader>V :!~/.vim/plugin/delete_wire.sh %<CR><CR>




"seting for tab
set ts=8
set expandtab
set autoindent


"setting copied from automatic =======================================
"
"set fileencoding=utf-8,bg18030,latin1
set termencoding=utf-8
set fileformats=unix
"set encoding=prc

set guifont=Liberation\ Mono\ 14


set tabstop=4
set shiftwidth=4
set softtabstop=4

set smartindent
"set autoindent
set ruler
set hlsearch
set incsearch
set cursorline
"set nowrapscan

let b:match_words = '\<function\>:\<endfunction\>,'
					\ . '\<task\>:\<endtask\>,'
					\ . '\<module\>:\<endmodule\>,'
					\ . '\<begin\>:\<end\>,'
					\ . '\<case\>:\<endcase\>,'
					\ . '\<class\>:\<endclass\>,'
					\ . '\<for\>:\<endfor\>,'
					\ . '\<while\>:\<endwhile\>,'
					\ . '\<specify\>:\<endspecify\>,'
					\ . '\<\(ifdef\|ifndef\)\>:\<\(else\|elsif\)\>:\<endif\>,'
					\ . '`\<\(ifdef\|ifndef\)\>:`\<\(else\|elsif\)\>:`\<endif\>'


"====restore your cursor position in a file over several editing sessions
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


"UltiSnips.txt
"
let   g:UltiSnipsSnippetDirectories=["mysnippets"]
let   g:UltiSnipsExpandTrigger="ii"
"let   g:UltiSnipsExpandTrigger=<tab>
"let   g:UltiSnipsListSnippets=<c-tab>
let   g:UltiSnipsJumpForwardTrigger="<c-j>"
let   g:UltiSnipsJumpBackwardTrigger="<c-k>"


call pathogen#infect()
execute pathogen#infect()

"## Always On:

"``vim
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"``
"
"

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"bufferhint
nnoremap <leader>b :call bufferhint#Popup()<CR>
"nnoremap - :call bufferhint#LoadPrevious()<CR>


" delimitMate
""<BS>         is mapped to <Plug>delimitMateBS
""<S-BS>       is mapped to <Plug>delimitMateS-BS
""<S-Tab>      is mapped to <Plug>delimitMateS-Tab
""<C-G>g       is mapped to <Plug>delimitMateJumpMany



"EASY-ALIGN - 
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

set tags=tags
set autochdir


let Tlist_Show_One_File=1     "��ͬʱ��ʾ����ļ���tag��ֻ��ʾ��ǰ�ļ���    
let Tlist_Exit_OnlyWindow=1   "���taglist���������һ�����ڣ����˳�vim   
let Tlist_Ctags_Cmd="/usr/local/bin/ctags" "��taglist��ctags����"

if filereadable("cscope.out")
    cs add cscope.out
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif

"set cscopequickfix=s-,c-,d-,i-,t-,e-

set laststatus=2      " ������ʾ״̬��"
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%] "��ʾ�ļ��������������ܵ��ַ���
"set ruler "�ڱ༭�����У������½���ʾ���λ�õ�״̬��
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
" ��ȡ��ǰ·������$HOMEת��Ϊ~
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
"set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ asc=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\
set statusline=[%n]\ %f%m%r%h\ \(%{CurDir()}\)%=%l,%c\ \ %p%%\ 
"set statusline=[%n]\ %f%m%r%h\ \|\ \|%=\|\ %l,%c\ %p%%\ \|

"��vimʱ,�Զ���NERDTree
"autocmd vimenter * NERDTree

" ����NerdTree�򿪵Ŀ�ݼ�,�����и���
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

"��NERDTreeΪʣ�µ�Ψһ����ʱ�Զ��ر�
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



map <F4> :MarkdownPreview<CR>
