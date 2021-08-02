local Tunnel = module("Server/CallBack/Callback_Tunnel")
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tools = module("Server/CallBack/Callback_Tools")

_Framework = {}
local ready = false
local inRaio = false
local userWeapons = {}
FrameworkSV = Tunnel.getInterface("_xFramework")
Proxy.addInterface("_xFramework",_Framework)
Tunnel.bindInterface("_xFramework",_Framework)

function _Framework.Ready(vida)
    ready = true
    SetJoinHealth(vida)
end
function reduzirNumero(numero)
    return math.ceil(numero*100)/100
end


function NewEvent(functionName, Function)
    RegisterNetEvent(functionName)
    AddEventHandler(functionName, Function)
end



-- function _Framework.getGlobalConfig()
--         return ConfigFile
-- end


function a()

end

function _Framework.GetNearestPlayer(radius)
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end

    for i = 1, #players, 1 do
        local tgt = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance

            end
        end
    end
    if closestDistance <= radius then 
        return closestPlayer, closestDistance, GetPlayerServerId(closestPlayer)
    else 
        return 0, 0, 0
    end
end
Citizen.CreateThread(function()
    Citizen.InvokeNative(0x4B8F743A4A6D2FF8, true) -- Revelar o mapa todo para o jogador
    while true do
        Citizen.Wait(10000)
        if IsPlayerPlaying(PlayerId()) and ready then
            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
            x=reduzirNumero(x)
            y=reduzirNumero(y)
            z=reduzirNumero(z)
            FrameworkSV.UpdatePlayerLastPosition(x, y, z)
            FrameworkSV.UpdatePlayerLife(GetEntityHealth(PlayerPedId()))
        end
    end
end)

function _Framework.spawnHorse(horse)
    local waiting = 0
    while not HasModelLoaded(horse) do
        waiting = waiting + 100
        Citizen.Wait(100)
        RequestModel(horse)
        if waiting > 5000 then
            TriggerEvent("xFramework:Notify", "negado","ped invalido")
            break
        end
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    local playerPed = PlayerPedId()
    local create = CreatePed(horse, x+0.1, y, z+2, GetEntityHeading(playerPed), 1, 0)
    Citizen.InvokeNative(0x6A071245EB0D1882, create, playerPed, -1, 7.2, 2.0, 0, 0)
    Citizen.InvokeNative(0x283978A15512B2FE, create, true)
    Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, create)
    SetModelAsNoLongerNeeded(create)
    local n = Citizen.InvokeNative
    local entity = create
    local default_stamina = GetAttributeCoreValue(create, 1)
    default_stamina = default_stamina - 50
    Citizen.InvokeNative(0xC6258F41D86676E0, create, 1, default_stamina) --core
    Citizen.InvokeNative(0xC6258F41D86676E0, create, 0, default_stamina) --core
    n(0x6A071245EB0D1882, create, playerPed, -1, 15.2, 2.0, 0, 0)
    n(0x283978A15512B2FE, create, true)
    n(0x23f74c2fda6e7c61, -1230993421, create)
    n(0x5F57522BC1EB9D9D, create, GetHashKey('PLAYER_HORSE'))
    n(0xFD6943B6DF77E449, create, false)
    tag = n(0xE961BF23EAB76B12, create, name)
    n(0x931B241409216C1F, PlayerPedId(), create, 0)
    n(0x5F57522BC1EB9D9D, tag, GetHashKey('PLAYER_HORSE'))
    AddAttributePoints(create, 7, 950)
    n(0xA691C10054275290, PlayerPedId(), create, 0)
    n(0x931B241409216C1F, PlayerPedId(), create, 0)
    n(0xED1C764997A86D5A, PlayerPedId(), create)
    n(0xED1C764997A86D5A, PlayerPedId(), create)
    n(0xB8B6430EAD2D2437, create, 130495496)
    n(0xDF93973251FB2CA5, GetEntityModel(create), 1)
    n(0xAEB97D84CDF3C00B, create, 0)
    n(0x1913FE4CBF41C463, create, 211, true)
    n(0x1913FE4CBF41C463, create, 208, true)
    n(0x1913FE4CBF41C463, create, 209, true)
    n(0x1913FE4CBF41C463, create, 400, true)
    n(0x1913FE4CBF41C463, create, 297, true)
    n(0x1913FE4CBF41C463, create, 136, false)
    n(0x1913FE4CBF41C463, create, 312, false)
    n(0x1913FE4CBF41C463, create, 113, false)
    n(0x1913FE4CBF41C463, create, 301, false)
    n(0x1913FE4CBF41C463, create, 277, true)
    n(0x1913FE4CBF41C463, create, 319, true)
    n(0x1913FE4CBF41C463, create, 6, true)
    n(0x9FF1E042FA597187, create, 25, false)
    n(0x9FF1E042FA597187, create, 24, false)
    n(0xA691C10054275290, create, PlayerId())
    n(0x6734F0A6A52C371C, PlayerId(), 431)
    n(0x024EC9B649111915, create, 1)
    n(0xEB8886E1065654CD, create, 10, 'ALL', 10)
end

function _Framework.FirstJoin()
    local x, y, z = FrameworkSV.newPSpawnPos().x, FrameworkSV.newPSpawnPos().y, FrameworkSV.newPSpawnPos().z
    SetEntityCoords(PlayerPedId(), x, y, z )
    -- --("teleportado para a posição inicial!")
end
function _Framework.GetPosition()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    return {x=x, y=y, z=z}
end

function _Framework.GetDistance(x1,y1,z1,x2,y2,z2)
    return GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, true)
end

function _Framework.TeleportPlayer(x, y, z)
    SetEntityCoords(PlayerPedId(), x, y, z, true, true, true, false )
end
local fire = false
function _Framework.StartFire()
    fire = not fire
end

function _Framework.ForceLightningFlashAtCoords_(x, y, z)
    cds = vector3(x, y, z)
    ForceLightningFlashAtCoords(cds);
end

function _Framework.startRaio()
    inRaio = not inRaio
end

function SetJoinHealth(v)
    SetEntityHealth(PlayerPedId(), tonumber(v))

end
function _Framework.mHHHHHhhhhHH(AHHHHHHHH_)
    SetEntityMaxHealth(PlayerPedId(), 100)
end
function _Framework.TeleportPlayerToWaypoint()
    local playerped = PlayerPedId()
    local waypt =   GetWaypointCoords()

    local vehicle = Citizen.InvokeNative(0x9A9112A0FE9A4713, playerped,false)
    local entity
    for height = 1, 1000 do
        if Citizen.InvokeNative(0xA3EE4A07279BB9DB, playerped,vehicle,true) then
            entity = vehicle
        else
            entity = playerped
        end

        SetEntityCoords(entity, waypt.x, waypt.y, height + 0.0, true, true, true, false)
        local foundGround, zPos = GetGroundZAndNormalFor_3dCoord(waypt.x, waypt.y, height + 0.0)

        if foundGround then
            SetEntityCoords(playerped , waypt.x, waypt.y, height + 0.0, true, true, true, false)
            break
        end

        Citizen.Wait(5)
        SetEntityCoords(playerped , waypt.x, waypt.y + height, height + 0.0, true, true, true, false)
    end
end

function _Framework.varyHealth(variation)
    local ped = PlayerPedId()
    local n = math.floor(GetEntityHealth(ped)+variation)
    SetEntityHealth(ped,n)
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if (not IsEntityDead(PlayerPedId()) and fire) then
            StartEntityFire(PlayerPedId(), 0, 0, 100000);
        else
            fire = false;
        end
    end
end)
function GetCoordsFromCam(distance)
    local rot = GetGameplayCamRot(2);
    local coord = GetGameplayCamCoord()   
    local tZ = rot.z * 0.0174532924
    local tX = rot.x * 0.0174532924    
    local num = math.abs(math.cos(tX))   
    local newCoordX = coord.x + (-math.sin(tZ)) * (num + distance);
    local newCoordY = coord.y + (math.cos(tZ)) * (num + distance);
    local newCoordZ = coord.z + (math.sin(tX)) * (num + distance) 
    return vector3(newCoordX, newCoordY, newCoordZ);
end
Citizen.CreateThread(function()
    while true do 
    W = 1500
        if inRaio then 
            W = 1 
            local camCoords = GetGameplayCamCoord()
            local sourceCoords = GetCoordsFromCam(1000.0)
            local rayHandle = StartShapeTestRay(camCoords, sourceCoords, -1, PlayerPedId(), 0);
            local result, hit, endCoord, surfaceNormal, entity = GetShapeTestResult(rayHandle)
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, endCoord, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 50.0, 153, 51, 153, 50, false, false, 2, false, 0, 0, false);
            if (IsControlJustPressed(0, 0xCEE12B50)) then
                FrameworkSV.addRaio(endCoord.x, endCoord.y, endCoord.z)
            end
        end   
    Citizen.Wait(W)
    end
end)


--> Kill Logs
