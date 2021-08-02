local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tools = module('Server/CallBack/Callback_Tools')

Function = {}

x_hudSV = Proxy.getInterface('x_hud')
x_hudCL = Tunnel.getInterface('x_hud')

FrameworkSV = Proxy.getInterface('_xFramework')
FrameworkCL = Tunnel.getInterface('_xFramework')

Proxy.addInterface('x_hud', Function)
Tunnel.bindInterface('x_hud', Function)


function Function.Fome()
    --("sv:18")
    local user_id = FrameworkSV.GetUserId(source)
    local _hunger_val = FrameworkSV.getFome(tonumber(user_id))
    --(_hunger_val)
    return _hunger_val
end


function Function.Sede()
    local user_id = FrameworkSV.GetUserId(source)

    local _thirst_val = FrameworkSV.getSede(tonumber(user_id))

    return _thirst_val
end

function Function.maxV()
return FrameworkSV.LoginConfig().Survival.VidaMaxim
end 

AddEventHandler("xFramework:PlayerLogin", function(source, user_id)
    Wait(1000)
    TriggerClientEvent("x_hud:stts:playerLogin", source)
end )