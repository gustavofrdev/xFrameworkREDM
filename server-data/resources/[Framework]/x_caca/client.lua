
local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')

x_cacaSV = Tunnel.getInterface('x_caca')
x_cacaCL = Proxy.getInterface('x_caca')
FrameworkSV = Tunnel.getInterface('_xFramework')
FrameworkCL = Proxy.getInterface('_xFramework')

Function = {}
Proxy.addInterface('x_caca', Function)
Tunnel.bindInterface('x_caca', Function)


local ButcherPrompt
local hasAlreadyEnteredMarker
local currentZone = nil

local PromptGorup = GetRandomIntInRange(0, 0xffffff)

function SetupButcherPrompt()
    Citizen.CreateThread(function()
        local str = 'Vender'
        ButcherPrompt = PromptRegisterBegin()
        PromptSetControlAction(ButcherPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ButcherPrompt, str)
        PromptSetEnabled(ButcherPrompt, true)
        PromptSetVisible(ButcherPrompt, true)
        PromptSetHoldMode(ButcherPrompt, true)
        PromptSetGroup(ButcherPrompt, PromptGorup)
        PromptRegisterEnd(ButcherPrompt)
    end)
end

local blip = {}

if Config.Blips == true then
    Citizen.CreateThread(function()
        for _, info in pairs(Config.shops) do
            local number = #blip + 1
            blip[number] = N_0x554d9d53f696d002(1664425300, info.coords.x, info.coords.y, info.coords.z)
            SetBlipSprite(blip[number], -1665418949, 1)
            SetBlipScale(blip[number], 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip[number], 'Caçador')
        end  
    end)
end

Citizen.CreateThread(function()
    SetupButcherPrompt()
	while true do
		Wait(500)
		local isInMarker, tempZone = false
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for _,v in pairs(Config.shops) do 
            local distance = #(coords - v.coords)
            if distance < 2.5 then
                local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
                if holding ~= false then
                    isInMarker  = true
                    tempZone = 'butcher'
                end
            end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			currentZone = tempZone
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			currentZone = nil
		end
	end
end)

function DeleteThis(holding)
    NetworkRequestControlOfEntity(holding)
    SetEntityAsMissionEntity(holding, true, true)
    Wait(100)
    DeleteEntity(holding)
    Wait(500)
    local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
    local holdingcheck = GetPedType(entitycheck)
    if holdingcheck == 0 then
        return true
    else
        return false
    end
end

function Selltobutcher()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    for k = 1, #Config.shops do 
        local distance = #(Config.shops[k]["coords"] - coords)
        if distance < 3.0 then
            local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
            local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
            local model = GetEntityModel(holding)
            local type = GetPedType(holding)
            if holding ~= false then
                for i, row in pairs(Config.Animal) do
                    if model == Config.Animal[i]["model"] then
                        if Config.Animal[i]["tip"] ~=  Config.shops[k]["tip"] then 
                             TriggerEvent("xFramework:Notify","aviso","este animal não pode ser vendido aqui. ele é do tipo "..Config.Animal[i].tip.. " aqui aceitamos apenas animais ".. Config.shops[k].tip.. "s", 10000)
                            Wait(10000)
                            return
                        end
                    end
                    if type == 28 then
                        if model == Config.Animal[i]["model"] then
                            local reward = Config.shops[k]["gain"] * Config.Animal[i]["reward"]
                           

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                print("giveItem", Config.Animal[i]["item"])
                                if string.find(Config.Animal[i]["item"], "chicken") or string.find(Config.Animal[i]["item"], "frango")  then 
                                    TriggerServerEvent("caca:giveitem", "pena", 1)
                                end
                                 TriggerServerEvent("caca:giveitem", Config.Animal[i]["item"], 1)
                                TriggerServerEvent("caca:reward", reward)
                                
                            else
                            --    TriggerEvent("xFramework:Notify","aviso","DELETE ENTITY NATIVE IS SCUFFED - RELOG PLZ", "error")
                            end

                        end
                    end
                    if quality ~= false then
                        if quality == Config.Animal[i]["poor"] then

                            local rewardresult = Config.shops[k]["gain"] * Config.Animal[i]["reward"]
                            local reward = rewardresult * 0.5
                          

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                if string.find(Config.Animal[i]["item"], "chicken") or string.find(Config.Animal[i]["item"], "frango")  then 
                                    TriggerServerEvent("caca:giveitem", "pena", 1)
                                end
                                TriggerServerEvent("caca:giveitem", Config.Animal[i]["item"], 1)
                                TriggerServerEvent("caca:reward", reward)
                               
                            else
		                --   TriggerEvent("xFramework:Notify","aviso","DELETE ENTITY NATIVE IS SCUFFED - RELOG PLZ", "error")
                              
                            end

                        elseif quality == Config.Animal[i]["good"] then

                            local rewardresult = Config.shops[k]["gain"] * Config.Animal[i]["reward"]
                            local reward = rewardresult * 0.75
                           

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                if string.find(Config.Animal[i]["item"], "chicken") or string.find(Config.Animal[i]["item"], "frango")  then 
                                    TriggerServerEvent("caca:giveitem", "pena", 1)
                                end
                                TriggerServerEvent("caca:giveitem", Config.Animal[i]["item"], 1)
                                TriggerServerEvent("caca:reward", reward)
                                
                            else
                                -- TriggerEvent("xFramework:Notify","aviso","DELETE ENTITY NATIVE IS SCUFFED - RELOG PLZ", "error")
                            end

                        elseif quality == Config.Animal[i]["perfect"] then

                            local reward = Config.shops[k]["gain"] * Config.Animal[i]["reward"]
                         

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                if string.find(Config.Animal[i]["item"], "chicken") or string.find(Config.Animal[i]["item"], "frango")  then 
                                    TriggerServerEvent("caca:giveitem", "pena", 1)
                                end
                                TriggerServerEvent("caca:giveitem", Config.Animal[i]["item"], 1)
                                TriggerServerEvent("caca:reward", reward)
                            
                            else
                                -- TriggerEvent("xFramework:Notify","aviso","DELETE ENTITY NATIVE IS SCUFFED - RELOG PLZ", "error")
                            end

                        end
                    end
                end
            else
              
            end
        end
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        PromptSetEnabled(ButcherPrompt, false)
        PromptSetVisible(ButcherPrompt, false)
        for k,v in pairs(blip) do
            RemoveBlip(blip[k])
            DeleteEntity(butcher01)
             DeleteEntity(butcher02)
               DeleteEntity(butcher03)
                 DeleteEntity(butcher04)
                  DeleteEntity(butcher05)
                   DeleteEntity(butcher06)
        end
    end
end)

-- Key Controls for butcher01
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
 
 playerCoords = GetEntityCoords(PlayerPedId())
 butcher01Coords = GetEntityCoords(butcher01)     
       FreezeEntityPosition(butcher01, true)
        if GetDistanceBetweenCoords(playerCoords,butcher01Coords, true) < 3 and DoesEntityExist(butcher01) and GetEntityHealth(butcher01)  >= 1 then
            local label  = CreateVarString(10, 'LITERAL_STRING', "")
             PromptSetActiveGroupThisFrame(PromptGorup, label)
            --  --("", 0.40, 0.40, 0.5, 0.85, 164, 0, 20, 1)
            --  --(Config.Text, 0.35, 0.35, 0.5, 0.88, 255, 255, 255, 0)
            if PromptHasHoldModeCompleted(ButcherPrompt) and Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())then
                Selltobutcher()
				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
 
 playerCoords = GetEntityCoords(PlayerPedId())
 butcher02Coords = GetEntityCoords(butcher02)      
       FreezeEntityPosition(butcher02, true)
        if GetDistanceBetweenCoords(playerCoords,butcher02Coords, true) < 3 and DoesEntityExist(butcher02) and GetEntityHealth(butcher02)  >= 1 then
            local label  = CreateVarString(10, 'LITERAL_STRING', "")
            PromptSetActiveGroupThisFrame(PromptGorup, label)
             --("", 0.40, 0.40, 0.5, 0.85, 164, 0, 20, 1)
             --(Config.Text, 0.35, 0.35, 0.5, 0.88, 255, 255, 255, 0)
            if PromptHasHoldModeCompleted(ButcherPrompt) then
                Selltobutcher()
				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

 playerCoords = GetEntityCoords(PlayerPedId())
 butcher03Coords = GetEntityCoords(butcher03)      
       FreezeEntityPosition(butcher03, true)	
        if GetDistanceBetweenCoords(playerCoords,butcher03Coords, true) < 3 and DoesEntityExist(butcher03) and GetEntityHealth(butcher03)  >= 1 then
            local label  = CreateVarString(10, 'LITERAL_STRING', "")
            PromptSetActiveGroupThisFrame(PromptGorup, label)
             --("", 0.40, 0.40, 0.5, 0.85, 164, 0, 20, 1)
             --(Config.Text, 0.35, 0.35, 0.5, 0.88, 255, 255, 255, 0)
            if PromptHasHoldModeCompleted(ButcherPrompt) then
                Selltobutcher()
				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

 playerCoords = GetEntityCoords(PlayerPedId())
 butcher04Coords = GetEntityCoords(butcher04)      
        FreezeEntityPosition(butcher04, true)
        if GetDistanceBetweenCoords(playerCoords,butcher04Coords, true) < 3 and DoesEntityExist(butcher04) and GetEntityHealth(butcher04)  >= 1 then
            local label  = CreateVarString(10, 'LITERAL_STRING', "")
            PromptSetActiveGroupThisFrame(PromptGorup, label)
             --("", 0.40, 0.40, 0.5, 0.85, 164, 0, 20, 1)
             --(Config.Text, 0.35, 0.35, 0.5, 0.88, 255, 255, 255, 0)
            if PromptHasHoldModeCompleted(ButcherPrompt)  then
                Selltobutcher()
				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

 playerCoords = GetEntityCoords(PlayerPedId())
 butcher05Coords = GetEntityCoords(butcher05)      
        FreezeEntityPosition(butcher05, true)
        if GetDistanceBetweenCoords(playerCoords,butcher05Coords, true) < 3 and DoesEntityExist(butcher05) and GetEntityHealth(butcher05)  >= 1 then
            local label  = CreateVarString(10, 'LITERAL_STRING', "")
            PromptSetActiveGroupThisFrame(PromptGorup, label)
            --("", 0.40, 0.40, 0.5, 0.85, 164, 0, 20, 1)
            --(Config.Text, 0.35, 0.35, 0.5, 0.88, 255, 255, 255, 0)
            if PromptHasHoldModeCompleted(ButcherPrompt)  then
                Selltobutcher()
				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
 
 playerCoords = GetEntityCoords(PlayerPedId())
 butcher06Coords = GetEntityCoords(butcher06)        
        FreezeEntityPosition(butcher06, true)
        if GetDistanceBetweenCoords(playerCoords,butcher06Coords, true) < 3 and DoesEntityExist(butcher06) and GetEntityHealth(butcher06)  >= 1 then
            local label  = CreateVarString(10, 'LITERAL_STRING', "")
            PromptSetActiveGroupThisFrame(PromptGorup, label)
            --("", 0.40, 0.40, 0.5, 0.85, 164, 0, 20, 1)
            --(Config.Text, 0.35, 0.35, 0.5, 0.88, 255, 255, 255, 0)
            if PromptHasHoldModeCompleted(ButcherPrompt) then
                Selltobutcher()
				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent("animacao:comerCarne")
AddEventHandler("animacao:comerCarne", function(carneName)comerCarne(carneName)end)

RegisterNetEvent("animacao:comerAlgo")
AddEventHandler("animacao:comerAlgo", function(prop, carneName)comerAlgo(prop, carneName)end)

RegisterNetEvent("animacao:assarCarneFogueira")
AddEventHandler("animacao:assarCarneFogueira", function(carneName)comerCarne(carneName)end)

function comerCarne(carneName)
    local playerCds = GetEntityCoords(PlayerPedId())
	local dict = "mech_inventory@clothing@bandana";
	local anim = "NECK_2_FACE_RH";
	RequestAnimDict(dict);
	while (not HasAnimDictLoaded(dict)) do Wait(100) end 
	local hashItem = GetHashKey("P_MAIN_ROASTBEEF01X");
	local prop = CreateObject(hashItem, playerCds.x, playerCds.y, playerCds.z + 0.2, true, true, false, false, true);
	local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger12");
	Wait(1000)
	TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
	AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
    exports["x_progress"]:startUI(6000, "Comendo "..carneName)
	Wait(6000)
	DeleteObject(prop)
	ClearPedSecondaryTask(PlayerPedId())
end

function comerAlgo(prop, carneName)
    local playerCds = GetEntityCoords(PlayerPedId())
	local dict = "mech_inventory@clothing@bandana";
	local anim = "NECK_2_FACE_RH";
    if carneName == "Agua" then 
        dict = "amb_rest_drunk@world_human_drinking@male_a@idle_a";
        anim = "idle_a";
        if (not IsPedMale(PlayerPedId())) then 
            dict = "amb_rest_drunk@world_human_drinking@female_a@idle_b"
            anim = "idle_e"
        end
    end
	RequestAnimDict(dict);
	while (not HasAnimDictLoaded(dict)) do Wait(100) end 
	local hashItem = GetHashKey(prop);
	local prop = CreateObject(hashItem, playerCds.x, playerCds.y, playerCds.z + 0.2, true, true, false, false, true);
	local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger12");
	Wait(1000)
	TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
    if carneName == "Cenoura" then 
	    AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.08, 0.008, 0.05, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
    elseif carneName == "Pera" then 
        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.01, 0.008, 0.05, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
    elseif carneName == "Banana" then 
        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.01, -0.004, 0.3, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
    elseif carneName == "Agua" then 
        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.04, 0.002, 0.09, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
    end
    exports["x_progress"]:startUI(6000, ""..carneName)
	Wait(6000)
	DeleteObject(prop)
	ClearPedSecondaryTask(PlayerPedId())
end

function Function.comerEnsopado(carneName)
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true) -- unarm player
    local playerCds = GetEntityCoords(PlayerPedId())
	local dict = "mech_inventory@eating@stew";
	local anim = "intro";
	RequestAnimDict(dict);
	while (not HasAnimDictLoaded(dict)) do Wait(100) end 
	local hashItem = GetHashKey("p_stewplate01x");
    local hashItem2 = GetHashKey("p_stewspoon01x");
	local prop = CreateObject(hashItem, playerCds.x, playerCds.y, playerCds.z + 0.2, true, true, false, false, true);
    local prop2 = CreateObject(hashItem2, playerCds.x, playerCds.y, playerCds.z + 0.2, true, true, false, false, true);
	local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_L_Finger12");
    local boneIndex2 = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger12");
	TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
	AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.02, 0.028, 0.001, 900.0, 900.0, 900.0, true, true, false, true, 1, true)
    AttachEntityToEntity(prop2, PlayerPedId(), boneIndex2, 1, -0.018, 0.01, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
    exports["x_progress"]:startUI(5000, "Comendo Ensopado ")
	Wait(5000)
	DeleteObject(prop)
    DeleteObject(prop2)
	ClearPedSecondaryTask(PlayerPedId())
end

function Function.cozinharCarneEmFogueiraProxima(nomeCarne)
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    local nearFogueira = GetClosestObjectOfType(x, y, z, 3.0, GetHashKey("p_campfirecombined03x"), false, true ,true)
    print(nearFogueira)
    if nearFogueira ~= 0 then 
        exports["x_progress"]:startUI(7000, "Cozinhando ")
        TaskPlayAnim(PlayerPedId(), dict, "inspectfloor_player", 1.0, 8.0, -1, 1, 0, false, false, false)
        Wait(7000)
        ClearPedTasks(PlayerPedId())
        return true
    else 
        return false
    end
end

-- colheita


function DrawText3D(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, 'LITERAL_STRING', str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 1)
    DisplayText(str, x, y)
end
local colheita = {
	{
		hasFruto = true,
		chance = 10,
		local_ = {1140.67, -1006.77, 68.73},
		chanceDb = {[1] = {item = "milho", chance = 100 },}
		
	},
	{
		hasFruto = true,
		chance = 10,
		local_ = {1585.93, -1406.18, 55.49},
		chanceDb = {[1] = {item = "milho", chance = 100 },}
		
	},
	{
		hasFruto = true,
		chance = 10,
		local_ = {-4008.78, -2716.43, -6.53},
		chanceDb = {[1] = {item = "cacto", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {-3792.92, -3280.64, -9.21},
		chanceDb = {[1] = {item = "cacto", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {82.58, 484.48, 159.35 },
		chanceDb = {[1] = {item = "cacto", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {309.36, 292.03, 157.04 },
		chanceDb = {[1] = {item = "cenoura", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {220.7, 683.76, 176.66 },
		chanceDb = {[1] = {item = "cenoura", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {1082.3, 1608.19, 375.73 },
		chanceDb = {[1] = {item = "cenoura", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {2537.8, 1191.54, 164.61 },
		chanceDb = {[1] = {item = "cenoura", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {3598.46, 1275.34, 48.42  },
		chanceDb = {[1] = {item = "cogumelo", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {3010.36, 1522.74, 58.17  },
		chanceDb = {[1] = {item = "cogumelo", chance = 100 },}
		
	},
}

local lowestIndex = 0;
local lowestValue = false;
local hIndex = 0
local hValue = false 
function selectMostProximityValueByInt(t, base)
	for k, v in ipairs(t) do
		if not lowestValue or v < lowestValue then
			lowestIndex = k;
			lowestValue = v;
		end
	end
	for k, v in pairs(base) do 
		if v.chance == lowestValue then 
			lowestIndex = k 
		end
	end 
	local resps = {lowestIndex, lowestValue}
	lowestValue = false
	lowestIndex = 0
	if resps[2] == false then
		local foo = {}
		for i = 1, #base do 
			table.insert(foo, tonumber(base[i].chance))
		end
		local max_val, key = 0,0
		for k, v in pairs(foo) do
			key = k
			if max_val == 0 then 
				max_val = v 
			end
			if v > max_val then
				max_val, key = v, k
			end
			max = max_val
		end
		for k, v in pairs(base) do 
			if v.chance == max_val then 
				key = k 
			end
		end 
		resps = {key, max}
	end
	return resps[2], resps[1];
end
local blip = {}
Citizen.CreateThread(function()
    for k,v in pairs(colheita) do
        -->(v[1], v[2], v[3])
        blip[k] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v.local_[1], v.local_[2], v.local_[3])
        SetBlipSprite(blip[k], 935247438, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], 'Colheita Ingredientes')
    end
end)
Citizen.CreateThread(function()
while true do 
	local W = 500
	for k, v in pairs(colheita) do 
		local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.local_[1], v.local_[2], v.local_[3])
        if dist < 9.0 then 
			W = 1
			_DrawText3D( v.local_[1], v.local_[2], v.local_[3]-1, "Pressione ~e~[R]~p~ para colher")
			if dist < 2.0 then 
                W = 1
			_DrawText3D( v.local_[1], v.local_[2], v.local_[3]-1, "Pressione ~e~[R]~p~ para colher")
				if IsControlJustPressed(0,0xE30CD707) then
                    local adaptacao = true 
					if adaptacao then 	
						local ar_stamp = x_cacaSV.getArbustoStamp(k)
						local cur_stamp = x_cacaSV.currentServerTimeStamp()
                        print(ar_stamp, cur_stamp)
						local ignore = false
						if type(ar_stamp) == "number" then 
							if  ( ( (cur_stamp - ar_stamp)/60 ) - 30 ) * -1 > 30 then 
								-->("ignore ...>>>", ( ( (cur_stamp - ar_stamp)/60 ) - 30 ) * -1 )
								ignore = true 
							end
						end
						if type(ar_stamp) == "number" then 
							-->("log: "..(cur_stamp - ar_stamp)/60)
						end
						if ignore or not ar_stamp or (cur_stamp - ar_stamp)/60 > 30 then 
							local itens = v.chanceDb;
							local val = 0.4
							local t_total = 0;
							for _, v2 in pairs(itens) do 
								t_total = t_total + v2.chance
							end
							local ch = math.random(100)%t_total;
							local o = {}
							local cV, cK = false, 0
							local integers = {}
							for k, v in pairs(itens) do 
								if v.chance > ch then 
									o[v.item] = v.chance
									table.insert(integers, v.chance)
								end
							end
							local l, key = selectMostProximityValueByInt(integers, itens)
							for k in pairs(integers) do 
								integers[k] = nil
							end
							TriggerAnim(v.local_[1], v.local_[2], v.local_[3])
							--:>('sel_item ==> '..v.chanceDb[key].item)
							x_cacaSV.giveItem(v.chanceDb[key].item)
							x_cacaSV.set(k)
						else
							local rest = ( ( (cur_stamp - ar_stamp)/60 ) - 30 ) * -1
							rest = string.format("%.2f",rest)
							TriggerEvent("xFramework:Notify", "negado", "Este arbusto não têm frutos. Volte daqui "..rest.. " Minutos")	  
                        end
						end
					end
				end	
			end
		end
		Citizen.Wait(W)
	end
end)
function TriggerAnim(x, y, z)
   local dict  = "amb_camp@world_human_wash_dishes@table@right@female_b@drop_spoon@base"
   local anim = "dropspoon_trans_grabdish"
   --:>("trigger<sucess>")
   RequestAnimDict(dict)
   while not HasAnimDictLoaded(dict) do Wait(0) end--:>("loading: try <TRY>>") end
   SetEntityCoordsNoOffset(PlayerPedId(), x, y, z)
   exports["x_progress"]:startUI(4000*3+1000, "Coletando...")
   for i = 1, 3 do 
    	TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
    	Wait(4000)
	end
end
function _DrawText3D(x, y, z, text)
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
