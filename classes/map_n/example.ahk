#include map_n.ahk
; Example:
mn := map_n.new()			; Create a new map
; Store some values:
mn[1, 1, 1] := 'a'			
mn[1, 1, 2] := 'b'
mn['x', 'y', 'z'] := 1
mn['x', 'y', 'w'] := 2


; Note that you can store values at any "depth", but this loop only works for 3 indices.
; Print:
for index_1, sub_map1 in mn
	for index_2, sub_map2 in sub_map1
		for index_3, value in sub_map2
			msgbox  'mn( ' . index_1 .  ', ' . index_2 . ', ' . index_3 . ' ) := ' . value
