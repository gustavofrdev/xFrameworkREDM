local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
FrameworkSV = Proxy.getInterface('_xFramework')
FrameworkCL = Tunnel.getInterface('x_API')
_Tunnel = {}
local n

Proxy.addInterface("x_API", _Tunnel)
Tunnel.bindInterface("x_API", _Tunnel)

function IsAuthorized(jobName, doorID)
	if doorID then 
    for _, job in pairs(doorID.Propiedade) do
        if job == jobName then
            return true
        end
    end
    return false
end
end

function _Tunnel.UpdateDoor(_, doorID)
	-- --("dr. Update")
    local _source = tonumber(source)
    local test1 = false
    local test2 = false

    local u_identifier = FrameworkSV.GetUserId(_source)
    local data = FrameworkSV.SQLExecute('SELECT house FROM xframework_personagens WHERE id=(@identifier)',{['@identifier'] = u_identifier})
            data = data[1].house
			n = data 
            if tonumber(data) == tonumber(Config.DoorList[doorID].Propiedade[1]) then
                FrameworkCL.ChangeDoor(-1, doorID)
            else
                return
            end
        end
    
		
    if not IsAuthorized(n, Config.DoorList[doorID]) then
        test2 = true
    else
        FrameworkCL.ChangeDoor(_source, doorID)
    end

    if test1 and test2 then
        -- TriggerClientEvent('chatMessage', source, '', {0, 0, 200}, '^1Vc não tem a chave')
		TriggerClient("xFramework:Notify", source, "negado", "Essa casa não é sua ")
    end


function _Tunnel.UpdateState(doorID, state)
    local _source = source

    if type(doorID) ~= 'number' then
        return
    end
	local data = FrameworkSV.SQLExecute('SELECT house FROM xframework_personagens WHERE id=(@identifier)',{['@identifier'] = u_identifier})
	data = data[1].house
    if not IsAuthorized(data, Config.DoorList[doorID]) then
        return
    end

    DoorInfo[doorID] = {}
    FrameworkCL.SetState(doorID, state)
end
