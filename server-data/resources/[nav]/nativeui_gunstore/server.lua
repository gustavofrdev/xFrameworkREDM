--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("nativeui_gunstore")
nativeui_gunstore = Tunnel.getInterface("nativeui_gunstore")
nativeui_gunstoreSv = Proxy.getInterface("nativeui_gunstore")
_Tunnel = {}
Tunnel.bindInterface("nativeui_gunstore", _Tunnel)
--------------------------------------------------------
local valores = {
    weapon_revolver_cattleman = {120, 1},
    weapon_repeater_winchester = {200, 1},
    weapon_lasso = {20, 1},
    weapon_melee_knife = {20, 1},
    weapon_bow = {30, 1},
    weapon_melee_knife_jawbone = {50, 1},
    weapon_melee_machete = {60, 1},
    ammo_repeater = {15, 1},
    ammo_arrow = {5, 1},
    ammo_revolver = {10, 1}
}
function _Tunnel.comprar(data)
    local source = source 
    local sel_val = valores[data][1];
    local sel_qnt = valores[data][2]
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