#dllload dll_rand_%a_ptrsize%.dll

random(min := unset, max := unset) {
	local out
	if !isset(max) {
		if !isset(min)
			min := 0.0, max := 1.0 ; no params, use default 0.0, 1.0
		else
			max := min, min := 0 ; only min specified, use 0, min
	}
	local nt := isfloat(min) || isfloat(max) ; determine number type
	local dbl_i64 := nt ? 'double' : 'int64'
	switch a_ptrsize {
		case 8:	dllcall 'dll_rand_8.dll\gen', dbl_i64, min, dbl_i64, max, 'int', nt, dbl_i64 . '*', &out := 0, 'ptr', 0
		case 4:	dllcall 'dll_rand_4.dll\gen', dbl_i64, min, dbl_i64, max, 'int', nt, dbl_i64 . '*', &out := 0, 'ptr', 0
	}
	return out
}

randomseed(seed) {
	switch a_ptrsize {
		case 8:	dllcall 'dll_rand_8.dll\gen', 'int64', 0, 'int64', 0, 'int', 0, 'ptr', 0, 'int64*', seed
		case 4:	dllcall 'dll_rand_4.dll\gen', 'int64', 0, 'int64', 0, 'int', 0, 'ptr', 0, 'int64*', seed
	}
}