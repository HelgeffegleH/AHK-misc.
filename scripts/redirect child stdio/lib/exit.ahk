ErrorExit(str){
	msgbox str . '`n`n' formatLastError() . '`n`nThe application will close.', 'Error', 0x30
	exitapp( 1 )
}
formatLastError(msgn:=''){
	; Url:
	;	- https://msdn.microsoft.com/en-us/library/windows/desktop/ms679351(v=vs.85).aspx (FormatMessage function)
	; 
	local msg
	static FORMAT_MESSAGE_ALLOCATE_BUFFER:=0x00000100
	static FORMAT_MESSAGE_FROM_SYSTEM:=0x00001000
	if msgn == ''
		msgn := A_LastError ; In case format message changes it
	local lpBuffer := 0
	if DllCall('Kernel32.dll\FormatMessage', 'Uint', FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUFFER, 'Ptr', 0, 'Uint',  msgn, 'Uint', 0, 'PtrP', lpBuffer,  'Uint', 0, 'Ptr', 0, 'Uint')
		msg := StrGet(lpBuffer)
	else 
		throw exception('FormatMessage failed.')
	if !DllCall('Kernel32.dll\HeapFree', 'Ptr', DllCall('Kernel32.dll\GetProcessHeap','Ptr'), 'Uint', 0, 'Ptr', lpBuffer) ; If the function succeeds, the return value is nonzero.
		throw exception('HeapFree failed.')
	return StrReplace(msg, '`r`n') . '  ' . msgn . Format(' (0x{:04x})',msgn)
}
GetLastError(){
	return a_lasterror
}
TEXT(str){
	return str
}