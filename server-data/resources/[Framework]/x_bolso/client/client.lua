local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_bolso")
x_bolso = Proxy.getInterface("x_bolso")
x_bolsoSv = Tunnel.getInterface("x_bolso")
_Tunnel = {}
Tunnel.bindInterface("x_bolso", _Tunnel)
 
RegisterNetEvent("x_bolso:Use")
AddEventHandler("x_bolso:Use", function(userId)
    local bolsoAtual = x_bolsoSv.getBolso(userId)
    if bolsoAtual > 100 then return end;
    local newBolso = bolsoAtual + 10 
    x_bolsoSv.setBolso(userId, newBolso)
end)
