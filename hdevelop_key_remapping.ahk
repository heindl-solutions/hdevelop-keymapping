; hdevelop_key_remapping.ahk
; map typical Visual Studio hotkeys to nonstandard HDevelop keys.

; this utility needs Autohotkey from http://www.autohotkey.com/ installed.

; http://www.heindl-solutions.com/
; Copyright 2015-2016 Andreas Heindl Software Solutions. Available as Open Source covered by the GNU General Public License version 2, see LICENSE for details.

#SingleInstance force

;1: A window's title must start with the specified WinTitle to be a match.
;2: A window's title can contain WinTitle anywhere inside it to be a match. 
;3: A window's title must exactly match WinTitle to be a match.
SetTitleMatchMode, 1
ArrHelp := Object()
ArrHelp.Insert("")
ArrHelp.Insert("Bookmarks")
ArrHelp.Insert("===============")
ArrHelp.Insert("[CTRL+M]          Set bookmark")
ArrHelp.Insert("[CTRL+>]          Goto next bookmark")
ArrHelp.Insert("[CTRL+<]          Goto previous bookmark")
ArrHelp.Insert("")
ArrHelp.Insert("Execute")
ArrHelp.Insert("===============")
ArrHelp.Insert("[F9]              Set breakpoint")
ArrHelp.Insert("[F5]              Run")
ArrHelp.Insert("[Ctrl+F10]        Run to Insert Cursor")
ArrHelp.Insert("[F10]             Step Over")
ArrHelp.Insert("[Shift+F10]       Step Forward")
ArrHelp.Insert("[F11]             Step Into")
ArrHelp.Insert("[Shift+F11]       Step Out")
ArrHelp.Insert("[Shift+F5]        Stop")
ArrHelp.Insert("[Ctrl+Shift+F5]   Stop after procedure")
ArrHelp.Insert("")
ArrHelp.Insert("Windows")
ArrHelp.Insert("===============")
ArrHelp.Insert("[Ctrl+Shift+O]    Organize windows + Fit aspect")
ArrHelp.Insert("[Ctrl+Return]     Edit interface of procedure")
ArrHelp.Insert("")
ArrHelp.Insert("Various")
ArrHelp.Insert("===============")
ArrHelp.Insert("[Ctrl+F1]         This help")
ArrHelp.Insert("[Alt+Space]       Run git bash in current directory")
ArrHelp.Insert("[Ctrl+Alt+Space]  Run explorer in current directory")

; Shift -> +
; Ctrl -> ^
; Win -> #
; Alt -> !
#IfWinActive, HDevelop ; remap for windows where title starts with "HDevelop"
$^m::send, {Ctrl Down}{F11}{Ctrl Up}  ; CTRL+M -> Set bookmark
$^>::send, {F11}  ; CTRL+> -> Goto next bookmark
$^<::send, {Shift Down}{F11}{Shift Up}  ; CTRL+< -> Goto previous bookmark

; https://www.autohotkey.com/docs/Hotkeys.htm

; $   means: don't trigger script
;     This is usually only necessary if the script uses the Send command to send the keys that comprise the hotkey itself, which might otherwise cause it to trigger itself. The $ prefix forces the keyboard hook to be used to implement this hotkey, which as a side-effect prevents the Send command from triggering it.

; F5::F5                                ; [F5]        Run
$^F10::send, {Shift Down}{F5}{Shift Up} ; [Ctrl+F10]  Run to Insert Cursor
$F10::F6                                ; [F10]       Step Over
$+F10::send, {Shift Down}{F6}{Shift Up} ; [Shift+F10] Step Forward
$F11::F7                                ; [F11]       Step Into
$+F11::F8                               ; [Shift+F11] Step Out
$+F5::F9                                ; [Shift+F5]  Stop
$+^F5::send, {Shift Down}{F9}{Shift Up} ; [Ctrl+Shift+F5] Stop after Procedure
$F9::F10                                ; [F9]        Set Breakpoint
$+^o::send, {Ctrl Down}{Shift Down}w{Shift Up}{Ctrl Up}o{Ctrl Down}{Shift Down}g{Shift Up}{Ctrl Up}.; [Ctrl+Shift+O]  Organize Windows + Fit aspect
$^Return::send, {Ctrl Down}{Shift Down}p{Shift Up}{Ctrl Up}i                                        ; [Ctrl+Return]   Edit interface of procedure

$^F1::ShowHelp(ArrHelp) ; [Ctrl+F1] Show keyboard help

$!Space::  ; [Alt+Space]       Run git bash in current directory
WinGetTitle, Title, A
Path := RegExReplace(Title, "^HDevelop *- *([A-Za-z]:.*)/.*", "$1")
if (Path == Title) {
  MsgBox, Cannot get current directory from HDevelop title bar. Maybe save your HDevelop program first.
}
else {
  Path := RegExReplace(Path, "/", "\")
  Run, C:\Program Files\Git\git-bash.exe, %Path%
}
return

$^!Space::  ; [Ctrl+Alt+Space]  Run explorer in current directory
WinGetTitle, Title, A
Path := RegExReplace(Title, "^HDevelop *- *([A-Za-z]:.*)", "$1")
if (Path == Title) {
  MsgBox, Cannot get current directory from HDevelop title bar. Maybe save your HDevelop program first.
}
else {
  Path := RegExReplace(Path, "/", "\")
  explorerpath:= "explorer /select," Path
  Run, %explorerpath%
}
return

#IfWinActive  ; end of remapping
return


ShowHelp(ArrHelp)
{
    Gui, New
    Gui, Font, s10, Courier New
	Loop % ArrHelp.MaxIndex()
		Content .= ArrHelp[A_Index] "`n"
    Gui, Add, Text,, % Content

    Gui +Resize
    Gui, Show, AutoSize Center, Help remapped HDevelop keyboard shortcuts

    return
}

GuiEscape:
Gui, Destroy
return



