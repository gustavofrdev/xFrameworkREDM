
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("craftings_medico")
craftings_medico = Proxy.getInterface("craftings_medico")
craftings_medicoSv = Tunnel.getInterface("craftings_medico")
_Tunnel = {}
Tunnel.bindInterface("craftings_medico", _Tunnel)
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
		local_ = {1221.23, 1941.6, 309.22},
		chanceDb = {
			[1] = {item = "alecrim", chance = 2 },
			[2] = {item = 'aroeira', chance = 83},
			[3] = {item = 'boldo',   chance = 85},
			[4] = {item = 'hortela', chance = 87},
			[5] = {item = 'guaco',   chance = 7 },
			[6] = {item = 'arruda',  chance = 6 }

		}
		
	},
	{
		hasFruto = true,
		chance = 90,
		local_ = {-1310.97, 1068.72, 182.55},
		chanceDb = {
			[1] = {item ='alecrim', chance =   7},
			[2] = {item ='aroeira', chance =  80},
			[3] = {item ='boldo',   chance =  83},
			[4] = {item ='hortela', chance =  85},
			[5] = {item ='guaco',   chance =   2},
			[6] = {item ='arruda',  chance =   5}
		} 
	},
	{
		hasFruto = true,
		chance = 50,
		local_ = {-5788.53, -3118.72, 3.11},
		chanceDb = {
			[1] = {item = 'alecrim', chance =  1},
			[2] = {item = 'aroeira', chance = 83},
			[3] = {item = 'boldo',  chance = 70},
			[4] = {item = 'hortela', chance = 55},
			[5] = {item = 'guaco',  chance =  3},
			[6] = {item = 'arruda',  chance =  8}
		}
	}
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
        blip[k] = Citizen.InvokeNative(0x554d9d53f696d002, 2033377404, v.local_[1], v.local_[2], v.local_[3])
        SetBlipSprite(blip[k], -1944395098	, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], 'Ervas')
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
			_DrawText3D( v.local_[1], v.local_[2], v.local_[3]-1, "Pressione ~e~[R]~p~ para colher ervas")
				if IsControlJustPressed(0,0xE30CD707) then
					if craftings_medicoSv.medPerm() then 	
						local ar_stamp = craftings_medicoSv.getArbustoStamp(k)
						local cur_stamp = craftings_medicoSv.currentServerTimeStamp()
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
							craftings_medicoSv.giveItem(v.chanceDb[key].item)
							craftings_medicoSv.set(k)
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
local local_craft = {
	{ x= 2722.94, y= -1229.45, z= 50.17 }
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false

function ToggleActionMenu()
	if craftings_medicoSv.medPerm() then 
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
	.case("tonico_aa_", function() 
		--:>("aa")
		--:>(craftings_medicoSv.itemQntCheck("aroeira"))
		if craftings_medicoSv.itemQntCheck("aroeira") >= 1 and craftings_medicoSv.itemQntCheck("alecrim") >=1 then
			craftings_medicoSv.removeItem("aroeira", 1)
			craftings_medicoSv.removeItem("alecrim", 1)
			local i = craftings_medicoSv.addItem("tonico_aa_", 1)
			if i == "fail" then 
				craftings_medicoSv.addItem("aroeira", 1)
				craftings_medicoSv.addItem("alecrim", 1)
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
	.case("tonico_ar_", function()
		if craftings_medicoSv.itemQntCheck("aroeira") >= 1 and craftings_medicoSv.itemQntCheck("arruda") >=1 then
			craftings_medicoSv.removeItem("aroeira", 1)
			craftings_medicoSv.removeItem("arruda", 1)
			local i = craftings_medicoSv.addItem("tonico_ar_", 1)
			if i == "fail" then 
				craftings_medicoSv.addItem("aroeira", 1)
				craftings_medicoSv.addItem("arruda", 1)
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
	.case("tonico_ga_", function()
		if craftings_medicoSv.itemQntCheck("guaco") >= 1 and craftings_medicoSv.itemQntCheck("arruda") >=1 then
			craftings_medicoSv.removeItem("guaco", 1)
			craftings_medicoSv.removeItem("arruda", 1)
			local i = craftings_medicoSv.addItem("tonico_ga_", 1)
			if i == "fail" then 
				craftings_medicoSv.addItem("guaco", 1)
				craftings_medicoSv.addItem("arruda", 1)
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
	.case("tonico_ba_", function()
		if craftings_medicoSv.itemQntCheck("boldo") >= 1 and craftings_medicoSv.itemQntCheck("hortela") >=1 then
			craftings_medicoSv.removeItem("boldo", 1)
			craftings_medicoSv.removeItem("hortela", 1)
			local i = craftings_medicoSv.addItem("tonico_ba_", 1)
			if i == "fail" then 
				craftings_medicoSv.addItem("boldo", 1)
				craftings_medicoSv.addItem("hortela", 1)
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
	.case("tonico_aga_", function()
		if craftings_medicoSv.itemQntCheck("alecrim") >= 1 and craftings_medicoSv.itemQntCheck("guaco") >=1 and craftings_medicoSv.itemQntCheck("arruda") >=1 then
			craftings_medicoSv.removeItem("alecrim", 1)
			craftings_medicoSv.removeItem("guaco", 1)
			craftings_medicoSv.removeItem("arruda", 1)
			local i = craftings_medicoSv.addItem("tonico_aga_", 1)
			if i == "fail" then 
				craftings_medicoSv.addItem("alecrim", 1)
				craftings_medicoSv.addItem("guaco", 1)
				craftings_medicoSv.addItem("arruda", 1)
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
	.case("tonico_gh_", function()
		if craftings_medicoSv.itemQntCheck("guaco") >= 1 and craftings_medicoSv.itemQntCheck("hortela") >=1 then
			craftings_medicoSv.removeItem("guaco", 1)
			craftings_medicoSv.removeItem("hortela", 1)
			local i = craftings_medicoSv.addItem("tonico_gh_", 1)
			if i == "fail" then 
				craftings_medicoSv.addItem("guaco", 1)
				craftings_medicoSv.addItem("hortela", 1)
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
Citizen.CreateThread(function()
	while true do
		local W = 500
		

		for k,v in pairs(local_craft) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(v.x,v.y,z,x,y,z,true)
			local local_craft = local_craft[k]
			local idBancada = local_craft[id]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), local_craft.x, local_craft.y, local_craft.z, true ) <= 1 and not onmenu then
				W = 1
				
				_DrawText3D( local_craft.x, local_craft.y, local_craft.z-1, "Pressione ~e~[R]~p~ para abrir crafts")
			end
			if distance <= 15 then
				-- DrawMarker(23, local_craft.x, local_craft.y, local_craft.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,0xE30CD707) then
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(W)
	end
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

RegisterNetEvent("tonicos")
AddEventHandler("tonicos", function(tonico)
	--(tonico)
	switch(tonico)
	.case("tonico_ar_", function()
		local add = 50
		drinkinganim()
		Wait(300)
		exports["x_progress"]:startUI(30000, "")
		ClearPedTasks(PlayerPedId())
		--:>(":: m - a - x :: ")
		--:>(GetEntityMaxHealth(PlayerPedId()))
		if GetEntityHealth(PlayerPedId())+add > 100 then 	
			--:>(" nova vida :: ", 100)
			Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,100)
		end
		Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,GetEntityHealth(PlayerPedId())+add)
		local time = 30000
		Citizen.InvokeNative(0x4102732DF6B4005F,"PlayerDrunk01",0, true) --playdrunk
		Wait(30000)
		--:> "FIM"
		Citizen.InvokeNative(0xB4FD7446BAB2F394 , "PlayerDrunk01")
		Wait(5000)
		--:>(GetEntityHealth(PlayerPedId()))
	end)
	.case("tonico_aa_", function()
		local add = 25
		drinkinganim()
		Wait(300)
		exports["x_progress"]:startUI(10000, "")
		ClearPedTasks(PlayerPedId())
		--:>(":: m - a - x :: ")
		--:>(GetEntityMaxHealth(PlayerPedId()))
		if GetEntityHealth(PlayerPedId())+add > 100 then 	
			--:>(" nova vida :: ", 100)
			Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,100)
		end
		Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,GetEntityHealth(PlayerPedId())+add)
		Citizen.InvokeNative(0x4102732DF6B4005F,"PlayerDrunk01",0, true) --playdrunk
		Wait(10000)
		--:> "FIM"
		Citizen.InvokeNative(0xB4FD7446BAB2F394 , "PlayerDrunk01")
		Wait(5000)
		--:>(GetEntityHealth(PlayerPedId()))
	end)
	.case("tonico_ga_", function()
		local add = 60
		drinkinganim()
		Wait(300)
		exports["x_progress"]:startUI(45000, "")
		ClearPedTasks(PlayerPedId())
		--:>(":: m - a - x :: ")
		--:>(GetEntityMaxHealth(PlayerPedId()))
		if GetEntityHealth(PlayerPedId())+add > 100 then 	
			--:>(" nova vida :: ", 100)
			Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,100)
		end
		Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,GetEntityHealth(PlayerPedId())+add)
		Citizen.InvokeNative(0x4102732DF6B4005F,"PlayerDrunk01",0, true) --playdrunk
		Wait(45000)
		--:> "FIM"
		Citizen.InvokeNative(0xB4FD7446BAB2F394 , "PlayerDrunk01")
		Wait(5000)
		--:>(GetEntityHealth(PlayerPedId()))
	end)
	.case("tonico_ba_", function()
		local add = 30
		drinkinganim()
		Wait(300)
		exports["x_progress"]:startUI(60000, "")
		ClearPedTasks(PlayerPedId())
		--:>(":: m - a - x :: ")
		--:>(GetEntityMaxHealth(PlayerPedId()))
		if GetEntityHealth(PlayerPedId())+add > 100 then 	
			--:>(" nova vida :: ", 100)
			Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,100)
		end
		Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,GetEntityHealth(PlayerPedId())+add)
		Citizen.InvokeNative(0x4102732DF6B4005F,"PlayerDrunk01",0, true) --playdrunk
		Wait(60000)
		--:> "FIM"
		Citizen.InvokeNative(0xB4FD7446BAB2F394 , "PlayerDrunk01")
		Wait(5000)
		--:>(GetEntityHealth(PlayerPedId()))
	end)
	.case("tonico_aga_", function()
		local add = 80
		drinkinganim()
		Wait(300)
		exports["x_progress"]:startUI(60000, "")
		ClearPedTasks(PlayerPedId())
		--:>(":: m - a - x :: ")
		--:>(GetEntityMaxHealth(PlayerPedId()))
		if GetEntityHealth(PlayerPedId())+add > 100 then 	
			--:>(" nova vida :: ", 100)
			Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,100)
		end
		Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,GetEntityHealth(PlayerPedId())+add)
		Citizen.InvokeNative(0x4102732DF6B4005F,"PlayerDrunk01",0, true) --playdrunk
		Wait(60000)
		--:> "FIM"
		Citizen.InvokeNative(0xB4FD7446BAB2F394 , "PlayerDrunk01")
		Wait(5000)
		--:>(GetEntityHealth(PlayerPedId()))
	end)
	.case("tonico_gh_", function()
		local add = 15
		drinkinganim()
		Wait(300)
		exports["x_progress"]:startUI(1, "")
		ClearPedTasks(PlayerPedId())
		--:>(":: m - a - x :: ")
		--:>(GetEntityMaxHealth(PlayerPedId()))
		if GetEntityHealth(PlayerPedId())+add > 100 then 	
			--:>(" nova vida :: ", 100)
			Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,100)
		end
		Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,GetEntityHealth(PlayerPedId())+add)
		Citizen.InvokeNative(0x4102732DF6B4005F,"PlayerDrunk01",0, true) --playdrunk
		Wait(1)
		--:> "FIM"
		Citizen.InvokeNative(0xB4FD7446BAB2F394 , "PlayerDrunk01")
		Wait(5000)
		--:>(GetEntityHealth(PlayerPedId()))
	end)
	.default(function()end)
	.process()
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


