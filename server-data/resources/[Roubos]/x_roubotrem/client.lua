

--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_roubotrem")
x_roubotrem = Proxy.getInterface("x_roubotrem")
x_roubotremSv = Tunnel.getInterface("x_roubotrem")
_Tunnel = {}
Tunnel.bindInterface("x_roubotrem", _Tunnel)
--------------------------------------------------------
Config = {}

Config.settings = {
    {
        bombSignalRange = 30.0,
        bombExplosionRadius = 1.0
    }
}

local safe = {
	"S_VAULT_SML_L_VAL01X"
}
function GetPlayers()
	local players = {}

	for i = 0, 31 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, GetPlayerServerId(i))
		end
	end

	return players
end

local _players = GetPlayers()

RegisterNetEvent("gorp:safeforrobbery")
AddEventHandler("gorp:safeforrobbery",function()
		
		TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, false, false, false)
		-- TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true)
		-- https://www.mod-rdr.com/wiki/pages/list-of-rdr2-scenarios/
		local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
		x_roubotremSv.police(x, y, z)
		exports["progressBars"]:startUI(300000, "Violando...")
		Citizen.Wait(300000)
		ClearPedTasks(GetPlayerPed())
		TriggerServerEvent("gorp:robberycomplete")
	end -- function()
) -- AddEventHandler(

RegisterNetEvent("Trem:ToggleNotification2")
AddEventHandler("Trem:ToggleNotification2", function(coords)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	x_roubotremSv.police(x, y, z)
	local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, coords, 5.0) -- LOCAL FIXO
	-- TriggerEvent('chatMessage','Departamento de policia',{65,176,251, 0.54}," Tentativa de Roubo o Trem!",5000)
	Wait(10000)--Time till notify blips dispears, 1 min
	RemoveBlip(blip)
end)

RegisterNetEvent("Trem:ToggleNotification3")
AddEventHandler("Trem:ToggleNotification3", function(coords)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	x_roubotremSv.police(x, y, z)
	local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, coords, 5.0) -- LOCAL FIXO
	----('policia recebeu a notificação do roubo')
	Wait(10000)--Time till notify blips dispears, 1 min
	RemoveBlip(blip)
end)

RegisterNetEvent("Trem:ToggleNotification4")
AddEventHandler("Trem:ToggleNotification4", function(coords)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	x_roubotremSv.police(x, y, z)
	-- local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, coords, 50.0) -- LOCAL FIXO
	TriggerEvent('chatMessage','Departamento de policia',{65,176,251, 0.54}," A ultima localização do ladrão foi aqui!",5000)
	Wait(60000)--Time till notify blips dispears, 1 min
	RemoveBlip(blip)
end)
local cx, cy, cz 
local safe_;
local explodido = false 
local modoColeta = false 
Citizen.CreateThread(function()
	while true do 
		local w = 500
        --("rodando")
		local coords = GetEntityCoords(PlayerPedId())
		for key, value in pairs(safe) do
			 local safe = DoesObjectOfTypeExistAtCoords(coords.x, coords.y, coords.z, 1.0, GetHashKey(value), true)
             if safe then 
                safe_ = GetClosestObjectOfType(coords.x, coords.y, coords.z, 3.0, GetHashKey(value), false, true ,true)
             end
             --(safe)
			if safe then
                --("?")
				w = 1
				local safe = GetEntityCoords(safe)
                if not explodido then 
                    if cx then 
				        DrawText3D(cx, cy, cz, false, "[H] roubar trem. Necessário bomba! ")
                        modoColeta = false 
                    end
                elseif explodido then  
                    DrawText3D(cx, cy, cz, false, "[H] Coletar a grana ")
                    modoColeta = true 
                end
                
                if IsControlJustPressed(0,0x84543902) then
                    if modoColeta then 
                        explodido = false 
                        TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, false, false, false)
                        exports["x_progress"]:startUI(30000, "Pegando Dinheiro...")
                        Citizen.Wait(30000)
                        ClearPedTasksImmediately(PlayerPedId())
                        x_roubotremSv.giveMoney()
                        goto c
                    end
                    if x_roubotremSv.cd() then 
                        TriggerEvent("xFramework:Notify", "negado", "O trem foi roubado recentemente.")
                        goto c 
                    end
                    if not x_roubotremSv.hasNCops() then 
                        TriggerEvent("xFramework:Notify", "negado", "Não há policias em serviço o suficiente")
                        goto c 
                    end
                    if not x_roubotremSv.hasBomba() then 
                        TriggerEvent("xFramework:Notify", "negado", "Você não tem bomba x1")
                        goto c 
                    end
                    cx, cy, cz = coords.x, coords.y, coords.z
                    TriggerEvent("nic_bomb:useBomb")
                    TriggerServerEvent("roubotrem:cd")
                    x_roubotremSv.police(coords.x, coords.y, coords.z)
                    -- TriggerServerEvent("gorp:startrobbery", _players)
                end
			end
		end
        ::c::
		Citizen.Wait(w)
	end
end)

--> Update Prop CoordS()
Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if safe_ then 
            local x, y, z = table.unpack(GetEntityCoords(safe_))
            cx, cy, cz = x, y, z
        end 
    end
end)




-- GLOBAL VARIABLES DECLARATIONS
----------------------------------------------------------------------------------------------------

local detonated, holdingBomb, placed, holdingDetonator, inprogress, pressed = false
local bombProp, detonatorProp, blip
local sprite = -1489164512


RegisterNetEvent('nic_bomb:useBomb')
AddEventHandler('nic_bomb:useBomb', function()
    -- "usebomb"
    if not IsPedRagdoll(PlayerPedId()) and not holdingBomb and not pressed then
        -- "usebomb"
        TriggerEvent("vorp_inventory:CloseInv")
        Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), 1, true)
        TriggerServerEvent("nic_bomb:removeBomb")
        inprogress = true
        pressed = true
        getItemBomb()
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        local animation = "mech_crouch@generic@base"
        local animation2 = "mech_inventory@binoculars"
        local animation3 = "mech_inspection@generic@lh@base"
        local playerPed = PlayerPedId()
        local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_Hand")
        RequestAnimDict(animation) 
        while (not HasAnimDictLoaded(animation)) do 
            Citizen.Wait(100)
        end
        if not pressed and IsControlJustPressed(0, 0xAB62E997) and not IsPedRagdoll(PlayerPedId()) and not holdingBomb then
            TriggerServerEvent("nic_bomb:checkCount")
            --("Equipped Bomb")
        end
        if inprogress then
            if holdingBomb then
                Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), 1, true)
                -- DrawTxt(":", 0.5, 0.08, 0.3, 0.4, true, 181, 204, 242, 250, true)  
                DrawTxt("Pressione MOUSE1 para armar a bomba!", 0.5, 0.10, 0.3, 0.7, true, 199, 215, 0, 200, true)
                DisableControlAction(0, 0xC1989F95, true)
                if IsControlJustPressed(0, 0x07CE1E61) then
                    ClearPedTasksImmediately(PlayerPedId())
                    TaskPlayAnim(playerPed, animation2, "hold", 8.0, -1.0, 120000, 31, 0, true, 0, false, 0, false)
                    TaskPlayAnim(playerPed, animation, "idle", 8.0, -1.0, 120000, 1, 0, true, 0, false, 0, false)
                    Citizen.Wait(1000)
                    DetachEntity(bombProp, true, true)
                    SetEntityCollision(bombProp, true, false)
                    Citizen.InvokeNative(0x9587913B9E772D29, bombProp, true)
                    blip = SET_BLIP_TYPE(bombProp)
                    SetBlipSprite(blip, sprite, 1)
                    Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'Bomb')
                    ClearPedTasks(PlayerPedId())
                    holdingBomb = false
                    placed = true
                    holdingDetonator = true
                elseif IsControlJustPressed(0, 0x4AF4D473) then
                    playKeepkAnimation()
                    TriggerServerEvent("nic_bomb:addBomb")
                    RemoveBlip(blip)
                    DeleteEntity(bombProp)
                    DeleteEntity(detonatorProp)
                    ClearPedTasks(PlayerPedId())
                    holdingBomb = false
                    holdingDetonator = false
                    inprogress = false
                    pressed = false
                end
            end
            if placed then
                if IsPlayerNearBombArea(cx, cy, cz) then
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, cx, cy, cz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 255, 0, 0, 190, false, true, 2, false, false, false, false)
    
                    DrawTxt("Pessione MOUSE1 para ", 0.5, 0.08, 0.3, 0.4, true, 181, 204, 242, 250, true)  
                    DrawTxt("Detonar a bomba", 0.5, 0.10, 0.3, 0.7, true, 199, 215, 0, 200, true)
                    if IsControlJustPressed(0, 0x07CE1E61) and not IsPedRagdoll(PlayerPedId()) then
                        holdDetonator()
                        RemoveBlip(blip)
                        Citizen.Wait(200)
                        for key, value in pairs(Config.settings) do
                            AddExplosion(cx, cy, cz, 23, value.bombExplosionRadius, true, false, true)
                        end
                        explodido = true
                        Citizen.Wait(800)
                        DeleteEntity(bombProp)
                        DeleteEntity(detonatorProp)
                        ClearPedTasks(PlayerPedId())
                        placed = false
                        holdingDetonator = false
                        inprogress = false
                        pressed = false
                    end
                else
                    DrawTxt("Alerta:", 0.5, 0.08, 0.3, 0.4, true, 252, 91, 91, 250, true)  
                    DrawTxt("Sinal fora de alcance", 0.5, 0.10, 0.3, 0.7, true, 255, 0, 0, 200, true)
                end
            else
                if IsControlJustPressed(0, 0x4AF4D473) then
                    playKeepkAnimation()
                    TriggerServerEvent("nic_bomb:addBomb")
                    RemoveBlip(blip)
                    DeleteEntity(bombProp)
                    DeleteEntity(detonatorProp)
                    ClearPedTasks(PlayerPedId())
                    holdingDetonator = false
                    holdingBomb = false
                    inprogress = false
                    pressed = false
                end
            end
            if IsControlJustPressed(0, 0xB238FE0B) or IsControlJustPressed(0, 0x156F7119) or IsEntityDead(PlayerPedId()) or IsPedRagdoll(PlayerPedId()) or IsPedSwimming(PlayerPedId()) then
                if not placed and not holdingDetonator then
                    RemoveBlip(blip)
                    TriggerServerEvent("nic_bomb:addBomb")
                    DeleteEntity(bombProp)
                    DeleteEntity(detonatorProp)
                    ClearPedTasks(PlayerPedId())
                    holdingDetonator = false
                    holdingBomb = false
                    inprogress = false
                    pressed = false
                end
            end
            if IsPlayerNearBomb(cx, cy, cz) and not holdingBomb and placed then
                Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, cx, cy, cz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 255, 0, 0, 190, false, true, 2, false, false, false, false)
            end
        end
	end
end)

function SET_BLIP_TYPE (bombProp)
	return Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, bombProp)
end

function getItemBomb()
    local animation = "mech_inventory@item@fallbacks@tonic_potent@offhand"
    local animation2 = "mech_inventory@binoculars"
    local propName = "p_colognebox01x"
    local playerPed = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(playerPed))
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_Hand")
    RequestAnimDict(animation2) 
    while (not HasAnimDictLoaded(animation2)) do 
        Citizen.Wait(100)
    end
    TaskPlayAnim(playerPed, animation, "use_quick", 8.0, -1.0, 120000, 31, 0, true, 0, false, 0, false)
    Citizen.Wait(1000)
    bombProp = CreateObject(GetHashKey(propName), x, y, z,  true,  true, true)
    AttachEntityToEntity(bombProp, playerPed, boneIndex, 0.12, 0.02, -0.15, -60.0, -20.00, 0.00, true, true, false, true, 1, true)
    TaskPlayAnim(playerPed, animation2, "hold", 8.0, -1.0, 120000, 31, 0, true, 0, false, 0, false)
    holdingBomb = true
end

function IsPlayerNearBomb(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(GetPlayerPed(), 0))
    local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)

    if distance < 4.0 then
        return true
    end
end

function IsPlayerNearBombArea(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(GetPlayerPed(), 0))
    local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)

    for key, value in pairs(Config.settings) do
        if distance < value.bombSignalRange then
            return true
        end
    end
end

-- PLAY DETONATOR ANIMATION FUNCTION
----------------------------------------------------------------------------------------------------

function holdDetonator()
    local animation = "mech_inventory@item@fallbacks@tonic_potent@offhand"
    local animation2 = "mech_inspection@generic@lh@base"
    local propName = "p_camerabox_film01x"
    local playerPed = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(playerPed))
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_L_Hand")
    RequestAnimDict(animation)
    while not HasAnimDictLoaded(animation) do
        Wait(100)
    end
    RequestAnimDict(animation2)
    while not HasAnimDictLoaded(animation2) do
        Wait(100)
    end
    detonatorProp = CreateObject(GetHashKey(propName), x, y, z,  true,  true, true)
    AttachEntityToEntity(detonatorProp, playerPed, boneIndex, 0.10, 0.05, 0.05, 0.0, 0.0, -30.0, true, true, false, true, 1, true)
    TaskPlayAnim(playerPed, animation2, "hold", 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
end

function playKeepkAnimation()
    local animation = "mech_pickup@plant@gold_currant"
    RequestAnimDict(animation)
    while not HasAnimDictLoaded(animation) do
        Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), animation, "stn_long_low_skill_exit", 8.0, -1.0, -1, 31, 0, true, 0, false, 0, false)
    Citizen.Wait(800)
end

-- FUNCTION UTILS
----------------------------------------------------------------------------------------------------

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
   SetTextScale(w, h)
   SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
   SetTextCentre(centre)
   if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
   Citizen.InvokeNative(0xADA9255D, 10);
   DisplayText(str, x, y)
end

function DrawText3D(x, y, z, enableShadow, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end