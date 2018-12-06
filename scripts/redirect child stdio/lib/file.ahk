WriteFile(
	hFile,
    lpBuffer,
    nNumberOfBytesToWrite,
    lpNumberOfBytesWritten,
    lpOverlapped ) {
	/*
	BOOL WriteFile(
		HANDLE       hFile,
		LPCVOID      lpBuffer,
		DWORD        nNumberOfBytesToWrite,
		LPDWORD      lpNumberOfBytesWritten,
		LPOVERLAPPED lpOverlapped
	);
	*/
	return dllcall('Kernel32.dll\WriteFile',
		'ptr', 	hFile,
		'ptr', 	lpBuffer,
		'uint',	nNumberOfBytesToWrite,
		'ptr', 	lpNumberOfBytesWritten,
		'ptr', 	lpOverlapped,
		'int' )
}
ReadFile(
	hFile,
    lpBuffer,
    nNumberOfBytesToRead,
    lpNumberOfBytesRead,
    lpOverlapped ) {
	/*
	BOOL ReadFile(
		HANDLE       hFile,
		LPVOID       lpBuffer,
		DWORD        nNumberOfBytesToRead,
		LPDWORD      lpNumberOfBytesRead,
		LPOVERLAPPED lpOverlapped
	);
	*/
	return dllcall('Kernel32.dll\ReadFile',
		'ptr', 	hFile,
	    'ptr', 	lpBuffer,
	    'uint',	nNumberOfBytesToRead,
	    'ptr', 	lpNumberOfBytesRead,
	    'ptr', 	lpOverlapped,
		'int' )
}
CreateFile(
	lpFileName,
    dwDesiredAccess,
    dwShareMode,
    lpSecurityAttributes,
    dwCreationDisposition,
    dwFlagsAndAttributes,
    hTemplateFile ) {
	/*
	HANDLE CreateFileW(
		LPCWSTR               lpFileName,
		DWORD                 dwDesiredAccess,
		DWORD                 dwShareMode,
		LPSECURITY_ATTRIBUTES lpSecurityAttributes,
		DWORD                 dwCreationDisposition,
		DWORD                 dwFlagsAndAttributes,
		HANDLE                hTemplateFile
	);
	*/
	return dllcall('Kernel32.dll\CreateFile',
		'ptr', 	lpFileName,
		'uint', dwDesiredAccess,
		'uint', dwShareMode,
		'ptr', 	lpSecurityAttributes,
		'uint', dwCreationDisposition,
		'uint', dwFlagsAndAttributes,
		'ptr', 	hTemplateFile,
		'ptr')
}
printf(fmt, p*){
	p.push 'cdecl int'
	return dllcall('msvcrt.dll\printf', 'astr', fmt, p*)
}
