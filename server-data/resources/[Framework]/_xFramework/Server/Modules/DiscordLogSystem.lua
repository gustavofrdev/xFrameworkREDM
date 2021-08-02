RegisterServerEvent("_xFramework:Discord")
AddEventHandler("_xFramework:Discord", function(wbh, msg)
    SendWebhookMessage(wbh, msg)
end)

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
