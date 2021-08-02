local starting = false
local already = false
local count = {}
local createdped = {}
local pressing = false
local gpsx = 0.0
local gpsy = 0.0
local gpsz = 0.0

function missionstart()

--Elige el array de coordenadas(lugar)
	local randomNCoords = math.random(2)
	local chossenCoords = {}
	print(randomNCoords)

	if randomNCoords == 1 then
		chossenCoords = Config.Coordenates.coords
	elseif randomNCoords == 2 then
		chossenCoords = Config.Coordenates.coords2
	end

			  
	for k,item in pairs(chossenCoords) do
		
	--Take a random model
		local modelNumeroRandom = math.random(32)
		local modelRandom = Config.models[modelNumeroRandom].hash
		local _hash = GetHashKey(modelRandom)
		RequestModel(_hash)
		if not HasModelLoaded(_hash) then 
			RequestModel(_hash) 
		end
	
		while not HasModelLoaded(_hash) do 
			Citizen.Wait(1) 
		end
		
		print(modelNumeroRandom)

	--Take a random weapon
		local randomNumeroArma = math.random(22)
		local arma = Config.weapons[randomNumeroArma].hash
		print(randomNumeroArma)

		createdped[k] = CreatePed(_hash, item.x, item.y, item.z, true, true, true, true)
		Citizen.InvokeNative(0x283978A15512B2FE, createdped[k], true)
		Citizen.InvokeNative(0x23f74c2fda6e7c61, 953018525, createdped[k])
		gpsx = item.x
		gpsy = item.y
		gpsz = item.z
	--Give weapons to ped and equip them
		GiveWeaponToPed_2(createdped[k], arma, 10, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)
		SetCurrentPedWeapon(createdped[k], arma, true)
	--Ped becomes agressive to the player
		TaskCombatPed(createdped[k],PlayerPedId())
		count[k] = createdped[k]
		print(count[k])
	end
	StartGpsMultiRoute(6, true, true)
        
    -- Add the points
    AddPointToGpsMultiRoute(gpsx, gpsy, gpsz)
    AddPointToGpsMultiRoute(gpsx, gpsy, gpsz)

    -- Set the route to render
	SetGpsMultiRouteRender(true)

	starting = true
	Wait(1000)
	Citizen.CreateThread(function()
		local x = #chossenCoords
		local pl = Citizen.InvokeNative(0x217E9DC48139933D)
		while starting == true do
			Citizen.Wait(0)
			for k,v in pairs(createdped) do
				if IsEntityDead(v) then
					if count[k] ~= nil then
						x = x - 1
						count[k] = nil
						if x == 0 then
						
							TriggerEvent("xFramework:Notify", "sucesso", "Você concluiu sua missão")
							TriggerServerEvent('AT_bountyhunting:AddSomeMoney')
							stopmission()
						end
					end
				end
				if IsPlayerDead(pl) then
					TriggerEvent("xFramework:Notify", "negado", "Você falhou com a sua missão")
					stopmission()
				end
			end
		end
	end)
end

function stopmission()
	Wait(5000)
	pressing = false
	starting = false
	already = false
	SetGpsMultiRouteRender(false)
	for k,v in pairs(createdped) do
		DeletePed(v)
		Wait(500)
	end
	table.remove{createdped}
	table.remove{count}
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function startdialog()
	Citizen.CreateThread(function()
	  local timetocheck = 600
		while timetocheck >= 0  do
			Citizen.Wait(0)
			timetocheck = timetocheck - 1
		end
	end)
end

local Bountys = {
    ["Bounty"] = {
	[1] = { ["x"] = 2556.668, ["y"] = 757.9832, ["z"] = 76.87212, ["h"] = 323.77005004883}, -- 2556.668, 757.9832, 76.87212
    }, 
}

local Keys = {
    ["G"] = 0x760A9C6F
}

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(14)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 215
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

function SetupBounty(location)
    local Coords = GetEntityCoords(PlayerPedId())
    local Gebied = GetDistanceBetweenCoords(Coords.x, Coords.y, Coords.z, location["x"], location["y"], location["z"], true)
    if Gebied <= 2.2 and not already then
        DrawText3D(location["x"], location["y"], location["z"], 'G - Iniciar Missão') 
		if IsControlJustPressed(0, Keys['G']) and not pressing then
			TriggerEvent("xFramework:Notify", "sucesso", "A missão começou!")						
		  stopmission()
		  pressing = true
		  missionstart()
		  startdialog()
		  already = true
    end
 end
end

Citizen.CreateThread(function()
   while true do
    Wait(0)
   for i = 1,1 do
    SetupBounty(Bountys["Bounty"][i])
   end
  end
end)
