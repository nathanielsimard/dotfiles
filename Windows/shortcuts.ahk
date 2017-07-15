#NoEnv                                                                                  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input                                                                          ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%                                                             ; Ensures a consistent starting directory.

CapsLock::Esc                                                                           ; remap capslock to escape

<#!l:: sendevent {LWin down}{LCtrl down}{Right down}{LWin up}{LCtrl up}{Right up}       ; switch to previous virtual desktop
<#!h:: sendevent {LWin down}{LCtrl down}{Left down}{Lwin up}{LCtrl up}{Left up}         ; switch to next virtual desktop

<!h:: sendevent {LWin down}{Left down}{Lwin up}{Left up}                                ; tile window to left
<!l:: sendevent {LWin down}{Right down}{Lwin up}{Right up}                              ; tile window to right
<!k:: sendevent {LWin down}{Up down}{Lwin up}{Up up}                                    ; tile window maximize
<!j:: sendevent {LWin down}{Down down}{Lwin up}{Down up}                                ; tile window minimize

<!w:: sendevent {F11}                                                                   ; tile window full screen
<!q:: sendevent {LAlt down}{F4 down}{LAlt up}{F4 up}                                    ; close window

<^!t:: run "C:\WINDOWS\system32\bash.exe"                                               ; lauch terminal