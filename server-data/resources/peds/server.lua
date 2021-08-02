
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("peds")
peds = Tunnel.getInterface("peds")
pedsSv = Proxy.getInterface("peds")
_Tunnel = {}
Tunnel.bindInterface("peds", _Tunnel)
--------------------------------------------------------

function _Tunnel.perm()
    return FrameworkSV.HasPermission(FrameworkSV.GetUserId(source), "skin.permissao")
end