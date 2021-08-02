
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_garimpo")
x_garimpo = Tunnel.getInterface("x_garimpo")
x_garimpoSv = Proxy.getInterface("x_garimpo")
_Tunnel = {}
Tunnel.bindInterface("x_garimpo", _Tunnel)
--------------------------------------------------------
local p_uses = {}
function _Tunnel.peneira(locc)
	if locc and  locc == "rem" then 
		FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(source), "peneira", 1)
	end
	return FrameworkSV.GetInventoryItemAmount(FrameworkSV.GetUserId(source), "peneira") >= 1
end
function _Tunnel.g2_gv(a)
	if string.find(a, "_bruto") then 
		FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), a, 1)
	end
end
function _Tunnel.addUse(r)
	local user = source
	if r and r == "res" then 
		p_uses[user] = 0
	end
	if not p_uses[user] then 
		p_uses[user] = 1
	else
		p_uses[user] = p_uses[user] + 1
	end
end

function _Tunnel.getUses()
	local source = source
	return p_uses[source] or 0
end