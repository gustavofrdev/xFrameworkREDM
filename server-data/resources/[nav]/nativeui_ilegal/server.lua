--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("nativeui_ilegal")
nativeui_ilegal = Tunnel.getInterface("nativeui_ilegal")
nativeui_ilegalSv = Proxy.getInterface("nativeui_ilegal")
_Tunnel = {}
Tunnel.bindInterface("nativeui_ilegal", _Tunnel)
--------------------------------------------------------
local valores = {
    oldbuckle = 40,
    oldwatch = 50,
    rubyring = 60,
    goldtooth = 70,
    piratecoin = 60
}

local compra = {
    bomba = {50, 1},
    lockpick = {100, 1},
    semente_cocaina = {30, 1},
    semente_maconha = {30, 1},
    bandana = {30, 1},

}
function _Tunnel.vender(data)
    local source = source 
    local sel_val = valores[data];
    local id = FrameworkSV.GetUserId(source)
    print(id)
    if FrameworkSV.TryGetInventoryItem(id, data, 1) then 
        FrameworkSV.GiveMoney(id, sel_val)
    else
        TriggerClientEvent("xFramework:Notify", source, "negado", "você não tem esse item ["..data.."]")
    end
end

function _Tunnel.comprar(data)
    local source = source 
    local sel_val = compra[data][1];
    local sel_qnt = compra[data][2]
    local id = FrameworkSV.GetUserId(source)
    print(id)
    if FrameworkSV.TryPayment(FrameworkSV.GetUserId(source), sel_val) then 
        local add_result = FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), data, sel_qnt)
        if add_result and add_result == "fail" then 
            FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source), sel_val)
        end
    else
        TriggerClientEvent("xFramework:Notify", source, "negado", "você não tem dinheiro $["..sel_val.."]")
    end
end