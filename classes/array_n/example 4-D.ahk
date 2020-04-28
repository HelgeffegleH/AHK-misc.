#include array_n.ahk
; 4-D loop example:
; Create a book of 3 chapters each with 2 pages containing a grid of 3 rows and 4 columns:
arr := array_n.new(3, 2, 3, 4) 

; All elements in an array_n is layed out sequentially in an underlaying linear array.
loop arr.length ; the size of the array
	arr[a_index] := a_index ; arr[x] access the_underlying_array[x]

; print:
s := ''
chapter := 1
page := 1
for v in arr {
	
	if !mod(a_index-1, 24) 					; every 24:th value starts a new page		(2*3*4*1)
		s .= '`n`nChapter ' . chapter++ . ':', page := 1
	if !mod(a_index-1, 12) 					; every twelveth value starts a new page	(3*4*1)
		s .= '`nPage ' . page++ . ':'
	if !mod(a_index-1, 4) 					; every fourth value starts a new row		(4*1)
		s .= '`n'
	
	s .= v . '`t'
	
}
msgbox 'A book with three chapters, each with two pages containing a 3 by 4 grid:' . s

; If the above was a 5-D example, eg, a bookshelf with x 4-D books, arr := array_n.new(x, 3, 2, 3, 4)
; then we'd print each book by adding something like:
; if !mod(a_index-1, 3*2*3*4) 
; 	s .= 'new book'
; A 6-D example, eg z bookshelves with x books would use !mod(a_index-1, x*3*2*3*4) to print each bookshelf.