local keys = {
    ["A"] = 0x7065027D,
    ["B"] = 0x4CC0E2FE,
    ["C"] = 0x9959A6F0,
    ["D"] = 0xB4E465B4,
    ["E"] = 0xCEFD9220,
    ["F"] = 0xB2F377E8,
    ["G"] = 0x760A9C6F,
    ["H"] = 0x24978A28,
    ["I"] = 0xC1989F95,
    ["J"] = 0xF3830D8E,
    ["L"] = 0x80F28E95,
    ["M"] = 0xE31C6A41,
    ["N"] = 0x4BC9DABB,
    ["O"] = 0xF1301666,
    ["P"] = 0xD82E0BD2,
    ["Q"] = 0xDE794E3E,
    ["R"] = 0xE30CD707,
    ["S"] = 0xD27782E3,
    ["U"] = 0xD8F73058,
    ["V"] = 0x7F8D09B8,
    ["W"] = 0x8FD015D8,
    ["X"] = 0x8CC9CD42,
    ["Z"] = 0x26E9DC00,
    ["RIGHTBRACKET"] = 0xA5BDCD3C,
    ["LEFTBRACKET"] = 0x430593AA,
    ["MOUSE1"] = 0x07CE1E61,
    ["MOUSE2"] = 0xF84FA74F,
    ["MOUSE3"] = 0xCEE12B50,
    ["MWUP"] = 0x3076E97C,
    ["CTRL"] = 0xDB096B85,
    ["TAB"] = 0xB238FE0B,
    ["SHIFT"] = 0x8FFC75D6,
    ["SPACEBAR"] = 0xD9D0E1C0,
    ["ENTER"] = 0xC7B5340A,
    ["BACKSPACE"] = 0x156F7119,
    ["LALT"] = 0x8AAA0AD4,
    ["DEL"] = 0x4AF4D473,
    ["PGUP"] = 0x446258B6,
    ["PGDN"] = 0x3C3DD371,
    ["F1"] = 0xA8E3F467,
    ["F4"] = 0x1F6D95E5,
    ["F6"] = 0x3C0A40F2,
    ["1"] = 0xE6F612E4,
    ["2"] = 0x1CE6D9EB,
    ["3"] = 0x4F49CC4C,
    ["4"] = 0x8F9F9E58,
    ["5"] = 0xAB62E997,
    ["6"] = 0xA1FDE2A6,
    ["7"] = 0xB03A913B,
    ["8"] = 0x42385422,
    ["DOWN"] = 0x05CA7C52,
    ["UP"] = 0x6319DB71,
    ["LEFT"] = 0xA65EBAB4,
    ["RIGHT"] = 0xDEB34313,
}

function whenKeyJustPressed(key)
    local k = keys[key]
    if Citizen.InvokeNative(0x580417101DDB492F, 0, k) then
        return true
    else
        return false
    end
end

function IsDead(e)
	return Citizen.InvokeNative(0x2E9C3FCB6798F397, e)
end

function ClearPTask(e)
	return ClearPedTasks(e)
end

function p()
	return PlayerId()
end

-- ped = PlayerPedId()
function Ped()
	return PlayerPedId()
end

-- ps = GetPlayerServerId(PlayerId())
function ps()
	return GetPlayerServerId(PlayerId())
end

function GetEntityCoords(e)
    return Citizen.InvokeNative(0xA86D5F069399F44D, e, Citizen.ResultAsVector())
end

function GetEntityHead(e)
	return GetEntityHeading(e)
end

function GetDistance(pc,oc)
    return GetDistanceBetweenCoords(pc.x, pc.y, pc.z, oc.x, oc.y, oc.z, false)
end
function GetDistanceZTrue(pc,oc)
    return GetDistanceBetweenCoords(pc.x, pc.y, pc.z, oc.x, oc.y, oc.z, true)
end

function SetCoords(c)
	return SetEntityCoords(c.x,c.y,c.z)
end

function PlayAnim(d,a)
    local player = PlayerPedId()

    local dict = d
    RequestAnimDict(d)
    while not HasAnimDictLoaded(d) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(player, d, a, 1.0, 8.0, -1, 1, 0, false, false, false)
end

function PlayWalkAnim(d,a)
    local player = PlayerPedId()

    local dict = d
    RequestAnimDict(d)
    while not HasAnimDictLoaded(d) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(player, d, a, 1.0, 8.0, -1, 31, 0, false, false, false)
end

function PlayScenario(s)
    local player = PlayerPedId()
    local model = GetHashKey(s)
    TaskStartScenarioInPlace(player, model,-1, true, false, false, false)
end

function pv()
	return GetVehiclePedIsIn(ped(), false)
end

function lpv()
	return GetVehiclePedIsIn(ped(), true)
end

function fix(veh)
	SetVehicleFixed(veh)
	return ""
end

function translateAngle(x1, y1, ang, offset)
    x1 = x1 + math.sin(ang) * offset
    y1 = y1 + math.cos(ang) * offset
    return {x1, y1}
end

function SpawnEntOnP(e)
    local player = GetPlayerPed()
    local pCoords = GetEntityCoords(player)
    local pDir = GetEntityHeading(player)
    local spawnCoords = GetOffsetFromEntityInWorldCoords(player, 0, -0.5, -0.5)
    local modelName = e
    local modelHash = GetHashKey(modelName)
    Citizen.CreateThread(function()
        LoadModel(modelHash)
        local entity = CreatePed(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, pDir, true, false, false, false)
        SetEntityVisible(entity, true)
        SetEntityAlpha(entity, 255, false)
        Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
        SetModelAsNoLongerNeeded(modelHash)
    end)
end

function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

function ShowPrompt(msg)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end