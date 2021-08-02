
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
FrameworkCL = Tunnel.getInterface('_xFramework')
FrameworkSV = Proxy.getInterface('_xFramework')
x_bankrobbery = Tunnel.getInterface('x_bankrobbery')
x_bankrobberySv = Proxy.getInterface('x_bankrobbery')
_Tunnel = {}
Proxy.addInterface("x_bankrobbery",_Tunnel)
Tunnel.bindInterface("x_bankrobbery",_Tunnel)
local cd = {}
function _Tunnel.copsOnline()
    return FrameworkSV.GetUsersByPermission("policia.permissao")
end

RegisterServerEvent('__::pay::___')
AddEventHandler('__::pay::___',function(mt)
        local _source = source
        local dinheiro = mt.dinheiro 
        FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source), dinheiro)
    end)

RegisterServerEvent('sendCops')
AddEventHandler('sendCops', function(x, y, z)
    TriggerClientEvent("xFramework:CallCallback::policia_roubo_progress",-1, x , y, z  )

end)
function _Tunnel.Bomba()
    return FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(source), "bomba", 1)
end

local isInCd = false 
RegisterServerEvent("bankrob:cd")
AddEventHandler("bankrob:cd", function(a)
    cd[a] = true 
    Wait(1000 * 1800)
    cd[a] = false 
end)
function _Tunnel.cd(a)
    return cd[a]
end
function _Tunnel.hasNCops()
    return  #FrameworkSV.GetUsersByPermission("policia.permissao") >= 3 
end