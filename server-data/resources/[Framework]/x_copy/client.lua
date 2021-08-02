function SetClipboard(text)	
	SendNUIMessage({
		text = text
	})
end
RegisterNetEvent("x_copy:set")
AddEventHandler("x_copy:set",function(string)
SetClipboard(string)
end)

