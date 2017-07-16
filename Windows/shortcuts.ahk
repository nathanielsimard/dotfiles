#NoEnv                                                                                  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input                                                                          ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%                                                             ; Ensures a consistent starting directory.

CapsLock::Esc                                                                           ; Remap capslock to escape
Esc::CapsLock                                                                           ; Remap esc to capslock

<#!l:: sendevent {LWin down}{LCtrl down}{Right down}{LWin up}{LCtrl up}{Right up}       ; Switch to previous virtual desktop
<#!h:: sendevent {LWin down}{LCtrl down}{Left down}{Lwin up}{LCtrl up}{Left up}         ; Switch to next virtual desktop

<!h:: sendevent {LWin down}{Left down}{Lwin up}{Left up}                                ; Tile window to the left
<!l:: sendevent {LWin down}{Right down}{Lwin up}{Right up}                              ; Tile window to the right

<!k:: sendevent {LWin down}{Up down}{Lwin up}{Up up}                                    ; Maximize window
<!j:: sendevent {LWin down}{Down down}{Lwin up}{Down up}                                ; Minimize window

<!w:: sendevent {F11}                                                                   ; Full screen
<!q:: sendevent {LAlt down}{F4 down}{LAlt up}{F4 up}                                    ; Close window

<^!t:: run "C:\WINDOWS\system32\bash.exe"                                               ; Lauch terminal