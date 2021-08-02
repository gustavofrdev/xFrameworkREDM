
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("craftings_elixir")
craftings_elixir = Proxy.getInterface("craftings_elixir")
craftings_elixirSv = Tunnel.getInterface("craftings_elixir")
_Tunnel = {}
Tunnel.bindInterface("craftings_elixir", _Tunnel)
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
function craftAnim()
		local dict  = "amb_camp@world_human_wash_dishes@table@right@female_b@drop_spoon@base"
		local anim = "dropspoon_trans_grabdish"
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do Wait(0) end--:>("loading: try <TRY>>") end
		-- SetEntityCoordsNoOffset(PlayerPedId(), x, y, z)
		exports["x_progress"]:startUI(4000*3+1000, "Coletando...")
		for _ = 1, 3 do 
			TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
			Wait(4000)
	end
end
RegisterNetEvent("elixirblips2")
AddEventHandler("elixirblips2", function() _Tunnel.blip()
end)
function _Tunnel.blip()
	Wait(5000)
	if craftings_elixirSv.bruxaPerm() then 
		local blip = Citizen.InvokeNative(0x554d9d53f696d002, 2033377404,  1182.55, 2035.93, 324.07 )
		SetBlipSprite(blip,-507621590, 1)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Bruxas - Caldeirão ')
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
	{ x = 1182.61, y = 2035.95, z = 324.07 }
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false

function ToggleActionMenu()
	if craftings_elixirSv.bruxaPerm() then 
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
	else 
		TriggerEvent("xFramework:Notify", "negado", "Você não pode fazer isso")
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	ToggleActionMenu()
	switch(data)
	.case("elixir_vida", function() 
		if craftings_elixirSv.itemQntCheck("camelia") >= 1 
			and craftings_elixirSv.itemQntCheck("primola") >=1
			and craftings_elixirSv.itemQntCheck("gardenia") >=1
			and craftings_elixirSv.itemQntCheck("corpuscularia") >=1 then
				craftAnim()
			craftings_elixirSv.removeItem("camelia", 1)
			craftings_elixirSv.removeItem("primola", 1)
			craftings_elixirSv.removeItem("gardenia", 1)
			craftings_elixirSv.removeItem("corpuscularia", 1)
			local i = craftings_elixirSv.addItem("elixir_vida", 1)
			if i == "fail" then 
				craftings_elixirSv.addItem("camelia", 1)
				craftings_elixirSv.addItem("primola", 1)
				craftings_elixirSv.addItem("gardenia", 1)
				craftings_elixirSv.addItem("corpuscularia", 1)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			TriggerEvent("xFramework:Notify", "negado", "Você não tem os itens para craftar!")
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		end
	end)
	.case("elixir_morte", function() 
		if craftings_elixirSv.itemQntCheck("veneno_cobra") >= 1 
			and craftings_elixirSv.itemQntCheck("bloodmary") >=1
			and craftings_elixirSv.itemQntCheck("heleboro") >=1
			and craftings_elixirSv.itemQntCheck("gerbera") >=1 then
				craftAnim()
			craftings_elixirSv.removeItem("veneno_cobra", 1)
			craftings_elixirSv.removeItem("bloodmary", 1)
			craftings_elixirSv.removeItem("heleboro", 1)
			craftings_elixirSv.removeItem("gerbera", 1)
			local i = craftings_elixirSv.addItem("elixir_morte", 1)
			if i == "fail" then 
				craftings_elixirSv.addItem("veneno_cobra", 1)
				craftings_elixirSv.addItem("bloodmary", 1)
				craftings_elixirSv.addItem("heleboro", 1)
				craftings_elixirSv.addItem("gerbera", 1)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			TriggerEvent("xFramework:Notify", "negado", "Você não tem os itens para craftar!")
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		end
	end)

	.case("elixir_energia", function() 
		if craftings_elixirSv.itemQntCheck("camelia") >= 1 
			and craftings_elixirSv.itemQntCheck("dalia") >=1
			and craftings_elixirSv.itemQntCheck("violetta") >=1 then
				craftAnim()
			craftings_elixirSv.removeItem("camelia", 1)
			craftings_elixirSv.removeItem("dalia", 1)
			craftings_elixirSv.removeItem("violetta", 1)
			local i = craftings_elixirSv.addItem("elixir_energia", 1)
			if i == "fail" then 
				craftings_elixirSv.addItem("camelia", 1)
				craftings_elixirSv.addItem("dalia", 1)
				craftings_elixirSv.addItem("violetta", 1)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			TriggerEvent("xFramework:Notify", "negado", "Você não tem os itens para craftar!")
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		end
	end)

	.case("veruns_morthari", function() 
		if craftings_elixirSv.itemQntCheck("corpuscularia") >= 1 
			and craftings_elixirSv.itemQntCheck("heleboro") >=1
			and craftings_elixirSv.itemQntCheck("bloodmary") >=1
			and craftings_elixirSv.itemQntCheck("girassol") >=1 then
				craftAnim()
			craftings_elixirSv.removeItem("girassol", 1)
			craftings_elixirSv.removeItem("bloodmary", 1)
			craftings_elixirSv.removeItem("heleboro", 1)
			craftings_elixirSv.removeItem("corpuscularia", 1)
			local i = craftings_elixirSv.addItem("veruns_morthari", 1)
			if i == "fail" then 
				craftings_elixirSv.addItem("corpuscularia", 1)
				craftings_elixirSv.addItem("heleboro", 1)
				craftings_elixirSv.addItem("bloodmary", 1)
				craftings_elixirSv.addItem("girassol", 1)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			TriggerEvent("xFramework:Notify", "negado", "Você não tem os itens para craftar!")
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		end
	end)

	.case("atration_tontelle", function() 
		if craftings_elixirSv.itemQntCheck("galantus") >= 1 
			and craftings_elixirSv.itemQntCheck("bloodmary") >=1
			and craftings_elixirSv.itemQntCheck("girassol") >=1
			and craftings_elixirSv.itemQntCheck("violetta") >=1 then
				craftAnim()
			craftings_elixirSv.removeItem("violetta", 1)
			craftings_elixirSv.removeItem("girassol", 1)
			craftings_elixirSv.removeItem("bloodmary", 1)
			craftings_elixirSv.removeItem("galantus", 1)
			local i = craftings_elixirSv.addItem("atration_tontelle", 1)
			if i == "fail" then 
				craftings_elixirSv.addItem("galantus", 1)
				craftings_elixirSv.addItem("bloodmary", 1)
				craftings_elixirSv.addItem("girassol", 1)
				craftings_elixirSv.addItem("violetta", 1)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			TriggerEvent("xFramework:Notify", "negado", "Você não tem os itens para craftar!")
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		end
	end)

	.case("veruns_transformarun", function() 
		if craftings_elixirSv.itemQntCheck("viburno") >= 1 
			and craftings_elixirSv.itemQntCheck("gardenia") >=1 then
				craftAnim()
			craftings_elixirSv.removeItem("viburno", 1)
			craftings_elixirSv.removeItem("gardenia", 1)
			local i = craftings_elixirSv.addItem("veruns_transformarun", 1)
			if i == "fail" then 
				craftings_elixirSv.addItem("viburno", 1)
				craftings_elixirSv.addItem("gardenia", 1)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			TriggerEvent("xFramework:Notify", "negado", "Você não tem os itens para craftar!")
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
		if craftings_elixirSv.itemQntCheck("alecrim") >= 1 and craftings_elixirSv.itemQntCheck("guaco") >=1 and craftings_elixirSv.itemQntCheck("arruda") >=1 then
			craftings_elixirSv.removeItem("alecrim", 1)
			craftings_elixirSv.removeItem("guaco", 1)
			craftings_elixirSv.removeItem("arruda", 1)
			local i = craftings_elixirSv.addItem("tonico_aga_", 1)
			if i == "fail" then 
				craftings_elixirSv.addItem("alecrim", 1)
				craftings_elixirSv.addItem("guaco", 1)
				craftings_elixirSv.addItem("arruda", 1)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			TriggerEvent("xFramework:Notify", "negado", "Você não tem os itens para craftar!")
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		end
	end)
	.case("tonico_gh_", function()
		if craftings_elixirSv.itemQntCheck("guaco") >= 1 and craftings_elixirSv.itemQntCheck("hortela") >=1 then
			craftings_elixirSv.removeItem("guaco", 1)
			craftings_elixirSv.removeItem("hortela", 1)
			local i = craftings_elixirSv.addItem("tonico_gh_", 1)
			if i == "fail" then 
				craftings_elixirSv.addItem("guaco", 1)
				craftings_elixirSv.addItem("hortela", 1)
			end
			SetNuiFocus(false)
			SendNUIMessage({ hidemenu = true })
			menuactive = false 
			onmenu = false
		else
			TriggerEvent("xFramework:Notify", "negado", "Você não tem os itens para craftar!")
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

function telaZoada()
	Citizen.InvokeNative(0x4102732DF6B4005F,"PlayerDrunk01",0, true)
	Wait(30000)
	Citizen.InvokeNative(0xB4FD7446BAB2F394 , "PlayerDrunk01")

end
-- Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,100)
RegisterNetEvent("elixir")
AddEventHandler("elixir", function(tonico)
	--(tonico)
	switch(tonico)
	.case("vida", function()
		local add = 50
		drinkinganim()
		Wait(300)
		exports["x_progress"]:startUI(30000, "")
		ClearPedTasks(PlayerPedId())
		local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
		NetworkResurrectLocalPlayer(x, y, z , 90.0, true, false)
		Citizen.InvokeNative( 0xC6258F41D86676E0 , PlayerPedId(), 0 ,100)
		telaZoada()
	end)
	.case("morte", function()
		local add = 50
		drinkinganim()
		Wait(300)
		exports["x_progress"]:startUI(30000, "")
		SetEntityHealth(PlayerPedId(), 0)
		telaZoada()
	end)
	.case("energia", function()
		local add = 50
		drinkinganim()
		Wait(300)
		exports["x_progress"]:startUI(20000, "")
		-- SetEntityHealth(PlayerPedId(), 0)
		local seconds_infinite = 20000
		RestorePlayerStamina(PlayerId(), 1.0)
		-- telaZoada()
		while seconds_infinite > 0 do 
			seconds_infinite = seconds_infinite - 13
			RestorePlayerStamina(PlayerId(), 1.0)
			Wait(0)
		end
	end)
	.case("ficticio", function()
		drinkinganim()
		Wait(300)
		telaZoada()
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


