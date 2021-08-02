local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")

FrameworkSV = Proxy.getInterface("_xFramework")
-- Framework = Proxy.getInterface("_xFramework")
Cl = Tunnel.getInterface("x_heist_fort")
_Tunnel = {}
Tunnel.bindInterface("x_heist_fort", _Tunnel)
local bandos = {"Indios", "Bandido1", "Bandido2"}

local disputaAtual = ""

request ={}
local results={}
request.isPlayerFromAnyBando=function(user_id, setDisputa)
    local user_id = user_id
    --(user_id, "<<<")
    for k, v in pairs(bandos) do
        --(" !!!!!!!!!!!!!")
        --(user_id, v, "!!!!") 
        if  FrameworkSV.HasGroup(user_id, v) then 
            results[user_id] = v
            if setDisputa then 
                disputaAtual = v
            end
            return true
        end
    end
    return false
end

request.getOwnerFortBando=function()
    local result = FrameworkSV.SQLExecute("SELECT bando_dominou FROM x_fort", {})
    if result[1].bando_dominou == "[]" then 
        return "none"
    else return result[1].bando_dominou end 
end

request.setDominado=function(bando_dominou)
    FrameworkSV.SQLExecute("UPDATE x_fort SET bando_dominou = @bando_dominou", {["@bando_dominou"] = bando_dominou})
end



RegisterServerEvent("x_heist_robbery:open_crafts")
AddEventHandler("x_heist_robbery:open_crafts", function()
    local source = source;
    local user = FrameworkSV.GetUserId(source)
    if request.isPlayerFromAnyBando(user, false) then 
        print("ok1")
        if request.getOwnerFortBando() == results[user] then 
            if string.lower(results[user]) == "indios" then 
                TriggerClientEvent("OpenIndios-Farm", source)
                print "indios"
            else 
                TriggerClientEvent("OpenBandos-Farm", source)
                print "any else"
            end
        end
    end
end)

RegisterNetEvent("x_heist_robbery:startToRob")
AddEventHandler("x_heist_robbery:startToRob", function()
    local _source = source
    --(FrameworkSV.GetUserId(_source))
    --(request.getOwnerFortBando())
    if not request.isPlayerFromAnyBando(FrameworkSV.GetUserId(_source), true) then TriggerClientEvent("xFramework:Notify", _source, "negado", "Você não é de um bando!") return end
    if FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(_source), "lockpick", 1) then
        TriggerClientEvent('x_heist_robbery:startTimer', _source)
		TriggerClientEvent('x_heist_robbery:startAnimation', _source)
    else
        TriggerClientEvent("xFramework:Notify", _source, "negado", "Você não tem lockpick")
    end     
end)

RegisterNetEvent("x_heist_robbery:payout")
AddEventHandler("x_heist_robbery:payout", function()
    local source = source
    FrameworkSV.GiveMoney(FrameworkSV.GetUserId(source), 150)
    request.setDominado(disputaAtual)
end)
