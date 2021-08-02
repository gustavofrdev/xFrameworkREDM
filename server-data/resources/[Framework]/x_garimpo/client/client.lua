
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("x_garimpo")
x_garimpo = Proxy.getInterface("x_garimpo")
x_garimpoSv = Tunnel.getInterface("x_garimpo")
_Tunnel = {}
Tunnel.bindInterface("x_garimpo", _Tunnel)
--------------------------------------------------------

local garimpando = false 
start_smelting = {}
start_selling = {}
start_prospect = {}
local smelting = false
local selling = false
local prospect = false
local result = 0

Citizen.CreateThread(function()
while true do 
	local W = 500
		for k, v in pairs(Config.Locs) do
			local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))
			local lx, ly, lz = v.x, v.y, v.z
			if GetDistanceBetweenCoords(px, py, pz, lx, ly, lz, true) < 10 then 
				W = 1
				if not garimpando then 
					DrawText3D(lx, ly, lz, "Pressione [R] para garimpar")
				else 
					DrawText3D(lx, ly, lz, "Você está garimpando 🐧")
				end
				if GetDistanceBetweenCoords(px, py, pz, lx, ly, lz, true) < 3 then 
					if IsControlJustPressed(0, 0xE30CD707) and not garimpando then 
						if x_garimpoSv.peneira() then 
							TriggerEvent("cancelando", true)
							garimpando = true
							TriggerEvent("x_garimpo:start_panning")
							x_garimpoSv.addUse()
	
							if x_garimpoSv.getUses() >= 10 then 
								print(x_garimpoSv.getUses() )
								x_garimpoSv.peneira("rem")
								x_garimpoSv.addUse("res")
								TriggerEvent("xFramework:Notify", "negado", "Sua peneira quebrou")
							end
						else
							TriggerEvent("xFramework:Notify", "negado", "Você precisa de uma Peneira para continuar o trabalho...")
						end
					end
				end
			end
		end
		Citizen.Wait(W)
	end
end)
local entity = 0;

function LoadModel(model)
    local attempts = 0
    while attempts < 100 and not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
        attempts = attempts + 1
    end
    return IsModelValid(model)
end
function CrouchAnimAndAttach()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_HAND")
    local modelHash = GetHashKey("P_CS_MININGPAN01X")
    LoadModel(modelHash)
    entity = CreateObject(modelHash, coords.x+0.3, coords.y,coords.z, true, false, false)
    SetEntityVisible(entity, true)
    SetEntityAlpha(entity, 255, false)
    Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
    SetModelAsNoLongerNeeded(modelHash)
    AttachEntityToEntity(entity,ped, boneIndex, 0.2, 0.0, -0.2, -100.0, -50.0, 0.0, false, false, false, true, 2, true)

    TaskPlayAnim(ped, dict, "inspectfloor_player", 1.0, 8.0, -1, 1, 0, false, false, false)
end

function GoldShake()
    local dict = "script_re@gold_panner@gold_success"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, "SEARCH02", 1.0, 8.0, -1, 1, 0, false, false, false)
end
function playAnim(dict,name)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), dict, name, 8.0, -8.0, 7500, 0, 0, true, 0, false, 0, false)  
end

function play_sound_frontend(audioName, audioRef,b1,p2,b3,p4)
    PlaySound(audioName, audioRef, true,0,true,0)
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

local lowestIndex = 0;
local lowestValue = false;
local hIndex = 0
local hValue = false 
function selectMostProximityValueByInt(t, base)
	for k, v in ipairs(t) do
		if not lowestValue or v < lowestValue then
			lowestIndex = k;
			lowestValue = v;
		end
	end
	for k, v in pairs(base) do 
		if v.chance == lowestValue then 
			lowestIndex = k
		end
	end 
	local resps = {lowestIndex, lowestValue}
	lowestValue = false
	lowestIndex = 0
	if resps[2] == false then
		local foo = {}
		for i = 1, #base do 
			table.insert(foo, tonumber(base[i].chance))
		end
		local max_val, key = 0,0
		for k, v in pairs(foo) do
			key = k
			if max_val == 0 then 
				max_val = v 
			end
			if v > max_val then
				max_val, key = v, k
			end
			max = max_val
		end
		for k, v in pairs(base) do 
			if v.chance == max_val then 
				key = k 
			end
		end 
		resps = {key, max}
	end
	return resps[2], resps[1];
end
---------------- start panning for gold
RegisterNetEvent('x_garimpo:start_panning')
AddEventHandler('x_garimpo:start_panning', function()	
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
	if prospect == false then
		
		foundwater = true             
		CrouchAnimAndAttach()
		-- TriggerEvent("xFramework:Notify", "aviso", "panning for gold!", 18, "success")
		exports["x_progress"]:startUI(6000, "Procurando...")
		 Citizen.Wait(6100)
		 exports["x_progress"]:startUI(30000, "Peneirando")
		 GoldShake()
		 Wait(30050)
		 ClearPedTasks(ped)
		 DeleteObject(entity)
		 DeleteEntity(entity)
		 TriggerEvent("cancelando", false)
		 garimpando = false
		ClearPedTasksImmediately(PlayerPedId())
		ClearPedSecondaryTask(PlayerPedId())
		-->
		prospect = false
		for k, v in pairs(Config.Itens) do
			local itens = v
			local val = 0.4
			local t_total = 0;
			for _, v2 in pairs(itens) do 
				t_total = t_total + v2.chance
			end
			local ch = math.random(100)%t_total;
			local o = {}
			local cV, cK = false, 0
			local integers = {}
			for k, v in pairs(itens) do 
				if v.chance > ch then 
					o[v.item] = v.chance
					table.insert(integers, v.chance)
				end
			end
			local l, key = selectMostProximityValueByInt(integers, itens)
			-- print("select: ", v[key].item)
			x_garimpoSv.g2_gv(v[key].item)
			for k in pairs(integers) do 
				integers[k] = nil
			end
		end
	end
end)


function DrawText3D(x, y, z, text)
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
