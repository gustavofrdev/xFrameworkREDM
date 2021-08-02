local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
_Framework = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_multicharacter")
_CharacterCreator = Proxy.getInterface("x_charactercreator")
_Tunnel = {}
Tunnel.bindInterface("x_multicharacter", _Tunnel)
local cam
--------------------------------------------------------------------
-- functions <> --
-------------------------------------------------------------------


function CreateNewEvent(eventLabel, eventFunc)
    RegisterNetEvent(eventLabel)
    AddEventHandler(eventLabel, eventFunc)
end

function Tr(f) Citizen.CreateThread(f) end 

--------------------------------------------------------------------
-- functions <> --
--------------------------------------------------------------------
function _Tunnel.sendCharactersData(characters)
    ShutdownLoadingScreenNui()
    SetNuiFocus(true,true)
    -- print(characters)
	SendNUIMessage({CanStart = "ABRIR", action = "openui", characters = characters })
end
--------------------------------------------------------------------
-- NUI CallBacks <> --
--------------------------------------------------------------------
RegisterNUICallback("CharacterChosen",function(data)
    DoScreenFadeOut(500)
    SendNUIMessage({remBody = true})
    MultiCharacter.SpawnCharacter(data.id)
    SetEntityVisible(PlayerPedId(), true)
    FreezeEntityPosition(PlayerPedId(), false)
    SetNuiFocus(false, false )

    local coords = {}
    coords.x, coords.y, coords.z = table.unpack(GetEntityCoords(PlayerPedId()))
    
    DestroyCam(camera)
    cam =
        CreateCamWithParams(
        "DEFAULT_SCRIPTED_CAMERA",
        coords.x + 200,
        coords.y + 200,
        coords.z + 200,
        300.00,
        0.00,
        0.00,
        100.00,
        false,
        0
    ) -- CAMERA COORDS
    PointCamAtCoord(cam, coords.x, coords.y, coords.z + 200)
    SetCamActive(cam, true)
    ShutdownLoadingScreen()
    DoScreenFadeIn(500)
  
    RenderScriptCams(true, false, 1, true, true)
    Citizen.Wait(500)
    cam3 =
        CreateCamWithParams(
        "DEFAULT_SCRIPTED_CAMERA",
        coords.x,
        coords.y,
        coords.z + 200,
        300.00,
        0.00,
        0.00,
        100.00,
        false,
        0
    )
    PointCamAtCoord(cam3, coords.x, coords.y, coords.z + 200)
    SetCamActiveWithInterp(cam3, cam, 3900, true, true)
    Citizen.Wait(3900)
    cam2 =
        CreateCamWithParams(
        "DEFAULT_SCRIPTED_CAMERA",
        coords.x,
        coords.y,
        coords.z + 200,
        300.00,
        0.00,
        0.00,
        100.00,
        false,
        0
    )
    PointCamAtCoord(cam2, coords.x, coords.y, coords.z + 2)
    SetCamActiveWithInterp(cam2, cam3, 3700, true, true)
    RenderScriptCams(false, true, 500, true, true)
    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z + 0.5)
    Citizen.Wait(1500)
    DestroyAllCams(true)
    Citizen.Wait(800)
    DisplayHud(true)
    -- DisplayRadar(true)
    local playerHash = GetHashKey("PLAYER")
     Citizen.InvokeNative(0xF808475FA571D823, true)
     Citizen.InvokeNative(0xBF25EB89375A37AD, 5, playerHash, playerHash)
end)
RegisterNetEvent("x_multicharacter:Continue")
AddEventHandler("x_multicharacter:Continue", function()
    SendNUIMessage({remBody = true})
    SetEntityVisible(PlayerPedId(), true)
    FreezeEntityPosition(PlayerPedId(), false)
    DestroyCam(camera)
    SetNuiFocus(false, false)
    TriggerEvent("incriacaostatuts", true )
end )
RegisterNUICallback("CriarPersonagem", function(data)
    -- print("criando novo personagem .")
    MultiCharacter.CreateNewCharacter(data.IsSecond)
end )
--------------------------------------------------------------------
-- Thread <> --
--------------------------------------------------------------------

Tr(function()
    ShutdownLoadingScreen()
    Wait(3000)
    SetEntityVisible(PlayerPedId(), false)
    FreezeEntityPosition(PlayerPedId(),true)
	local coords = {}
    coords.x, coords.y, coords.z = 37.6, -1288.95, 876.8
    camera =
        CreateCamWithParams(
        "DEFAULT_SCRIPTED_CAMERA",
        coords.x + 200,
        coords.y + 200,
        coords.z + 200,
        300.00,
        0.00,
        0.00,
        100.00,
        false,
        0
    ) -- CAMERA COORDS
    PointCamAtCoord(camera, coords.x, coords.y, coords.z + 200)
    SetCamActive(camera, true)
    RenderScriptCams(true, false, 1, true, true)
    local playerHash = GetHashKey("PLAYER")
    Citizen.InvokeNative(0xF808475FA571D823, true)
    Citizen.InvokeNative(0xBF25EB89375A37AD, 5, playerHash, playerHash)
    MultiCharacter.PlayerLogin()
end)
