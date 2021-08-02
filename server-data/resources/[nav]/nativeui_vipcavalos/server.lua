--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("nativeui_vipcavalos")
nativeui_vipcavalos = Tunnel.getInterface("nativeui_vipcavalos")
nativeui_vipcavalosSv = Proxy.getInterface("nativeui_vipcavalos")
_Tunnel = {}
Tunnel.bindInterface("nativeui_vipcavalos", _Tunnel)
--------------------------------------------------------
local valores = {
    feno = {40, 1},
    escova = {40, 1},
    maca = {40, 1},
}
function _Tunnel.comprar(data)
    local source = source 
    local sel_val = valores[data][1];
    local sel_qnt = valores[data][2]
    local id = FrameworkSV.GetUserId(source)
    if FrameworkSV.HasPermission(id, "vipcavalo.permissao") then 
        if FrameworkSV.TryPayment(FrameworkSV.GetUserId(source), sel_val) then 
            local add_result = FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), data, sel_qnt)
            if add_result and add_result == "fail" then 
                FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source), sel_val)
            end
        else
            TriggerClientEvent("xFramework:Notify", source, "negado", "você não tem dinheiro $["..sel_val.."]")
        end
    end
end