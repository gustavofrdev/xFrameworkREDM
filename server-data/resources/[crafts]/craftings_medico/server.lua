--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("craftings_medico")
craftings_medico = Tunnel.getInterface("craftings_medico")
craftings_medicoSv = Proxy.getInterface("craftings_medico")
_Tunnel = {}
Tunnel.bindInterface("craftings_medico", _Tunnel)

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

function _Tunnel.medPerm()
    return FrameworkSV.HasPermission(FrameworkSV.GetUserId(source), "medico.permissao")
end
RegisterServerEvent("xFramework_ItemFunction:tonico_ar_")
AddEventHandler("xFramework_ItemFunction:tonico_ar_", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    FrameworkSV.TryGetInventoryItem(user_id,"tonico_ar_", 1)
    TriggerClientEvent("tonicos", s, "tonico_ar_")
end)
RegisterServerEvent("xFramework_ItemFunction:tonico_aa_")
AddEventHandler("xFramework_ItemFunction:tonico_aa_", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    FrameworkSV.TryGetInventoryItem(user_id,"tonico_aa_", 1)
    TriggerClientEvent("tonicos", s, "tonico_aa_")
end)
RegisterServerEvent("xFramework_ItemFunction:tonico_ga_")
AddEventHandler("xFramework_ItemFunction:tonico_ga_", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    FrameworkSV.TryGetInventoryItem(user_id,"tonico_ga_", 1)
    TriggerClientEvent("tonicos", s, "tonico_ga_")
end)
RegisterServerEvent("xFramework_ItemFunction:tonico_ba_")
AddEventHandler("xFramework_ItemFunction:tonico_ba_", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    FrameworkSV.TryGetInventoryItem(user_id,"tonico_ba_", 1)
    TriggerClientEvent("tonicos", s, "tonico_ba_")
end)
RegisterServerEvent("xFramework_ItemFunction:tonico_aga_")
AddEventHandler("xFramework_ItemFunction:tonico_aga_", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    FrameworkSV.TryGetInventoryItem(user_id,"tonico_aga_", 1)
    TriggerClientEvent("tonicos", s, "tonico_aga_")
end)
RegisterServerEvent("xFramework_ItemFunction:tonico_gh_")
AddEventHandler("xFramework_ItemFunction:tonico_gh_", function(user_id)
    local s = FrameworkSV.GetUserSource(user_id)
    FrameworkSV.TryGetInventoryItem(user_id,"tonico_gh_", 1)
    TriggerClientEvent("tonicos", s, "tonico_gh_")
end)