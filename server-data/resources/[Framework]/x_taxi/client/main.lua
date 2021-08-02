--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
x_cavalos = Proxy.getInterface("x_cavalos")
MultiCharacter = Tunnel.getInterface("x_taxi")
x_taxi = Proxy.getInterface("x_taxi")
x_taxiSv = Tunnel.getInterface("x_taxi")
_Tunnel = {}
Tunnel.bindInterface("x_taxi", _Tunnel)
--------------------------------------------------------
local emServico = false

local driving = false
local keys = { ['O'] = 0xF1301666, ['G'] = 0x5415BE48 }

-- Create Wagon Wheel Map Marker

Citizen.CreateThread(function()
    for _, marker in pairs(Config.Marker) do
        local blip = N_0x554d9d53f696d002(1664425300, marker.x, marker.y, marker.z)
        SetBlipSprite(blip, marker.sprite, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Chofer")

    end  
end)

-- Spawn Buy Stage Coach NPC Location Trigger
Citizen.CreateThread(function()
    for _, zone in pairs(Config.Marker) do
        CreateNPC(zone)
    end
end)  

-- Generate Job Giver NPC's
function CreateNPC(zone)
    if not DoesEntityExist(npc) then
    
        local model = GetHashKey( "S_M_M_TrainStationWorker_01" )
        local coord = GetEntityCoords(PlayerPedId())
        RequestModel( model )

        while not HasModelLoaded( model ) do
            Wait(500)
        end
                
        npc = CreatePed( model, zone.x, zone.y, zone.z, zone.h,  false, true)
        Citizen.InvokeNative(0x283978A15512B2FE , npc, true )
        SetEntityNoCollisionEntity(PlayerPedId(), npc, false)
        SetEntityCanBeDamaged(npc, false)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetModelAsNoLongerNeeded(model)
    end
end

-- Get District Hash
function GetDistrictHash()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local district_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 10)
    if district_hash then
        local district_name = Config.Districts[district_hash].name
        return district_name
    else
        return ""
    end
end

-- Get Current Town Name, Some Towns missing
function GetCurentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords ,1)
    if town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("roanoke") then
        return "Roanoke Ridge"
    elseif town_hash == GetHashKey("Annesburg") then
        return "Annesburg"
    elseif town_hash == GetHashKey("Armadillo") then
        return "Armadillo"
    elseif town_hash == GetHashKey("Blackwater") then
        return "Blackwater"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "BeechersHope"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "Braithwaite"
    elseif town_hash == GetHashKey("Butcher") then
        return "Butcher"
    elseif town_hash == GetHashKey("Caliga") then
        return "Caliga"
    elseif town_hash == GetHashKey("cornwall") then
        return "Cornwall"
    elseif town_hash == GetHashKey("Emerald") then
        return "Emerald"
    elseif town_hash == GetHashKey("lagras") then
        return "lagras"
    elseif town_hash == GetHashKey("Manzanita") then
        return "Manzanita"
    elseif town_hash == GetHashKey("Rhodes") then
        return "Rhodes"
    elseif town_hash == GetHashKey("Siska") then
        return "Siska"
    elseif town_hash == GetHashKey("StDenis") then
        return "Saint Denis"
    elseif town_hash == GetHashKey("Strawberry") then
        return "Strawberry"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "Tumbleweed"
    elseif town_hash == GetHashKey("valentine") then
        return "Valentine"
    elseif town_hash == GetHashKey("VANHORN") then
        return "Vanhorn"
    elseif town_hash == GetHashKey("Wallace") then
        return "Wallace"
    elseif town_hash == GetHashKey("wapiti") then
        return "Wapiti"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "Aguasdulces Farm"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "Aguasdulces Ruins"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "Aguasdulces Villa"
    elseif town_hash == GetHashKey("Manicato") then
        return "Manicato"
    else
        return ""
    end
end

-- Successful Drop Off / Pay Fare

function successful_dropoff (fare, npc_id)
    while true do
        x_taxiSv.pay(fare)
        local fare_paid = true
        RemoveBlip(p1)
        ClearGpsMultiRoute()
        passenger_spawned = false
        x_taxiSv.startCoachJob(zone_name, spawn_coach, passenger_spawned)
        Wait(30000)
        DeleteEntity(npc_id)
        
        if fare_paid == true then
            break
        end
    end
end

-- Unuccessful Drop Off / No Fare Payment

function unsuccessful_dropoff (fare, npc_id)
    while true do
        local fare_paid = true
        RemoveBlip(p1)
        ClearGpsMultiRoute()
        passenger_spawned = false
        x_taxiSv.startCoachJob(zone_name, spawn_coach, passenger_spawned)
        Wait(30000)
        DeleteEntity(npc_id)
        
        if fare_paid == true then
            break
        end
    end
end

function PassengerOnboard (zone_name, route, spawn_coach, repair_active)
    RemoveBlip(p1)
    ClearGpsMultiRoute()
    StartGpsMultiRoute(GetHashKey("COLOR_YELLOW"), true, true)
    AddPointToGpsMultiRoute(Config.PickUp[zone_name][route].x + 5, Config.PickUp[zone_name][route].y + 5, Config.PickUp[zone_name][route].z)
    AddPointToGpsMultiRoute(Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y, Config.Destination[zone_name][route].z)
    SetGpsMultiRouteRender(true)

    p1 = N_0x554d9d53f696d002(1664425300, Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y, Config.Destination[zone_name][route].z)
    SetBlipSprite(p1, Config.Destination[zone_name][route].sprite, 5)
    SetBlipScale(p1, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, p1, Config.Destination[zone_name][route].name)
    passenger_onboard = true
    
    while true do
        Wait(10)   
        local coach_health = GetVehicleBodyHealth(spawn_coach);
        local coach_drivable = IsVehicleDriveable(spawn_coach);
        current = GetEntityCoords(passenger)
        distance = GetDistanceBetweenCoords(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z, current, false)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local disctrict_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords ,10)
        town_name = GetCurentTownName()
        district_hash = GetDistrictHash()
        fare_amount = 50
        if GetDistanceBetweenCoords(Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y, Config.Destination[zone_name][route].z, GetEntityCoords(passenger),false)<5 and passenger_onboard ~= false then 
            Wait(100)
            local spawn_coach = GetVehiclePedIsIn(PlayerPedId(),false)
            TaskLeaveVehicle(passenger, spawn_coach, 0)
            TaskGoToCoordAnyMeans(passenger, Config.Destination[zone_name][route].x, Config.Destination[zone_name][route].y +40, Config.Destination[zone_name][route].z, 1.0, 0, 0, 786603, 0xbf800000)
            npc_id = GetPedIndexFromEntityIndex(passenger)
            successful_dropoff(fare_amount, npc_id)
            passenger_onboard = false
        end       
        if IsEntityDead(passenger) then
            unsuccessful_dropoff(0, npc_id)
            passenger_onboard = false
        end
        if passenger_onboard == false then
            break
        end
    end
end
local cancel = false
RegisterNetEvent("coachJob")
AddEventHandler("coachJob", function(zone_name, spawn_coach)
    driving = true
    zone_name = GetDistrictHash()
    local passenger_despawned = true
    route = math.random(2)
    player_loc = GetEntityCoords(PlayerPedId())
    passenger_onboard = false
    StartGpsMultiRoute(GetHashKey("COLOR_YELLOW"), true, true)
    AddPointToGpsMultiRoute(player_loc)
    AddPointToGpsMultiRoute(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z)
    SetGpsMultiRouteRender(true)
    p1 = N_0x554d9d53f696d002(1664425300, Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z)
    SetBlipSprite(p1, Config.PickUp[zone_name][route].sprite, 1)
    SetBlipScale(p1, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, p1, Config.PickUp[zone_name][route].name)
    while passenger_despawned do
        Wait(10)
        if cancel then break end;
        if GetDistanceBetweenCoords(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z,GetEntityCoords(PlayerPedId()),false)<500 and passenger_despawned == true then
            local model = GetHashKey(Config.PickUp[zone_name][route].model)

            RequestModel( model ) 
                while not HasModelLoaded( model ) do
                    Wait(500)
                end
        if not DoesEntityExist(passenger) then
            passenger = CreatePed(model, Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z, Config.PickUp[zone_name][route].h, true, true)
                    Citizen.InvokeNative(0x283978A15512B2FE , passenger, true )
                    passenger_despawned = false
                    Wait(10)
                end   
            end
            if passenger_despawned == false then
                break
        end
    end

    
    
    while not passenger_onboard do
        Wait(10)
        if cancel then break end
        if GetDistanceBetweenCoords(Config.PickUp[zone_name][route].x, Config.PickUp[zone_name][route].y, Config.PickUp[zone_name][route].z, GetEntityCoords(PlayerPedId()),false)<10 then
            spawn_coach = GetVehiclePedIsIn(PlayerPedId(),false)
            SetEntityAsMissionEntity(spawn_coach, false, false)
            SetEntityAsMissionEntity(passenger, false, false)
            npc_group = GetPedRelationshipGroupHash(passenger)
            SetRelationshipBetweenGroups(1 , GetHashKey("PLAYER") , npc_group)
            Wait(500)       
            TaskEnterVehicle(passenger, spawn_coach, -1, 1, 1.0, 1, 0)
            passenger_onboard = true
            RemoveBlip(p1)
            PassengerOnboard(zone_name, route, spawn_coach)
        end

        if passenger_onboard == true then
            break
        end
    end
end)     

-- Destroy Cams
function EndStageCoachCam()
    ClearFocus()

    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam_a, false)
    DestroyCam(cam_b, false)

    cam_a = nil
    cam_b = nil

end

local StageCoachPrompt
local active = false
local group 
local inRotas = false
local name, oped, dist
-- Main Stage Coach Menu Prompt Location Trigger
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if emServico then
            if IsControlJustPressed(0, 0x3C0A40F2) then 
                DeletePed(passenger)
                DeletePed(npc)
                DeleteEntity(npc_id)
                RemoveBlip(p1)
                RemoveBlip(coachblip)
                ClearGpsMultiRoute()
                cancel = true 
            end
        end
    end
end)
Citizen.CreateThread(function()
    while true do
    local W = 500 
        for _, zone in pairs(Config.Marker) do
            if GetDistanceBetweenCoords(zone.rotas.x, zone.rotas.y, zone.rotas.z,GetEntityCoords(PlayerPedId()),false) < 2 then
                W = 1
                if emServico then 
                    if not inRotas then
                        DrawText3D(zone.rotas.x, zone.rotas.y, zone.rotas.z, "Pressione ~e~[R]~p~ para iniciar as rotas")
                    else  
                        DrawText3D(zone.rotas.x, zone.rotas.y, zone.rotas.z, "Pressione ~e~[R]~p~ para CANCELAR as rotas")
                    end
                end
                if IsControlJustPressed(0, 0xE30CD707) and emServico then
                    inRotas = not inRotas
                    if inRotas then 
                        TriggerEvent("xFramework:Notify", "sucesso", "Você começou as rotas. Pode cancelar a qualquer momento pressionando F6.")
                        x_taxiSv.startCoachJob(zone, ped)
                    else
                        TriggerEvent("xFramework:Notify", "sucesso", "Você CANCELOU as rotas ")
                        DeletePed(passenger)
                        DeletePed(npc)
                        DeleteEntity(npc_id)
                        RemoveBlip(p1)
                        RemoveBlip(coachblip)
                        ClearGpsMultiRoute()
                        cancel = true 
                    end
                end
            elseif GetDistanceBetweenCoords(zone.x, zone.y, zone.z,GetEntityCoords(PlayerPedId()),false) < 2 then
                W = 1 
                if not emServico then
                    cancel = false
                    DrawText3D(zone.x, zone.y, zone.z, "Pressione ~e~[R]~p~ para trabalhar aqui\n esteja com sua carroça própia!")
                else
                    DrawText3D(zone.x, zone.y, zone.z, "Pressione ~e~[R]~p~ para parar de trabalhar")
                end
                if IsControlJustPressed(0, 0xE30CD707) then
                    name, oped, dist = x_cavalos.SpawnedCoach()
                    if oped and string.lower(oped) ~= "wagon06x" then  TriggerEvent("xFramework:Notify", "sucesso", "Sua carroça não pode fazer este trabalho") goto continue end
                    
                    if emServico then 
                        emServico = false 
                        TriggerEvent("xFramework:Notify", "sucesso", "Você saiu de serviço")
                        if passenger then 
                            DeletePed(passenger)
                            DeletePed(npc)
                            DeleteEntity(npc_id)
                            RemoveBlip(p1)
                            RemoveBlip(coachblip)
                            ClearGpsMultiRoute()
                            cancel = true 
                        end
                        goto continue
                    end
                    if name then 
                        if dist < 25 then
                            emServico = true  
                            TriggerEvent("xFramework:Notify", "sucesso", "Você entrou em serviço com "..name)
                        else
                            TriggerEvent("xFramework:Notify", "negado", "Você tem uma carroça de fora, porém ela está muito longe de você [>vdist(10)]")
                        end
                    else
                        TriggerEvent("xFramework:Notify", "negado", "Você não tem uma carroça do lado de fora.")
                    end
                end
                
            end
        end
        ::continue::
        Citizen.Wait(W)
    end
end)

-- Calculate Fare Amount
function CalculateFare(passenger_pickup_coords, player_onboard, invehicle, driver)
    Citizen.CreateThread( function()
        while true do
            Citizen.Wait(10)
            local invehicle = GetPlayersInVehicle()
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            
            if invehicle then
                current = GetEntityCoords(PlayerPedId())
                distance = GetDistanceBetweenCoords(passenger_pickup_coords.x, passenger_pickup_coords.y, passenger_pickup_coords.z, current, false)
                fare_amount = (distance / 1609.34) * 50
                fare_amount = string.format("%.0f", fare_amount)
                fare_amount = tonumber(fare_amount)
                Wait(100)
                TriggerServerEvent("parks_stagecoach:pay_fare", fare_amount)
                break
            elseif invehicle == nil then
                Citizen.Wait(1000)
                TriggerServerEvent("parks_stagecoach:pay_fare", fare_amount)
                break
            end
        end
    end)
end

-- Check if players are in vehicle
function GetPlayersInVehicle()
    local players = GetActivePlayers()
    local ply = PlayerPedId()
    local returnablePlayers = {}
    local playerVehicle = GetVehiclePedIsIn(ply, false)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local vehicle = GetVehiclePedIsIn(target, false)
            if playerVehicle ~= 0 and playerVehicle == vehicle then
                table.insert(returnablePlayers, value)
            end
        end
    end
    
    return returnablePlayers[1] 

end
    
-- Check For Button Press Menu Open / Is a Player in Vehicle
Citizen.CreateThread(function(fare_amount)
    
    local active = false
    local player = PlayerPedId()
    local get_player_passenger_coords = false
    fare_amount = 0
    
    while true do
        Citizen.Wait(10)
        
        vehicle = GetVehiclePedIsIn(player)
        driver = GetPedInVehicleSeat(vehicle, -1)

        if vehicle and driver == player then
            
            local invehicle = GetPlayersInVehicle()

            if invehicle and get_player_passenger_coords == false then
                passenger_pickup_coords = GetEntityCoords(PlayerPedId())
                player_onboard = true
                CalculateFare(passenger_pickup_coords, player_onboard, invehicle, driver)
                get_player_passenger_coords = true
            
            elseif invehicle == nil then
                player_onboard = false              
                get_player_passenger_coords = false
            end
        end

        if IsControlJustReleased(0, keys['O']) then
            OpenDrivingStatusMenu()
        end

    end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		DeleteEntity(spawn_coach)
		DeletePed(passenger)
        DeletePed(npc)
        DeleteEntity(npc_id)
        RemoveBlip(p1)
        RemoveBlip(coachblip)
        ClearGpsMultiRoute()
	end
end)


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

RegisterNetEvent("xFramework:CallCallback::medico")
AddEventHandler("xFramework:CallCallback::medico", function(authorName, authorId, cha_id)
    print(NetworkGetPlayerIndexFromPed(PlayerPedId()), x_taxiSv.src(authorId))
    if x_taxiSv.src(authorId) == getSvFromPed(PlayerPedId()) then 
        if not x_taxiSv.any() then 
            TriggerEvent("xFramework:Notify", "sucesso", "Chamado enviado. Aguarde resposta.")
        else
            TriggerEvent("xFramework:Notify", "negado", "Não foi possível enviar o chamado. Já há um ativo: Tente novamente me alguns segundos")
            return
        end
    end 
    Wait(300)
    if emServico then 
        local cb_ac = false 
        print(authorName, authorId, cha_id)
        if not x_taxiSv.any() then 
            TriggerServerEvent("insert_call_3", cha_id)
            print(1)
            print(2)
            local source = x_taxiSv.src(authorId)
            local targPed = GetPlayerPed(GetPlayerFromServerId(source))
            local cds = GetEntityCoords(targPed)
            local msg = "Chofer Solicitado"
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
        args = {'CHOFER-ALERTA',"Novo chamado chofer de: ".. authorName.. "["..authorId.."]: "..msg}
    })
    local i = 0 
    TriggerEvent("xFramework:Notify", "aviso", "PageUP: Aceitar; PageDOWN: Recusar")
    while true do
        i=i+1
        if i >= 2800 then TriggerEvent("xFramework:Notify", "aviso", "Tempo expirado; pedido recusado.") break end
        if IsControlJustPressed(0, confirm_keys.accept) then 
            if not x_taxiSv.isAccepted(cha_id) then 
                x_taxiSv.manageCall(cha_id, true)
                x_taxiSv.notif(source, "sucesso", "Seu chamado foi aceito, aguarde a chegada.")
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

