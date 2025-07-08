"===============================================================================
" File:         autobrace.vim
" Author:       Rituraj Borpujari <riturajborpujari@outlook.com>
" Version:      0.1.0
" Description:  perform multiple functionalities related to matching pairs
"               1. auto closes
"                   1. brackets (, {, [
"                   2. quotes ', `, "
"               2. escapes manual typing of closing ')', '}', ']'
"               3. deletes matching pairs with single <BACKSPACE>
"               4. handles extra line insert when <return> is pressed after the
"               opening character of a mathing pair of brackets 
" License:      MIT
" Note:         This work is a modification of - 
"               File:       closepairs.vim
"               Author:     NoWhereMan (Edoardo Vacchi)
"                           <uncommonnonsense at gmail dot com>
"               Version:    0.1
"               Url:        http://www.flatpress.org/
"               License:    Public Domain
"===============================================================================

inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>

inoremap <expr> <bs> <SID>delpair()
inoremap <expr> <cr> <SID>alignedcr()

inoremap <expr> ) <SID>escapepair(')')
inoremap <expr> } <SID>escapepair('}')
inoremap <expr> ] <SID>escapepair(']')

inoremap <expr> " <SID>pairquotes('"')
inoremap <expr> ' <SID>pairquotes("'")
inoremap <expr> ` <SID>pairquotes("`")

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

function! s:delpair()
	let l:lst = ['""',"''",'{}','[]','()','``']
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

function! s:alignedcr()
    let l:lst = [')',"}",']']
	let l:col = col('.') - 1
	let l:line = getline('.')
	let l:chr = l:line[l:col]
	if index(l:lst, l:chr) > -1
		return "\<cr>\<esc>\<s-o>"
	else
		return "\<cr>"
endf

