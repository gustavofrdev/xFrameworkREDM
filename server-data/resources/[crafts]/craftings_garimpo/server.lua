--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("craftings_garimpo")
craftings_garimpo = Tunnel.getInterface("craftings_garimpo")
craftings_garimpoSv = Proxy.getInterface("craftings_garimpo")
_Tunnel = {}
Tunnel.bindInterface("craftings_garimpo", _Tunnel)


function _Tunnel.giveItem(item)
    FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), item, 1)
end

function _Tunnel.itemQntCheck(item)
    return FrameworkSV.GetInventoryItemAmount(FrameworkSV.GetUserId(source), item)
end

function _Tunnel.removeItem(item, qnt)
    FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(source), item, qnt)
end 

function _Tunnel.addItem(item ,qnt)
    return FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), item, qnt)
end
