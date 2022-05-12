#include array_n.ahk
; 3-D example:
; Create a "book" of grids:
pages := 2
rows := 2
cols := 2

grid_book := array_n(pages, rows, cols)

grid_book[1,1,2] := 'A'
grid_book[2,2,1] := 'B'

; For visual comparison, a similar book of grids, consisting of an array of arrays of arrays:
grid_book_2 := [
	[ 	; page 1
		[	; row 1
			'' , 'a' ; col1, col2
		],
		[	; row 2
			'', '' ; col1, col2
		]
	],			
	[ 	; page 2
		[	; row 1
			'', '' ; col1, col2
		],
		[	; row 2
			'b', '' ; col1 col2
		]
	]
]
; Print
msgbox 'Print grid book example, array_n on line one:`n`n'
	. grid_book[1, 1, 2] . '`t' . grid_book[2, 2, 1] . '`n'	; can't access grid_book[][][], must use [...]
	. grid_book_2[1][1][2] . '`t' . grid_book_2[2][2][1]		; can't access grid_book_2[ind*] must use  [][][]

