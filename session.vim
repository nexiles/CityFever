let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <S-Tab> =BackwardsSnippet()
inoremap <C-Tab> 	
inoremap <silent> <Plug>NERDCommenterInInsert  <BS>:call NERDComment(0, "insert")
inoremap <C-Space> 
map! <D-v> *
snoremap <silent> 	 i<Right>=TriggerSnippet()
snoremap  b<BS>
snoremap % b<BS>%
snoremap ' b<BS>'
nmap <silent> ,t :CommandT
nmap ,ihn :IHN
nmap ,is :IHS:A
nmap ,ih :IHS
nmap ,ca <Plug>NERDCommenterAltDelims
vmap ,cA <Plug>NERDCommenterAppend
nmap ,cA <Plug>NERDCommenterAppend
vmap ,c$ <Plug>NERDCommenterToEOL
nmap ,c$ <Plug>NERDCommenterToEOL
vmap ,cu <Plug>NERDCommenterUncomment
nmap ,cu <Plug>NERDCommenterUncomment
vmap ,cn <Plug>NERDCommenterNest
nmap ,cn <Plug>NERDCommenterNest
vmap ,cb <Plug>NERDCommenterAlignBoth
nmap ,cb <Plug>NERDCommenterAlignBoth
vmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cl <Plug>NERDCommenterAlignLeft
vmap ,cy <Plug>NERDCommenterYank
nmap ,cy <Plug>NERDCommenterYank
vmap ,ci <Plug>NERDCommenterInvert
nmap ,ci <Plug>NERDCommenterInvert
vmap ,cs <Plug>NERDCommenterSexy
nmap ,cs <Plug>NERDCommenterSexy
vmap ,cm <Plug>NERDCommenterMinimal
nmap ,cm <Plug>NERDCommenterMinimal
vmap ,c  <Plug>NERDCommenterToggle
nmap ,c  <Plug>NERDCommenterToggle
vmap ,cc <Plug>NERDCommenterComment
nmap ,cc <Plug>NERDCommenterComment
vmap <silent> ,vR <Plug>EgMapReplaceSelection_R
nmap <silent> ,vR <Plug>EgMapReplaceCurrentWord_R
omap <silent> ,vR <Plug>EgMapReplaceCurrentWord_R
vmap <silent> ,vr <Plug>EgMapReplaceSelection_r
nmap <silent> ,vr <Plug>EgMapReplaceCurrentWord_r
omap <silent> ,vr <Plug>EgMapReplaceCurrentWord_r
vmap <silent> ,vA <Plug>EgMapGrepSelection_A
nmap <silent> ,vA <Plug>EgMapGrepCurrentWord_A
omap <silent> ,vA <Plug>EgMapGrepCurrentWord_A
vmap <silent> ,va <Plug>EgMapGrepSelection_a
nmap <silent> ,va <Plug>EgMapGrepCurrentWord_a
omap <silent> ,va <Plug>EgMapGrepCurrentWord_a
vmap <silent> ,vV <Plug>EgMapGrepSelection_V
nmap <silent> ,vV <Plug>EgMapGrepCurrentWord_V
omap <silent> ,vV <Plug>EgMapGrepCurrentWord_V
vmap <silent> ,vv <Plug>EgMapGrepSelection_v
nmap <silent> ,vv <Plug>EgMapGrepCurrentWord_v
omap <silent> ,vv <Plug>EgMapGrepCurrentWord_v
map <silent> ,vo <Plug>EgMapGrepOptions
map ,e :e =expand("%:h")/
nmap ,a :A
nnoremap <silent> 0j :OScan lastdown
nnoremap <silent> 0k :OScan lastup
nnoremap <silent> 0l :OScan last
nnoremap <silent> 0n :OScan definition_declaration
nnoremap <silent> 0u :OScan taglist_under_cursor
nnoremap <silent> 0M :OScan marks global user
nnoremap <silent> 0m :OScan marks
nnoremap <silent> 0h :OScan changes
nnoremap <silent> 0p :OScan paste
nnoremap <silent> 0v :OScan vims
nnoremap <silent> 0w :OScan windows
nnoremap <silent> 0b :OScan buffers
nnoremap <silent> 0as :OScan search_in_scope
nnoremap <silent> 0S :OScan multiline_search
nnoremap <silent> 0s :OScan search
nnoremap <silent> 0g :OScan file 
nnoremap <silent> 0o :OScan file object
nnoremap <silent> 0d :OScan file destructor
nnoremap <silent> 0c :OScan file constructor
nnoremap <silent> 0t :OScan file
nmap K :call ShowPyDoc('', 1)
snoremap U b<BS>U
vmap [[ :PBoBm'gv``
nmap [[ :PBoB
omap [[ :PBoB
snoremap \ b<BS>\
vmap ]f :call PythonDec("function", 1)
vmap ]F :call PythonDec("function", -1)
vmap ]j :call PythonDec("class", 1)
vmap ]J :call PythonDec("class", -1)
vmap ]u :call PythonUncommentSelection()
vmap ]# :call PythonCommentSelection()
vmap ]> >
vmap ]< <
vmap ]] :PEoBm'gv``
nmap ]f :call PythonDec("function", 1)
omap ]f :call PythonDec("function", 1)
nmap ]F :call PythonDec("function", -1)
omap ]F :call PythonDec("function", -1)
nmap ]j :call PythonDec("class", 1)
omap ]j :call PythonDec("class", 1)
nmap ]J :call PythonDec("class", -1)
omap ]J :call PythonDec("class", -1)
nmap ]u :call PythonUncommentSelection()
omap ]u :call PythonUncommentSelection()
nmap ]# :call PythonCommentSelection()
omap ]# :call PythonCommentSelection()
nmap ]> [[V]]>
omap ]> [[V]]>
nmap ]< [[V]]<
omap ]< [[V]]<
nmap ]] :PEoB
omap ]] :PEoB
map ]<Down> :call PythonNextLine(1)
map ]<Up> :call PythonNextLine(-1)
map ]c :call PythonSelectObject("class")
map ]v [[V]]
snoremap ^ b<BS>^
snoremap ` b<BS>`
nmap gx <Plug>NetrwBrowseX
snoremap <Left> bi
snoremap <Right> a
snoremap <BS> b<BS>
snoremap <silent> <S-Tab> i<Right>=BackwardsSnippet()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nmap <silent> <Plug>NERDCommenterAppend :call NERDComment(0, "append")
nnoremap <silent> <Plug>NERDCommenterToEOL :call NERDComment(0, "toEOL")
vnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment(1, "uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment(0, "uncomment")
vnoremap <silent> <Plug>NERDCommenterNest :call NERDComment(1, "nested")
nnoremap <silent> <Plug>NERDCommenterNest :call NERDComment(0, "nested")
vnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment(1, "alignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment(0, "alignBoth")
vnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment(1, "alignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment(0, "alignLeft")
vmap <silent> <Plug>NERDCommenterYank :call NERDComment(1, "yank")
nmap <silent> <Plug>NERDCommenterYank :call NERDComment(0, "yank")
vnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment(1, "invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment(0, "invert")
vnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment(1, "sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment(0, "sexy")
vnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment(1, "minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment(0, "minimal")
vnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment(1, "toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment(0, "toggle")
vnoremap <silent> <Plug>NERDCommenterComment :call NERDComment(1, "norm")
nnoremap <silent> <Plug>NERDCommenterComment :call NERDComment(0, "norm")
nmap <D-CR> $v%zf
nmap <C-CR> za
nmap <F1> :NERDTreeToggle
nmap <C-Tab> :NERDTreeToggle
nmap <D-Left> :tabp
nmap <D-Right> :tabn
map <silent> <S-D-Left> :macaction selectPreviousWindow:
map <silent> <S-D-Right> :macaction selectNextWindow:
nmap <C-S-Down> <Down>_
nmap <C-S-Up> <Up>_
nmap <C-Left> <Left>
nmap <C-Right> <Right>
nmap <C-Down> <Down>
nmap <C-Up> <Up>
nmap <F9> :cp
nmap <S-F10> :cn
nmap <F7> z
nmap <S-F8> :ptnext
nmap <F8> }
nmap <F5> :bp
nmap <F6> :bn
nmap <F4> :bdel
nmap <S-F2> :make
nmap <F2> :w
xmap <BS> "-d
vmap <D-x> "*d
vmap <D-c> "*y
vmap <D-v> "-d"*P
nmap <D-v> "*P
inoremap <silent> 	 =TriggerSnippet()
inoremap <silent> 	 =ShowAvailableSnips()
imap ,ihn :IHN
imap ,is :IHS:A
imap ,ih :IHS
abbr kmod :r ~/.vim/skeletons/skeleton.py
abbr kvpdb import vimpdb; vimpdb.set_trace()
abbr kipdb import ipdb; ipdb.set_trace()
abbr kpdb import pdb; pdb.set_trace()
abbr kvim # vim: set ft=python ts=4 sw=4 expandtab :
abbr kportlets :r ~/.vim/templates/portlets.xml
abbr kviewlet :r ~/.vim/templates/viewlets.xml
abbr krolemap :r ~/.vim/templates/rolemap.xml
abbr kwf :r ~/.vim/templates/workflow.xml
abbr kwfs :r ~/.vim/templates/workflows.xml
abbr kjs :r ~/.vim/templates/jsregistry.xml
abbr kkss :r ~/.vim/templates/kssregistry.xml
abbr kcss :r ~/.vim/templates/cssregistry.xml
abbr kskins :r ~/.vim/templates/skins.xml
abbr ktype :r ~/.vim/templates/type.xml
abbr ktypes :r ~/.vim/templates/types.xml
abbr kactions :r ~/.vim/templates/actions.xml
abbr kconfigure :r ~/.vim/templates/configure.zcml
abbr kpt :r ~/.vim/templates/kbrowserview.pt
abbr kbrowserview :r ~/.vim/templates/kbrowserview.py
abbr khead :r ~/.vim/templates/head.py
abbr kclass :r ~/.vim/templates/atclass.py
abbr kconfig :r ~/.vim/templates/config.py
abbr kinit :r ~/.vim/templates/init.py
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set background=dark
set backspace=2
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set fuoptions=maxvert,maxhorz
set guifont=Menlo:h14
set guioptions=egt
set guitablabel=%M%t
set helplang=de
set hlsearch
set incsearch
set langmenu=none
set listchars=trail:·,extends:>,precedes:<,tab:»·
set makeprg=~/bin/ptest
set mouse=a
set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ +\ v:shell_error
set ruler
set scrolloff=5
set shiftwidth=4
set showmatch
set statusline=%<%f%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ 0x%0B
set switchbuf=useopen
set tabstop=4
set termencoding=utf-8
set updatetime=3000
set visualbell
set wildignore=*.pyc
set wildmode=longest,list
set winminheight=0
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/.vim/ftplugin
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 ~/develop/bfever/CityFever/Classes/CityFeverAppDelegate.m
badd +1 ~/develop/bfever/CityFever/Classes/CityFeverAppDelegate.h
badd +13 ~/.vim/plugin/cocoa.vim
badd +1 ~/.vim/mappings.vim
badd +5 ~/.vim/settings.vim
badd +1 ~/.vim/muha.vim
badd +1 ~/.vim/skeletons/skeleton.pt
badd +1 ~/.vim/skeletons/skeleton.py
badd +1 objc_matchbracket.vim
badd +32 ~/.vim/ftplugin/objc_cocoa_mappings.vim
args ~/develop/bfever/CityFever/Classes/CityFeverAppDelegate.m
edit ~/develop/bfever/CityFever/Classes/CityFeverAppDelegate.m
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <silent> <F5> 
nnoremap <buffer> <silent> K :call objc#man#ShowDoc()
nnoremap <buffer> <D-]> >>
nnoremap <buffer> <D-[> <<
nnoremap <buffer> <D-/> I// 
nmap <buffer> <silent> <D-CR> <D-r>
nnoremap <buffer> <silent> <D-2> :ListMethods
nnoremap <buffer> <silent> <D-0> :call system('open -a Xcode '.b:cocoa_proj)
cnoremap <buffer> <expr>  fugitive#buffer().rev()
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'objc'
setlocal filetype=objc
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=marker
setlocal foldmethod=marker
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=^s*#s*import
setlocal includeexpr=
setlocal indentexpr=GetObjCIndent()
setlocal indentkeys=0{,0},0#,!^F,o,O,e,<:>
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
set list
setlocal list
setlocal nomacmeta
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=objc#cocoacomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal smartindent
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'objc'
setlocal syntax=objc
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 26 - ((25 * winheight(0) + 34) / 69)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
26
normal! 015l
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
