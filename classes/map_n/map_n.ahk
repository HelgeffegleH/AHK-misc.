; An "n-dimensional" map.
class map_n extends map {
	static __new()
		=> this.prototype.class := this			; for __item to work for a general subclass.
	
	__item[k1, p*] {
		; Consider one index at a time, k1.
		get {
			return p.length 			
				; Below, the first index operator invokes "map.__item[this, k1]" (since we use the "super" keyword),
				; the second, [p*], invokes "map_n.__item" since the first index operator returns an object of type map_n,
				; which is ensured by the setter below.
				? super[k1][p*] 				; Get the sub-map (map_n) and invoke it with the remaining indices.
				: super[k1]						; Reached the lowest lever, get the stored value.
			
		}
		set {
			if	p.length  						; If there are still parameters remaining
				&& (!super.has(k1)				; and this index has not been set before
				
				|| !(super[k1] is this.class))	; or it was set but is not a map_n. (need this check to allow overwriting existing indices)
				; Then:
				super[k1] := (this.class)()		; store a sub-map (map_n) here. This sub-map will either hold the value,
												; or another sub-map which will either hold the value or ... until
												; p.length == 0 and the value will be stored in the final sub-map.
			
			( p.length )						; Any remaining indices ?
				? super[k1][p*] := value 		; Yes, then invoke the sub-map with one less parameters than this setter was called with.
												
			
				: super[k1] := value			; No, then we store the value in this sub-map, without creating any other sub-map. 
												; We use "super" to avoid invoking the above getter, this will just store the value instead.
		}
	}
}
