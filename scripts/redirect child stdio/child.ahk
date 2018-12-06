#include <constants>
#include <mem>
#include <file>
#include <handle>

msgbox 'child start'
main
msgbox 'child end'

exitapp 0

main() 
{ 
	local chBuf := malloc( BUFSIZE )
	ZeroMemory(chBuf, BUFSIZE)
	local dwRead := 0, dwWritten := 0 
	local hStdin := 0, hStdout := 0
	local bSuccess := false

	local hStdout := GetStdHandle( STD_OUTPUT_HANDLE ) 
	local hStdin := GetStdHandle( STD_INPUT_HANDLE )
	if ( 
		(hStdout == INVALID_HANDLE_VALUE) || 
		(hStdin == INVALID_HANDLE_VALUE) 
	) 
		exitapp( 1 ) 
 
	; Send something to this process's stdout using printf.
	printf("`n ** This is a message from the child process. ** `n")

	;	This simple algorithm uses the existence of the pipes to control execution.
	;	It relies on the pipe buffers to ensure that no data is lost.
	;	Larger applications would use more advanced process control.
	
	loop
	{ 
		; Read from standard input and stop on error or no data.
		
		bSuccess := ReadFile(hStdin, chBuf, BUFSIZE, &dwRead, NULL)
		if (! bSuccess || dwRead == 0) 
			break
		
		; Write to standard output and stop on error.
		bSuccess := WriteFile(hStdout, chBuf, dwRead, &dwWritten, NULL)
		if (! bSuccess) 
			break
	}
	
	printf("`n ** This is another message from the child process. ** `n")
	printf('__end__')
	free( chBuf )
	return 0
}