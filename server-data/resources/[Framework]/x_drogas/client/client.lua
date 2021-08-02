
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_drogas")
x_drogas = Proxy.getInterface("x_drogas")
x_drogasSv = Tunnel.getInterface("x_drogas")
_Tunnel = {}
Tunnel.bindInterface("x_drogas", _Tunnel)
--------------------------------------------------------
--> Venda
--> Rota Maconha
local emServico_maconha = false
local sel_pos_maconha = 1
local pagar_maconha = {min = 100, max = 100}
local pos_vendas_maconha = {
    [1] = {2516.79, -1193.6, 53.79},
    [2] = {2670.88, -1273.8, 52.33},
    [3] = {2731.6, -1307.05, 48.05},
    [4] = {1369.55, -1310.45, 78.04},
    [5] = {-965.78, -1253.16, 54.07},
    [6] = {-235.14, 748.12, 117.85},
}
local can_item_maconha = {
    [1] = {"maconha", "maconha", 1, 3},
}
local iniciar_maconha = {-265.09, 769.86, 118.04}
local sel_max_maconha = #pos_vendas_maconha 
Citizen.CreateThread(function()
    local blip3 = N_0x554d9d53f696d002(1664425300,iniciar_maconha[1], iniciar_maconha[2], iniciar_maconha[3])
    SetBlipSprite(blip3,-1944395098, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip3, "Maconha - Rotas")
end)
Citizen.CreateThread(function()
    while true do 
        local W = 500
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), iniciar_maconha[1], iniciar_maconha[2], iniciar_maconha[3], true) < 3 then 
                W = 1
                if not emServico_maconha then 
                    DrawText3D2(iniciar_maconha[1], iniciar_maconha[2], iniciar_maconha[3]-1, "Pressione ~e~[r]~p~ para iniciar a rota. - Maconha")
                end
                if not emServico_maconha and IsControlJustPressed(0, 0xE30CD707) then 
                    TriggerEvent("xFramework:Notify","aviso","Rotas iniciadas. Pressione F6 para cancelar em qualquer momento.")
                    emServico_maconha = true
                    drawRota_maconha()
                end
            end
        Citizen.Wait(W)
    end
end)
local item_maconha, selected_item_internal_maconha, selected_item_label_maconha, qnt_maconha
function drawRota_maconha()
    StartGpsMultiRoute(GetHashKey("COLOR_YELLOW"), true, true)
    AddPointToGpsMultiRoute(pos_vendas_maconha[sel_pos_maconha][1],pos_vendas_maconha[sel_pos_maconha][2],pos_vendas_maconha[sel_pos_maconha][3])
    SetGpsMultiRouteRender(true)
    item_maconha = math.random(1, #can_item_maconha)
    selected_item_internal_maconha = can_item_maconha[item_maconha][1]
    selected_item_label_maconha = can_item_maconha[item_maconha][2]
    qnt_maconha = math.random(can_item_maconha[item_maconha][3], can_item_maconha[item_maconha][4])
    print("dados: item selecionado",item_maconha, "internal",selected_item_internal_maconha,"label",selected_item_label_maconha,"qnt",qnt_maconha)
end
Citizen.CreateThread(function()
    while true do 
       local W = 500
       if emServico_maconha then 
        W = 1
        if IsControlJustPressed(0, 0x3C0A40F2) then 
            ClearGpsMultiRoute()
            emServico_maconha = false 
            sel_pos_maconha = 1
        end
            DrawTxt('Entregue x'..qnt_maconha.. " "..selected_item_label_maconha.. "\n F6 = Cancelar rota.",0.50,0.90,0.5,0.5,true,255,255,255,255,true)
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos_vendas_maconha[sel_pos_maconha][1],pos_vendas_maconha[sel_pos_maconha][2],pos_vendas_maconha[sel_pos_maconha][3], true) < 20 then 
                W = 1
                DrawText3D2(pos_vendas_maconha[sel_pos_maconha][1],pos_vendas_maconha[sel_pos_maconha][2],pos_vendas_maconha[sel_pos_maconha][3], "~e~[r]~p~ Entregar")
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos_vendas_maconha[sel_pos_maconha][1],pos_vendas_maconha[sel_pos_maconha][2],pos_vendas_maconha[sel_pos_maconha][3], true) < 6 then 
                    W = 1
                    if IsControlJustPressed(0, 0xE30CD707)  then 
                        sel_pos_maconha = sel_pos_maconha + 1
                        if sel_pos_maconha > sel_max_maconha then 
                            ClearGpsMultiRoute()
                            emServico_maconha = false 
                            sel_pos_maconha = 1
                        else
                            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
                            drawRota_maconha()
                             x_drogasSv.remove(selected_item_internal_maconha, qnt_maconha, math.random(pagar_maconha.min, pagar_maconha.max),x, y, z)
                        end
                    end
                end
            end
       end
       Citizen.Wait(W)
    end
end)
--> Venda
--> Rota Cocaina 
local emServico_cocaina = false
local sel_pos_cocaina = 1
local pagar_cocaina = {min = 100, max = 100}
local pos_vendas_cocaina = {
    [1] = {2516.79, -1193.6, 53.79},
    [2] = {2670.88, -1273.8, 52.33},
    [3] = {2731.6, -1307.05, 48.05},
    [4] = {1369.55, -1310.45, 78.04},
    [5] = {-965.78, -1253.16, 54.07},
    [6] = {-235.14, 748.12, 117.85},
}
local can_item_cocaina = {
    [1] = {"cocaina", "cocaina", 1, 3},
}
local iniciar_cocaina = {-266.07, 773.86, 118.27}
local sel_max_cocaina = #pos_vendas_cocaina 
Citizen.CreateThread(function()
    local blip3 = N_0x554d9d53f696d002(1664425300,iniciar_cocaina[1], iniciar_cocaina[2], iniciar_cocaina[3])
    SetBlipSprite(blip3,-1944395098, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip3, "Cocaina - Rotas")
end)
Citizen.CreateThread(function()
    while true do 
        local W = 500
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), iniciar_cocaina[1], iniciar_cocaina[2], iniciar_cocaina[3], true) < 3 then 
                W = 1
                if not emServico_cocaina then 
                    DrawText3D2(iniciar_cocaina[1], iniciar_cocaina[2], iniciar_cocaina[3]-1, "Pressione ~e~[r]~p~ para iniciar a rota - Cocaina.")
                end
                if not emServico_cocaina and IsControlJustPressed(0, 0xE30CD707) then 
                    TriggerEvent("xFramework:Notify","aviso","Rotas iniciadas. Pressione F6 para cancelar em qualquer momento.")
                    emServico_cocaina = true
                    drawRota_cocaina()
                end
            end
        Citizen.Wait(W)
    end
end)
local item_cocaina, selected_item_internal_cocaina, selected_item_label_cocaina, qnt_cocaina
function drawRota_cocaina()
    StartGpsMultiRoute(GetHashKey("COLOR_YELLOW"), true, true)
    AddPointToGpsMultiRoute(pos_vendas_cocaina[sel_pos_cocaina][1],pos_vendas_cocaina[sel_pos_cocaina][2],pos_vendas_cocaina[sel_pos_cocaina][3])
    SetGpsMultiRouteRender(true)
    item_cocaina = math.random(1, #can_item_cocaina)
    selected_item_internal_cocaina = can_item_cocaina[item_cocaina][1]
    selected_item_label_cocaina = can_item_cocaina[item_cocaina][2]
    qnt_cocaina = math.random(can_item_cocaina[item_cocaina][3], can_item_cocaina[item_cocaina][4])
    print("dados: item selecionado",item_cocaina, "internal",selected_item_internal_cocaina,"label",selected_item_label_cocaina,"qnt",qnt_cocaina)
end
Citizen.CreateThread(function()
    while true do 
       local W = 500
       if emServico_cocaina then 
        W = 1
        if IsControlJustPressed(0, 0x3C0A40F2) then 
            ClearGpsMultiRoute()
            emServico_cocaina = false 
            sel_pos_cocaina = 1
        end
            DrawTxt('Entregue x'..qnt_cocaina.. " "..selected_item_label_cocaina.. "\n F6 = Cancelar rota.",0.50,0.90,0.5,0.5,true,255,255,255,255,true)
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos_vendas_cocaina[sel_pos_cocaina][1],pos_vendas_cocaina[sel_pos_cocaina][2],pos_vendas_cocaina[sel_pos_cocaina][3], true) < 20 then 
                W = 1
                DrawText3D2(pos_vendas_cocaina[sel_pos_cocaina][1],pos_vendas_cocaina[sel_pos_cocaina][2],pos_vendas_cocaina[sel_pos_cocaina][3], "~e~[r]~p~ Entregar")
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos_vendas_cocaina[sel_pos_cocaina][1],pos_vendas_cocaina[sel_pos_cocaina][2],pos_vendas_cocaina[sel_pos_cocaina][3], true) < 6 then 
                    W = 1
                    if IsControlJustPressed(0, 0xE30CD707)  then 
                        sel_pos_cocaina = sel_pos_cocaina + 1
                        if sel_pos_cocaina > sel_max_cocaina then 
                            ClearGpsMultiRoute()
                            emServico_cocaina = false 
                            sel_pos_cocaina = 1
                        else
                            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
                            drawRota_cocaina()
                             x_drogasSv.remove(selected_item_internal_cocaina, qnt_cocaina, math.random(pagar_cocaina.min, pagar_cocaina.max), x, y, z)
                        end
                    end
                end
            end
       end
       Citizen.Wait(W)
    end
end)


local myPlants, nearField = {}, nil
local prompt, prompt2 = false, false
local DelPrompt
local PlantPrompt

function SetupDelPrompt()
    Citizen.CreateThread(function()
        local str = 'Remover Planta'
        DelPrompt = PromptRegisterBegin()
        PromptSetControlAction(DelPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(DelPrompt, str)
        PromptSetEnabled(DelPrompt, false)
        PromptSetVisible(DelPrompt, false)
        PromptSetHoldMode(DelPrompt, true)
        PromptRegisterEnd(DelPrompt)

    end)
end

function SetupPlantPrompt()
    Citizen.CreateThread(function()
        local str = 'Plantar'
        PlantPrompt = PromptRegisterBegin()
        PromptSetControlAction(PlantPrompt, 0x07CE1E61)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PlantPrompt, str)
        PromptSetEnabled(PlantPrompt, false)
        PromptSetVisible(PlantPrompt, false)
        PromptSetHoldMode(PlantPrompt, true)
        PromptRegisterEnd(PlantPrompt)

    end)
end

RegisterNetEvent('x_drogas:planto1')
AddEventHandler('x_drogas:planto1', function(hash1, hash2, hash3, item)
    local myPed = PlayerPedId()
    local pHead = GetEntityHeading(myPed)
    local pos = GetEntityCoords(PlayerPedId(), true)
    local plant1 = GetHashKey(hash1)

    if not HasModelLoaded(plant1) then
        RequestModel(plant1)
    end

    while not HasModelLoaded(plant1) do
        Citizen.Wait(1)
    end

    local placing = true
    local tempObj = CreateObject(plant1, pos.x, pos.y, pos.z, true, true, false)
    SetEntityHeading(tempObj, pHead)
    SetEntityAlpha(tempObj, 51)
    AttachEntityToEntity(tempObj, myPed, 0, 0.0, 1.0, -0.7, 0.0, 0.0, 0.0, true, false, false, false, false)
    while placing do
        Wait(10)
        if prompt == false then
            PromptSetEnabled(PlantPrompt, true)
            PromptSetVisible(PlantPrompt, true)
            prompt = true
        end
        if PromptHasHoldModeCompleted(PlantPrompt) then
            PromptSetEnabled(PlantPrompt, false)
            PromptSetVisible(PlantPrompt, false)
            PromptSetEnabled(DelPrompt, false)
            PromptSetVisible(DelPrompt, false)
            prompt = false
            prompt2 = false
            local pPos = GetEntityCoords(tempObj, true)
            DeleteObject(tempObj)
            animacion()
            local object = CreateObject(plant1, pPos.x, pPos.y, pPos.z, true, true, false)
            myPlants[#myPlants+1] = {["object"] = object, ['x'] = pPos.x, ['y'] = pPos.y, ['z'] = pPos.z, ['stage'] = 1, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3,}
            local plantCount = #myPlants
            PlaceObjectOnGroundProperly(myPlants[plantCount].object)
            SetEntityAsMissionEntity(myPlants[plantCount].object, true)
            break
        end
        if prompt2 == false then
            PromptSetEnabled(DelPrompt, true)
            PromptSetVisible(DelPrompt, true)
            prompt2 = true
        end
        if PromptHasHoldModeCompleted(DelPrompt) then
            PromptSetEnabled(PlantPrompt, false)
            PromptSetVisible(PlantPrompt, false)
            PromptSetEnabled(DelPrompt, false)
            PromptSetVisible(DelPrompt, false)
            prompt = false
            prompt2 = false
            DeleteObject(tempObj)
            break
        end
	end
end)


RegisterNetEvent('x_drogas:regar1')
AddEventHandler('x_drogas:regar1', function(source)
    local pos = GetEntityCoords(PlayerPedId(), true)
    --local plant2 = GetHashKey("CRP_TOBACCOPLANT_AB_SIM")
    local object = nil
    local key = nil
    local hash1, hash2, hash3 = nil, nil, nil
    local planta = GetEntityCoords(object, true)
    local x, y, z = nil, nil, nil
    
    for k, v in ipairs(myPlants) do
        if v.stage == 1 then
            if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 2.0 then
                object = v.object
                key = k
                x, y, z = v.x, v.y, v.z
                hash1, hash2, hash3 = v.hash, v.hash2, v.hash3
                break
            end
        end
    end
    
    local plant2 = hash2
    
    if DoesEntityExist(object) then
        animacion2()

        RequestModel(plant2)

        while not HasModelLoaded(plant2) do
            Citizen.Wait(1)
        end

        DeleteObject(object)
        table.remove(myPlants, key)
        Wait(800)
        local object = CreateObject(plant2, x, y, z, true, true, false)
        myPlants[#myPlants+1] = {["object"] = object, ['x'] = x, ['y'] = y, ['z'] = z, ['stage'] = 2, ['timer'] = 150, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3}
        local plantCount = #myPlants
        PlaceObjectOnGroundProperly(myPlants[plantCount].object)
        SetEntityAsMissionEntity(myPlants[plantCount].object, true)
    end
end)

RegisterNetEvent('x_drogas:fin2')
AddEventHandler('x_drogas:fin2', function(object2, x, y, z, key, hash1, hash2, hash3)
    --local plant3 = GetHashKey("CRP_TOBACCOPLANT_AC_SIM")
    local planta2 = GetEntityCoords(object2, true)
    
    TriggerEvent("redemrp_notification:start", 'Your plant has matured!', 5)
    
    local plant3 = hash3
    
    RequestModel(plant3)

    while not HasModelLoaded(plant3) do
        Citizen.Wait(1)
    end
    
    DeleteObject(object2)
    table.remove(myPlants, key)
    Wait(800)
    local object3 = CreateObject(plant3, x, y, z, true, true, false)
    PlaceObjectOnGroundProperly(object3)
    myPlants[#myPlants+1] = {["object"] = object3, ['x'] = x, ['y'] = y, ['z'] = z, ['stage'] = 3, ['prompt'] = false, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3,}
    local plantCount = #myPlants
    PlaceObjectOnGroundProperly(myPlants[plantCount].object)
    SetEntityAsMissionEntity(myPlants[plantCount].object, true)
end)

function harvestPlant(key)
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
    exports['x_progress']:startUI(10000, 'Coletando...')
    Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
	DeleteObject(myPlants[key].object)
	table.remove(myPlants, key)
end

Citizen.CreateThread(function()
    SetupPlantPrompt()
    SetupDelPrompt()
    while true do
        Wait(1000)
        local pos = GetEntityCoords(PlayerPedId(), true)
            nearField = true
        if myPlants[1] ~= nil then
            for k, v in ipairs(myPlants) do
                if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 30 then
                    if v.stage == 2 then
                        v.timer = v.timer-1
                        if v.timer == 0 then
                            v.stage = 3
                            local key = k
                            TriggerEvent('x_drogas:fin2', v.object, v.x, v.y, v.z, key, v.hash, v.hash2, v.hash3)
                        end
                    end    
                    if v.stage == 3 and GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) <= 2 then
                        if not v.prompt then
                            v.prompt = true
                        end
                    end
                        
                    if v.stage == 3 and GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) > 3 then
                        if v.prompt then
                            v.prompt = false
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if myPlants[1] ~= nil and nearField then
			local pos = GetEntityCoords(PlayerPedId(), true)
			for k, v in ipairs(myPlants) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 7.0 then
					if v.stage == 1 then
						DrawText3D(v.x, v.y, v.z, 'Precisa de Água')
					end
					if v.stage == 2 then
						DrawText3D(v.x, v.y, v.z, 'Crescendo: ' .. v.timer)
					end
					if v.stage == 3 then
						DrawText3D(v.x, v.y, v.z, 'Pronta para colher! [E]')
					end
					if v.prompt then
						if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0xCEFD9220) then
							local key = k
							harvestPlant(key)
							TriggerServerEvent("x_drogas:giveitem", v.hash3)
						end
					end
				end
			end
		end
	end
end)
		
function animacion()
	PromptSetEnabled(prompt, true)
	PromptSetVisible(prompt, true)
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_FARMER_RAKE'), 10000, true, false, false, false)
    exports['x_progress']:startUI(10000, 'Arando terreno...')
    Wait(10000)
    ClearPedTasksImmediately(PlayerPedId())
	Wait(1000)
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 20000, true, false, false, false)
    exports['x_progress']:startUI(20000, 'Plantando...')
    Wait(20000)
    ClearPedTasksImmediately(PlayerPedId())
	PromptSetEnabled(prompt, false)
	PromptSetVisible(prompt, false)
end

function animacion2()
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_BUCKET_POUR_LOW'), 7000, true, false, false, false)
    exports['x_progress']:startUI(7000, 'Regando a planta...')
    Wait(7000)
    ClearPedTasksImmediately(PlayerPedId())
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)

    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
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

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 52, 52, 52, 190, 0)
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 52, 52, 52, 190, 0)
end
   
function DrawText3D2(x, y, z, text)
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


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in ipairs(myPlants) do
			DeleteObject(v.object)
			table.remove(myPlants, k)
		end
	end
end)
