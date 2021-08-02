--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("craftings_elixir")
craftings_elixir = Tunnel.getInterface("craftings_elixir")
craftings_elixirSv = Proxy.getInterface("craftings_elixir")
_Tunnel = {}
Tunnel.bindInterface("craftings_elixir", _Tunnel)

--------------------------------------------------------
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
function _Tunnel.getArbustoStamp(a)
    if d[a] then 
        return d[a]
    else 
        return false 
    end
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

function _Tunnel.bruxaPerm()
    return FrameworkSV.HasPermission(FrameworkSV.GetUserId(source), "elixir.permissao")
end
RegisterServerEvent("xFramework_ItemFunction:elixir_vida")
AddEventHandler("xFramework_ItemFunction:elixir_vida", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    if FrameworkSV.TryGetInventoryItem(user_id,"elixir_vida", 1) then 
        TriggerClientEvent("elixir", s, "vida")
    end 
end)

RegisterServerEvent("xFramework_ItemFunction:elixir_morte")
AddEventHandler("xFramework_ItemFunction:elixir_morte", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    if FrameworkSV.TryGetInventoryItem(user_id,"elixir_morte", 1) then 
        TriggerClientEvent("elixir", s, "morte")
    end 
end)

RegisterServerEvent("xFramework_ItemFunction:elixir_energia")
AddEventHandler("xFramework_ItemFunction:elixir_energia", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    if FrameworkSV.TryGetInventoryItem(user_id,"elixir_energia", 1) then 
        TriggerClientEvent("elixir", s, "energia")
    end 
end)

RegisterServerEvent("xFramework_ItemFunction:veruns_morthari")
AddEventHandler("xFramework_ItemFunction:veruns_morthari", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    if FrameworkSV.TryGetInventoryItem(user_id,"veruns_morthari", 1) then 
        TriggerClientEvent("elixir", s, "ficticio")
    end 
end)

RegisterServerEvent("xFramework_ItemFunction:veruns_transformarun")
AddEventHandler("xFramework_ItemFunction:veruns_transformarun", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    if FrameworkSV.TryGetInventoryItem(user_id,"veruns_transformarun", 1) then 
        TriggerClientEvent("elixir", s, "ficticio")
    end 
end)

RegisterServerEvent("xFramework_ItemFunction:atration_tontelle")
AddEventHandler("xFramework_ItemFunction:atration_tontelle", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    if FrameworkSV.TryGetInventoryItem(user_id,"atration_tontelle", 1) then 
        TriggerClientEvent("elixir", s, "ficticio")
    end 
end)


AddEventHandler("xFramework:PlayerLogin", function(source, user_id)
    craftings_elixir.blip(source)
end)