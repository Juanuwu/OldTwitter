#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; Use Control + Left Click to modify the URL
^LButton::
{
    
    ; Simulate right-clicking the link to open the context menu
    MouseClick, right
    Sleep 100

    ; Select "Copy Link Address" (works for Chrome-based browsers)
    Send {Down 7} ; Adjust based on your browser's context menu order
    Send {Enter}
    Sleep 100 ; Allow time for the clipboard to update

    ; Get the copied URL from the clipboard
    Url := Clipboard
    FileAppend, `n[Debug] Copied URL: "` Url `"`n, *

    ; Check if it already contains parameters
    if (InStr(Url, "?") > 0)
    {
        Url := Url . "&newtwitter=true"
    }
    else
    {
        Url := Url . "?newtwitter=true"
    }
    FileAppend, `n[Debug] Modified URL: "` Url `"`n, *

    ; Open the modified URL in a new tab
    Run, % Url
    FileAppend, `n[Debug] Run command executed with URL: "` Url `"`n, *

    return
}