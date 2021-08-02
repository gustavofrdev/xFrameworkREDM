
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("craftings_armasBando")
craftings_armasBando = Proxy.getInterface("craftings_armasBando")
craftings_armasBandoSv = Tunnel.getInterface("craftings_armasBando")
_Tunnel = {}
Tunnel.bindInterface("craftings_armasBando", _Tunnel)
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
	if craftings_armasBandoSv.medPerm() then 
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


	.case("ammo_rifle", function() 
		--:>("aa")
		--:>(craftings_armasBandoSv.itemQntCheck("aroeira"))
		if craftings_armasBandoSv.itemQntCheck("chumbo") >= 2 and craftings_armasBandoSv.itemQntCheck("polvora") >=2 then
			craftings_armasBandoSv.removeItem("polvora", 2)
			craftings_armasBandoSv.removeItem("chumbo", 2)
			local i = craftings_armasBandoSv.addItem(data, 30)
			if i == "fail" then 
				craftings_armasBandoSv.addItem("polvora", 2)
				craftings_armasBandoSv.addItem("chumbo", 2)
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

	.case("ammo_shotgun", function() 
		--:>("aa")
		--:>(craftings_armasBandoSv.itemQntCheck("aroeira"))
		if craftings_armasBandoSv.itemQntCheck("chumbo") >= 1 and craftings_armasBandoSv.itemQntCheck("polvora") >=1 then
			craftings_armasBandoSv.removeItem("polvora", 1)
			craftings_armasBandoSv.removeItem("chumbo", 1)
			local i = craftings_armasBandoSv.addItem(data, 30)
			if i == "fail" then 
				craftings_armasBandoSv.addItem("chumbo", 1)
				craftings_armasBandoSv.addItem("polvora", 1)
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
--[[                                            <li>x2 Zinco</li>
                                            <li>x2 Cobre</li>
                                            <li>x2 Chumbo</li>]]
	.case("weapon_sniperrifle_rollingblock", function() 
		--:>("aa")
		--:>(craftings_armasBandoSv.itemQntCheck("aroeira"))
		if craftings_armasBandoSv.itemQntCheck("zinco") >= 2 and craftings_armasBandoSv.itemQntCheck("cobre") >=2 and craftings_armasBandoSv.itemQntCheck("chumbo") >=2 then
			craftings_armasBandoSv.removeItem("zinco", 2)
			craftings_armasBandoSv.removeItem("chumbo", 2)
			craftings_armasBandoSv.removeItem("cobre", 2)
			local i = craftings_armasBandoSv.addItem(data, 1)
			if i == "fail" then 
				craftings_armasBandoSv.addItem("chumbo", 2)
				craftings_armasBandoSv.addItem("cobre", 2)
				craftings_armasBandoSv.addItem("zinco", 2)
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
	.case("weapon_shotgun_doublebarrel", function() 
		--:>("aa")
		--:>(craftings_armasBandoSv.itemQntCheck("aroeira"))
		if craftings_armasBandoSv.itemQntCheck("zinco") >= 1 and craftings_armasBandoSv.itemQntCheck("cobre") >=1 and craftings_armasBandoSv.itemQntCheck("chumbo") >=1 then
			craftings_armasBandoSv.removeItem("zinco", 1)
			craftings_armasBandoSv.removeItem("chumbo", 1)
			craftings_armasBandoSv.removeItem("cobre", 1)
			local i = craftings_armasBandoSv.addItem(data, 1)
			if i == "fail" then 
				craftings_armasBandoSv.addItem("chumbo", 1)
				craftings_armasBandoSv.addItem("cobre", 1)
				craftings_armasBandoSv.addItem("zinco", 1)
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
RegisterNetEvent("OpenBandos-Farm")
AddEventHandler("OpenBandos-Farm", function()
	ToggleActionMenu()
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
--> Uso dos itens <--

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


