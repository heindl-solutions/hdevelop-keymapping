; hdevelop_key_remapping.ahk
; map typical Visual Studio hotkeys to nonstandard HDevelop keys.

; this utility needs Autohotkey from http://www.autohotkey.com/ installed.
#SingleInstance force
#NoTrayIcon

;1: A window's title must start with the specified WinTitle to be a match.
;2: A window's title can contain WinTitle anywhere inside it to be a match. 
;3: A window's title must exactly match WinTitle to be a match.
SetTitleMatchMode, 1

; Shift -> +
; Ctrl -> ^
; Win -> #
; Alt -> !
#IfWinActive, HDevelop ; remap for windows where title starts with "HDevelop"
; F5::F5                               ; [F5]        Run
^F10::send, {Shift Down}{F5}{Shift Up} ; [Ctrl+F10]  Run to Insert Cursor
F10::F6                                ; [F10]       Step Over
+F10::send, {Shift Down}{F6}{Shift Up} ; [Shift+F10] Step Forward
F11::F7                                ; [F11]       Step Into
+F11::F8                               ; [Shift+F11] Step Out
+F5::F9                                ; [Shift+F5]  Stop
+^F5::send, {Shift Down}{F9}{Shift Up} ; [Ctrl+Shift+F5] Stop after Procedure
F9::F10                                ; [F9]        Set Breakpoint
+^o::send, {Ctrl Down}{Shift Down}w{Shift Up}{Ctrl Up}o; Organize Windows
#IfWinActive  ; end of remapping

