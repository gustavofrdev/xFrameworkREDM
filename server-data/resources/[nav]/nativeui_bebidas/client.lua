-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
    if data == "cerveja.item.compra()" then
		TriggerServerEvent("nativeui_bebidas:comprar","cerveja")

    elseif data == "whisky.item.compra()" then
            TriggerServerEvent("nativeui_bebidas:comprar","whisky")
    elseif data == "fechar" then

		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local place_cds = {}

local cds = {
    {-815.7490234375,-1319.2823486328,43.67892074585}
}
local cds_to_npc = {
    {-817.83764648438,-1319.7780761719,43.687932189941,269.77}
}

-- @@ table.unpack(place_cds)
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-311.683, 806.363, 118.9300,true)
        if distance <= 30 then
            
		--	DrawMarker(23,-268.960,299.0656,61.880-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
            if distance <= 1.2 then
                DrawText3D(-311.683, 806.363, 118.9300,"Pressione [G] para acessar o menu")
                if Citizen.InvokeNative(0x580417101DDB492F, 0, 0x760A9C6F)  then
                    print("ta clicado pai")
					ToggleActionMenu()
				end
				
			end
		end
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),3288.475, -1306.247, 42.803,true)
        if distance <= 30 then
            
		--	DrawMarker(23,-268.960,299.0656,61.880-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
            if distance <= 1.2 then
                DrawText3D(3288.475, -1306.247, 42.803,"Pressione [G] para acessar o menu")
                if Citizen.InvokeNative(0x580417101DDB492F, 0, 0x760A9C6F)  then
                    print("ta clicado pai")
					ToggleActionMenu()
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-815.7490234375,-1319.2823486328,43.67892074585,true)
        if distance <= 30 then
            
		--	DrawMarker(23,-268.960,299.0656,61.880-0.97,0,0,0,0,0,0,1.0,1.0,0.5,240,200,80,20,0,0,0,0)
            if distance <= 1.2 then
                DrawText3D(-815.7490234375,-1319.2823486328,43.67892074585,"Pressione [G] para acessar o menu")
                if Citizen.InvokeNative(0x580417101DDB492F, 0, 0x760A9C6F)  then
                    print("ta clicado pai")
					ToggleActionMenu()
				end
			end
		end
	end
end)

Citizen.CreateThread(
    function()
        local currenthairIndex = 1
        local selectedhairIndex = 1
        local currentmustacheIndex = 1
        local selectedmustacheIndex = 1

        if not DoesEntityExist(florencewatson) then
            local hash = GetHashKey('S_M_M_STRDEALER_01')
            --RequestModel(hash)

            while not HasModelLoaded(hash) do
                Wait(100)
            end

            local florencewatson = CreatePed(hash, -313.361, 806.410, 118.930-1, 281.584, false, true)
          SetPedRandomComponentVariation(florencewatson, 0)
        SetBlockingOfNonTemporaryEvents(florencewatson, true)
         SetEntityInvincible(florencewatson, true)
         SetPedCanBeTargettedByPlayer(florencewatson, GetPlayerPed(), false);
         FreezeEntityPosition(florencewatson, true)
        end
    end)

    Citizen.CreateThread(
    function()
        local currenthairIndex = 1
        local selectedhairIndex = 1
        local currentmustacheIndex = 1
        local selectedmustacheIndex = 1

        if not DoesEntityExist(florencewat22son) then
            local hash = GetHashKey('S_M_M_STRDEALER_01')
            --RequestModel(hash)

            while not HasModelLoaded(hash) do
                Wait(100)
            end

            local florencewat22son = CreatePed(hash, 3288.3625488281,-1303.4265136719,42.915138244629-1,179.61,  false, true)
          SetPedRandomComponentVariation(florencewat22son, 0)
        SetBlockingOfNonTemporaryEvents(florencewat22son, true)
         SetEntityInvincible(florencewat22son, true)
         SetPedCanBeTargettedByPlayer(florencewat22son, GetPlayerPed(), false);
         FreezeEntityPosition(florencewat22son, true)
        end
    end)

    Citizen.CreateThread(
    function()
        local currenthairIndex = 1
        local selectedhairIndex = 1
        local currentmustacheIndex = 1
        local selectedmustacheIndex = 1

        if not DoesEntityExist(florencewatson2) then
            local hash = GetHashKey('S_M_M_STRDEALER_01')
            --RequestModel(hash)

            while not HasModelLoaded(hash) do
                Wait(100)
            end

            local florencewatson2 = CreatePed(hash, -817.83764648438,-1319.7780761719,43.687932189941-1,269.77, false, true)
          SetPedRandomComponentVariation(florencewatson2, 0)
        SetBlockingOfNonTemporaryEvents(florencewatson2, true)
         SetEntityInvincible(florencewatson2, true)
         SetPedCanBeTargettedByPlayer(florencewatson2, GetPlayerPed(), false);
         FreezeEntityPosition(florencewatson2, true)
        end
    end)
    
    Citizen.CreateThread(function()
      --  local cfg = getCFG()
        local blip3 = N_0x554d9d53f696d002(1664425300,-815.7490234375,-1319.2823486328,43.67892074585 )
        SetBlipSprite(blip3, -392465725, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip3, "Bebidas")
    
    end)

    Citizen.CreateThread(function()
     --   local cfg = getCFG()
        local blip34 = N_0x554d9d53f696d002(1664425300,-313.361, 806.410, 118.930,43.687932189941 )
        SetBlipSprite(blip34, -392465725, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip34, "Bebidas")
    
    end)





---2826.579, -1233.9824, 47.568, 311.681
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
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end


function DisplayHelpText(str)
	Citizen.InvokeNative(0x8509B634FBE7DA11, "STRING")
	Citizen.InvokeNative(0x5F68520888E69014, str)
	Citizen.InvokeNative(0x238FFE5C7B0498A6, 0, 0, 1, -1)
end

--> Client Utils <--
weaponNames = {
	"WEAPON_MOONSHINEJUG",
	"WEAPON_MELEE_LANTERN_ELECTRIC",
	"WEAPON_MELEE_TORCH",
	"WEAPON_LASSO",
	"WEAPON_MELEE_BROKEN_SWORD",
	"WEAPON_FISHINGROD",
	"WEAPON_MELEE_HATCHET",
	"WEAPON_MELEE_CLEAVER",
	"WEAPON_MELEE_ANCIENT_HATCHET",
	"WEAPON_MELEE_HATCHET_VIKING",
	"WEAPON_MELEE_HATCHET_HEWING",
	"WEAPON_MELEE_HATCHET_DOUBLE_BIT",
	"WEAPON_MELEE_HATCHET_DOUBLE_BIT_RUSTED",
	"WEAPON_MELEE_HATCHET_HUNTER",
	"WEAPON_MELEE_HATCHET_HUNTER_RUSTED",
	"WEAPON_MELEE_KNIFE_JOHN",
	"WEAPON_MELEE_KNIFE",
	"WEAPON_MELEE_KNIFE_JAWBONE",
	"WEAPON_THROWN_THROWING_KNIVES",
	"WEAPON_MELEE_KNIFE_MINER",
	"WEAPON_MELEE_KNIFE_CIVIL_WAR",
	"WEAPON_MELEE_KNIFE_BEAR",
	"WEAPON_MELEE_KNIFE_VAMPIRE",
	"WEAPON_MELEE_MACHETE",
	"WEAPON_THROWN_TOMAHAWK",
	"WEAPON_THROWN_TOMAHAWK_ANCIENT",
	"WEAPON_PISTOL_M1899",
	"WEAPON_PISTOL_MAUSER",
	"WEAPON_PISTOL_MAUSER_DRUNK",
	"WEAPON_PISTOL_SEMIAUTO",
	"WEAPON_PISTOL_VOLCANIC",
	"WEAPON_REPEATER_CARBINE",
	"WEAPON_REPEATER_HENRY",
	"WEAPON_RIFLE_VARMINT",
	"WEAPON_REPEATER_WINCHESTER",
	"WEAPON_REVOLVER_CATTLEMAN",
	"WEAPON_REVOLVER_CATTLEMAN_JOHN",
	"WEAPON_REVOLVER_CATTLEMAN_MEXICAN",
	"WEAPON_REVOLVER_CATTLEMAN_PIG",
	"WEAPON_REVOLVER_DOUBLEACTION",
	"WEAPON_REVOLVER_DOUBLEACTION_EXOTIC",
	"WEAPON_REVOLVER_DOUBLEACTION_GAMBLER",
	"WEAPON_REVOLVER_DOUBLEACTION_MICAH",
	"WEAPON_REVOLVER_LEMAT",
	"WEAPON_REVOLVER_SCHOFIELD",
	"WEAPON_REVOLVER_SCHOFIELD_GOLDEN",
	"WEAPON_REVOLVER_SCHOFIELD_CALLOWAY",
	"WEAPON_RIFLE_BOLTACTION",
	"WEAPON_SNIPERRIFLE_CARCANO",
	"WEAPON_SNIPERRIFLE_ROLLINGBLOCK",
	"WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC",
	"WEAPON_RIFLE_SPRINGFIELD",
	"WEAPON_SHOTGUN_DOUBLEBARREL",
	"WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC",
	"WEAPON_SHOTGUN_PUMP",
	"WEAPON_SHOTGUN_REPEATING",
	"WEAPON_SHOTGUN_SAWEDOFF",
	"WEAPON_SHOTGUN_SEMIAUTO",
	"WEAPON_BOW",
	"WEAPON_THROWN_DYNAMITE",
	"WEAPON_THROWN_MOLOTOV",
}

local keys = {
    -- Letters
    ["A"] = 0x7065027D,
    ["B"] = 0x4CC0E2FE,
    ["C"] = 0x9959A6F0,
    ["D"] = 0xB4E465B4,
    ["E"] = 0xCEFD9220,
    ["F"] = 0xB2F377E8,
    ["G"] = 0x760A9C6F,
    ["H"] = 0x24978A28,
    ["I"] = 0xC1989F95,
    ["J"] = 0xF3830D8E,
    -- Missing K, don't know if anything is actually bound to it
    ["L"] = 0x80F28E95,
    ["M"] = 0xE31C6A41,
    ["N"] = 0x4BC9DABB, -- Push to talk key
    ["O"] = 0xF1301666,
    ["P"] = 0xD82E0BD2,
    ["Q"] = 0xDE794E3E,
    ["R"] = 0xE30CD707,
    ["S"] = 0xD27782E3,
    -- Missing T
    ["U"] = 0xD8F73058,
    ["V"] = 0x7F8D09B8,
    ["W"] = 0x8FD015D8,
    ["X"] = 0x8CC9CD42,
    -- Missing Y
    ["Z"] = 0x26E9DC00,

    -- Symbol Keys
    ["RIGHTBRACKET"] = 0xA5BDCD3C,
    ["LEFTBRACKET"] = 0x430593AA,
    -- Mouse buttons
    ["MOUSE1"] = 0x07CE1E61,
    ["MOUSE2"] = 0xF84FA74F,
    ["MOUSE3"] = 0xCEE12B50,
    ["MWUP"] = 0x3076E97C,
    -- Modifier Keys
    ["CTRL"] = 0xDB096B85,
    ["TAB"] = 0xB238FE0B,
    ["SHIFT"] = 0x8FFC75D6,
    ["SPACEBAR"] = 0xD9D0E1C0,
    ["ENTER"] = 0xC7B5340A,
    ["BACKSPACE"] = 0x156F7119,
    ["LALT"] = 0x8AAA0AD4,
    ["DEL"] = 0x4AF4D473,
    ["PGUP"] = 0x446258B6,
    ["PGDN"] = 0x3C3DD371,
    -- Function Keys
    ["F1"] = 0xA8E3F467,
    ["F4"] = 0x1F6D95E5,
    ["F6"] = 0x3C0A40F2,
    -- Number Keys
    ["1"] = 0xE6F612E4,
    ["2"] = 0x1CE6D9EB,
    ["3"] = 0x4F49CC4C,
    ["4"] = 0x8F9F9E58,
    ["5"] = 0xAB62E997,
    ["6"] = 0xA1FDE2A6,
    ["7"] = 0xB03A913B,
    ["8"] = 0x42385422,
    -- Arrow Keys
    ["DOWN"] = 0x05CA7C52,
    ["UP"] = 0x6319DB71,
    ["LEFT"] = 0xA65EBAB4,
    ["RIGHT"] = 0xDEB34313,
}


--whenKeyJustPressed(keys["X"])
function whenKeyJustPressed(key)
    k = keys[key]
    if Citizen.InvokeNative(0x580417101DDB492F, 0, k) then
        return true
    else
        return false
    end
end

function IsDead(e)
	return Citizen.InvokeNative(0x2E9C3FCB6798F397, e)
end

function ClearPTask(e)
	return ClearPedTasks(e)
end

function p()
	return PlayerId()
end

-- ped = PlayerPedId()
function Ped()
	return PlayerPedId()
end

-- ps = GetPlayerServerId(PlayerId())
function ps()
	return GetPlayerServerId(PlayerId())
end

function GetEntityCoords(e)
    return Citizen.InvokeNative(0xA86D5F069399F44D, e, Citizen.ResultAsVector())
end

function GetEntityHead(e)
	return GetEntityHeading(e)
end

function GetDistance(pc,oc)
    return GetDistanceBetweenCoords(pc.x, pc.y, pc.z, oc.x, oc.y, oc.z, false)
end
function GetDistanceZTrue(pc,oc)
    return GetDistanceBetweenCoords(pc.x, pc.y, pc.z, oc.x, oc.y, oc.z, true)
end

function SetCoords(c)
	return SetEntityCoords(c.x,c.y,c.z)
end

function PlayAnim(d,a)
    local player = PlayerPedId()

    local dict = d
    RequestAnimDict(d)
    while not HasAnimDictLoaded(d) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(player, d, a, 1.0, 8.0, -1, 1, 0, false, false, false)
end

function PlayWalkAnim(d,a)
    local player = PlayerPedId()

    local dict = d
    RequestAnimDict(d)
    while not HasAnimDictLoaded(d) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(player, d, a, 1.0, 8.0, -1, 31, 0, false, false, false)
end

function PlayScenario(s)
    local player = PlayerPedId()
    local model = GetHashKey(s)
    TaskStartScenarioInPlace(player, model,-1, true, false, false, false)
end


-- pv = PlayerVehicle
function pv()
	return GetVehiclePedIsIn(ped(), false)
end

-- lpv = LastPlayerVehicle
function lpv()
	return GetVehiclePedIsIn(ped(), true)
end

-- fix = Fixes the specified vehicle
function fix(veh)
	SetVehicleFixed(veh)
	return ""
end

function translateAngle(x1, y1, ang, offset)
    x1 = x1 + math.sin(ang) * offset
    y1 = y1 + math.cos(ang) * offset
    return {x1, y1}
end

function SpawnEntOnP(e)
    local player = GetPlayerPed()
    local pCoords = GetEntityCoords(player)
    local pDir = GetEntityHeading(player)
    -- 0x405180B14DA5A935 SetPedType(entity, ??) -- Always makes PedType 4

    local spawnCoords = GetOffsetFromEntityInWorldCoords(player, 0, -0.5, -0.5)

    local modelName = e
    local modelHash = GetHashKey(modelName)
    Citizen.CreateThread(function()
        LoadModel(modelHash)
        local entity = CreatePed(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, pDir, true, false, false, false)
        SetEntityVisible(entity, true)
        SetEntityAlpha(entity, 255, false)
        Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
        SetModelAsNoLongerNeeded(modelHash)
    end)
end

function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
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
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

function ShowPrompt(msg)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end
local modoBebendo = false 
local animBeer = function()
    local x, y, z  = table.unpack(GetEntityCoords(PlayerPedId()))
    local itemHash = GetHashKey("p_bottlebeer01a")
    local obj = CreateObject(itemHash, x, y, z, false, true, false ,false, true )
    TaskItemInteraction_2(PlayerPedId(), -1199896558, obj, GetHashKey("p_bottleBeer01x_PH_R_HAND"), GetHashKey("DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_TABLE_HOLD"), 1, 0, -1);
    local retval;
    modoBebendo = true 
    Wait(1000)
    while modoBebendo do 
        Wait(0)
        retval = DoesEntityExist(obj);
        if not retval then 
            modoBebendo = false
            Citizen.InvokeNative(0x4102732DF6B4005F,"PlayerDrunk01",0, true) --playdrunk
            Wait(30000)
            Citizen.InvokeNative(0xB4FD7446BAB2F394 , "PlayerDrunk01")
        end
    end
end

local animWhiskey = function()
    local x, y, z  = table.unpack(GetEntityCoords(PlayerPedId()))
    local itemHash = GetHashKey("p_bottlejd01x")
    local obj = CreateObject(itemHash, x, y, z, false, true, false ,false, true )
    TaskItemInteraction_2(PlayerPedId(), -1199896558, obj, GetHashKey("p_bottleJD01x_ph_r_hand"), GetHashKey("DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD"), 1, 0, -1);
    local retval;
    modoBebendo = true 
    Wait(1000)
    while modoBebendo do 
        Wait(0)
        retval = DoesEntityExist(obj);
        if not retval then 
            modoBebendo = false
            Citizen.InvokeNative(0x4102732DF6B4005F,"PlayerDrunk01",0, true) --playdrunk
            Wait(50000)
            Citizen.InvokeNative(0xB4FD7446BAB2F394 , "PlayerDrunk01")
        end
    end
end

RegisterNetEvent("cerveja")
AddEventHandler("cerveja", animBeer)

RegisterNetEvent("whiskey")
AddEventHandler("whiskey", animWhiskey)