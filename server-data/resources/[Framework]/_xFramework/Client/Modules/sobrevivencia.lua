-- ! Survival Module
-- ? Semelhante: vRPEX!

local C = Citizen.CreateThread
local N = Citizen.InvokeNative
local SLEEP = Citizen.Wait
local nukkle = exports.spawnmanager

--  Para funções
local temp_wait_HP = 0.00
local ac = {}
ac.__fome = 0
ac.__sede = 0
ac.__sended = false
local Cache = {}
local isDead = false
local cam = nil

function levantarAnim() 
  local dict2  = "amb_rest_drunk@world_human_sit_ground@drink@male_b@stand_exit_withprop"
  local anim2 = "exit_front"
  local dict = "amb_rest_sit@world_human_sit_ground@fall_asleep@male_a@sleeping@idle_a"
  local anim = "idle_a"
  --"trigger<sucess>")
  RequestAnimDict(dict)
  RequestAnimDict(dict2)
  while not HasAnimDictLoaded(dict) do Wait(0) print("loading: try <TRY>>") end
  while not HasAnimDictLoaded(dict2) do Wait(0) print("loading: try <TRY>>") end
  -- amb_rest_sit@world_human_sit_ground@fall_asleep@female_a@sleeping@idle_a
  --[[
      "idle_a",
      "idle_c",
      "idle_b",
  ]]
  TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
  Wait(8000)
  TaskPlayAnim(PlayerPedId(), dict2, anim2, 8.0, -0.5, -1, 0, 0, true)
end
function StartDeathCam()
  Citizen.CreateThread(function()
  ClearFocus()

  local playerPed = PlayerPedId()

  cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', GetEntityCoords(playerPed), 0, 0, 0, GetGameplayCamFov())
  ShakeCam(cam, 'DRUNK_SHAKE', 0.5)
  SetCamActive(cam, true)
  RenderScriptCams(true, true, 1000, true, false)
  end)
end
RegisterNetEvent("___mMMMMMhhhhhSSSSsssQQQqqqqqQQQQQQ")
AddEventHandler("___mMMMMMhhhhhSSSSsssQQQqqqqqQQQQQQ", function(fome, sede)
-- print("fome, sede", fome, sede)
ac.__fome   = fome
ac.__sede   = sede
ac.__sended = true
end)


local extra = ""
-- Mother Thread
C(function()
temp_wait_HP = FrameworkSV.GetHPMaxTime()
Cache["thp"] = temp_wait_HP
while true do
  local W = 500
  if IsPlayerDead(PlayerId()) then
    W = 1
    if(IsEntityAttachedToAnyPed(PlayerPedId()))then
      local carrier = N(0x09B83E68DE004CD4,PlayerPedId())
      NetworkSetInSpectatorMode(true, carrier)
      extra = "<Você está sendo carregado>"
    else
      NetworkSetInSpectatorMode(false, PlayerPedId())
      extra = ""
    end
    isDead=true
    DisplayHud(false)
    DisplayRadar(false)
    nukkle:setAutoSpawn(false)
    N(0xFA08722A5EA82DA7, 'LensDistDrunk')
    N(0xFDB74C9CC54C3F37, 1.0)
    AnimpostfxPlay('DeathFailMP01')
    if temp_wait_HP >= 1  then
      DrawTxt("Tempo: ~r~" ..tostring(temp_wait_HP).. " "..extra, 0.50, 0.80, 0.7, 0.7, true, 255, 255, 255, 255, true)
    else
      DrawTxt( "Pressione E para voltar", 0.50, 0.80, 0.7, 0.7, true, 255, 255, 255, 255, true)
      if(IsControlJustPressed(0, 0xB99A9CAD))  then
        respawn()
      end
    end
  end
  SLEEP(W)
end
end)

function EndDeathCam()
  C(function()
  ClearFocus()
  RenderScriptCams(false, false, 0, true, false)
  DestroyCam(cam, false)
  cam = nil
  end)
end

function ProcessCamControls()
  C(function()
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)

  DisableFirstPersonCamThisFrame()

  local newPos = ProcessNewPosition()

  SetCamCoord(cam, newPos.x, newPos.y, newPos.z)

  PointCamAtCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
  end)
end
function ProcessNewPosition()
  local mouseX = 0.0
  local mouseY = 0.0

  -- keyboard
  if (IsInputDisabled(0)) then
    -- controller
    -- rotation
    mouseX = GetDisabledControlNormal(1, 0x4D8FB4C1) * 3.0
    mouseY = GetDisabledControlNormal(1, 0xFDA83190) * 3.0
  else
    -- rotation
    mouseX = GetDisabledControlNormal(1, 0x4D8FB4C1) * 1.0
    mouseY = GetDisabledControlNormal(1, 0xFDA83190) * 1.0
  end
  angleZ = angleZ - mouseX -- around Z axis (left / right)
  angleY = angleY + mouseY -- up / down
  -- limit up / down angle to 90°
  if (angleY > 89.0) then
    angleY = 89.0
  elseif (angleY < -89.0) then
    angleY = -89.0
  end

  local pCoords = GetEntityCoords(PlayerPedId())

  local behindCam = {
    x = pCoords.x + ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * (1.5 + 0.5),
    y = pCoords.y + ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * (1.5 + 0.5),
    z = pCoords.z + (Sin(angleY)) * (1.5 + 0.5)
  }
  local rayHandle =
  StartShapeTestRay(
  pCoords.x,
  pCoords.y,
  pCoords.z + 0.5,
  behindCam.x,
  behindCam.y,
  behindCam.z,
  -1,
  PlayerPedId(),
  0
  )
  local a, hitBool, hitCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

  local maxRadius = 1.5
  if (hitBool and Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords) < 1.5 + 0.5) then
    maxRadius = Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords)
  end

  local offset = {
    x = ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * maxRadius,
    y = ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * maxRadius,
    z = (Sin(angleY)) * maxRadius
  }

  local pos = {
    x = pCoords.x + offset.x,
    y = pCoords.y + offset.y,
    z = pCoords.z + offset.z
  }

  return pos
end

function _Framework.Kill()
  SetEntityHealth(PlayerPedId(), 0)
end
function _Framework.ReviveGod()
  ClearTimecycleModifier()
  SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
  N(0x71BC8E838B9C6035, PlayerPedId())
  AnimpostfxStop('DeathFailMP01')
  TriggerEvent('playerSpawned')
  NetworkSetInSpectatorMode(false, PlayerPedId())
  N(0xD63FE3AF9FB3D53F, true)
  N(0x1B3DA717B9AFF828, true)
  DestroyAllCams(true)
  local pl = N(0x217E9DC48139933D)
  local ped = N(0x275F255ED201B937, pl)
  local coords = GetEntityCoords(ped, false)
  local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
  NetworkResurrectLocalPlayer(x, y, z , 90.0, true, false)
  ClearPedBloodDamage(PlayerId())
  levantarAnim()
  FreezeEntityPosition(ped, true)
  N(0x71BC8E838B9C6035, ped)
  N(0x0E3F4AF2D63491FB)
  FreezeEntityPosition(PlayerPedId(), false)
  DisplayHud(true)
  DisplayRadar(true)
  DestroyAllCams(true)
  RenderScriptCams(false, true, 500, true, true)
  DestroyAllCams(true)
  DisplayHud(true)
  local playerHash = GetHashKey("PLAYER")
  N(0xF808475FA571D823, true)
  N(0xBF25EB89375A37AD, 5, playerHash, playerHash)
  AnimpostfxStopAll()
  ClearTimecycleModifier()
  isDead = false
  temp_wait_HP = Cache["thp"]
end
function _Framework.isDead()
  return isDead
end

function RespawnCamera(x,y,z)
  DoScreenFadeIn(500)
  local coords = _coords
  cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 621.67,374.08,873.24, 300.00,0.00,0.00, 100.00, false, 0) -- CAMERA COORDS
  PointCamAtCoord(cam, x, y,z +200)
  SetCamActive(cam, true)
  RenderScriptCams(true, false, 1, true, true)
  DoScreenFadeIn(500)
  Citizen.Wait(500)

  cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y,z +200, 300.00,0.00,0.00, 100.00, false, 0)
  PointCamAtCoord(cam3, x, y,z +200)
  SetCamActiveWithInterp(cam3, cam, 3700, true, true)
  Citizen.Wait(3700)

  cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y,z +200, 300.00,0.00,0.00, 100.00, false, 0)
  PointCamAtCoord(cam2, x, y,z +2)
  SetCamActiveWithInterp(cam2, cam3, 3700, true, true)
  RenderScriptCams(false, true, 500, true, true)
  Citizen.Wait(500)
  SetCamActive(cam, false)
  FreezeEntityPosition(PlayerPedId(), false)
  DestroyCam(cam, true)
  DestroyCam(cam2, true)
  DestroyCam(cam3, true)
  DisplayHud(true)
  DisplayRadar(true)
  Citizen.Wait(3000)
  AnimpostfxStopAll()

end
function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
  local str = CreateVarString(10, "LITERAL_STRING", str)


  SetTextScale(w, h)
  SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
  SetTextCentre(centre)
  if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
  N(0xADA9255D, 1)
  SetTextFontForCurrentCommand(7)
  DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
  return N(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

C(function()
while true do
  local l = 1000
  if(temp_wait_HP > 0 and isDead ) then
    l = 1000
    temp_wait_HP = temp_wait_HP - 1
    if temp_wait_HP == 0 then temp_wait_HP = 0 end
  end
  SLEEP(l)
end
end)


function respawn()
  AnimpostfxStopAll()
  ClearTimecycleModifier()
  local _pos = FrameworkSV.GetSpawnLocation()
  -- print(json.encode(_pos))
  local x,y,z = _pos.x,  _pos.y,  _pos.z
  NetworkResurrectLocalPlayer(x, y, z , 90.0, true, false)
  levantarAnim()
  isDead = false
  temp_wait_HP = Cache["thp"]
  RespawnCamera(x,y,z)

end

-- Map_gu

function _Framework.HasMap()
  return FrameworkSV.HasMap()
end


