--------------------------------------------------------
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
FrameworkCL = Proxy.getInterface('_xFramework')
FrameworkSV = Tunnel.getInterface('_xFramework')
MultiCharacter = Tunnel.getInterface('x_medicos')
x_medicos = Proxy.getInterface('x_medicos')
x_medicosSv = Tunnel.getInterface('x_medicos')
_Tunnel = {}
Tunnel.bindInterface('x_medicos', _Tunnel)
--------------------------------------------------------

local playerInService = false
local blip = {}
Citizen.CreateThread(function()
    for k,v in pairs(config.entrar_em_servico) do
        blip[k] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v[1], v[2], v[3])
        SetBlipSprite(blip[k], -695368421, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], 'Hospital')
    end
end)
Citizen.CreateThread(
    function()
        while true do
            local W = 500
            local string = 'Você NÃO ESTÁ em serviço. Pressione [G] para entrar!'
            local playerCoords = GetEntityCoords(PlayerPedId())
            for k, v in ipairs(config.entrar_em_servico) do
                if not playerInService then
                    string = 'Você NÃO ESTÁ em serviço. Pressione [G] para entrar!'
                else
                    string = 'Você ESTÁ em serviço. Pressione [G] para sair!'
                end
                if GetDistanceBetweenCoords(playerCoords, v[1], v[2], v[3], true) < 4.0 then
                    W = 1
                    Citizen.InvokeNative(0x2A32FAA57B937173,-1795314153,v[1] - 0.6,v[2],v[3] - 2.0,0,0,0,0,0,0,1.0,1.0,1.5,255,255,0,155,0,0,2,0,0,0,0)
                    if GetDistanceBetweenCoords(playerCoords, v[1], v[2], v[3], true) < 1.0 then
                        DrawText3D(v[1] - 0.6,v[2],v[3]-1, string)
                        if IsControlJustPressed(0, 0x760A9C6F) then
                            if x_medicosSv.permissao() then
                                playerInService = not playerInService
                                if not playerInService then
                                else
                                end
                            end
                        end
                    end
                end
            end
            Citizen.Wait(W)
        end
    end
)

RegisterCommand("re", function(source, args, rawCommand)
    if playerInService then 
        local player = FrameworkCL.GetNearestPlayer(3)
            if player > 0 then
                local pedT = GetPlayerPed(player) 
                if GetEntityHealth(pedT) > 0 then return end;
                local h = GetEntityHeading(pedT)
                local j = GetEntityCoords(pedT)
                SetEntityCoordsNoOffset(PlayerPedId(), j)
                SetEntityHeading(PlayerPedId(), h+180)
                local dict  = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
                local anim = "inspectfloor_player"
                print("trigger<sucess>")
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do Wait(0) print("loading: try <TRY>>") end
                TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 1.0, 20000, 0, 0, true, 0, false, 0, false)
                Wait(7000)
                x_medicosSv.Reviver(GetPlayerServerId(player))
        end
    end
end )
function getSvFromPed(found)
    local sel ;
    for _, player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == found then 
            return GetPlayerServerId(player)
        end
    end
end

RegisterNetEvent("xFramework:CallCallback::medico")
AddEventHandler("xFramework:CallCallback::medico", function(authorName, authorId, cha_id)
    print(NetworkGetPlayerIndexFromPed(PlayerPedId()), x_medicosSv.src(authorId))
    if x_medicosSv.src(authorId) == getSvFromPed(PlayerPedId()) then 
        if not x_medicosSv.any() then 
            TriggerEvent("xFramework:Notify", "sucesso", "Chamado enviado. Aguarde resposta.")
        else
            TriggerEvent("xFramework:Notify", "negado", "Não foi possível enviar o chamado. Já há um ativo: Tente novamente me alguns segundos")
            return
        end
    end 
    Wait(300)
    if playerInService then 
        local cb_ac = false 
        print(authorName, authorId, cha_id)
        if not x_medicosSv.any() then 
            TriggerServerEvent("insert_call_1", cha_id)
            print(1)
            print(2)
            local source = x_medicosSv.src(authorId)
            local targPed = GetPlayerPed(GetPlayerFromServerId(source))
            local cds = GetEntityCoords(targPed)
            local msg = "Resgate Solicitado"
            Wait(300)
            addBlip(cds, msg, authorName, authorId, cha_id, source)
        end
    end
end)

function addBlip(cds, msg, authorName, authorId, cha_id, source)
    local x = cds.x
    local y = cds.y
    local z = cds.z
    local mensagem = msg
    local confirm_keys = {
        accept = 0x446258B6,
        decline = 0x3C3DD371
    }
    TriggerEvent("chat:addMessage",  {
        color = {240,248,255},
        multiline = true,
        args = {'MEDICO-ALERTA',"Novo chamado medico de: ".. authorName.. "["..authorId.."]: "..msg}
    })
    local i = 0 
    TriggerEvent("xFramework:Notify", "aviso", "PageUP: Aceitar; PageDOWN: Recusar")
    while true do
        i=i+1
        if i >= 2800 then TriggerEvent("xFramework:Notify", "aviso", "Tempo expirado; pedido recusado.") break end
        if IsControlJustPressed(0, confirm_keys.accept) then 
            if not x_medicosSv.isAccepted(cha_id) then 
                x_medicosSv.manageCall(cha_id, true)
                x_medicosSv.notif(source, "sucesso", "Seu chamado foi aceito, aguarde a chegada.")
                TriggerEvent("xFramework:Notify", "sucesso", "Chamado Aceito")
                print('adicionado ás ', cds)
                StartGpsMultiRoute(6, true, true)
                AddPointToGpsMultiRoute(x, y, z)
                AddPointToGpsMultiRoute(x, y, z)
                SetGpsMultiRouteRender(true)
                Wait(30000)
                local x,y,z = Citizen.InvokeNative(0xA86D5F069399F44D, PlayerPedId(), Citizen.ResultAsVector())
                StartGpsMultiRoute(6, false, false)
                AddPointToGpsMultiRoute(x, y, z)
                AddPointToGpsMultiRoute(x, y, z)
                SetGpsMultiRouteRender(false)
            else
                TriggerEvent("xFramework:Notify", "negado", "Este chamado já foi aceito")
            end
            break
        elseif IsControlJustPressed(0, confirm_keys.decline) then 
            TriggerEvent("xFramework:Notify", "negado", "Chamado Recusado")
            break
        end
        Wait(0)
    end
end



function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z+1.0)
    local px,py,pz=table.unpack(GetGameplayCamCoord())  
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
        SetTextScale(0.35, 0.35)
      SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        SetTextCentre(1)
        SetTextDropshadow(1, 0, 0, 0, 255)
        DisplayText(str,_x,_y)
    end
end