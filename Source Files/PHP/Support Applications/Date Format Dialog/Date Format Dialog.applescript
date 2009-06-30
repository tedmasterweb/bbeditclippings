-- date_dialog.applescript
-- date_dialog

--  Created by Gustave Stresen-Reuter on 6/21/09.
--  Copyright 2009 Chicago IT Systems, S.L.. All rights reserved.

property dfitems : {{php:"", asver:""}, {php:"Y-m-d", asver:""}, {php:"F j, Y", asver:""}, {php:"l, F j, Y", asver:""}, {php:"H:i:s", asver:""}, {php:"d/m/Y", asver:""}}
property php_help_page : "http://php.net/date"


on clicked theObject
	if name of theObject is "help" then
		tell application "System Events"
			open location php_help_page
		end tell
	else
		tell (window of theObject)
			set visible to false
			return the contents of the text field "date format php"
		end tell
	end if
end clicked

on choose menu item theObject
	tell (window of theObject)
		repeat with oneFormat in dfitems
			if asver of oneFormat = the title of current menu item of theObject then
				set contents of the text field "date format php" to php of oneFormat
				exit repeat
			end if
		end repeat
	end tell
end choose menu item

on launched theObject
	-- set up the sample date menu
	set now to the current date
	set nowhour to ((time of now) div 60 div 60)
	set nowhour2digit to nowhour as text
	if nowhour < 10 then
		set nowhour2digit to "0" & nowhour2digit
	end if
	
	set nowminute to (((time of now) div 60) - (nowhour * 60))
	set nowminute2digit to nowminute as text
	if nowminute < 10 then
		set nowminute2digit to "0" & nowminute2digit
	end if
	
	set nowsecond to (time of now) - (nowhour * 60 * 60) - (nowminute * 60)
	set nowsecond2digit to nowsecond as text
	if nowsecond < 10 then
		set nowsecond2digit to "0" & nowsecond2digit
	end if
	
	set this_2digit_day to the day of now as integer
	if this_2digit_day is less than 10 then
		set this_2digit_day to "0" & this_2digit_day as text
	end if
	set this_text_day to the weekday of now
	set this_2digit_month to the month of now as integer
	if this_2digit_month as text does not start with 1 then
		set this_2digit_month to "0" & this_2digit_month as text
	end if
	set this_text_month to the month of now
	
	repeat with oneFormat in dfitems
		if php of oneFormat = "Y-m-d" then
			set asver of oneFormat to (year of now & "-" & this_2digit_month & "-" & this_2digit_day) as text
		else if php of oneFormat = "F j, Y" then
			set asver of oneFormat to (this_text_month & " " & the day of now & ", " & the year of now) as text
		else if php of oneFormat = "l, F j, Y" then
			set asver of oneFormat to (weekday of now & ", " & this_text_month & " " & the day of now & ", " & the year of now) as text
		else if php of oneFormat = "H:i:s" then
			set asver of oneFormat to (nowhour2digit & ":" & nowminute2digit & ":" & nowsecond2digit) as text
		else if php of oneFormat = "d/m/Y" then
			set asver of oneFormat to (this_2digit_day & "/" & this_2digit_month & "/" & year of now) as text
		end if
	end repeat
	tell window 1
		tell menu of popup button "date formats"
			delete every menu item
			repeat with aMenuItem in dfitems
				make new menu item at end of menu items with properties {title:asver of aMenuItem}
			end repeat
		end tell
		
	end tell
end launched
