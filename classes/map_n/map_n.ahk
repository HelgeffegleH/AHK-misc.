; An "n-dimensional" map.
class map_n extends map {
	__item[k1, p*] {
		; Consider one index at a time, k1.
		get {
			return p.length 			
				; Below, the first index operator invokes "map.__item[this, k1]" (since we use the "base" keyword),
				; the second, [p*], invokes "map_n.__item" since the first index operator returns an object of type map_n,
				; which is ensured by the setter below.
				? base[k1][p*] 				; Get the sub-map (map_n) and invoke it with the remaining indices.
				: base[k1]					; Reached the lowest lever, get the stored value.
			
		}
		set {
			if	p.length  					; If there are still parameters remaining
				&& (!this.has(k1)			; and this index has not been set before
				
				|| !(base[k1] is map_n))	; or it was set but is not a map_n. (need this check to allow overwriting existing indices)
				; Then:
				base[k1] := map_n.new()		; store a sub-map (map_n) here. This sub-map will either hold the value,
											; or and other sub-map which will either hold the value or ... until
											; p.length == 0 and the value will be stored in the final sub-map.
			
			( p.length )					; Any remaining indices ?
				? this[k1][p*] := value 	; Yes, then invoke the sub-map with one less parameters than this setter was called with.
											; Note that this[k1], will invoken the getter above
			
				: base[k1] := value			; No, then we store the value in this sub-map, without creating any other sub-map. 
											; We use "base" to avoid invoking the above getter, this will just store the value instead.
		}
	}
}
