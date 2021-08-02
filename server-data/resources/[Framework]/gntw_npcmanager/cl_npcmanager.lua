local loadnpc = function(personagem)
    local i = 1
    personagem = GetHashKey(personagem)
    while not HasModelLoaded(personagem) do
        i = i + 1
        RequestModel(personagem)
        if i > 200 then
            error(
                'Há algo de errado com o ped(NÃO EXISTENTE/ERRO DIGITAÇÃO). Isso fez com que o script parasse de rodar. Por favor, verifique o problema.'
            )
            break
        end
        Citizen.Wait(10)
    end
end
local loaddict = function(dict)
    local i = 1
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        i = i + 1
        RequestAnimDict(dict)
        if i > 200 then
            error(
                'Há algo de errado com o dict desta animação(NÃO EXISTENTE/ERRO DIGITAÇÃO). Isso fez com que o script parasse de rodar. Por favor, verifique o problema.'
            )
            break
        end
        Citizen.Wait(10)
    end
end
local Main = function()
    while true do
        local Wait = 500
        for k, v in pairs(Config.NPCS) do
            local Me = PlayerPedId()
            local MeCoords = GetEntityCoords(Me)
            local checkDistance = GetDistanceBetweenCoords(MeCoords, v[1], v[2], v[3], true)
            if Config.DebugMode and checkDistance < v.distanciasumir then
                Wait = 0
                local internalID = v[1] .. '-' .. v[2] .. '-' .. v[3] .. '-' .. v[4] .. '_' .. v.ped
                DrawText3D(v[1], v[2], v[3], internalID)
            end
            if checkDistance > v.distanciasumir and v.spawnado then
                if v.ScriptInteraceID ~= nil then
                    v.spawnado = false
                    DeletePed(v.ScriptInteraceID)
                end
            elseif checkDistance < v.distanciasumir and not v.spawnado then
                if v.horario.usar == false then
                    v.spawnado = true

                    Wait = 0
                    loadnpc(v.ped)
                    --('criando ' .. v.ped)
                    local NPC_CREATED =
                        CreatePed(GetHashKey(v.ped), v[1], v[2], v[3] - v.lessground, v[4], false, false, false, false)
                    SetModelAsNoLongerNeeded(GetHashKey(v.ped))
                    SetEntityAsMissionEntity(NPC_CREATED, true, true)
                    Citizen.InvokeNative(0x283978A15512B2FE, NPC_CREATED, true)
                    RequestCollisionAtCoord(x, y, z)
                    SetPedCanBeTargettedByPlayer(NPC_CREATED, GetPlayerPed(), false)
                    SetBlockingOfNonTemporaryEvents(NPC_CREATED, true)
                    v.ScriptInteraceID = NPC_CREATED
                    if v.animacao.usar then
                        local flags = 0
                        local animDict, animName, animFlags = 0, 0, 0
                        if v.animacao.loop then
                            flags = flags + 1
                        end
                        loaddict(v.animacao.dict)
                        if HasAnimDictLoaded(v.animacao.dict) then
                            animDict = v.animacao.dict
                            animName = v.animacao.anim
                            animFlags = flags
                            TaskPlayAnim(NPC_CREATED, v.animacao.dict, v.animacao.anim, 3.0, 3.0, -1, flags, 0, 0, 0, 0)
                        end
                    end
                    if v.parado then
                        FreezeEntityPosition(NPC_CREATED, true)
                        SetBlockingOfNonTemporaryEvents(NPC_CREATED, true)
                        SetEntityInvincible(NPC_CREATED, true)
                    end
                elseif v.horario.usar == true then
                    if GetClockHours() >= tonumber(v.horario.inicio) and GetClockHours() <= tonumber(v.horario.fim) then
                        v.spawnado = true

                        Wait = 0
                        loadnpc(v.ped)

                        local NPC_CREATED =
                            CreatePed(GetHashKey(v.ped), v[1], v[2], v[3] + 2, v[4], false, false, false, false)

                        v.ScriptInteraceID = NPC_CREATED
                        if v.animacao.usar then
                            local flags = 0
                            local animDict, animName, animFlags = 0, 0, 0
                            if v.animacao.loop then
                                flags = flags + 1
                            end
                            loaddict(v.animacao.dict)
                            if HasAnimDictLoaded(v.animacao.dict) then
                                animDict = v.animacao.dict
                                animName = v.animacao.anim
                                animFlags = flags
                                TaskPlayAnim(
                                    NPC_CREATED,
                                    v.animacao.dict,
                                    v.animacao.anim,
                                    3.0,
                                    3.0,
                                    -1,
                                    flags,
                                    0,
                                    0,
                                    0,
                                    0
                                )
                            end
                        end
                        if v.parado then
                            FreezeEntityPosition(NPC_CREATED, true)
                            SetBlockingOfNonTemporaryEvents(NPC_CREATED, true)
                            SetEntityInvincible(NPC_CREATED, true)
                        end
                    end
                end
            end
        end
        Citizen.Wait(Wait)
    end
end
Citizen.CreateThread(Main)
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
