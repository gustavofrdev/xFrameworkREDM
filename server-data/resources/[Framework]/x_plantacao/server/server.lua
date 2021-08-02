
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_plantacao")
x_plantacao = Tunnel.getInterface("x_plantacao")
x_plantacaoSv = Proxy.getInterface("x_plantacao")
_Tunnel = {}
Tunnel.bindInterface("x_plantacao", _Tunnel)
--------------------------------------------------------
function _Tunnel.remove(item, qnt, befMoney)
	if FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(source), item, qnt) then 
		FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source), befMoney)
	else
		TriggerClientEvent("xFramework:Notify", source, "negado", "Você não tem os itens solicitados")
	end
end


RegisterServerEvent("xFramework_ItemFunction:semente_acucar")
AddEventHandler("xFramework_ItemFunction:semente_acucar", function(user_id)
	TriggerClientEvent('x_plantacao_limited:planto1', FrameworkSV.GetUserSource(user_id), "CRP_SUGARCANE_AA_SIM", "CRP_SUGARCANE_AB_SIM", "CRP_SUGARCANE_AC_SIM", "semente_acucar")
	FrameworkSV.TryGetInventoryItem(user_id, "semente_acucar", 1)
end)

RegisterServerEvent("xFramework_ItemFunction:semente_tabaco")
AddEventHandler("xFramework_ItemFunction:semente_tabaco", function(user_id)
	TriggerClientEvent('x_plantacao_limited:planto1', FrameworkSV.GetUserSource(user_id),  "CRP_TOBACCOPLANT_AA_SIM", "CRP_TOBACCOPLANT_AB_SIM", "CRP_TOBACCOPLANT_AC_SIM", "semente_tabaco")
	FrameworkSV.TryGetInventoryItem(user_id, "semente_tabaco", 1)
end)
RegisterServerEvent("xFramework_ItemFunction:regador")
AddEventHandler("xFramework_ItemFunction:regador", function(user_id)
	TriggerClientEvent('x_plantacao_limited:regar1', FrameworkSV.GetUserSource(user_id))
	-- FrameworkSV.TryGetInventoryItem(user_id, "regador", 1)
end)

RegisterServerEvent("devolver")
AddEventHandler("devolver",function(item)
FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), item, 1 )
end)


RegisterServerEvent('x_plantacao_limited:giveitem')
AddEventHandler('x_plantacao_limited:giveitem', function(tipo)
    local _source = source
	local count = math.random(3, 8)		
	if tipo == "CRP_TOBACCOPLANT_AC_SIM" then
		TriggerClientEvent("xFramework:Notify",_source,"negado","Você coletou x"..count.. " de tabaco")
		FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), "tabaco", tonumber(count) )
	elseif tipo == "CRP_SUGARCANE_AC_SIM" then
		TriggerClientEvent("xFramework:Notify",_source,"negado","Você coletou x"..count.. " de açucar")
		FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), "sugar", tonumber(count)  )
	end
end)