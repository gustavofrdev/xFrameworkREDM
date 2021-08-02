local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')

x_cacaCL = Tunnel.getInterface('x_caca')
FrameworkSV = Proxy.getInterface('_xFramework')
FrameworkCL = Tunnel.getInterface('_xFramework')
_Tunnel = {}
Proxy.addInterface('x_caca', _Tunnel)
Tunnel.bindInterface('x_caca', _Tunnel)
local delay = 20 --(min)
local d = {}
local f = {}
function _Tunnel.set(arbusto)
    if f[arbusto] and f[arbusto] >= 10 then 
        d[arbusto] = os.time()
        f[arbusto] = 0;
    else 
        if not f[arbusto] then 
            f[arbusto] = 1 
        else
            f[arbusto] = f[arbusto] + 1
        end 
        --(f[arbusto])
    end
end
function _Tunnel.currentServerTimeStamp()
    return os.time()
end
function _Tunnel.giveItem(item)
    FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), item, 1)
end

function _Tunnel.itemQntCheck(item)
    return FrameworkSV.GetInventoryItemAmount(FrameworkSV.GetUserId(source), item)
end

function _Tunnel.removeItem(item, qnt)
    FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(source), item, qnt)
end

function _Tunnel.addItem(item ,qnt)
    return FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), item, qnt)
end
function _Tunnel.getArbustoStamp(a)
    if d[a] then 
        return d[a]
    else 
        return false 
    end
end

RegisterServerEvent("caca:giveitem")
AddEventHandler("caca:giveitem", function(i, q)
	FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), i, q )
end)

RegisterServerEvent("caca:reward")
AddEventHandler("caca:reward", function(i)
	FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source), i )
end)

local done = {}
local createdPena = false 
Citizen.CreateThread(function()
	local config = Config;
	local t = {}
	for k, v in pairs(config.Animal) do 
		if v.item ~= "veneno_cobra" then 
			if not done[v["item"]] then 
				if not t[v["item"]] then 
					t[v["item"]] = {Descricao = v["item"],Label = "Carne de "..v["name"],Peso = 1,Tipo = 'Usar',Foto = "carne",Limite = -1}
					t[v["item"].."_assado"] = {Descricao = v["item"],Label = "Carne de "..v["name"] .. " Assada",Peso = 1,Tipo = 'Usar',Foto = "carne_assada",Limite = -1}
				end
				FrameworkSV.RemoteCreateInventoryItem(v["item"], t[v["item"]])
				FrameworkSV.RemoteCreateInventoryItem(v["item"].."_assado", t[v["item"].."_assado"])
				-- Comer Qualquer Carne
				RegisterServerEvent("xFramework_ItemFunction:"..v["item"].."_assado")
				AddEventHandler("xFramework_ItemFunction:"..v["item"].."_assado", function(user_id)
					if FrameworkSV.TryGetInventoryItem(user_id, v["item"].."_assado", 1) then 
						local s = FrameworkSV.GetUserSource(user_id)
						TriggerClientEvent("animacao:comerCarne", s, "Carne de "..v["name"] .. " Assada")
						FrameworkSV.varyFome(user_id, -10)
					end
				end)
				-- Cozinhar qualquer carne
				RegisterServerEvent("xFramework_ItemFunction:"..v["item"])
				AddEventHandler("xFramework_ItemFunction:"..v["item"], function(user_id)
					-- if FrameworkSV.TryGetInventoryItem(user_id, v["item"], 1) then 
						local s = FrameworkSV.GetUserSource(user_id)
						local _r = x_cacaCL.cozinharCarneEmFogueiraProxima(s, v["name"])
						if _r then 
							 if FrameworkSV.TryGetInventoryItem(user_id, v["item"], 1) then 
								local can = FrameworkSV.GiveInventoryItem(user_id, v["item"].."_assado", 1 )
								if can and can == "fail" then 
									FrameworkSV.GiveInventoryItem(user_id, v["item"], 1)
								end
							end
						end
					-- end
				end)
			end
			done[v["item"]] = true 
		end
		if not createdPena then 
			FrameworkSV.RemoteCreateInventoryItem("pena", {Descricao = "",Label = "Pena de galinha",Peso = 1,Tipo = 'Usar',Limite = -1})
			createdPena = true 
		end
	end
end)

--> Ensopados -->
RegisterServerEvent("xFramework_ItemFunction:ensopado_cenoura")
AddEventHandler("xFramework_ItemFunction:ensopado_cenoura", function(user_id)
	if FrameworkSV.TryGetInventoryItem(user_id, "ensopado_cenoura", 1) then 
		local source = FrameworkSV.GetUserSource(user_id)
		x_cacaCL.comerEnsopado(source, "Bode")
	
		FrameworkSV.varyFome(user_id, -30)
	end
end)

RegisterServerEvent("xFramework_ItemFunction:ensopado_javali")
AddEventHandler("xFramework_ItemFunction:ensopado_javali", function(user_id)
	if FrameworkSV.TryGetInventoryItem(user_id, "ensopado_javali", 1) then 
		local source = FrameworkSV.GetUserSource(user_id)
		x_cacaCL.comerEnsopado(source,"Javali")
	
		FrameworkSV.varyFome(user_id, -35)
	end
end)


RegisterServerEvent("xFramework_ItemFunction:ensopado_pato")
AddEventHandler("xFramework_ItemFunction:ensopado_pato", function(user_id)
	if FrameworkSV.TryGetInventoryItem(user_id, "ensopado_pato", 1) then 
		local source = FrameworkSV.GetUserSource(user_id)
		x_cacaCL.comerEnsopado(source, "Pato")

		FrameworkSV.varyFome(user_id, -20)
	end
end)


RegisterServerEvent("xFramework_ItemFunction:ensopado_peru")
AddEventHandler("xFramework_ItemFunction:ensopado_peru", function(user_id)
	if FrameworkSV.TryGetInventoryItem(user_id, "ensopado_peru", 1) then 
		local source = FrameworkSV.GetUserSource(user_id)
		x_cacaCL.comerEnsopado(source,"Peru")

		FrameworkSV.varyFome(user_id, -25)
	end
end)

RegisterServerEvent("xFramework_ItemFunction:ensopado_frango")
AddEventHandler("xFramework_ItemFunction:ensopado_frango", function(user_id)
	if FrameworkSV.TryGetInventoryItem(user_id, "ensopado_frango", 1) then 
		local source = FrameworkSV.GetUserSource(user_id)
		x_cacaCL.comerEnsopado(source,"Frango")
		FrameworkSV.varyFome(user_id, -15)
	end
end)

RegisterServerEvent("xFramework_ItemFunction:ensopado_iguana")
AddEventHandler("xFramework_ItemFunction:ensopado_iguana", function(user_id)
	if FrameworkSV.TryGetInventoryItem(user_id, "ensopado_iguana", 1) then 
		local source = FrameworkSV.GetUserSource(user_id)
		x_cacaCL.comerEnsopado(source,"Iguana verde")
		FrameworkSV.varyFome(user_id, -50)
	end
end)

RegisterServerEvent("xFramework_ItemFunction:ensopado_angus")
AddEventHandler("xFramework_ItemFunction:ensopado_angus", function(user_id)
	if FrameworkSV.TryGetInventoryItem(user_id, "ensopado_angus", 1) then 
		local source = FrameworkSV.GetUserSource(user_id)
		x_cacaCL.comerEnsopado(source,"Angus")
		-- Wait(5000)
		FrameworkSV.varyFome(user_id, -40)
	end
end)

-- frutas -- Consumo

RegisterServerEvent("xFramework_ItemFunction:pera")
AddEventHandler("xFramework_ItemFunction:pera", function(user_id)
	if FrameworkSV.TryGetInventoryItem(user_id, "pera", 1) then 
		local s = FrameworkSV.GetUserSource(user_id)
		TriggerClientEvent("animacao:comerAlgo", s, "p_pear_01x", "Pera")
		-- Wait(6000+1000)
		FrameworkSV.varyFome(user_id, -7)
	end
end)
RegisterServerEvent("xFramework_ItemFunction:cenoura")
AddEventHandler("xFramework_ItemFunction:cenoura", function(user_id)
	if FrameworkSV.TryGetInventoryItem(user_id, "cenoura", 1) then 
		local s = FrameworkSV.GetUserSource(user_id)
		TriggerClientEvent("animacao:comerAlgo", s, "p_carrot01x", "Cenoura")
		-- Wait(6000+1000)
		FrameworkSV.varyFome(user_id, -7)
	end
end)
RegisterServerEvent("xFramework_ItemFunction:banana")
AddEventHandler("xFramework_ItemFunction:banana", function(user_id)
	if FrameworkSV.TryGetInventoryItem(user_id, "banana", 1) then 
		local s = FrameworkSV.GetUserSource(user_id)
		TriggerClientEvent("animacao:comerAlgo", s, "p_banana_day_01x", "Banana")
		-- Wait(6000+1000)
		FrameworkSV.varyFome(user_id, -7)
	end
end)
RegisterServerEvent("xFramework_ItemFunction:agua")
AddEventHandler("xFramework_ItemFunction:agua", function(user_id)
	if FrameworkSV.TryGetInventoryItem(user_id, "agua", 1) then 
		local s = FrameworkSV.GetUserSource(user_id)
		TriggerClientEvent("animacao:comerAlgo", s, "P_WATER01X", "Agua")
		-- Wait(6000+1000)
		FrameworkSV.varySede(user_id, -30)
	end
end)