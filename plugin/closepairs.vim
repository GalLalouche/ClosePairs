"==============================================================================
" closepairs.vim - Auto closes pairs of characters
"==============================================================================
"
" Author:   Gal Lalouche
"	OriginalAuthor:  NoWhereMan (Edoardo Vacchi) <uncommonnonsense at gmail dot com>
" Version:  0.1
" License:  Public Domain
"==============================================================================


inoremap <expr> ( <SID>insertpair('(', ')')
inoremap <expr> [ <SID>insertpair('[', ']')
inoremap <expr> { <SID>insertpair('{', '}')
inoremap <expr> " <SID>insertpair('"', '"')
inoremap <expr> ' <SID>insertpair("'", "'")
inoremap <expr> < <SID>insertpair("<", ">")

" Not needed anymore since vim-surround
" vnoremap <leader>" "zdi"<c-r>z"
" vnoremap <leader>( "zdi(<c-r>z)
" vnoremap <leader>[ "zdi[<c-r>z]
" vnoremap <leader>{ "zdi{<c-r>z}

inoremap <expr> <bs> <SID>delpair()

inoremap <expr> ) <SID>escapepair(')')
inoremap <expr> } <SID>escapepair('}')
inoremap <expr> ] <SID>escapepair(']')


function! s:insertpair(a, b)
	let l:chr = getline('.')[col('.') - 1]
	if ' ' == l:chr || '' == l:chr
		return a:a.a:b."\<left>"
	else
		return a:a
endf

function! s:delpair()
	let l:lst = ['""',"'",'{}','[]','()', '<>']
	let l:col = col('.')
	let l:line = getline('.')
	let l:chr = l:line[l:col-2 : l:col-1]
	if index(l:lst, l:chr) > -1
		return "\<bs>\<del>"
	else
		let l:chr = l:line[l:col-3:l:col-2]
		if (index(l:lst, l:chr)) > - 1
			return "\<bs>\<bs>"
		endif
		return "\<bs>"
endf

function! s:escapepair(right)
	let l:col = col('.')
	let l:chr = getline('.')[l:col-1]
	if a:right == l:chr 
		return "\<right>"
	else
		return a:right

endf

function! s:pairquotes(pair)
	let l:col = col('.')
	let l:line = getline('.')
	let l:chr = l:line[l:col-1]
	if a:pair == l:chr 
		return "\<right>"
	else
		return a:pair.a:pair."\<left>"

endf

