
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_drogas")
x_drogas = Tunnel.getInterface("x_drogas")
x_drogasSv = Proxy.getInterface("x_drogas")
_Tunnel = {}
Tunnel.bindInterface("x_drogas", _Tunnel)
--------------------------------------------------------
function _Tunnel.remove(item, qnt, befMoney, x, y, z)
	if FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(source), item, qnt) then 
		FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source), befMoney*qnt)
		TriggerClientEvent("xFramework:CallCallback::policia_roubo_progress",-1, x , y, z  )
	else
		TriggerClientEvent("xFramework:Notify", source, "negado", "Você não tem os itens solicitados")
	end
end


RegisterServerEvent("xFramework_ItemFunction:semente_cocaina")
AddEventHandler("xFramework_ItemFunction:semente_cocaina", function(user_id)
	TriggerClientEvent('x_drogas:planto1', FrameworkSV.GetUserSource(user_id), "s_inv_saltbush01bx", "s_inv_saltbush01ex", "rdr_bush_wandering_aa_sim", "semente_acucar")
	FrameworkSV.TryGetInventoryItem(user_id, "semente_cocaina", 1)
end)

RegisterServerEvent("xFramework_ItemFunction:semente_maconha")
AddEventHandler("xFramework_ItemFunction:semente_maconha", function(user_id)
	TriggerClientEvent('x_drogas:planto1', FrameworkSV.GetUserSource(user_id),  "rdr_bush_ear_ab_sim", "rdr_bush_ear_aa_sim", "rdr_bush_palm_aa_sim", "semente_tabaco")
	FrameworkSV.TryGetInventoryItem(user_id, "semente_maconha", 1)
end)
RegisterServerEvent("xFramework_ItemFunction:regador")
AddEventHandler("xFramework_ItemFunction:regador", function(user_id)
	TriggerClientEvent('x_drogas:regar1', FrameworkSV.GetUserSource(user_id))
	-- FrameworkSV.TryGetInventoryItem(user_id, "regador", 1)
end)

RegisterServerEvent("devolver_2")
AddEventHandler("devolver_2",function(item)
FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), item, 1 )
end)


RegisterServerEvent('x_drogas:giveitem')
AddEventHandler('x_drogas:giveitem', function(tipo)
    local _source = source
	local count = math.random(3, 8)		
	if tipo == "rdr_bush_wandering_aa_sim" then
		FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), "maconha", count )
	elseif tipo == "rdr_bush_palm_aa_sim" then
		FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), "cocaina", count )
	end
end)