local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
x_bolso = Tunnel.getInterface("x_bolso")
x_bolsoSv = Proxy.getInterface("x_bolso")
_Tunnel = {}
Tunnel.bindInterface("x_bolso", _Tunnel)

function _Tunnel.getBolso(userId)
    local source = source
    return FrameworkSV.GetInventoryMaxWeight(userId)
end
function _Tunnel.setBolso(userId, bolso)
    local source = source 
    FrameworkSV.SetInventoryMaxWeight(userId, bolso)
end

RegisterNetEvent("xFramework_ItemFunction:mochila")
AddEventHandler("xFramework_ItemFunction:mochila", function(userId)
    local source = FrameworkSV.GetUserSource(userId);
    if _Tunnel.getBolso(userId) < 100 then 
        if FrameworkSV.TryGetInventoryItem(userId, "mochila", 1) then 
            TriggerClientEvent("x_bolso:Use", source, userId);
        end
    else 
        TriggerClientEvent("xFramework:Notify", source, "negado", "Bolso passou dos limites...")
    end 
end)