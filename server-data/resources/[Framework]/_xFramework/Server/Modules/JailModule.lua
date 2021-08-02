function _Framework.JailPlayer(time)
    local user_id = _Framework.GetUserId(source)
    local userData = _Framework.GetUserData(tonumber(user_id))
    if not userData.prisao then 
        userData.prisao = tonumber(time)
        return
    end
    userData.prisao = tonumber(time)
end

function _Framework.SetJailTime(time)
    local user_id = _Framework.GetUserId(source)
    local userData = _Framework.GetUserData(tonumber(user_id))
    if not userData.prisao then 
        userData.prisao = tonumber(time)
        return 
    end
    userData.prisao = tonumber(time)
end

function _Framework.UnjailPlayer()
    local user_id = _Framework.GetUserId(source)
    local userData = _Framework.GetUserData(tonumber(user_id))
    if not userData.prisao then 
        userData.prisao = 0
        return
    end
    userData.prisao = 0
end

function t_Framework.sv_manage_jail()
    TriggerClientEvent("sv_manage_jail_sync", -1, true)
    Wait(12000)
    TriggerClientEvent("sv_manage_jail_sync", -1, false)
end 

function t_Framework.sv_manage_jail2()
    TriggerClientEvent("sv_manage_jail_sync2", -1, true)
    Wait(12000)
    TriggerClientEvent("sv_manage_jail_sync2", -1, false)
end 