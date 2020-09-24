#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^1::addAndSwap()		; shortcut for incrementing (CTRL+1)
;~ ^2::addAndSwap("s")		; shortcut for incrementing and swapping - available in version 2 of script - https://github.com/Gangula2/Paste-Incremental-Numbers/blob/master/Paste%20increment%20-%20v2.ahk

/* Example: If you copy a text like "001. ABC and EFG", you can paste it like follows using Shortcut "CTRL+1":
 * 002. ABC and EFG
 * 003. ABC and EFG
 ...
 */

addAndSwap(vMode:="") 
	{
		name := Clipboard
		name_actual := StrSplit(name, " -").1
		comment := StrSplit(name, " -").2
		Clipboard := name_actual
		
		if RegExMatch(Clipboard, "s)(.*?)(\d+)(.*)", m) 						; finds the number at the starting  -   delete "?" to find the number at the end of the line
		{	; increment script	
			lm2 := strlen(m2) 											; calculates the length of the number in the copied text (i.e., 005 = 3 & 05 = 2)
			Clipboard := m1 . Format("{:0" lm2 "}", m2+1) . m3 			; uses the above copied string to retain the length(padding) of number (i.e., replaces 006 with 007 instead of 7)
		}
			num_final := Clipboard
			If_comment := StrLen(comment)
			If If_comment = 0				; If there is no comment in the name
			{
				Clipboard := num_final
			}
			else
			{
				Clipboard := num_final . " - " . comment
			}
			sendinput ^v
	}
return