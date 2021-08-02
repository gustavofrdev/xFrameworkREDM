local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_vinho")
x_vinho = Tunnel.getInterface("x_vinho")
x_vinhoSv = Proxy.getInterface("x_vinho")
_Tunnel = {}
Tunnel.bindInterface("x_vinho", _Tunnel)

RegisterServerEvent('vinho:reward')
AddEventHandler('vinho:reward', function(money, xp)
    FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source), money)
end)