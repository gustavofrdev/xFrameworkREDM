
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("craftings_garimpo")
craftings_garimpo = Proxy.getInterface("craftings_garimpo")
craftings_garimpoSv = Tunnel.getInterface("craftings_garimpo")
_Tunnel = {}
Tunnel.bindInterface("craftings_garimpo", _Tunnel)
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

local blip = {}
Citizen.CreateThread(function()
        -->(v[1], v[2], v[3])
        blip = Citizen.InvokeNative(0x554d9d53f696d002, 2033377404,  483.86, 680.18, 117.41 )
        SetBlipSprite(blip, -1944395098	, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Fundição')
    
end)

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
	{ x = 483.86, y = 680.18, z = 117.41 }
}
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false

function ToggleActionMenu()
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
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	ToggleActionMenu()
	switch(data)
	.case("fechar", function()
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		menuactive = false 
		onmenu = false 
	end)
	.case("ouro_f", function()
		--"ouro_f")
		if craftings_garimpoSv.itemQntCheck("ouro_bruto") >= 1 and craftings_garimpoSv.itemQntCheck("mercurio") >=1  then
			craftings_garimpoSv.removeItem("ouro_bruto", 1)
			craftings_garimpoSv.removeItem("mercurio", 1)
			local i = craftings_garimpoSv.addItem("ouro", 1)
			if i == "fail" then 
				craftings_garimpoSv.addItem("ouro_bruto", 1)
				craftings_garimpoSv.addItem("mercurio", 1)
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
	.case("diamante_f", function()
		if craftings_garimpoSv.itemQntCheck("diamante_bruto") >= 1 and craftings_garimpoSv.itemQntCheck("mercurio") >=1  then
			craftings_garimpoSv.removeItem("diamante_bruto", 1)
			craftings_garimpoSv.removeItem("mercurio", 1)
			local i = craftings_garimpoSv.addItem("diamante", 1)
			if i == "fail" then 
				craftings_garimpoSv.addItem("diamante_bruto", 1)
				craftings_garimpoSv.addItem("mercurio", 1)
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
	.case("painita_f", function()
		if craftings_garimpoSv.itemQntCheck("painita_bruto") >= 1 and craftings_garimpoSv.itemQntCheck("mercurio") >=1  then
			craftings_garimpoSv.removeItem("painita_bruto", 1)
			craftings_garimpoSv.removeItem("mercurio", 1)
			local i = craftings_garimpoSv.addItem("painita", 1)
			if i == "fail" then 
				craftings_garimpoSv.addItem("painita_bruto", 1)
				craftings_garimpoSv.addItem("mercurio", 1)
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
	.case("prata_f", function()
		if craftings_garimpoSv.itemQntCheck("prata_bruto") >= 1 and craftings_garimpoSv.itemQntCheck("mercurio") >=1  then
			craftings_garimpoSv.removeItem("prata_bruto", 1)
			craftings_garimpoSv.removeItem("mercurio", 1)
			local i = craftings_garimpoSv.addItem("prata", 1)
			if i == "fail" then 
				craftings_garimpoSv.addItem("prata_bruto", 1)
				craftings_garimpoSv.addItem("mercurio", 1)
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


