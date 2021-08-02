
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("craftings_ensopados")
craftings_ensopados = Proxy.getInterface("craftings_ensopados")
craftings_ensopadosSv = Tunnel.getInterface("craftings_ensopados")
_Tunnel = {}
Tunnel.bindInterface("craftings_ensopados", _Tunnel)
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

function craftAnim()
	local Dict  = "script_re@moonshine_camp@initial@male_b@crouch"
    local Anim = "idle_a"
   RequestAnimDict(Dict)
   while not HasAnimDictLoaded(Dict) do Wait(0) print("loading: try <TRY>>") end
   TaskPlayAnim(PlayerPedId(), Dict, Anim, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
   exports["x_progress"]:startUI(5000, "criando ensopado...")
   Wait(5000)

end
-- RegisterCommand("testanim", function()
-- craftAnim()
-- end)
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	ToggleActionMenu()
	switch(data)
	.case("ensopado_javali", function() 
		--:>("aa")
		--:>(craftings_ensopadosSv.itemQntCheck("aroeira"))
		if craftings_ensopadosSv.itemQntCheck("item_javali") >= 1 and craftings_ensopadosSv.itemQntCheck("cogumelo") >=1 then
			craftings_ensopadosSv.removeItem("cogumelo", 1)
			craftings_ensopadosSv.removeItem("item_javali", 1)
			craftAnim()
			local i = craftings_ensopadosSv.addItem(data, 1)
			if i == "fail" then 
				craftings_ensopadosSv.addItem("item_javali", 1)
				craftings_ensopadosSv.addItem("cogumelo", 1)
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
			TriggerEvent("xFramework:Notify", "negado", 'Você não tem os itens para fazer esse ensopado')
		end
	end)
	.case("ensopado_pato", function()
		if craftings_ensopadosSv.itemQntCheck("item_pato") >= 1 and craftings_ensopadosSv.itemQntCheck("cacto") >=1 then
			craftings_ensopadosSv.removeItem("cacto", 1)
			craftings_ensopadosSv.removeItem("item_pato", 1)
			craftAnim()
			local i = craftings_ensopadosSv.addItem(data, 1)
			if i == "fail" then 
				craftings_ensopadosSv.addItem("cacto", 1)
				craftings_ensopadosSv.addItem("item_pato", 1)
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
			TriggerEvent("xFramework:Notify", "negado", 'Você não tem os itens para fazer esse ensopado')
		end
	end)
	.case("ensopado_peru", function()
		if craftings_ensopadosSv.itemQntCheck("item_meat_turkey") >= 1 and craftings_ensopadosSv.itemQntCheck("cogumelo") >=1 then
			craftings_ensopadosSv.removeItem("item_meat_turkey", 1)
			craftings_ensopadosSv.removeItem("cogumelo", 1)
			craftAnim()
			local i = craftings_ensopadosSv.addItem(data, 1)
			if i == "fail" then 
				craftings_ensopadosSv.addItem("item_meat_turkey", 1)
				craftings_ensopadosSv.addItem("cogumelo", 1)
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
			TriggerEvent("xFramework:Notify", "negado", 'Você não tem os itens para fazer esse ensopado')
		end
	end)
	.case("ensopado_frango", function()
		if craftings_ensopadosSv.itemQntCheck("item_frango") >= 1 and craftings_ensopadosSv.itemQntCheck("milho") >=1 then
			craftings_ensopadosSv.removeItem("item_frango", 1)
			craftings_ensopadosSv.removeItem("milho", 1)
			craftAnim()
			local i = craftings_ensopadosSv.addItem(data, 1)
			if i == "fail" then 
				craftings_ensopadosSv.addItem("item_frango", 1)
				craftings_ensopadosSv.addItem("milho", 1)
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
			TriggerEvent("xFramework:Notify", "negado", 'Você não tem os itens para fazer esse ensopado')
		end
	end)

	.case("ensopado_iguana", function()
		if craftings_ensopadosSv.itemQntCheck("item_iguana_verde") >= 1 and craftings_ensopadosSv.itemQntCheck("milho") >=1 then
			craftings_ensopadosSv.removeItem("item_iguana_verde", 1)
			craftings_ensopadosSv.removeItem("cenoura", 1)
			craftAnim()
			local i = craftings_ensopadosSv.addItem(data, 1)
			if i == "fail" then 
				craftings_ensopadosSv.addItem("item_iguana_verde", 1)
				craftings_ensopadosSv.addItem("cenoura", 1)
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
			TriggerEvent("xFramework:Notify", "negado", 'Você não tem os itens para fazer esse ensopado')
		end
	end)
	.case("ensopado_iguana", function()
		if craftings_ensopadosSv.itemQntCheck("item_meat_angus") >= 1 and craftings_ensopadosSv.itemQntCheck("milho") >=1 then
			craftings_ensopadosSv.removeItem("item_meat_angus", 1)
			craftings_ensopadosSv.removeItem("cacto", 1)
			craftAnim()
			local i = craftings_ensopadosSv.addItem(data, 1)
			if i == "fail" then 
				craftings_ensopadosSv.addItem("item_meat_angus", 1)
				craftings_ensopadosSv.addItem("cacto", 1)
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
			TriggerEvent("xFramework:Notify", "negado", 'Você não tem os itens para fazer esse ensopado')
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
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local nearFogueira = GetClosestObjectOfType(x, y, z, 3.0, GetHashKey("p_campfirecombined03x"), false, true ,true)
    		if nearFogueira ~= 0  and not onmenu then 
				nearFogueira = GetEntityCoords(nearFogueira)
				W = 1
				_DrawText3D( nearFogueira.x, nearFogueira.y, nearFogueira.z-1, "Pressione ~e~[R]~p~ para abrir crafts de ensopado\n caso queira apenas cozinhar uma carne, use-a no inventário.")
				if IsControlJustPressed(0,0xE30CD707) then
					ToggleActionMenu()
				end
			end
		Citizen.Wait(W)
	end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

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


