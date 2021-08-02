local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9 }

local pressTime = 0
local pressLeft = 0

local recentlySpawned = 0

local boatModel;
local boatSpawn = {}
local NumberboatSpawn = 0

--Config Boats Here

local boates = {
	    [1] = {
		['Text'] = "~q~Barco a remo ~t1~[$10]",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Price'] = 10,
			['Model'] = "rowboatSwamp02",
			['Level'] = 5
		}
	},
		[2] = {
		['Text'] = "~q~Canoa ~t1~[$5]",
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Price'] = 5,
			['Model'] = "CANOE",
			['Level'] = 1
		}
	},

		[3] = {
		['Text'] = "~q~Canoa Longa ~t1~[$5]",
		['SubText'] = "",
		['Desc'] = "level require [5]",
		['Param'] = {
			['Price'] = 5,
			['Model'] = "PIROGUE",
			['Level'] = 5
		}
	},

	    [4] = {
		['Text'] = "~q~Canoa de Treetrunk ~t1~[$2]",
		['SubText'] = "",
		['Desc'] = "level require [0]",
		['Param'] = {
			['Price'] = 2,
			['Model'] = "CANOETREETRUNK",
			['Level'] = 0
		}
	}

}
local function IsNearZone ( location )

	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for i=1,#location do
		if #(playerloc - location[i]) < 3.0 then
			return true
		end
	end

end

local function DisplayHelp( _message, x, y, w, h, enableShadow, col1, col2, col3, a, centre )

	local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

	SetTextScale(w, h)
	SetTextColor(col1, col2, col3, a)

	SetTextCentre(centre)

	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end

	Citizen.InvokeNative(0xADA9255D, 10);

	DisplayText(str, x, y)

end

local function ShowNotification( _message )
	local timer = 200
	while timer > 0 do
		DisplayHelp(_message, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
		Citizen.Wait(0)
	end
end

Citizen.CreateThread( function()
	WarMenu.CreateMenu('id_boat', 'Boat shop')
	while true do
		if WarMenu.IsMenuOpened('id_boat') then
			for i = 1, #boates do
				if WarMenu.Button(boates[i]['Text'], boates[i]['SubText']) then
					TriggerServerEvent('elrp:buyboat', boates[i]['Param']) 
			end
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do

		if IsNearZone( Config.Coords ) then
			DisplayHelp(Config.Shoptext, 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
			if IsControlJustReleased(0, keys['E']) then
				WarMenu.OpenMenu('id_boat')
			end
		end

		Citizen.Wait(0)
	end
end)

-- | Blips | --

Citizen.CreateThread(function()
-->	CreateBlips ( )
end)

-- | Notification | --

RegisterNetEvent('UI:DrawNotification')
AddEventHandler('UI:DrawNotification', function( _message )
	ShowNotification( _message )
end)

-- | Spawn boat | --

RegisterNetEvent( 'elrp:spawnBoat' )
AddEventHandler( 'elrp:spawnBoat', function ( boat )
	local checkPos =
	GetClosestVehicle(2844.44, -1465.93, 40.2,3.001,0,71)
	if not DoesEntityExist(checkPos) then 
		local player = PlayerPedId()

		local model = GetHashKey( boat )
		local x,y,z = 2844.44, -1465.93, 40.2
		local heading = GetEntityHeading( player ) + 90

		local oldIdOfTheboat = idOfTheboat

		local idOfTheboat = NumberboatSpawn + 1

		RequestModel( model )

		while not HasModelLoaded( model ) do
			Wait(500)
		end

		if ( boatSpawn[idOfTheboat] ~= oldIdOfTheboat ) then
			DeleteEntity( boatSpawn[idOfTheboat].model )
		end

		boatModel = CreateVehicle( model, x, y, z, heading, 1, 1 )

		SET_PED_DEFAULT_OUTFIT (boatModel)
		Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, boatModel)

		boatSpawn[idOfTheboat] = { id = idOfTheboat, model = boatModel }
	else
		TriggerEvent("xFramework:Notify", "negado", 'Há um barco no local. Espere a retirada')
	end

end )


function SET_PED_DEFAULT_OUTFIT ( boat )
	return Citizen.InvokeNative(0xAF35D0D2583051B0, boat, true )
end


-- | Timer | --

local barcoSpawn = false 
local pos = {x = 2819.5, y = -1423.65, z = 44.21}
Citizen.CreateThread(function()
	while true do 
		local W = 500 
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos.x, pos.y, pos.z, true) < 13 then 
			W = 1
			DrawText3D2(pos.x, pos.y, pos.z, "[R] Pegar/Guardar seu barco")
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos.x, pos.y, pos.z, true) < 2 then
				W = 1 
				if IsControlJustPressed(0, 0xE30CD707) then 
					barcoSpawn=not barcoSpawn
					if barcoSpawn then 
						TriggerServerEvent('elrp:dropboat')
					else
						DeleteVehicle(boatModel)
					end
				end
			end 
		end
		Citizen.Wait(W)
	end
end )
-- RegisterCommand("meubarco", function(source, args, raw)
--     if recentlySpawned <= 0 then
-- 				recentlySpawned = 10
-- 				TriggerServerEvent('elrp:dropboat')
-- 			else
-- 				TriggerEvent('chat:systemMessage', 'Espere ' .. recentlySpawned .. 'antes de sair do barco.')
-- 				TriggerEvent('chat:addMessage', {
-- 					color = { 171, 59, 36 },
-- 					multiline = true,
-- 					args = {"Anti-Spam", 'Espere ' .. recentlySpawned .. 'antes de sair do barco.'}
-- 				})
-- 			end
--    end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
		if recentlySpawned > 0 then
			recentlySpawned = recentlySpawned - 1
		end
    end
end)

-- x = 2819.5, y = -1423.65, z = 44.21
local boatshopblips = {
    {["ShopName"] = "Loja de Barcos", x = 2802.51, y = -1407.3, z = 45.44, ["HasRares"] = false},
	{["ShopName"] = "Barcos - Retirada de barcos",  x = 2819.5, y = -1423.65, z = 44.21, ["HasRares"] = false}
}

Citizen.CreateThread(function()
	for _, info in pairs(boatshopblips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
		SetBlipSprite(blip, 2005921736, 1)
	  SetBlipScale(blip, 0.2)
	  Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.ShopName)
	end  
end)

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
