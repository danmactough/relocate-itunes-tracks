set OldFolder to choose folder with prompt "Please select the old folder:" as string
set NewFolder to choose folder with prompt "Please select the new folder:" as string
set DialogText to "Ready to update track locations from \"" & OldFolder & "\" to \"" & NewFolder & "\" Continue?"
set DisplayResponse to display dialog DialogText buttons {"Don't Continue", "Continue"} default button "Continue" cancel button "Don't Continue"

tell application "iTunes"
	set AllTracks to (every track of library playlist 1)
	repeat with aTrack in AllTracks
		set OldLocation to location of aTrack as string
		if {OldLocation starts with OldFolder} then
			set NewLocation to do shell script "sed 's|" & OldFolder & "|" & NewFolder & "|g' <<< " & quoted form of OldLocation
			log OldLocation & " > " & NewLocation
			set location of aTrack to NewLocation as alias
			-- log OldLocation
		end if
	end repeat
end tell