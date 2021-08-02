--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_policia")
x_policia = Tunnel.getInterface("x_policia")
x_policiaSv = Proxy.getInterface("x_policia")
_Tunnel = {}
Tunnel.bindInterface("x_policia", _Tunnel)
local data = {
    chamados = {},
    ativo = false
}
--------------------------------------------------------

function _Tunnel.permissao()
    local has = false 
    local source = source
    local user_id = FrameworkSV.GetUserId(source);
    if FrameworkSV.HasPermission(user_id, config.perm) then 
        has = true 
    else 
        TriggerClientEvent("xFramework:Notify", source, 'negado', "Você não é da polícia")
    end
    return has
end
function _Tunnel.permissao_2()
    local has = false 
    local source = source
    local user_id = FrameworkSV.GetUserId(source);
    if FrameworkSV.HasPermission(user_id, config.cargo2) then 
        has = true 
    end
    return has
end


function _Tunnel.Algemar(nearSource)
    local isAlgemado = x_policia.isAlgemado(nearSource)
    print(isAlgemado)
        if isAlgemado then 
            x_policia.Desalgemar(nearSource)
        else
            x_policia.Algemar(nearSource)
    end
end


function _Tunnel.cv(nearSource)

    x_policia.cv(nearSource)
end
function _Tunnel.cv(nearSource)

     x_policia.rv(nearSource)
end


RegisterServerEvent("insert_call_2")
AddEventHandler("insert_call_2", function(callid)
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

function sendMessageToSource(source, t1, t2, r, g, b)
    TriggerClientEvent("chat:addMessage", source,  
    {
        color = {r, g, b },
        multiline = true,
        args = {t1,t2}
    })
end
RegisterCommand("revistar", function(source)
    local nearId, _, nearSrc = FrameworkCL.GetNearestPlayer(source, 3)  
    if nearId >= 1 then
        local nearInventory = FrameworkSV.GetInventory(FrameworkSV.GetUserId(nearSrc))
        sendMessageToSource(source, "-----> Revistar <----", "", 255, 0, 0)
        for k, v in pairs(nearInventory) do 
            local itemName = FrameworkSV.GetItemLabel(k);
            local itemQnt = v.amount 
            sendMessageToSource(source, "x"..itemQnt,""..itemName, 255, 0, 0)
        end
        sendMessageToSource(source, "-----> Revistar <----", "", 255, 0, 0)
    else
        TriggerClientEvent("xFramework:Notify", source, "negado", "Não há jogadores próximos")
    end
end)
RegisterCommand("loot", function(source)
    local nearId, _, nearSrc = FrameworkCL.GetNearestPlayer(source, 3)  
    if nearId >= 1 then
        local nearInventory = FrameworkSV.GetInventory(FrameworkSV.GetUserId(nearSrc))
        local ped, life = x_policia.getPlayerPedFromServerIdAndLifeLevel(source, nearSrc)
        if life <= 0 then 
            x_policia.lootAnim(source)
            x_policia.ExecuteGARMAS(nearSrc)
            TriggerClientEvent("xFramework:Notify", source, "aviso", "Aguarde mais alguns segundos...")
            Wait(5000)
            for k, v in pairs(nearInventory) do
                local itemName = k;
                local itemQnt = v.amount
                wbh(userId.." [LOOT] x"..itemQnt.. " "..itemName.. " de "..FrameworkSV.GetUserId(nearSrc))
                FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(nearSrc), itemName, itemQnt)
                local can = FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), itemName, itemQnt)
                if can and can == "fail" then 
                    FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(nearSrc), itemName, itemQnt)
                end
            end
        else
            TriggerClientEvent("xFramework:Notify", source, "negado", "Você só pode lootear alguém morto.")
        end
    else
        TriggerClientEvent("xFramework:Notify", source, "negado", "Não há jogadores próximos")
    end
end)

RegisterCommand("apreender", function(source)
    local userId = FrameworkSV.GetUserId(source)
    if not FrameworkSV.HasPermission(userId, "policia.permissao") then return end; 
    local nearId, _, nearSrc = FrameworkCL.GetNearestPlayer(source, 3)  
    if nearId >= 1 then
        local nearInventory = FrameworkSV.GetInventory(FrameworkSV.GetUserId(nearSrc))
        -- local ped, life = x_policia.getPlayerPedFromServerIdAndLifeLevel(source, nearSrc)
        -- if life <= 0 then 
            -- x_policia.lootAnim(source)
            x_policia.ExecuteGARMAS(nearSrc)
            TriggerClientEvent("xFramework:Notify", source, "aviso", "Aguarde alguns segundos...")
            Wait(5000)
            for k, v in pairs(nearInventory) do
                local itemName = k;
                local itemQnt = v.amount
                FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(nearSrc), itemName, itemQnt)
                wbh(userId.." [Apreender] x"..itemQnt.. " "..itemName.. " de "..FrameworkSV.GetUserId(nearSrc))
                local can = FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), itemName, itemQnt)
                if can and can == "fail" then 
                    print "devolvendo failStatusItem: "
                    print(">> ",itemName,itemQnt)
                    FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(nearSrc), itemName, itemQnt)
                end
            end
        -- else
            -- TriggerClientEvent("xFramework:Notify", source, "negado", "Você só pode lootear alguém morto.")
        -- end
    else
        TriggerClientEvent("xFramework:Notify", source, "negado", "Não há jogadores próximos")
    end
end)


function wbh(m)
    TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/867129770462150726/pIX9MFH54yeoD1XNuv9xQtcmWClThlEJNKv2XRrlkfTtWWMgsG_KF4o3-YO2VOqsA2jz", m)
  end