local robtime = 500 -- Time to rob (in seconds) now its 10mins
local timerCount = robtime
local isRobbing = false
local timers = false
local craft_forte_position = {x = 344.53, y = 1491.01, z = 179.73}
Citizen.CreateThread(function()
	while true do 
		w = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), craft_forte_position.x, craft_forte_position.y, craft_forte_position.z, true) < 5 then 
			w = 1
			_DrawText3D(craft_forte_position.x, craft_forte_position.y, craft_forte_position.z, "[R] abrir crafts!")
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), craft_forte_position.x, craft_forte_position.y, craft_forte_position.z, true) < 2 then
				if IsControlJustPressed(0,0xE30CD707) then
					TriggerServerEvent("x_heist_robbery:open_crafts")
				end
			end
		end
		Citizen.Wait(w)
	end
end ) 
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



function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end
Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords, 336.64, 1506.18, 181.87, true)
		if betweencoords < 2.0 then
			-- DrawTxt(Config.rob, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			_DrawText3D(336.64, 1506.18, 181.87-1, "[ENTER] Iniciar.\nNecessário: Lockpick")
			if IsControlJustReleased(0, 0xC7B5340A) then		
			TriggerServerEvent("x_heist_robbery:startToRob", function() --Getting the item lockpick
				isRobbing = true
				end)	
			end
		end
	end
end)

RegisterNetEvent('x_heist_robbery:startAnimation')
AddEventHandler('x_heist_robbery:startAnimation', function()	
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 35000, true, false, false, false)
	TriggerEvent("cancelando", true )
    exports['x_progress']:startUI(35000, "Checando......")
    Citizen.Wait(35000)
	ClearPedTasksImmediately(PlayerPedId())
	ClearPedSecondaryTask(PlayerPedId())
	Citizen.Wait(1000)
	TriggerEvent("x_heist_robbery:startTheEvent", function()
	end)
end)

--Startingthetimerandrob
RegisterNetEvent("x_heist_robbery:startTimer")
AddEventHandler("x_heist_robbery:startTimer",function()
	timers = true
	TriggerEvent("x_heist_robbery:startTimers")
		while timers do
		Citizen.Wait(0)
		DrawTxt("Proteja a área por... "..timerCount.." segundos", 0.50, 0.52, 0.7, 0.7, true, 255, 255, 255, 255, true)
		local playerPed = PlayerPedId()
		local playerdead = IsPlayerDead(playerPed)
		if GetEntityHealth(PlayerPedId()) <= 0 then
			timers = false
		end
		local coords = GetEntityCoords(playerPed)
		local betweencoords = GetDistanceBetweenCoords(coords, 336.64, 1506.18, 181.87, true)
		if betweencoords > 70.0 then
			timers = false
		end
		if timerCount == 0 then
			Citizen.Wait(1000)
			TriggerServerEvent("x_heist_robbery:payout", function()
		end)
		TriggerEvent("cancelando", false )
		end
	end
end)

AddEventHandler("x_heist_robbery:startTimers",function()
Citizen.CreateThread(function()
    while timers do
    
	Citizen.Wait(1000)
    if timerCount >= 0 then
        timerCount = timerCount - 1
	else
		timers = false
    end
	end
end)
end)

function DrawText(text,x,y)
    SetTextScale(0.35,0.35)
    SetTextColor(255,255,255,255)--r,g,b,a
    SetTextCentre(true)
    SetTextDropshadow(1,0,0,0,200)
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

RegisterNetEvent("x_heist_robbery:startTheEvent") -- Spawning the npc (locations are at config)
AddEventHandler("x_heist_robbery:startTheEvent",function(num,typey)
    while not HasModelLoaded( GetHashKey("s_m_m_valdeputy_01") ) do
        Wait(500)
        RequestModel( GetHashKey("s_m_m_valdeputy_01") )
    end
	local playerPed = PlayerPedId()
	AddRelationshipGroup('NPC')
	AddRelationshipGroup('PlayerPed')
	for k,v in pairs(Config.npcspawn) do
		pedy = CreatePed(GetHashKey("s_m_m_valdeputy_01"),v.x,v.y,v.z,0, true, false, 0, 0)
		SetPedRelationshipGroupHash(pedy, 'NPC')
        GiveWeaponToPed_2(pedy, 0x64356159, 500, true, 1, false, 0.0)
		Citizen.InvokeNative(0x283978A15512B2FE, pedy, true)
		Citizen.InvokeNative(0xF166E48407BAC484, pedy, PlayerPedId(), 0, 0)
		FreezeEntityPosition(pedy, false)
		TaskCombatPed(pedy,playerped, 0, 16)
	end
end)


