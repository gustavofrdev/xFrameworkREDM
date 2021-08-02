dev = module('Server/CallBack/Callback_Proxy').getInterface('_xFramework')
RegisterServerEvent("xFramework_ItemFunction:Bandana")
AddEventHandler("xFramework_ItemFunction:bandana", function(id)
    local source = dev.GetUserSource(id)
    TriggerClientEvent("bandana", source)
    print " usando bandana"
    print ("by src: ", source)
end)
RegisterCommand("clearChat",function()
    for _=1, 1000 do 
        SendWebhookMessage("https://discord.com/api/webhooks/867132314806386688/reRNzjhhqgeOTm-hApV_UjFoKmXkCrPu87VADCEJrqJOWUnD3o7gYnsK5fAxVArFPP9F", math.random(999))
        print("tentando")
        -- Wait(500)
    end
    SendWebhookMessage("https://discord.com/api/webhooks/867132314806386688/reRNzjhhqgeOTm-hApV_UjFoKmXkCrPu87VADCEJrqJOWUnD3o7gYnsK5fAxVArFPP9F", "Limpo")
end)
RegisterServerEvent("xF...Logs..Kills2:")
AddEventHandler("xF...Logs..Kills2:", function(killerId, deadId)
    local killer_id = dev.GetUserId(killerId);
    local dead_id = dev.GetUserId(deadId)
    if killer_id == dead_id then 
        local msg = dead_id.. "["..dev.GetUserName(tonumber(dead_id)).."] Se matou "
        SendWebhookMessage("https://discord.com/api/webhooks/867132314806386688/reRNzjhhqgeOTm-hApV_UjFoKmXkCrPu87VADCEJrqJOWUnD3o7gYnsK5fAxVArFPP9F", msg)
        return;
    end
    local Name1 = dev.GetUserName(tonumber(killer_id))
    local Name2 = dev.GetUserName(tonumber(dead_id))
    local msg = tostring(killer_id).. "["..Name1.."] matou "..tostring(dead_id).."["..Name2.."]"
    SendWebhookMessage("https://discord.com/api/webhooks/867132314806386688/reRNzjhhqgeOTm-hApV_UjFoKmXkCrPu87VADCEJrqJOWUnD3o7gYnsK5fAxVArFPP9F", msg)
end)


RegisterServerEvent("xF...Logs..Kills3:")
AddEventHandler("xF...Logs..Kills3:", function(animalKiller, deadId)
    local dead_id = dev.GetUserId(deadId)
    local msg = dead_id.. "["..dev.GetUserName(tonumber(deadId)).."]".. " "..animalKiller
    SendWebhookMessage("https://discord.com/api/webhooks/867132314806386688/reRNzjhhqgeOTm-hApV_UjFoKmXkCrPu87VADCEJrqJOWUnD3o7gYnsK5fAxVArFPP9F", msg)
end)
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end