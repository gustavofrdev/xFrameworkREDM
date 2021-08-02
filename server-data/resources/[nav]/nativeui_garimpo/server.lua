--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("nativeui_garimpo")
nativeui_garimpo = Tunnel.getInterface("nativeui_garimpo")
nativeui_garimpoSv = Proxy.getInterface("nativeui_garimpo")
_Tunnel = {}
Tunnel.bindInterface("nativeui_garimpo", _Tunnel)
--------------------------------------------------------
local valores = {
    ouro = 60,
    diamante = 50,
    prata = 40,
    painita = 70,
}

--[[[1] =  {item = "painita_bruto", chance = 2}, -- 70
        [2] =  {item ="ouro_bruto",  chance = 5}, -- 60
        [3] =  {item ="diamante_bruto",  chance = 40}, -- 50
        [4] =  {item ="prata_bruto", chance = 90} -- 40
        ]]
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