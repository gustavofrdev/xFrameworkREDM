
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
FrameworkCL = Proxy.getInterface('_xFramework')
FrameworkSV = Tunnel.getInterface('_xFramework')
x_bankrobbery = Proxy.getInterface('x_bankrobbery')
x_bankrobberySv = Tunnel.getInterface('x_bankrobbery')
_Tunnel = {}
local explodido = false 
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(tipo,texto)
	TriggerEvent("xFramework:Notify", "aviso", texto, 5000)
end)
Config = {}

Config.settings = {
    {
        bombSignalRange = 30.0,
        bombExplosionRadius = 1.0
    }
}

local bank_locations = {
	{id = 1,x=-308.821, y=765.25799, z=118.65311, dinheiro = 100,  mensagem = "Pressione ENTER para roubar este banco"},
	{id = 2, x=2833.13793994531,y=-1311.8519287109,z= 46.755668640137, dinheiro = 100,  mensagem = "Pressione ENTER para roubar esta loja" },
	{id = 3, x=-3687.3471679688,y=-2622.3266601563,z=-13431160926819, dinheiro = 100,  mensagem = "Pressione ENTER para roubar esta loja", },
	{id = 4, x=-5518.7983398438,y=-2906.6804199219,z=-1.7513055801392, dinheiro = 100,  mensagem = "Pressione ENTER para roubar o saloon", },
	{id = 5, x=2643.1379, y=-1306.823,z= 52.196, dinheiro = 100,  mensagem = "Pressione ENTER para roubar este banco",  },
	{id = 6, x=3288.3530273438,y=-1307.8438720703,z=51.713188171387, dinheiro = 100,  mensagem = "Pressione ENTER para roubar este barco", },
    {id = 7,x = 1287.67, y = -1314.9, z = 77.14, dinheiro = 100,  mensagem = "Pressione ENTER para roubar este banco"},
}
local act_values;

StartRobbing = {}
local robbing = false

-- RegisterNetEvent('StartRobbing')
-- AddEventHandler('StartRobbing', function(values)	
--     local ped = PlayerPedId()
-- 	local coords = GetEntityCoords(ped)
-- 	local _cb = true 
-- 	if _cb == true then 
-- 	if robbing == false then
-- 		ouro = values.ouro; dinheiro = values.dinheiro
		
--         TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
-- 		robbing = true
-- 	   TriggerEvent("Notify","sucesso","Você iniciou o roubo com sucesso",500)
--         Citizen.Wait(35000)
--         ClearPedTasksImmediately(PlayerPedId())
-- 		ClearPedSecondaryTask(PlayerPedId())
-- 		robbing = false
-- 			TriggerServerEvent("__::pay::___",values) -- add gold/money
-- 		end
-- 	end
-- end)

-- Citizen.CreateThread(function()
-- 	while true do 
-- 		local w = 500
-- 		if explodido and act_values then 
-- 			w = 1 
-- 			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), act_values.x, act_values.y, act_values.z, true) < 4

-- 		end
-- 		Citizen.Wait(w)
-- 	end
-- end )	

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

-- bank 1
local cx, cy, cz
local act_values;
local modoRoubo = false 
Citizen.CreateThread(function()
    while true do
		local w = 500
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		for k,v in pairs(bank_locations) do 
		local betweencoords = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) --val
		if betweencoords < 2.0 then
			w = 1 
			if not modoRoubo then 
			DrawTxt(v.mensagem, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			elseif explodido then 
				DrawTxt("[ENTER] pegar dinheiro", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
			end
			if IsControlJustReleased(0, 0xC7B5340A) then	
                if not x_bankrobberySv.hasNCops() then 
                    TriggerEvent("Notify","negado","Não há oficiais o suficiente",500)
                    goto c 
                end	
				if x_bankrobberySv.cd(v.id) and not modoRoubo then 
					TriggerEvent("Notify","negado","Cofres vazios. Volte novamente mais tarde.",500)
					goto c 
				end
				if explodido then 
					TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
					exports["x_progress"]:startUI(30000, "Pegando dinheiro")
					Wait(30000)
					TriggerServerEvent("__::pay::___",v)
					ClearPedTasksImmediately(PlayerPedId())
					modoRoubo = false
					explodido = false 
					goto c 
				end
				if not x_bankrobberySv.Bomba() then 
					TriggerEvent("Notify","negado","Você precisa de uma bomba",500)
					goto c 
				end
				if not modoRoubo then
					local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
					TriggerServerEvent("sendCops", x, y, z)
					TriggerEvent("bomba_this:useBomb")
					act_values = v
					cx, cy, cz = x, y, z
					modoRoubo = true
					TriggerServerEvent("bankrob:cd", v.id)
					end 
				end
			end
		end
		::c::
		Citizen.Wait(w)
	end
end)



-- GLOBAL VARIABLES DECLARATIONS
----------------------------------------------------------------------------------------------------

local detonated, holdingBomb, placed, holdingDetonator, inprogress, pressed = false
local bombProp, detonatorProp, blip
local sprite = -1489164512


RegisterNetEvent('bomba_this:useBomb')
AddEventHandler('bomba_this:useBomb', function()
    -- "usebomb"
    if not IsPedRagdoll(PlayerPedId()) and not holdingBomb and not pressed then
        -- "usebomb"
        TriggerEvent("vorp_inventory:CloseInv")
        Citizen.InvokeNative(0xFCCC886EDE3C63EC, PlayerPedId(), 1, true)
        TriggerServerEvent("bomba_this:removeBomb")
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
            TriggerServerEvent("bomba_this:checkCount")
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
                    TriggerServerEvent("bomba_this:addBomb")
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
						TriggerEvent("StartRobbing", act_values)
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
                    TriggerServerEvent("bomba_this:addBomb")
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
                    TriggerServerEvent("bomba_this:addBomb")
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