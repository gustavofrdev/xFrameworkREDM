
local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')

x_doorsSV = Proxy.getInterface('x_doors')
x_doorsCL = Tunnel.getInterface('x_doors')
FrameworkSV = Proxy.getInterface('_xFramework')
FrameworkCL = Tunnel .getInterface('_xFramework')

Function = {}
Proxy.addInterface('x_doors', Function)
Tunnel.bindInterface('x_doors', Function)
local DoorInfo	= {}

RegisterServerEvent('x_doors-:updatedoorsv')
AddEventHandler('x_doors-:updatedoorsv', function(source, doorID, cb)
    local _source = source
    if not IsAuthorized(Config.DoorList[doorID]) then
		TriggerClientEvent('chatMessage', _source, "", {0, 0, 200}, "^1Você não tem uma chave!^0")
        return
    else 
        TriggerClientEvent('x_doors-:changedoor', _source, doorID)
    end
end)

RegisterServerEvent('x_doors-:updateState')
AddEventHandler('x_doors-:updateState', function(doorID, state, cb)
    local _source = source
    
	if type(doorID) ~= 'number' then
		return
	end
	if not IsAuthorized(Config.DoorList[doorID]) then
		return
	end
	DoorInfo[doorID] = {}
	TriggerClientEvent('x_doors-:setState', -1, doorID, state)
end)

function IsAuthorized(doorID)
	local source = source
	for _,job in pairs(doorID.permissoes) do
		if FrameworkSV.HasPermission(FrameworkSV.GetUserId(source), job) then
			return true
		end
	end
	return false
end
