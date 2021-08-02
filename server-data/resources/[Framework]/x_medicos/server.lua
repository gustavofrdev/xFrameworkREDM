--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_medicos")
x_medicos = Tunnel.getInterface("x_medicos")
x_medicosSv = Proxy.getInterface("x_medicos")
_Tunnel = {}
Tunnel.bindInterface("x_medicos", _Tunnel)
local data = {
    chamados = {},
    ativo = false
}
-------------------------------------------------------

function _Tunnel.permissao()
    local has = false 
    local source = source
    local user_id = FrameworkSV.GetUserId(source);
    if FrameworkSV.HasPermission(user_id, config.perm) then 
        has = true 
    else 
        TriggerClientEvent("xFramework:Notify", source, 'negado', "Você não é um médico")
    end
    return has
end
function _Tunnel.Reviver(source)
    FrameworkCL.ReviveGod(source)
end
-- function _Tunnel.insertCall(callid)
RegisterServerEvent("insert_call_1")
AddEventHandler("insert_call_1", function(callid)
    data.chamados[callid] = {} 
    data.chamados[callid].aceito = false 
    data.chamados[callid].prog = false
    data.ativo = true 
    Wait(30000)
    data.ativo = false
    data.chamados[callid] = nil;
end)
function _Tunnel.manageCall(callid, isAccepted)
    data.chamados[callid].aceito = isAccepted
end
function _Tunnel.isAccepted(callid)
    print(json.encode(data.chamados))
    return data.chamados[callid].aceito
end
function _Tunnel.any()
    return data.ativo
end


RegisterServerEvent("insert_call_1")
AddEventHandler("insert_call_1", function(callid)
    data.chamados[callid] = {} 
    data.chamados[callid].aceito = false 
    data.chamados[callid].prog = false
    data.ativo = true 
    Wait(30000)
    data.ativo = false
    data.chamados[callid] = nil;
end)
function _Tunnel.manageCall(callid, isAccepted)
    data.chamados[callid].aceito = isAccepted
end
function _Tunnel.isAccepted(callid)
    print(json.encode(data.chamados))
    return data.chamados[callid].aceito
end
function _Tunnel.src(id)
    return FrameworkSV.GetUserSource(id)
end
function _Tunnel.any()
    return data.ativo
end
local s = {}
function _Tunnel.notif(p, tip, mes)
    TriggerClientEvent("xFramework:Notify", p, tip, mes)
end
