--------------------------------------------------------
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
FrameworkCL = Proxy.getInterface('_xFramework')
FrameworkSV = Tunnel.getInterface('_xFramework')
MultiCharacter = Tunnel.getInterface('x_policia')
x_policia = Proxy.getInterface('x_policia')
x_policiaSv = Tunnel.getInterface('x_policia')
_Tunnel = {}
Tunnel.bindInterface('x_policia', _Tunnel)
--------------------------------------------------------
local playerInService = false
local algemado = false
RegisterCommand(
    'h',
    function()
        print(GetEntityHeading(PlayerPedId()))
    end
)
local blip = {}
Citizen.CreateThread(
    function()
        for k, v in pairs(config.entrar_em_servico) do
            blip[k] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v[1], v[2], v[3])
            SetBlipSprite(blip[k], -1125110489, 1)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], 'Departamento Polícial')
        end
    end
)
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
                    Citizen.InvokeNative(
                        0x2A32FAA57B937173,
                        -1795314153,
                        v[1] - 0.6,
                        v[2],
                        v[3] - 2.0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        1.0,
                        1.0,
                        1.5,
                        255,
                        255,
                        0,
                        155,
                        0,
                        0,
                        2,
                        0,
                        0,
                        0,
                        0
                    )
                    if GetDistanceBetweenCoords(playerCoords, v[1], v[2], v[3], true) < 1.0 then
                        DrawText3D(v[1] - 0.6, v[2], v[3] - 1, string)
                        if IsControlJustPressed(0, 0x760A9C6F) then
                            if x_policiaSv.permissao() then
                                if not x_policiaSv.permissao_2() then
                                    playerInService = not playerInService
                                    TriggerEvent("police_em_servico_status", playerInService)
                                    if not playerInService then
                                        Citizen.InvokeNative(0x1B83C0DEEBCBB214, PlayerPedId())
                                        RemoveAllPedWeapons(PlayerPedId(), true, true)
                                    else
                                        for k2, v2 in pairs(config.lista_de_armas_def) do
                                            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), k2, 0, true, 0)
                                            SetPedAmmo(PlayerPedId(), k2, v2 + 1)
                                        end
                                    end
                                else
                                    playerInService = not playerInService
                                    TriggerEvent("police_em_servico_status", playerInService)
                                    if not playerInService then
                                        Citizen.InvokeNative(0x1B83C0DEEBCBB214, PlayerPedId())
                                        RemoveAllPedWeapons(PlayerPedId(), true, true)
                                    else
                                        for k2, v2 in pairs(config.lista_de_armas_2) do
                                            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), k2, 0, true, 0)
                                            SetPedAmmo(PlayerPedId(), k2, v2 + 1)
                                        end
                                    end
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

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z + 1.0)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    local str = CreateVarString(10, 'LITERAL_STRING', text, Citizen.ResultAsLong())
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        SetTextCentre(1)
        SetTextDropshadow(1, 0, 0, 0, 255)
        DisplayText(str, _x, _y)
    end
end
function SetIndex()
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0xD3ECF82F) then
                if x_policiaSv.permissao() then
                    local nearId, _, nearSrc = FrameworkCL.GetNearestPlayer(3)  
                    if nearId > 0 then
                        x_policiaSv.Algemar(GetPlayerServerId(nearSrc))
                    end
                end
            end
        end
    end
)

function _Tunnel.Algemar()
    algemado = true
    SetEnableHandcuffs(PlayerPedId(), true)
end

function _Tunnel.Desalgemar()
    algemado = false
    UncuffPed(PlayerPedId())
end

function _Tunnel.isAlgemado()
    return algemado
end

function _Tunnel.cv()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetVehicleCoords(coords)
    local seats = 1
    while seats <= 6 do
        if Citizen.InvokeNative(0xE052C1B1CAA4ECE4, vehicle, seats) then
            -- print('Vehiclue seat')
            Citizen.InvokeNative(0xF75B0D629E1C063D, ped, vehicle, seats)
            break
        end
        if seats == 7 then
            -- print('ESTO ESTA LLENO MUCHACHO')
            break
        end

        seats = seats + 1
    end
end

function _Tunnel.rv()
    local playerPed = PlayerPedId()
    local vehicle = GetVehicleCoords(coords)
    local inVehicle = GetVehiclePedIsIn(playerPed, false)
    local flag = 16
    TaskLeaveVehicle(playerPed, vehicle, flag)
end

function getSvFromPed(found)
    local sel
    for _, player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == found then
            return GetPlayerServerId(player)
        end
    end
end

RegisterNetEvent('xFramework:CallCallback::policia_roubo_progress')
AddEventHandler(
    'xFramework:CallCallback::policia_roubo_progress',
    function(x, y, z)
        if playerInService then
            TriggerEvent('xFramework:Notify', 'negado', 'Um crime está acontecendo, uma nova rota foi adicionada.')
            StartGpsMultiRoute(6, true, true)
            AddPointToGpsMultiRoute(x, y, z)
            AddPointToGpsMultiRoute(x, y, z)
            SetGpsMultiRouteRender(true)
            Wait(30000)
            local x, y, z = Citizen.InvokeNative(0xA86D5F069399F44D, PlayerPedId(), Citizen.ResultAsVector())
            StartGpsMultiRoute(6, false, false)
            AddPointToGpsMultiRoute(x, y, z)
            AddPointToGpsMultiRoute(x, y, z)
            SetGpsMultiRouteRender(false)
        end
    end
)

RegisterNetEvent('xFramework:CallCallback::policia')
AddEventHandler(
    'xFramework:CallCallback::policia',
    function(authorName, authorId, cha_id)
        print(NetworkGetPlayerIndexFromPed(PlayerPedId()), x_policiaSv.src(authorId))
        if x_policiaSv.src(authorId) == getSvFromPed(PlayerPedId()) then
            if not x_policiaSv.any() then
                TriggerEvent('xFramework:Notify', 'sucesso', 'Chamado enviado. Aguarde resposta.')
            else
                TriggerEvent(
                    'xFramework:Notify',
                    'negado',
                    'Não foi possível enviar o chamado. Já há um ativo: Tente novamente me alguns segundos'
                )
                return
            end
        end
        Wait(300)
        if playerInService then
            local cb_ac = false
            print(authorName, authorId, cha_id)
            if not x_policiaSv.any() then
                TriggerServerEvent('insert_call_2', cha_id)
                print(1)
                print(2)
                local source = x_policiaSv.src(authorId)
                local targPed = GetPlayerPed(GetPlayerFromServerId(source))
                local cds = GetEntityCoords(targPed)
                local msg = 'Resgate Solicitado'
                Wait(300)
                addBlip(cds, msg, authorName, authorId, cha_id, source)
            end
        end
    end
)

function addBlip(cds, msg, authorName, authorId, cha_id, source)
    local x = cds.x
    local y = cds.y
    local z = cds.z
    local mensagem = msg
    local confirm_keys = {
        accept = 0x446258B6,
        decline = 0x3C3DD371
    }
    TriggerEvent(
        'chat:addMessage',
        {
            color = {138, 3, 3},
            multiline = true,
            args = {'POLICIA-ALERTA', 'Novo chamado policial de: ' .. authorName .. '[' .. authorId .. ']: ' .. msg}
        }
    )
    local i = 0
    TriggerEvent('xFramework:Notify', 'aviso', 'PageUP: Aceitar; PageDOWN: Recusar')
    while true do
        i = i + 1
        if i >= 2800 then
            TriggerEvent('xFramework:Notify', 'aviso', 'Tempo expirado; pedido recusado.')
            break
        end
        if IsControlJustPressed(0, confirm_keys.accept) then
            if not x_policiaSv.isAccepted(cha_id) then
                x_policiaSv.manageCall(cha_id, true)
                x_policiaSv.notif(source, 'sucesso', 'Seu chamado foi aceito, aguarde a chegada.')
                TriggerEvent('xFramework:Notify', 'sucesso', 'Chamado Aceito')
                print('adicionado ás ', cds)
                StartGpsMultiRoute(6, true, true)
                AddPointToGpsMultiRoute(x, y, z)
                AddPointToGpsMultiRoute(x, y, z)
                SetGpsMultiRouteRender(true)
                Wait(30000)
                local x, y, z = Citizen.InvokeNative(0xA86D5F069399F44D, PlayerPedId(), Citizen.ResultAsVector())
                StartGpsMultiRoute(6, false, false)
                AddPointToGpsMultiRoute(x, y, z)
                AddPointToGpsMultiRoute(x, y, z)
                SetGpsMultiRouteRender(false)
            else
                TriggerEvent('xFramework:Notify', 'negado', 'Este chamado já foi aceito')
            end
            break
        elseif IsControlJustPressed(0, confirm_keys.decline) then
            TriggerEvent('xFramework:Notify', 'negado', 'Chamado Recusado')
            break
        end
        Wait(0)
    end
end

function _Tunnel.getPlayerPedFromServerIdAndLifeLevel(serverId)
    print( GetPlayerPed(GetPlayerFromServerId(serverId)))
    return GetPlayerPed(GetPlayerFromServerId(serverId)), GetEntityHealth(GetPlayerPed(GetPlayerFromServerId(serverId)))
end
function _Tunnel.lootAnim()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, "inspectfloor_player", 1.0, 8.0, -1, 1, 0, false, false, false)
    exports["x_progress"]:startUI(4000, "Loot...")
    Wait(4000)
    ClearPedTasksImmediately(PlayerPedId())
end
function _Tunnel.ExecuteGARMAS()
    ExecuteCommand("garmas")
end