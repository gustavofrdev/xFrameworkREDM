
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkSV = Proxy.getInterface("_xFramework")
FrameworkCL = Tunnel.getInterface("x_elixir")
MultiCharacter = Tunnel.getInterface("x_elixir")
_Tunnel = {}
Tunnel.bindInterface("x_elixir", _Tunnel)


local delay = 20 --(min)
local d = {}
local f = {}
function _Tunnel.set(arbusto)
    -- if not f[arbusto] then 
        f[arbusto] = 1 
        d[arbusto] = os.time()
        f[arbusto] = 0;
    -- else
        -- f[arbusto] = f[arbusto] + 1
    -- end 
end
function _Tunnel.isBruxa()
    if not FrameworkSV.GetUserId(source) then return false end;
    return FrameworkSV.HasPermission(FrameworkSV.GetUserId(source), "elixir.permissao")
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

AddEventHandler("xFramework:PlayerLogin", function(source, user_id)
    FrameworkCL.blip(source)
end)