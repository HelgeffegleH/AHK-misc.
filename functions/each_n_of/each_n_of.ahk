; enumerator examples:
each_val_of(p*) {
	return each_n_of(1, p*)
}
each_pair_of(p*) {
	return each_n_of(2, p*)
}
each_n_of(n, p*) {
	; n is the number of output parameters for the enumerators.
	; All enumerable objects (in p*) must accept at least n output parameters.
	; Enumeration stops when the first enumerator returns false.
	local
	if !(length := p.length)
		|| n * length > 19
		|| !n
		throw exception('Invalid use.')
	enumerators := []
	for enumerable_obj in p
		enumerators.push  enumerable_obj.__enum( n )
	if length == 1 ; this also implies that n <= 9
		return enumerators[1]
	
	return func('enum')
	
	enum(byref out1 := unset, byref out2 := unset, byref out3 := unset, byref out4 := unset, byref out5 := unset, byref out6 := unset, byref out7 := unset, byref out8 := unset, byref out9 := unset, byref out10 := unset, byref out11 := unset, byref out12 := unset, byref out13 := unset, byref out14 := unset, byref out15 := unset, byref out16 := unset, byref out17 := unset, byref out18 := unset,
		byref out19 := unset) {
		
		i := 0 ; output variable index
		for e in enumerators {
			; call each enumerator using n output variables.
			switch n {
				case 1: r := %e%(out%++i%)
				case 2: r := %e%(out%++i%, out%++i%)
				case 3: r := %e%(out%++i%, out%++i%, out%++i%)
				case 4: r := %e%(out%++i%, out%++i%, out%++i%, out%++i%)
				case 5: r := %e%(out%++i%, out%++i%, out%++i%, out%++i%, out%++i%)
				case 6: r := %e%(out%++i%, out%++i%, out%++i%, out%++i%, out%++i%, out%++i%)
				case 7: r := %e%(out%++i%, out%++i%, out%++i%, out%++i%, out%++i%, out%++i%, out%++i%)
				case 8: r := %e%(out%++i%, out%++i%, out%++i%, out%++i%, out%++i%, out%++i%, out%++i%, out%++i%)
				case 9: r := %e%(out%++i%, out%++i%, out%++i%, out%++i%, out%++i%, out%++i%, out%++i%, out%++i%, out%++i%)
				default: throw exception('Implementation error.')
			}
			if !r
				return false
		}
		return true
	}
}
each_sub_array_of(p) {
	; p can contain any amount of linear sub arrays with a maximum of 19 items each.
	local
	n := p[1].length	; number of output variables, assume all sub-arrays have the same length.
	if n > 19
		throw exception('Not supported.')
	i := 0 				; the index of the sub array (in p) being considered.
	i_max := p.length	; for the end condition
	
	return func('enum')
	
	enum(byref out1 := unset, byref out2 := unset, byref out3 := unset, byref out4 := unset, byref out5 := unset, byref out6 := unset, byref out7 := unset, byref out8 := unset, byref out9 := unset, byref out10 := unset, byref out11 := unset, byref out12 := unset, byref out13 := unset, byref out14 := unset, byref out15 := unset, byref out16 := unset, byref out17 := unset, byref out18 := unset,
		byref out19 := unset) {
		
		if i >= i_max 
			return false
		sub_array := p[++i]
		loop n
			out%a_index% := sub_array[a_index]
		return true
	}
}