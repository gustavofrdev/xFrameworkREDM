local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_vinho")
x_vinho = Proxy.getInterface("x_vinho")
x_vinhoSv = Tunnel.getInterface("x_vinho")
_Tunnel = {}
Tunnel.bindInterface("x_vinho", _Tunnel)

local money = 70
local xp = math.random(Config.xp['min'], Config.xp['max'])
local StartJob = false
local moonshine1 = false
local moonshine2 = false
local moonshine3 = false
local moonshine4 = false
local moonshine5 = false
local moonshine6 = false
local moonshine7 = false

Citizen.CreateThread(function() 
    local blip = N_0x554d9d53f696d002(1664425300, Config.Zonas['init'].x, Config.Zonas['init'].y, Config.Zonas['init'].z)
    SetBlipSprite(blip, 1961764827, 1)   
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Emprego: Vinho')
end)

RegisterNetEvent('vinho:start')
AddEventHandler('vinho:start', function(source)
    blip = N_0x554d9d53f696d002(203020899, Config.Zonas['moonshine1'].x, Config.Zonas['moonshine1'].y, Config.Zonas['moonshine1'].z)
    SetBlipSprite(blip, -570710357, 1)
    StartJob = true
    moonshine1 = true
end)

Citizen.CreateThread(function()
    while true do
        W = 500
        local pos = GetEntityCoords(PlayerPedId())
        if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['init'].x, Config.Zonas['init'].y, Config.Zonas['init'].z) < 3.0) then
            W = 1
            if moonshine1 == false then
                DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    local checkPos =GetClosestVehicle(Config.Zonas['initveh'].x, Config.Zonas['initveh'].y, Config.Zonas['initveh'].z,3.001,0,71)
                    if not DoesEntityExist(checkPos) then 
                        local player = PlayerPedId()
                        local vehicle = GetHashKey(Config.Vehicle1)
                        RequestModel(vehicle)
                        while not HasModelLoaded(vehicle) do
                            Citizen.Wait(0)
                        end
                        spawncar = CreateVehicle(vehicle, Config.Zonas['initveh'].x, Config.Zonas['initveh'].y, Config.Zonas['initveh'].z, Config.Zonas['initveh'].heading, true, false)
                        SetVehicleOnGroundProperly(spawncar)
                        SetModelAsNoLongerNeeded(vehicle)
                        blip = N_0x554d9d53f696d002(203020899, Config.Zonas['moonshine1'].x, Config.Zonas['moonshine1'].y, Config.Zonas['moonshine1'].z)
                        SetBlipSprite(blip, -570710357, 1)
                        StartJob = true
                        moonshine1 = true
                    else
                        TriggerEvent("xFramework:Notify", "aviso", "Já tem um veículo no local, aguarde um pouco", 5)
                        goto c
                    end
                    TriggerServerEvent('vinho:comjob')
                end
            end
        end
		-- start moonshine job / collect cracked corn / blip1
        if StartJob then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['moonshine1'].x, Config.Zonas['moonshine1'].y, Config.Zonas['moonshine1'].z) < 3.0) then
                W = 1
                DrawTxt(Language.translate[Config.lang]['press1'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    DeleteVehicle(spawncar)
                    local dict  = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
                    local anim = "inspectfloor_player"
                    RequestAnimDict(dict)
                    while not HasAnimDictLoaded(dict) do Wait(0) print("loading: try <TRY>>") end
                    TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 1.0, 20000, 0, 0, true, 0, false, 0, false)
                    Wait(10000)
                    ClearPedTasks(PlayerPedId())
                    TriggerEvent("xFramework:Notify", "aviso", Language.translate[Config.lang]['goto'], 5)
					RemoveBlip(blip)
					blip2 = N_0x554d9d53f696d002(203020899, Config.Zonas['moonshine2'].x, Config.Zonas['moonshine2'].y, Config.Zonas['moonshine2'].z)
                    SetBlipSprite(blip2, -570710357, 1)
					StartJob = false
					moonshine2 = true
					TriggerEvent('vinho:corn_shipment')
                end
            end
		-- load cracked corn into wagon / blip2
		elseif moonshine2  then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['moonshine2'].x, Config.Zonas['moonshine2'].y, Config.Zonas['moonshine2'].z) < 3.0) then
                W = 1
                DrawTxt(Language.translate[Config.lang]['press2'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    local dict  = "script_story@utp1@ig@ig_23_grab_hook"
                     local anim = "placehook_front_player"
                    print("trigger<sucess>")
                    RequestAnimDict(dict)
                    while not HasAnimDictLoaded(dict) do Wait(0) print("loading: try <TRY>>") end
                     TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
                     Wait(10000)
                    ClearPedTasks(PlayerPedId())
                    TriggerEvent("xFramework:Notify", "aviso", Language.translate[Config.lang]['carry'], 5)
                    RemoveBlip(blip2)
                    blip3 = N_0x554d9d53f696d002(203020899, Config.Zonas['moonshine3'].x, Config.Zonas['moonshine3'].y, Config.Zonas['moonshine3'].z)
                    SetBlipSprite(blip3, -570710357, 1)
                    moonshine2 = false
                    moonshine3 = true
                end
			end
		
		-- deliver cracked corn to the moonshine / blip3
		elseif moonshine3  then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['moonshine3'].x, Config.Zonas['moonshine3'].y, Config.Zonas['moonshine3'].z) < 3.0) then
                W = 1
                DrawTxt(Language.translate[Config.lang]['pressc'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    if IsPedInAnyVehicle(PlayerPedId(), true) then
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                        TriggerEvent("xFramework:Notify", "aviso", Language.translate[Config.lang]['corn_delivered'], 5)
						RemoveBlip(blip3)
						blip4 = N_0x554d9d53f696d002(203020899, Config.Zonas['moonshine4'].x, Config.Zonas['moonshine4'].y, Config.Zonas['moonshine4'].z)
						SetBlipSprite(blip4, -570710357, 1)
						moonshine3 = false
						moonshine4 = true
                    else
                        TriggerEvent("xFramework:Notify", "aviso", Language.translate[Config.lang]['noveh_corn'], 5)
                    end
                end
			end
		
		-- boil your cracked corn into mash / blip4
		elseif moonshine4  then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['moonshine4'].x, Config.Zonas['moonshine4'].y, Config.Zonas['moonshine4'].z) < 3.0) then
                W = 1
                DrawTxt(Language.translate[Config.lang]['press3'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
					DeleteVehicle(spawncar)
                    local dict  = "script_story@utp1@ig@ig_23_grab_hook"
                    local anim = "placehook_front_player"
                   print("trigger<sucess>")
                   RequestAnimDict(dict)
                   while not HasAnimDictLoaded(dict) do Wait(0) print("loading: try <TRY>>") end
                    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
                    Wait(10000)
                   ClearPedTasks(PlayerPedId())
                    TriggerEvent("xFramework:Notify", "aviso", Language.translate[Config.lang]['goto'], 5)
                    RemoveBlip(blip4)
                    blip5 = N_0x554d9d53f696d002(203020899, Config.Zonas['moonshine5'].x, Config.Zonas['moonshine5'].y, Config.Zonas['moonshine5'].z)
                    SetBlipSprite(blip5, -570710357, 1)
                    moonshine4 = false
                    moonshine5 = true
                end
            end
		-- bottling your moonshine ready to ship / blip5
		elseif moonshine5  then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['moonshine5'].x, Config.Zonas['moonshine5'].y, Config.Zonas['moonshine5'].z) < 3.0) then
                W = 1 
                DrawTxt(Language.translate[Config.lang]['press4'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
					DeleteVehicle(spawncar)
                    local dict  = "script_re@on_the_run@finddeadbeat_confront_kill"
                    local anim = "keep_mess_father"
                   print("trigger<sucess>")
                   RequestAnimDict(dict)
                   while not HasAnimDictLoaded(dict) do Wait(0) print("loading: try <TRY>>") end
                    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
                    Wait(3000)
                    ClearPedTasks(PlayerPedId())
                    TriggerEvent("xFramework:Notify", "aviso", Language.translate[Config.lang]['goto'], 5)
                    RemoveBlip(blip5)
                    blip6 = N_0x554d9d53f696d002(203020899, Config.Zonas['moonshine6'].x, Config.Zonas['moonshine6'].y, Config.Zonas['moonshine6'].z)
                    SetBlipSprite(blip6, -570710357, 1)
                    moonshine5 = false
                    moonshine6 = true
					TriggerEvent('vinho:moonshine_shipment')
                end
            end
		-- load moonshine into wagon / blip6
		elseif moonshine6  then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['moonshine6'].x, Config.Zonas['moonshine6'].y, Config.Zonas['moonshine6'].z) < 3.0) then
                W = 1 
                DrawTxt(Language.translate[Config.lang]['press5'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    local dict  = "script_story@utp1@ig@ig_23_grab_hook"
                     local anim = "placehook_front_player"
                    print("trigger<sucess>")
                    RequestAnimDict(dict)
                    while not HasAnimDictLoaded(dict) do Wait(0) print("loading: try <TRY>>") end
                     TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
                     Wait(10000)
                    ClearPedTasks(PlayerPedId())
                    TriggerEvent("xFramework:Notify", "aviso", Language.translate[Config.lang]['carry1'], 5)
                    RemoveBlip(blip6)
                    blip7 = N_0x554d9d53f696d002(203020899, Config.Zonas['moonshine7'].x, Config.Zonas['moonshine7'].y, Config.Zonas['moonshine7'].z)
                    SetBlipSprite(blip7, -570710357, 1)
                    moonshine6 = false
                    moonshine7 = true
                end
			end
		-- deliver the moonshine and get your reward money / xp / blip7
		elseif moonshine7  then
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['moonshine7'].x, Config.Zonas['moonshine7'].y, Config.Zonas['moonshine7'].z) < 3.0) then
                W = 1 
                DrawTxt(Language.translate[Config.lang]['pressf'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    if IsPedInAnyVehicle(PlayerPedId(), true) then
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                        -- TriggerEvent("xFramework:Notify", "aviso", Language.translate[Config.lang]['completejob'] ..money.."$", 5)
						RemoveBlip(blip7)
						TriggerServerEvent('vinho:reward', money)
                        StartJob = false
                        moonshine1 = false
						moonshine7 = false
                    else
                        TriggerEvent("xFramework:Notify", "aviso", Language.translate[Config.lang]['noveh'], 5)
                    end
                end
			end
        end
        ::c::
        Citizen.Wait(W)
    end
end)

RegisterNetEvent('vinho:corn_shipment')
AddEventHandler('vinho:corn_shipment', function()
	Citizen.Wait(0)
    local checkPos =GetClosestVehicle(Config.Zonas['moonshine2'].x, Config.Zonas['moonshine2'].y, Config.Zonas['moonshine2'].z,3.001,0,71)
    if not DoesEntityExist(checkPos) then 
	    local player = PlayerPedId()
	    local vehicle = GetHashKey(Config.Vehicle1)
	    RequestModel(vehicle)

	    while not HasModelLoaded(vehicle) do
	    	Citizen.Wait(0)
	    end

	    spawncar = CreateVehicle(vehicle, Config.Zonas['moonshine2'].x, Config.Zonas['moonshine2'].y, Config.Zonas['moonshine2'].z, Config.Zonas['moonshine2'].heading, true, false)
	    SetVehicleOnGroundProperly(spawncar)
	    SetModelAsNoLongerNeeded(vehicle)
    else
        TriggerEvent("xFramework:Notify", "aviso", "Já tem um veículo no local, aguarde um pouco", 5)
    end
end)

RegisterNetEvent('vinho:moonshine_shipment')
AddEventHandler('vinho:moonshine_shipment', function()
	Citizen.Wait(0)
        local checkPos =
        GetClosestVehicle(
        Config.Zonas['moonshine2'].x, 
        Config.Zonas['moonshine2'].y, 
        Config.Zonas['moonshine2'].z,
        3.001,
        0,
        71
        ) 
        if not DoesEntityExist(checkPos) then 
	    local player = PlayerPedId()
	    local vehicle = GetHashKey(Config.Vehicle1)
	    RequestModel(vehicle)

	    while not HasModelLoaded(vehicle) do
	    	Citizen.Wait(0)
	    end

	    spawncar = CreateVehicle(vehicle, Config.Zonas['moonshine6'].x, Config.Zonas['moonshine6'].y, Config.Zonas['moonshine6'].z, Config.Zonas['moonshine6'].heading, true, false)
	    SetVehicleOnGroundProperly(spawncar)
	    SetModelAsNoLongerNeeded(vehicle)
    else
        TriggerEvent("xFramework:Notify", "aviso", "Já tem um veículo no local, aguarde um pouco", 5)
    end
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)

    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end