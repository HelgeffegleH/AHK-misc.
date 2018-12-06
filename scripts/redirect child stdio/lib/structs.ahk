; user functions
sizeof(o){
	return o.getSize()
}
struct_pointer(o){
	return o.getPtr()
}
; user structs
class STARTUPINFO extends struct_base {
	/*
	typedef struct _STARTUPINFOA {
		DWORD  cb;
		LPSTR  lpReserved;
		LPSTR  lpDesktop;
		LPSTR  lpTitle;
		DWORD  dwX;
		DWORD  dwY;
		DWORD  dwXSize;
		DWORD  dwYSize;
		DWORD  dwXCountChars;
		DWORD  dwYCountChars;
		DWORD  dwFillAttribute;
		DWORD  dwFlags;
		WORD   wShowWindow;
		WORD   cbReserved2;
		LPBYTE lpReserved2;
		HANDLE hStdInput;
		HANDLE hStdOutput;
		HANDLE hStdError;
	} STARTUPINFOA, *LPSTARTUPINFOA;
	typedef struct _STARTUPINFOW {
		DWORD   cb;
		LPWSTR  lpReserved;
		LPWSTR  lpDesktop;
		LPWSTR  lpTitle;
		DWORD   dwX;
		DWORD   dwY;
		DWORD   dwXSize;
		DWORD   dwYSize;
		DWORD   dwXCountChars;
		DWORD   dwYCountChars;
		DWORD   dwFillAttribute;
		DWORD   dwFlags;
		WORD    wShowWindow;
		WORD    cbReserved2;
		LPBYTE  lpReserved2;
		HANDLE  hStdInput;
		HANDLE  hStdOutput;
		HANDLE  hStdError;
	} STARTUPINFOW, *LPSTARTUPINFOW;
	*/
	static __size__of__ := a_ptrsize == 8 ? 104 : 68
	static members := {
		cb 					: [0, 'uint'],
		lpReserved			: [a_ptrsize, 'ptr'],
		lpDesktop			: [a_ptrsize * 2, 'ptr'],
		lpTitle				: [a_ptrsize * 3, 'ptr'],
		dwX					: [a_ptrsize * 4 + 0, 'uint'],
		dwY					: [a_ptrsize * 4 + 4, 'uint'],
		dwXSize				: [a_ptrsize * 4 + 8, 'uint'],
		dwYSize				: [a_ptrsize * 4 + 12, 'uint'],
		dwXCountChars		: [a_ptrsize * 4 + 16, 'uint'],
		dwYCountChars		: [a_ptrsize * 4 + 20, 'uint'],
		dwFillAttribute		: [a_ptrsize * 4 + 24, 'uint'],
		dwFlags				: [a_ptrsize * 4 + 28, 'uint'],
		wShowWindow			: [a_ptrsize * 4 + 32, 'short'],
		cbReserved2			: [a_ptrsize * 4 + 34, 'short'],
		lpReserved2			: [a_ptrsize * 4 + 36 + ( a_ptrsize == 8 ? 4 : 0 ), 'ptr'],
		hStdInput			: [a_ptrsize * 5 + 36 + ( a_ptrsize == 8 ? 4 : 0 ), 'ptr'],
		hStdOutput			: [a_ptrsize * 6 + 36 + ( a_ptrsize == 8 ? 4 : 0 ), 'ptr'],
		hStdError			: [a_ptrsize * 7 + 36 + ( a_ptrsize == 8 ? 4 : 0 ), 'ptr']
	}
}

class PROCESS_INFORMATION extends struct_base {
	/*
	typedef struct _PROCESS_INFORMATION {
		HANDLE hProcess;
		HANDLE hThread;
		DWORD dwProcessId;
		DWORD dwThreadId;
	} PROCESS_INFORMATION, *PPROCESS_INFORMATION, *LPPROCESS_INFORMATION;
	*/
	static __size__of__ := a_ptrsize == 8 ? 24 : 16
	static members := { 
		hProcess 		: [0, 'ptr'],
		hThread 		: [a_ptrsize, 'ptr'],
		dwProcessId		: [a_ptrsize * 2, 'uint'],
		dwThreadId		: [a_ptrsize * 2 + 4, 'uint']
	}
}

class SECURITY_ATTRIBUTES extends struct_base {
	static __size__of__ := a_ptrsize == 8 ? 24 : 12
	/*
	typedef struct _SECURITY_ATTRIBUTES {
		DWORD  nLength;
		LPVOID lpSecurityDescriptor;
		BOOL   bInheritHandle;
	}
	url:
		- https://msdn.microsoft.com/en-us/library/windows/desktop/aa379560(v=vs.85).aspx
	*/
	static members := { 
		nLength 				: [0, 'uint'],
		lpSecurityDescriptor 	: [a_ptrsize, 'ptr'],
		bInheritHandle			: [a_ptrsize * 2, 'int']
	}
	
}
; Interal use
class struct_base {
	__new() {
		objrawset this, chr(1), malloc( sizeof( this ) )
	}
	__get(member) {
		if !this.members.haskey( member )
			throw exception(this.__class ' has no member: ' member)
		local member_data := this.members[ member ]
		return numget(struct_pointer(this), member_data*)
	}
	__set(member, value) {
		if !this.members.haskey( member )
			throw exception(this.__class ' has no member: ' member)
		local member_data := this.members[ member ]
		return numput(value, struct_pointer(this), member_data*)
		
	}
	__delete(){
		free(struct_pointer( this ))
	}
	getPtr(){
		return this[ chr(1) ]
	}
	getSize(){
		local sz := this.__size__of__
		if type( sz ) !== 'Integer'
			throw exception('Struct "size" not set for: ' . type( this ))
		return sz
	}
}