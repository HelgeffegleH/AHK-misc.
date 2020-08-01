#include 'each_n_of.ahk'

; Example 1
array_1 := [11, 12, 13]
array_2 := [21, 22, 23]
array_3 := [31, 32, 33]

for v1, v2, v3 in each_val_of(array_1, array_2, array_3)
	msgbox 	'Example 1:`n`n'
		. v1 . '`t' . v2 '`t' . v3

; Example 2
map_1 := map('key11', 'val11', 'key12', 'val12')
map_2 := map('key21', 'val21', 'key22', 'val22')
map_3 := map('key31', 'val31', 'key32', 'val32')

for	  k1,v1
	, k2,v2
	, k3,v3 in each_pair_of(map_1, map_2, map_3)
	msgbox 	'Example 2:`n`n'
		. k1 . '`t' . v1 . '`n' 	; map_1
		. k2 . '`t' . v2 . '`n'		; map_2
		. k3 . '`t' . v3			; map_3
		
; Example 3
for x, y, z in each_sub_array_of([array_1, array_2, array_3])
	msgbox 	'Example 3:`n`n'
		. 'array_' . a_index . ' := [ '
		. x . '`t' . y . '`t' . z . ' ]'
		

