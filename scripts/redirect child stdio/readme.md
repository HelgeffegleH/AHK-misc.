### Example script

AHK v2-a100 version of MSDN example: [Creating a Child Process with Redirected Input and Output](https://docs.microsoft.com/en-us/windows/desktop/procthread/creating-a-child-process-with-redirected-input-and-output)

### How to

* __1)__ Copy  `AutoHotkey32U.exe` and `AutoHotkey64U.exe` to the same folder as `child_32.ahk` and `child_64.ahk`, rename the executables to `child_32.exe` and `child_64.exe` as appropriate.

* __2)__ Either run `parent.ahk` directly, or run `cl.ahk`, which sets clipboard, and then paste in command prompt, to out put to file (`parent_stdout.txt`).