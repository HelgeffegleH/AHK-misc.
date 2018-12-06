#include <constants>
#include <mem>
#include <file>
#include <structs>
#include <exit>
#include <handle>
#include <process>
#include <pipe>

setworkingdir a_scriptdir

if a_args.length() == 0
{
	default_file := 'std_in.txt'
	if !fileexist( default_file )
		fileappend "these lines are passed via stdin from the parent`r`nto the child script`r`nand written to the child's stdout`r`nand printed to the parents stdout", default_file
	sleep 1000 ; due to dropbox synch.
	a_args.push default_file
}

try GetStdHandle( STD_OUTPUT_HANDLE )
catch
	AllocConsole


	
_tmain a_args.length(), a_args

sleep 4000

exitapp( 0 )

_tmain(argc, argv) 
{ 
	
	saAttr := new SECURITY_ATTRIBUTES
	
	saAttr.nLength := sizeof( SECURITY_ATTRIBUTES )
	saAttr.bInheritHandle := true				; Set the bInheritHandle flag so pipe handles are inherited. 
	saAttr.lpSecurityDescriptor := NULL

	printf("`r`n->Start of parent execution.`r`n")

	; Create a pipe for the child process's STDOUT. 
 
	if ( ! CreatePipe(&g_hChildStd_OUT_Rd, &g_hChildStd_OUT_Wr, struct_pointer( saAttr ), 0) ) 
		ErrorExit(TEXT("StdoutRd CreatePipe"))
	
	; Ensure the read handle to the pipe for STDOUT is not inherited.
	
	if ( ! SetHandleInformation(g_hChildStd_OUT_Rd, HANDLE_FLAG_INHERIT, 0) )
		ErrorExit(TEXT("Stdout SetHandleInformation"))

	; Create a pipe for the child process's STDIN. 
 
	if (! CreatePipe(&g_hChildStd_IN_Rd, &g_hChildStd_IN_Wr, struct_pointer( saAttr ), 0)) 
		ErrorExit(TEXT("Stdin CreatePipe"))

	; Ensure the write handle to the pipe for STDIN is not inherited. 
 
	if ( ! SetHandleInformation(g_hChildStd_IN_Wr, HANDLE_FLAG_INHERIT, 0) )
		ErrorExit(TEXT("Stdin SetHandleInformation"))
 
	; Create the child process. 
   
	CreateChildProcess()

	; Get a handle to an input file for the parent. 
	; This example assumes a plain text file and uses string output to verify data flow. 
 
	if (argc == 0)
		ErrorExit(TEXT("Please specify an input file."))
	
	g_hInputFile := CreateFile(
		argv.getaddress(1), 
		GENERIC_READ, 
		0, 
		NULL, 
		OPEN_EXISTING, 
		FILE_ATTRIBUTE_READONLY, 
		NULL)
	
	if ( g_hInputFile == INVALID_HANDLE_VALUE ) 
		ErrorExit(TEXT("CreateFile"))
 
	; Write to the pipe that is the standard input for a child process. 
	; Data is written to the pipe's buffers, so it is not necessary to wait
	; until the child process is running before writing data.
	
	WriteToPipe()
	
	printf( "`n->Contents of %s written to child STDIN pipe.`n", 'astr', argv[1])
 
	; Read from pipe that is the standard output for child process. 
 
	printf( "`n->Contents of child process STDOUT:`n`n")
	
	ReadFromPipe()
	
	printf("`n->End of parent execution.`n")

	; The remaining open handles are cleaned up when this process terminates. 
	; To avoid resource leaks in a larger application, close handles explicitly. 
	
	return 0
} 

CreateChildProcess()
	; Create a child process that uses the previously created pipes for STDIN and STDOUT.
{ 
	local szCmdline := TEXT("child_" . (a_ptrsize == 8 ? '64' : '32') ) ;'"' . a_scriptdir . "\child_" . (a_ptrsize == 8 ? '64' : '32') . '.exe"' ; TEXT("child_" . (a_ptrsize == 8 ? '64' : '32') )
	local piProcInfo := new PROCESS_INFORMATION
	local siStartInfo := new STARTUPINFO
	local bSuccess := false
 
	; Set up members of the PROCESS_INFORMATION structure. 
 
	ZeroMemory( struct_pointer( piProcInfo ), sizeof( PROCESS_INFORMATION ) )
 
	; Set up members of the STARTUPINFO structure. 
	; This structure specifies the STDIN and STDOUT handles for redirection.
 
	ZeroMemory( struct_pointer( siStartInfo ), sizeof( STARTUPINFO ) )
	siStartInfo.cb := sizeof( STARTUPINFO )
	siStartInfo.hStdError := g_hChildStd_OUT_Wr
	siStartInfo.hStdOutput := g_hChildStd_OUT_Wr
	siStartInfo.hStdInput := g_hChildStd_IN_Rd
	siStartInfo.dwFlags |= STARTF_USESTDHANDLES
	
	; Create the child process. 
    
	local bSuccess := CreateProcess(NULL, 	; application name
		&szCmdline,    						; command line 
		NULL,          						; process security attributes 
		NULL,          						; primary thread security attributes 
		TRUE,          						; handles are inherited 
		0,             						; creation flags 
		NULL,          						; use parent's environment 
		NULL,          						; use parent's current directory 
		struct_pointer( siStartInfo ),  	; STARTUPINFO pointer 
		struct_pointer( piProcInfo ) )		; receives PROCESS_INFORMATION 
   
	; If an error occurs, exit the application. 
	if ( ! bSuccess ) 
		ErrorExit(TEXT("CreateProcess"))
	else 
	{
		; Close handles to the child process and its primary thread.
		; Some applications might keep these handles to monitor the status
		; of the child process, for example. 
		CloseHandle(piProcInfo.hProcess)
		CloseHandle(piProcInfo.hThread)
   }
}

AllocConsole(){
	local
	if !b := dllcall('AllocConsole', 'int')
		throw exception(a_thisfunc . ' failed')
	return b
}