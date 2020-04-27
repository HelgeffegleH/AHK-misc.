#include array_n.ahk
class array_n_z extends array_n {
	; zero-based multidimensional array
	static base_index := 0
}

class array_n_bound_check extends array_n {
	; one-based multidimensional array with bound checking
	__item[indicies*] {
		get => base[ this.boundCheck(indicies)* ]
		set => base[ this.boundCheck(indicies)* ] := value
	}
	boundCheck(indicies) {
		if indicies.length !== this.dim.length
			throw exception('To few parameters passed to property __Item', -2, string(indicies.length) . ' of ' . string(this.dim.length))
		base_index :=  this.class.base_index
		for bound in this.dim
			if indicies[a_index] <  base_index
			|| indicies[a_index] >  bound + base_index - 1
			throw exception('Index out of bounds for dimension: ' a_index, -2, 
			'index = ' . string(indicies[a_index]) 
			.  ' with bound = (' . string(base_index) . ', ' . string(bound + base_index - 1) . ').' )
		return indicies ; success, pass indicies along to base.__Item
	}
}

class array_n_init extends array_n {
	; one-based multidimensional array with zero init
	static new(dim*) {
		new_array := base.new(dim*)
		new_array.init()
		return new_array
	}
	init() {
		local itm_set := array.prototype.getownpropdesc('__item').set
		loop this.length
			%itm_set%(this, 0, a_index)
	}
}

class array_n_z_init extends array_n_init {
	; zero-based multidimensional array with zero init.
	static base_index := 0
}