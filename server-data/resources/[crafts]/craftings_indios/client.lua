
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("craftings_indios")
craftings_indios = Proxy.getInterface("craftings_indios")
craftings_indiosSv = Tunnel.getInterface("craftings_indios")
_Tunnel = {}
Tunnel.bindInterface("craftings_indios", _Tunnel)
--------------------------------------------------------
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
		local_ = {-1619.15, 416.35, 107.11 },
		chanceDb = {[1] = {item = "madeira", chance = 100 },}
		
	},
	{
		hasFruto = true,
		chance = 10,
		local_ = {-1117.56, 129.06, 47.74 },
		chanceDb = {[1] = {item = "zinco", chance = 100 },}
		
	},
	{
		hasFruto = true,
		chance = 10,
		local_ = {-2592.64, 408.21, 148.99},
		chanceDb = {[1] = {item = "cobre", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {313.91, 1182.21, 181.76},
		chanceDb = {[1] = {item = "madeira", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {1421.67, 221.32, 91.59 },
		chanceDb = {[1] = {item = "madeira", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {-3032.25, -2611.45, 84.76 },
		chanceDb = {[1] = {item = "madeira", chance = 100 },}
		
	},
	{
		hasFruto = true,
		chance = 10,
		local_ = {499.59, 677.91, 117.56 },
		chanceDb = {[1] = {item = "chumbo", chance = 100 },}
		
	},
	{
		hasFruto = true,
		chance = 10,
		local_ = {1885.48, -1342.86, 42.61},
		chanceDb = {[1] = {item = "polvora", chance = 100 },}
		
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
		if v.chanceDb[1].item == "madeira" then 
			blip[k] = Citizen.InvokeNative(0x554D9D53F696D002,1664425300, v.local_[1], v.local_[2], v.local_[3]) 
			--v.local_[1], v.local_[2], v.local_[3])
			SetBlipSprite(blip[k],1904459580,true)
			SetBlipScale(blip[k],0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], "Bandos -  Coleta de galhos")
		elseif v.chanceDb[1].item == "polvora" then 
			blip[k] = Citizen.InvokeNative(0x554D9D53F696D002,1664425300, v.local_[1], v.local_[2], v.local_[3]) 
			--v.local_[1], v.local_[2], v.local_[3])
			SetBlipSprite(blip[k],1321928545,true)
			SetBlipScale(blip[k],0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], "Bandos -  Coleta de pólvora")
		elseif v.chanceDb[1].item == "cobre" then 
			blip[k] = Citizen.InvokeNative(0x554D9D53F696D002,1664425300, v.local_[1], v.local_[2], v.local_[3]) 
			--v.local_[1], v.local_[2], v.local_[3])
			SetBlipSprite(blip[k],1321928545,true)
			SetBlipScale(blip[k],0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], "Bandos -  Coleta de Cobre")
		elseif v.chanceDb[1].item == "zinco" then 
			blip[k] = Citizen.InvokeNative(0x554D9D53F696D002,1664425300, v.local_[1], v.local_[2], v.local_[3]) 
			--v.local_[1], v.local_[2], v.local_[3])
			SetBlipSprite(blip[k],1321928545,true)
			SetBlipScale(blip[k],0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], "Bandos -  Coleta de Zinco")
		else 
			blip[k] = Citizen.InvokeNative(0x554D9D53F696D002,1664425300, v.local_[1], v.local_[2], v.local_[3]) 
			--v.local_[1], v.local_[2], v.local_[3])
			SetBlipSprite(blip[k],-758970771,true)
			SetBlipScale(blip[k],0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], "Bandos -  Coleta de chumbo")
		end
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
			local l=v.chanceDb[1].item
			if l == "madeira" then l = "galho de madeira" end
			-- if l == "c" then l = "galho de madeira" end
			_DrawText3D( v.local_[1], v.local_[2], v.local_[3]-1, "Pressione ~e~[R]~p~ para coletar ".. l)
				if IsControlJustPressed(0,0xE30CD707) then
                    local adaptacao = true 
					if adaptacao then 	
						local ar_stamp = craftings_indiosSv.getArbustoStamp(k)
						local cur_stamp = craftings_indiosSv.currentServerTimeStamp()
                        --ar_stamp, cur_stamp)
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
							TriggerAnim(v.local_[1], v.local_[2], v.local_[3], v.chanceDb[key].item)
							--:>('sel_item ==> '..v.chanceDb[key].item)
							craftings_indiosSv.giveItem(v.chanceDb[key].item)
							craftings_indiosSv.set(k)
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
function TriggerAnim(x, y, z, item)
   local dict  = "amb_camp@world_human_wash_dishes@table@right@female_b@drop_spoon@base"
   local anim = "dropspoon_trans_grabdish"
   --:>("trigger<sucess>")
   RequestAnimDict(dict)
   while not HasAnimDictLoaded(dict) do Wait(0) end--:>("loading: try <TRY>>") end
   SetEntityCoordsNoOffset(PlayerPedId(), x, y, z)
   if item == "madeira" then 
    exports["x_progress"]:startUI(4000*3+1000, "Coletando galho...")
   elseif item == "polvora" then 
	exports["x_progress"]:startUI(4000*3+1000, "Coletando e refinando polvora...")
	elseif item == "zinco" then 
	exports["x_progress"]:startUI(4000*3+1000, "Coletando zinco...")
	elseif item == "cobre" then 
	exports["x_progress"]:startUI(4000*3+1000, "Coletando cobre...")
   else
	exports["x_progress"]:startUI(4000*3+1000, "Coletando chumbo da forja")
   end
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
function switch(element)
	local Table = {
	  ["Value"] = element,
	  ["DefaultFunction"] = nil,
	  ["Functions"] = {}
	}
	
	Table.case = function(testElement, callback)
	  Table.Functions[testElement] = callback
	  return Table
	end
	
	Table.default = function(callback)
	  Table.DefaultFunction = callback
	  return Table
	end
	
	Table.process = function()
	  local Case = Table.Functions[Table.Value]
	  if Case then
		Case()
	  elseif Table.DefaultFunction then
		Table.DefaultFunction()
	  end
	end
	
	return Table
  end

-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-- local local_craft = {
-- 	{ x = -288.81, y = 808.82, z = 119.49 }
-- }
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false

function ToggleActionMenu()
	if craftings_indiosSv.medPerm() then 
		menuactive = not menuactive
		onmenu = true
		if menuactive then
			SetNuiFocus(true,true)
			-- TransitionToBlurred(1000)
			SendNUIMessage({ showmenu = true })
		else
			SetNuiFocus(false)
			-- TransitionFromBlurred(1000)
			SendNUIMessage({ hidemenu = true })
		end
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	ToggleActionMenu()
	switch(data)
	.case("weapon_bow_improved", function() 
		--:>("aa")
		--:>(craftings_indiosSv.itemQntCheck("aroeira"))
		if craftings_indiosSv.itemQntCheck("madeira") >= 1 and craftings_indiosSv.itemQntCheck("pena") >=1 then
			craftings_indiosSv.removeItem("madeira", 1)
			craftings_indiosSv.removeItem("pena", 1)
			local i = craftings_indiosSv.addItem("weapon_bow_improved", 1)
			if i == "fail" then 
				craftings_indiosSv.addItem("pena", 1)
				craftings_indiosSv.addItem("madeira", 1)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		end
	end)

	.case("weapon_melee_hatchet_double_bit", function() 
		--:>("aa")
		--:>(craftings_indiosSv.itemQntCheck("aroeira"))
		if craftings_indiosSv.itemQntCheck("madeira") >= 1 and craftings_indiosSv.itemQntCheck("chumbo") >=1 then
			craftings_indiosSv.removeItem("madeira", 1)
			craftings_indiosSv.removeItem("chumbo", 1)
			local i = craftings_indiosSv.addItem("weapon_melee_hatchet_double_bit", 1)
			if i == "fail" then 
				craftings_indiosSv.addItem("chumbo", 1)
				craftings_indiosSv.addItem("madeira", 1)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		end
	end)

	.case("ammo_arrow_dynamite", function() 
		--:>("aa")
		--:>(craftings_indiosSv.itemQntCheck("aroeira"))
		if craftings_indiosSv.itemQntCheck("polvora") >= 2 and craftings_indiosSv.itemQntCheck("pena") >=2 then
			craftings_indiosSv.removeItem("polvora", 2)
			craftings_indiosSv.removeItem("pena", 2)
			local i = craftings_indiosSv.addItem("ammo_arrow_dynamite", 1)
			if i == "fail" then 
				craftings_indiosSv.addItem("pena", 2)
				craftings_indiosSv.addItem("polvora", 2)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		end
	end)

	.case("ammo_arrow_fire", function() 
		--:>("aa")
		--:>(craftings_indiosSv.itemQntCheck("aroeira"))
		if craftings_indiosSv.itemQntCheck("polvora") >= 1 and craftings_indiosSv.itemQntCheck("pena") >=1 then
			craftings_indiosSv.removeItem("polvora", 1)
			craftings_indiosSv.removeItem("pena", 1)
			local i = craftings_indiosSv.addItem("ammo_arrow_fire", 1)
			if i == "fail" then 
				craftings_indiosSv.addItem("pena", 1)
				craftings_indiosSv.addItem("polvora", 1)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		end
	end)


	.case("fechar", function()
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false 
		onmenu = false 
	end)
	.default(function() 
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false 
		onmenu = false
	end)
	.process()
end)

-------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNetEvent("OpenIndios-Farm")
AddEventHandler("OpenIndios-Farm", function()
	ToggleActionMenu()
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
--> Uso dos itens <--
function drinkinganim()
    local ped = PlayerPedId()
    if IsPedMale(ped) then
		exports["x_progress"]:startUI(10000, "Bebendo...")
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_DRINK_FLASK'), 10000, true, false, false, false)
        Wait(10000)
        ClearPedTasksImmediately(PlayerPedId())
    else
      -- FEMALE SCENARIO
	  	exports["x_progress"]:startUI(10000, "Bebendo...")
	    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_PLAYER_DRINK_WITCHES_BREW'), 60000, true, false, false, false)
        Wait(10000)
        ClearPedTasksImmediately(PlayerPedId())
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


