
local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tools = module('Server/CallBack/Callback_Tools')
chatSV = Tunnel.getInterface('chat')
chatCL = Proxy.getInterface('chat')
FrameworkCL = Tunnel.getInterface('_xFramework')
FrameworkSV = Proxy.getInterface('_xFramework')
local Function = {}
Proxy.addInterface('chat', Function)
Tunnel.bindInterface('chat', Function)
--Doublox#9803---
RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('_chat:messageEnteredA')
RegisterServerEvent('_chat:messageEnteredG')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler("_chat:messageEnteredG", function(source, color, message)
    local src = source
    args = stringsplit(message, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
        TriggerClientEvent("chatMessage", source,"Chat:", {0,255,255}, "Comando Inexistente")
    
    end
end)
function Function.group ( a10 )
local _source = source 
local user_id = FrameworkSV.GetUserId(_source)
return FrameworkSV.HasGroup(user_id, a10)

end 

function Function.nomes( )
    local _source = source 
local user_id = FrameworkSV.GetUserId(_source)

local nome = FrameworkSV.GetUserName(user_id)
return {
     nome = nome, 
     sobrenome = ""
}
end

function Function.id()
    local source = source 
    return FrameworkSV.GetUserId(source)
end 
function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

AddEventHandler('_chat:messageEntered', function(author, color, message)
    --()
    local src = source
    --(src)
    args = stringsplit(message, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
        TriggerClientEvent("chatMessage", source,"Chat:", {0,255,255}, "Comando Inexistente")
        return
    else
        TriggerClientEvent("chatMessage", -1, "[" .. FrameworkSV.GetUserName(FrameworkSV.GetUserId(source)) .. "] " .. "", color,  message)
        return
    end
        if not WasEventCanceled() then
            TriggerClientEvent('chatMessageG', -1, author,  { 65,105,225 }, message)
        end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
  
end)

--Doublox#9803---
-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

----------------------------
------------------------------

----------------------------
AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)
--Doublox#9803---
    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)


-- RegisterCommand('pd', function(source, args, rawCommand)
--     local src = source
--     local user_id =  godnetwork.sintaxes.vrp.GetUserId(source)
--     local identity =  godnetwork.sintaxes.vrp.GetUserIdentity(user_id)
--     local samus = godnetwork.sintaxes.vrp.getUsersByPermission("paramedico.permissao")

--     local msg = rawCommand:sub(3)
--     if player ~= false  then
--         local user = identity.name.. " " .. identity.firstname
--         local user2 ="Anônimo"
--         for k, v in pairs(godnetwork.sintaxes.vrp.getUsers()) do
--                 if godnetwork.sintaxes.vrp.hasPermission(k, "policiFrameworkSV.permissao") then
--           --          --(v)
--               TriggerClientEvent("chatMessage", v, "[" .. identity.name .." " ..identity.firstname..  "] " .. "chat privado polícia ", {0,255,255},  msg)
        
--     end 
-- end
-- end
-- end, false)

