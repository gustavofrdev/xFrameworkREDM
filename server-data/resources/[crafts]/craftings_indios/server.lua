--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("craftings_indios")
craftings_indios = Tunnel.getInterface("craftings_indios")
craftings_indiosSv = Proxy.getInterface("craftings_indios")
_Tunnel = {}
Tunnel.bindInterface("craftings_indios", _Tunnel)

--------------------------------------------------------
local delay = 20 --(min)
local d = {}
local f = {}
function _Tunnel.set(arbusto)
    if f[arbusto] and f[arbusto] >= 3 then 
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
-- "bandido1.permissao"}
function _Tunnel.medPerm()
    return FrameworkSV.HasPermission(FrameworkSV.GetUserId(source), "indio.permissao") 
    or FrameworkSV.HasPermission(FrameworkSV.GetUserId(source), "bandido1.permissao")
    or FrameworkSV.HasPermission(FrameworkSV.GetUserId(source), "bandido2.permissao")
end
