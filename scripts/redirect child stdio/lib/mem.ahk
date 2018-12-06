malloc(size){
	/*
	void *malloc(  
		size_t size   
	);  
	*/
	local p := dllcall('msvcrt.dll\malloc', 'ptr', size, 'cdecl ptr')
	if !p
		throw exception('malloc failed to alloc: ' . string(size) . ' bytes.')
	return p
}
ZeroMemory(dest, count) {
	/*
	 void *memset(  
		void *dest,  
		int c,  
		size_t count   
	);  
	*/
	dllcall('msvcrt.dll\memset', 'ptr', dest, 'int', 0, 'ptr', count, 'cdecl')
}
free(memblock){
	/*
	void free(   
		void *memblock   
	);  
	*/
	dllcall('msvcrt.dll\malloc', 'ptr', memblock, 'cdecl')
}