#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^1::addAndSwap()		; shortcut for incrementing (CTRL+1)
^2::addAndSwap("s")		; shortcut for incrementing and swapping (CTRL+2)

/* Example: If you copy a text like "001. ABC and EFG", 

you can paste it like follows using Shortcut "CTRL+1":
 * 002. ABC and EFG
 * 003. ABC and EFG
 ...
 
 you can paste it like follows using Shortcut "CTRL+2":
 * 002. EFG and ABC
 * 003. EFG and ABC
 ...
 */

addAndSwap(vMode:="") 
	{
		
		name := Clipboard
		
		name_actual := StrSplit(name, " -").1
		comment := StrSplit(name, " -").2
		Clipboard := name_actual
		
		if RegExMatch(Clipboard, "s)(.*?)(\d+)(.*)", m) 						; finds the number at the starting  -   delete "?" to find the number at the end of the line
		{	; increment script start	
			
			lm2 := strlen(m2) 											; calculates the length of the number in the copied text (i.e., 005 = 3 & 5 = 1)
			Clipboard := m1 . Format("{:0" lm2 "}", m2+1) . m3 			; uses the above copied string to retain the length(padding) of number (i.e., replaces 006 with 007 instead of 7)
			
			; increment script end
			
			{		; Swap Script
				
				if InStr(vMode, "s")				; if the shortcut contains Shift(+) in it run this swap script
				{
					{  ; Script if the number is at the beginning
						If RegExMatch(Clipboard , "O)^(.*?\d+\.\s*)(.+) (.+) (.+)$", Match)		; Finds the Number(Match[1] i.e., (.*?\d+\.\s*) ), First string(Match[2]), Second String - (vs) (Match[3]), Third String(Match[4])
						Clipboard := Match[1] Match[4] " " Match[3] " " Match[2]				;Swaps the position of First string(Match[2]), Second String(Match[3])
					}
					
					{  ; Script if the number Is at the end
						If RegExMatch(Clipboard , "O)^(.+) (.+) (.+)\.\s*(\d+\s*)$", Match)	; Finds the First string(Match([1]), Second String(Match[2]), the number (Match[3])
						Clipboard := Match[3] " " Match[2] " " Match[1] ". "  Match[4]
					}
					
				}
			}
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