--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("nativeui_stores")
nativeui_stores = Tunnel.getInterface("nativeui_stores")
nativeui_storesSv = Proxy.getInterface("nativeui_stores")
_Tunnel = {}
Tunnel.bindInterface("nativeui_stores", _Tunnel)
--------------------------------------------------------
local valores = {
    weapon_melee_torch = {40, 1},
    fogueira = {40, 1},
    semente_acucar = {40, 1},
    semente_tabaco = {40, 1},
    regador = {40, 1},
    peneira = {40, 1},

    agua = {40, 1},
    banana = {40, 1},
    pera = {40, 1},
    cenoura = {40, 1},

    mochila = {250, 1},
}
function _Tunnel.comprar(data)
    local source = source 
    local sel_val = valores[data][1];
    local sel_qnt = valores[data][2]
    local id = FrameworkSV.GetUserId(source)
    if FrameworkSV.TryPayment(FrameworkSV.GetUserId(source), sel_val) then 
        local add_result = FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), data, sel_qnt)
        if add_result and add_result == "fail" then 
            FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source), sel_val)
        end
    else
        TriggerClientEvent("xFramework:Notify", source, "negado", "você não tem dinheiro $["..sel_val.."]")
    end
end