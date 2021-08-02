local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')

x__forcaSV = Tunnel.getInterface('x__forca')
x__forcaCL = Proxy.getInterface('x__forca')
FrameworkSV = Tunnel.getInterface('_xFramework')
FrameworkCL = Proxy.getInterface('_xFramework')

Function = {}
Proxy.addInterface('x__forca', Function)
Tunnel.bindInterface('x__forca', Function)

local PenduActif = false
local TextePendu = false

local forca_positions = {
    {
        x = 3331.94, y = -679.01, z = 48.17-1.2, h = 287.874,
        cx = 3332.63, cy = -678.93, cz = 47.7
    },
    {
        x = 2688.53, y = -1114.0, z = 52.97-1, h =173.926,
        cx = 2688.53, cy = -1114.0, cz = 52.97
    }
}

RegisterCommand('forca', function(source, args, rawCommand)
    local pos = GetEntityCoords(PlayerPedId())
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local player, distance = FrameworkCL.GetNearestPlayer(3)
    for k, v in pairs(forca_positions) do
      print(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z))
      if (Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 5.0) then
          if player > 0 then
              TriggerServerEvent("forca:police", GetPlayerServerId(player), v)
          end
	    end
    end
end)

RegisterNetEvent("forca:go")
AddEventHandler("forca:go", function(target_id, values )
    TriggerServerEvent("forca:pendre", target_id, values )
end)

RegisterNetEvent("forca:joueur")
AddEventHandler("forca:joueur", function(v)
    local ped = PlayerPedId()
    print(json.encode(v))
    if not PenduActif then
        SetEntityCoords(ped, v.cx, v.cy, v.cz)
        FreezeEntityPosition(ped, true)
        SetEntityCoords(ped, v.x, v.y, v.z)
        SetEntityHeading(ped, v.h)
        SetEntityCoords(ped, v.x, v.y, v.z)
        SetEntityHeading(ped, v.h)
        FreezeEntityPosition(ped, true)
		SetEnableHandcuffs(ped, true)
		PlayAnimationM(ped, "script_re@public_hanging@criminal_male", "death_a")
        PenduActif = true
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent("forca:AnimLevier")
AddEventHandler("forca:AnimLevier", function()
    local ped = PlayerPedId()
	PlayAnimationL(ped, "mech_doors@locked@1handed", "knob_r_kick_fail")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()

		if isHandcuffed or isHandcuffed2 or isHandcuffed3 then
		
			DisableControlAction(0, 0xB2F377E8, true) -- Attack
			DisableControlAction(0, 0xC1989F95, true) -- Attack 2
			DisableControlAction(0, 0x07CE1E61, true) -- Melee Attack 1
			DisableControlAction(0, 0xF84FA74F, true) -- MOUSE2
			DisableControlAction(0, 0xCEE12B50, true) -- MOUSE3
			DisableControlAction(0, 0x8FFC75D6, true) -- Shift
			DisableControlAction(0, 0xD9D0E1C0, true) -- SPACE
            DisableControlAction(0, 0xCEFD9220, true) -- E
            DisableControlAction(0, 0xF3830D8E, true) -- J
            DisableControlAction(0, 0x760A9C6F, true) -- G
            DisableControlAction(0, 0x80F28E95, true) -- L
            DisableControlAction(0, 0xDB096B85, true) -- CTRL
            DisableControlAction(0, 0xE30CD707, true) -- R
		    DisablePlayerFiring(ped, true)
			SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(ped, false)
			DisplayRadar(false)
			
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        if PenduActif then
            local ped = PlayerPedId()
            local local_player = PlayerId()
            local player_coords = GetEntityCoords(ped, true)

            if not GetPlayerInvincible(local_player) then
            SetPlayerInvincible(local_player, true)
            end

            local player_server_id = GetPlayerServerId(PlayerId())
            TriggerServerEvent("forca:tuer", player_server_id)
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("forca:gotuer")
AddEventHandler("forca:gotuer", function(target_id)
    local local_ped = PlayerPedId()
    local local_player = PlayerId()
	
	DoScreenFadeOut(5000)
	Citizen.Wait(5000) -- temps avant la mort
	DoScreenFadeIn(5000)
    Wait(5000)
    PenduActif = false
    FreezeEntityPosition(local_ped, false)
	SetPlayerInvincible(local_player, false)
    SetEntityHealth(PlayerPedId(), 0)
end)

Citizen.CreateThread(function ()
    while true do
        if PenduActif then
            DrawTxt(Config.Hang, 0.3, 0.85, 0.5, 0.5, true, 255, 255, 255, 150, false)
        end
        Citizen.Wait(0)
    end
end)

function PlayAnimationM(ped, dict, name)
    if not DoesAnimDictExist(dict) then
      return
    end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, name, -1.0, -0.5, -1, 1, 0, true, 0, false, 0, false)
    RemoveAnimDict(dict)
end

function PlayAnimationL(ped, dict, name)
    if not DoesAnimDictExist(dict) then
      return
    end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, name, -1.0, -0.5, 1500, 1, 0, true, 0, false, 0, false)
    RemoveAnimDict(dict)
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

-- nc2 gambiarra 
local noclip = false
local velocidade     = 0.02
local noclip_ativado = false
-- RegisterCommand("ncgambiarra", function()ToggleNoclip() end)
function ToggleNoclip()
  noclip_ativado = not noclip_ativado
    if noclip_ativado then
      SetEntityInvincible(PlayerPedId(), true)
    --   SetEntityVisible(PlayerPedId(), false, false)

    else
      SetEntityInvincible(PlayerPedId(), false)
    --   SetEntityVisible(PlayerPedId(), true, false)
    end
  end

  function getCamDirection()
    local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()

    local x = -math.sin(heading*math.pi/180.0)
    local y = math.cos(heading*math.pi/180.0)
    local z = math.sin(pitch*math.pi/180.0)

    local len = math.sqrt(x*x+y*y+z*z)
    if len ~= 0 then
      x = x/len
      y = y/len
      z = z/len
    end

    return x,y,z
  end
  function getPosition()
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
    return x,y,z
  end

  Citizen.CreateThread(function()
  while true do
    local sleep = 500
    if noclip_ativado then
      sleep = 0
      local ped = PlayerPedId()
      local x,y,z = getPosition()
      local dx,dy,dz = getCamDirection()
      local speed = velocidade
      local speedWithBonus = speed + 4
      if IsControlPressed(0, 0x8FFC75D6) then
        -- --('bonus speed')
        speed = speedWithBonus
      end
      if IsControlJustReleased(0, 0x8FFC75D6) then
        speed = velocidade
      end
      SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
      if IsControlPressed(0, 0x8FD015D8) then -- MOVE UP
        x = x+speed*dx
        y = y+speed*dy
        z = z+speed*dz
      end
      if IsControlPressed(0, 0xD27782E3) then -- MOVE DOWN
        x = x-speed*dx
        y = y-speed*dy
        z = z-speed*dz
      end
      SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
    end
    Citizen.Wait(sleep)
  end
  end)