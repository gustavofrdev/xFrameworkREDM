--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_roubotrem")
x_roubotrem = Tunnel.getInterface("x_roubotrem")
x_roubotremSv = Proxy.getInterface("x_roubotrem")
_Tunnel = {}
Tunnel.bindInterface("x_roubotrem", _Tunnel)
--------------------------------------------------------

local isInCd = false 
RegisterServerEvent("roubotrem:cd")
AddEventHandler("roubotrem:cd", function()
    isInCd = true   
    Wait(1000 * 1800)
    isInCd = false 
end)
function _Tunnel.cd()
    return isInCd
end

function _Tunnel.hasBomba()
    return FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(source), "bomba", 1)
end

function _Tunnel.giveMoney()
    local recompensa = math.random(50, 90)
    FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source), recompensa)
end
function _Tunnel.hasNCops()
    return  #FrameworkSV.GetUsersByPermission("policia.permissao") >= 3 
end

-- local wbroubo = "https://discord.com/api/webhooks/834018941277962282/jjUi3SYKX7DKFiZdfbUOWa209XTptVU4CII7Fxagb_QepZ4RlBPofb30chgOWvRzeyDr"

local Items = {
    {item = "stolenmerch", name = "Mercadoria roubada", amountToGive = math.random(9, 12)}
}
local startedrob = false


Citizen.CreateThread(function()
        Citizen.Wait(2000)
        -- VorpInv.RegisterUsableItem("gazua",function(data)
        --      TriggerClientEvent("gorp:saferobberygetplayerped", data.source)
        -- end)
    end)
function LootToGive(source)
    local LootsToGive = {}
    for k, v in pairs(Items) do
        table.insert(LootsToGive, v.item)
    end

    if LootsToGive[1] ~= nil then
        local value = math.random(1, #LootsToGive)
        local picked = LootsToGive[value]
        return picked
    end
end

function startTrainRobbery()
    local _source = source -- pega id do assaltante
	local countdown = os.time() - storetimer -- verifica tempo se passou 1 minuto
    if FrameworkSV.GetUsersByPermission("policia.permissao") >= 3 then -- Seta a quantidade de policiais para ocorrer ação
        if countdown >= 3600 then -- countdown 3600 = 1 hora
            startedrob = true
            TriggerClientEvent("gorp:safeforrobbery", _source)
        else
            TriggerClientEvent("xFramework:Notify",_source, "aviso",'Cofres vazios! volte mais tarde.', 5000)
        end
     else
         TriggerClientEvent("xFramework:Notify",_source, "aviso","Numero de Oficiais em serviço é insuficiente!", 6000)
     end
end

RegisterNetEvent("gorp:startrobbery")
AddEventHandler("gorp:startrobbery",function(players)
    startTrainRobbery(players) -- inicia ação se estiver no tempo
end)

RegisterServerEvent("gorp:robberycomplete")
AddEventHandler("gorp:robberycomplete",
    function()
		local _source = source
        local FinalLoot = LootToGive(source)
        local chance = math.random(1, 100)
        if chance <= 80 then
            for k, v in pairs(Items) do
                if v.item == FinalLoot then
				SendWebhookMessage(wbroubo,"```prolog\n\n\n[Nome]: "..Character.firstname.." "..Character.lastname.." \n[SteamHex]: "..Character.identifier.." \n[Assaltou]: Trem \n[HORARIO]: "..os.date('%H:%M:%S - %d/%m/%y').."\r```")
                    TriggerEvent('dangy_stress:modify', 30.0)    
                    FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(source), "gazua", 1)
					local valor = math.random(10,20)
					FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source),valor)
                    TriggerClientEvent("xFramework:Notify",source,"Você pegou $" .. valor .." e " .. v.amountToGive .. " " .. v.name,3000)
                end
            end
        else
            TriggerClientEvent("xFramework:Notify", source, "Sua gazua quebrou e você não conseguiu abrir", 3000)
            VorpInv.subItem(source, "gazua", 1)
        end
    end
)
function _Tunnel.police(x, y, z)
    TriggerClientEvent("xFramework:CallCallback::policia_roubo_progress",-1, x , y, z  )
end

--> bomba

RegisterServerEvent('nic_bomb:checkCount')
AddEventHandler('nic_bomb:checkCount', function()
	local _source = source
    local count = FrameworkSV.GetInventoryItemAmount(FrameworkSV.GetUserId(source), "bomba")
    count = 4
    if count > 0 then
		TriggerClientEvent('nic_bomb:useBomb', _source)
    else
        TriggerClientEvent("vorp:TipBottom", _source, "Wala kang Bomba", 6000)
    end
end)