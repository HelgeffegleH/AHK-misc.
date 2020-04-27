class array_n extends array {
	; one-based multidimensional array
	; Usage:
	; new_array := array_n.new(dimensions*)
	; dimensions, an array where item k indicates the size of dimension k.
	; Maps any amount of indices to an index in an "underlying" linear array
	; No bound checking is done on dimension level, out of bounds access on the "underlying" linear array is detected automatically.
	static base_index := 1 ; indicates one-based, subclasses can override this.
	static __new() => this.prototype.class := this ; to allow subclasses to override base_index 
	__new(dimensions*) {
		local
		; calculate the length of the "underlying" array
		l := 1	
		for length in dimensions
			l *= length
		this.length := l 			; sets the capacity of the linear "underlying" array
		this.dim := dimensions		; store dimension sizes for proper index calculation
	}
	__item[indices*] {
		; Access the underlying linear array:
		get => base[ this.getIndex( indices ) ]				
		set => base[ this.getIndex( indices ) ] := value
	}
	
	getIndex(indices) {
		; Calculates the index in the "underlying" linear array
		local
		linear_index 													; linear_index is the index to access in the underlying linear array. 
			:= base_index  												; To begin, pretend that the base index of the underlying array matches 
			:= this.class.base_index 									; this base index.
											
		, dimension_offset := 1											; Start at the first "dimension offset"
		, dim := this.dim 												; look up once
		
		; consider (without any regard to base_index): arr[x1, ..., xn] with bounds [d1, ..., dn]
		; then we access underlying_arr[ xn
		; + x{n-1} * dn
		; + x{n-2} * dn * d{n-1}
		; + ...
		; + x1 * d2 * ... * dn ]
		
		; Note: if n < L := this.dim.length, then we do the same as above but with,
		; arr[xk, ..., xL] with bounds [dk, ..., dL] where k := L - n - 1,
		; in particular with n := 1, k becomes L and arr[x] will access underlying_arr[x]
		; which implies that we can access arr[x] for all base_index <= x  < this.length + base_index
		
		loop n := indices.length
			linear_index += (indices[ n ] - base_index)
				* dimension_offset
			, dimension_offset *= dim[ n-- ]	; dn * d{n-1} * ... * d2 
												; (the last iteration will do dimension_offset *= d1 but it will not be used)

		return linear_index	
			- base_index	; compensate for the choosen base index
			+ 1				; compensate for the "underlying" array being one-based
	}
}