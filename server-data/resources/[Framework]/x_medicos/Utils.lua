
local _act_horse = nil
local out = false;
GetVehicles = function()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function GetVehicleCoords(coords)
    local vehicles        = GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end

    return closestVehicle, closestDistance
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end
function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
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
-- local a=100%10;

function devolverCavaloMethod()
	if _act_horse == nil then out = false; return end;
	local me = GetEntityCoords(PlayerPedId())
	local myHorse = GetEntityCoords(_act_horse)
	if myHorse == nil then out = false; return end;
	if GetDistanceBetweenCoords(me, myHorse, true) < 5 then 
		DeleteEntity(_act_horse)
		_act_horse = nil;
		out = false;
	else
		TriggerEvent("xFramework:Notify", "negado", " Seu cavalo está muito longe!")
	end
end

function spawnNewMedHorse(ped, position)
	if out then TriggerEvent("xFramework:Notify", "negado", "Você já possuí um cavalo do lado de fora") return end;
local spawnedHorse = CreatePed(ped, position.x, position.y, position.z, GetEntityHeading(PlayerPedId()), 1, 0)
_act_horse = spawnedHorse;
local entity = spawnedHorse
local default_stamina =  GetAttributeCoreValue(spawnedHorse, 1)
default_stamina = default_stamina - 50
Citizen.InvokeNative(0xC6258F41D86676E0, spawnedHorse, 1, default_stamina) --core
Citizen.InvokeNative(0xC6258F41D86676E0, spawnedHorse, 0, default_stamina) --core
Citizen.InvokeNative(0x6A071245EB0D1882, spawnedHorse, PlayerPedId(), -1, 15.2, 2.0, 0, 0)
Citizen.InvokeNative(0x283978A15512B2FE, spawnedHorse, true)
Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, spawnedHorse)
Citizen.InvokeNative(0xFD6943B6DF77E449, spawnedHorse, false)
Citizen.InvokeNative(0x931B241409216C1F , PlayerPedId(), spawnedHorse , 0)
AddAttributePoints(spawnedHorse, 7 , 950)
Citizen.InvokeNative(0xA691C10054275290, PlayerPedId(), spawnedHorse, 0);
Citizen.InvokeNative(0x931B241409216C1F, PlayerPedId(), spawnedHorse, 0);
Citizen.InvokeNative(0xED1C764997A86D5A, PlayerPedId(), spawnedHorse);
Citizen.InvokeNative(0xED1C764997A86D5A, PlayerPedId(), spawnedHorse);
Citizen.InvokeNative(0xB8B6430EAD2D2437, spawnedHorse, 130495496);
Citizen.InvokeNative(0xDF93973251FB2CA5, GetEntityModel(spawnedHorse), 1)
Citizen.InvokeNative(0xAEB97D84CDF3C00B, spawnedHorse, 0)
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 211, true);
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 208, true);
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 209, true);
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 400, true);
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 297, true);
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 136, false);
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 312, false);
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 113, false);
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 301, false);
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 277, true);
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 319, true);
Citizen.InvokeNative(0x1913FE4CBF41C463, spawnedHorse, 6, true)
Citizen.InvokeNative(0x9FF1E042FA597187, spawnedHorse, 25, false);
Citizen.InvokeNative(0x9FF1E042FA597187, spawnedHorse, 24, false);
Citizen.InvokeNative(0xA691C10054275290, spawnedHorse, PlayerId())
Citizen.InvokeNative(0x6734F0A6A52C371C, PlayerId(), 431);
Citizen.InvokeNative(0x024EC9B649111915, spawnedHorse, 1);
Citizen.InvokeNative(0xEB8886E1065654CD, spawnedHorse, 10, "ALL", 10);
out = true 
if not spawnedHorse then out = false end;
end