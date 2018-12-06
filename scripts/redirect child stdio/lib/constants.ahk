global BUFSIZE := 4096 

global NULL := 0
global g_hChildStd_IN_Rd := NULL
global g_hChildStd_IN_Wr := NULL
global g_hChildStd_OUT_Rd := NULL
global g_hChildStd_OUT_Wr := NULL
global g_hInputFile := NULL


global HANDLE_FLAG_INHERIT := 0x00000001

global STARTF_USESTDHANDLES := 0x00000100

global GENERIC_READ 			:= 0x80000000
global OPEN_EXISTING 			:= 3
global FILE_ATTRIBUTE_READONLY	:= 0x00000001

global STD_INPUT_HANDLE 	:= -10
global STD_OUTPUT_HANDLE	:= -11
global STD_ERROR_HANDLE 	:= -12

global INVALID_HANDLE_VALUE := -1

