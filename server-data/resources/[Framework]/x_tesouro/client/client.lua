local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
local FrameworkCL = Proxy.getInterface('_xFramework')
local FrameworkSV = Tunnel.getInterface('_xFramework')
MultiCharacter = Tunnel.getInterface('x_tesouro')
local x_tesouro = Proxy.getInterface('x_tesouro')
local x_tesouroSv = Tunnel.getInterface('x_tesouro')
Tunnel.bindInterface('x_tesouro', _Tunnel)
 _Tunnel = {}
local peds = {}
local peds2 = {}
local blipId = 0
local p_attack = false
local p_text = false 
local isHost = false 
local life = {}
local cache = {}
local prop_data = {}
cache['dead_peds'] = {}
cache['item_table_act'] = {}
local act_rKey = 0
local chest_prop = "s_lootablemiscchest_wagon"
local client_object
local actual_number_vivos_animal = 0 
local actual_number_vivos_peds = 0 
-- function tablelength(T)
--     local count = 0
--     for _ in pairs(T) do count = count + 1 end
--     return count
--   end

RegisterNetEvent("x_tesouro:UpdateVivos")
AddEventHandler("x_tesouro:UpdateVivos", function(ped, animal)
    actual_number_vivos_animal = animal;
    actual_number_vivos_peds = ped;
    if ped == 0 and animal == 0 then 

    end

end)
  RegisterNetEvent("x_tesouro:SendSync")
AddEventHandler("x_tesouro:SendSync", function(type, table, ifKeyThisIsKey)
    if not false then 
        -- -->(json.encode(table), type)
        if type == "peds" then 
            peds2 = table
            -- Wait(5000)
            p_attack = true
            p_text = true
            -->("Informação atualizada: ", json.encode(table))
        elseif type == "criar_clientObj" then 
            if not isHost then 
                -->(json.encode(table))
                act_rKey = ifKeyThisIsKey
                --> ("tentando criar : client_object")
                prop_data = table
                -->(" na posição: ", table.x, table.y, table.z)
                client_object = CreateObject(table.modelHash , table.x, table.y, table.z, false, false, false)
                PlaceObjectOnGroundProperly(client_object)
                SetModelAsNoLongerNeeded(table.modelHash)
                SetModelAsNoLongerNeeded(client_object)
                -->(GetEntityCoords(client_object))
            end
        else 
            -->("Informação atualizada: ", json.encode(table))
            peds = table
        end
    end 
end)

RegisterNetEvent("eventoStatus")
AddEventHandler("eventoStatus", function(s)
    if s then 
    else
        p_attack = false
        p_text = false
        isHost = false  
    end
end)

RegisterNetEvent("ByeTesouro")
AddEventHandler("ByeTesouro", function()
    TriggerEvent("xFramework:Notify", "aviso", "O evento do tesouro acabou!")
    for _, v in pairs(cache["dead_peds"]) do 
        if v then 
            DeleteEntity(v)
        end
    end
    for _, v in pairs(peds) do 
        if v then 
            DeleteEntity(v)
        end
    end
    for _, v in pairs(peds2) do 
        if v then 
            DeleteEntity(v)
        end 
    end
    if client_object then 
        DeleteObject(client_object)
    end
    if blipId then 
        RemoveBlip(blipId)
    end
    p_attack = false
    p_text = false
    isHost = false; 
end)

RegisterNetEvent("newTesouro")
AddEventHandler("newTesouro",function(rKey)
    isHost = true 
    local x2, y2, z2
    blipId = Citizen.InvokeNative(0x554d9d53f696d002,2033377404,Config.Tesouro_Locais[rKey].x,Config.Tesouro_Locais[rKey].y,Config.Tesouro_Locais[rKey].z)
    SetBlipSprite(blipId, Config.Blip.Sprite, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, blipId, Config.Blip.BlipName)
    local this_habitat = Config.Tesouro_Locais[rKey].Habitat
    for k, v in pairs(Config.Animals) do
        -->(rKey, k)
        act_rKey = rKey
        if Config.Tesouro_Locais[rKey].Animais[k] then 
            local x, y, z = Config.Tesouro_Locais[rKey].Animais[k].x, Config.Tesouro_Locais[rKey].Animais[k].y, Config.Tesouro_Locais[rKey].Animais[k].z
             x2, y2, z2 = Config.Tesouro_Locais[rKey].x,Config.Tesouro_Locais[rKey].y, Config.Tesouro_Locais[rKey].z 
            if v[1] == this_habitat then 
                while not HasModelLoaded(GetHashKey(v[2])) do
                    Wait(500)
                    RequestModel(GetHashKey(v[2]))
                end
                local playerPed = PlayerPedId()
                peds[k] = CreatePed(GetHashKey(v[2]), x, y, z, GetEntityHeading(PlayerPedId()), 1, 0)
                -- peds[k] = Citizen.InvokeNative(0xD49F9B0955C367DE, GetHashKey(v[2]), x, y, z, 0, 0, 0, 0, Citizen.ResultAsInteger())
                SetPedAsGroupMember(peds[k], GetDefaultRelationshipGroupHash("G_M_M_UNISWAMP_01"))
			    AddRelationshipGroup("GANG_NIGHT_FOLK")
			    SetPedRelationshipGroupHash(peds[k], GetHashKey("GANG_NIGHT_FOLK"))
                Citizen.InvokeNative(0x1794B4FCC84D812F,  peds[k], 1) -- SetEntityVisible
                Citizen.InvokeNative(0x0DF7692B1D9E7BA7,  peds[k], 255, false) -- SetEntityAlpha
                Citizen.InvokeNative(0x283978A15512B2FE,  peds[k], true) -- Invisible without
                Citizen.InvokeNative(0x4AD96EF928BD4F9A,  GetHashKey(v[2])) -- SetModelAsNoLongerNeeded
                RequestModel(GetHashKey(chest_prop))
                while not HasModelLoaded(GetHashKey(chest_prop)) do 
                    Wait(0)
                end
                p_attack = true
                p_text = true  
                cache["item_table_act"] = Config.Tesouro_Locais[rKey].itens
               
            end
        end
        
    end
    local temp = {}
    for k, v in pairs(peds) do 
        table.insert(temp, v)
    end
    TriggerServerEvent("comunicacao", "animais", temp)
    --> spawn dos npcs
    for k, v in pairs(Config.Tesouro_Locais[rKey].Peds) do
        -->(k, json.encode(v))
        RequestModel(GetHashKey(Config.AssassinPedModel))
        while not HasModelLoaded(GetHashKey(Config.AssassinPedModel)) do
            Wait(500)
            RequestModel(GetHashKey(Config.AssassinPedModel))
        end
        peds2[k] = CreatePed(GetHashKey(Config.AssassinPedModel), v.x,v.y,v.z,0, 1, 0)
        -- peds2[k] = CreatePed(GetHashKey(Config.AssassinPedModel),v.x,v.y,v.z,0, false, false, 1, 0)
		SetPedRelationshipGroupHash(peds2[k], 'NPC')
        GiveWeaponToPed_2(peds2[k], 0x64356159, 500, true, 1, false, 0.0)
		Citizen.InvokeNative(0x283978A15512B2FE, peds2[k], true)
        AddRelationshipGroup("GANG_NIGHT_FOLK")
		SetPedRelationshipGroupHash(peds[k], GetHashKey("GANG_NIGHT_FOLK"))
		Citizen.InvokeNative(0xF166E48407BAC484, peds2[k], PlayerPedId(), 0, 0)
		FreezeEntityPosition(peds2[k], false)
		TaskCombatPed(peds2[k],playerped, 0, 16)
    end
    local temp = {}
    for k, v in pairs(peds2) do 
        table.insert(temp, v)
    end
    TriggerServerEvent("comunicacao", "peds", temp)
     prop_data = {
        modelHash = GetHashKey(chest_prop),
        x = x2,
        y = y2, 
        z = z2-1,
        isNetwork = true,
        netMissionEntity = true,
        doorFlag = false
    }
    client_object = CreateObject(prop_data.modelHash , prop_data.x, prop_data.y, prop_data.z, false, false, false)
    PlaceObjectOnGroundProperly(client_object)
    SetModelAsNoLongerNeeded(prop_data.modelHash)
    SetModelAsNoLongerNeeded(client_object)
    TriggerServerEvent("comunicacao", "propData", prop_data)
end)

Citizen.CreateThread(
	function()
	while true do
		Citizen.Wait(1)
		SetRelationshipBetweenGroups(5, "PLAYER", "GANG_NIGHT_FOLK")
		SetRelationshipBetweenGroups(5, "GANG_NIGHT_FOLK", "PLAYER")
	end
end)

function isAllDead()

end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if p_attack then 
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prop_data.x, prop_data.y, prop_data.z, true) < 112.0 then 
                for _, v in pairs(peds) do 
                    if isHost then 
                        Citizen.InvokeNative(0xF166E48407BAC484, v, PlayerPedId(), 0, 0)
                        if IsEntityDead(v) == 1 then 
                            table.insert( cache["dead_peds"], v)
                            local keys = table_invert(peds)
                            local thisKey = keys[v]
                            -->(thisKey)
                            peds[thisKey] = nil
                            local temp = {}
                            for k, v2 in pairs(peds) do 
                                table.insert(temp, v2)
                            end
                            TriggerServerEvent("comunicacao", "animais", temp)
                            temp = {}
                        end
                    end
                end
                for _, v in pairs(peds2) do 
                    if isHost then 
                        Citizen.InvokeNative(0xF166E48407BAC484, v, PlayerPedId(), 0, 0)
                        if IsEntityDead(v) == 1 then 
                            table.insert( cache["dead_peds"], v)
                            local keys = table_invert(peds2)
                            local thisKey = keys[v]
                            -->(thisKey)
                            peds2[thisKey] = nil
                            local temp = {}
                            for k, v2 in pairs(peds2) do 
                                table.insert(temp, v2)
                            end

                            TriggerServerEvent("comunicacao", "peds", temp)
                            temp = {}
                        end
                    end
                end
                Wait(500)
            end
        end   
    end
end)
function _Tunnel.removeTesouro(rKey)
end
local p = {}
function table_invert(t)
    local u = { }
    for k, v in pairs(t) do u[v] = k end
    return u
  end
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        -->("p_attack: ", p_attack)
        if p_attack then
            -->("?") 
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prop_data.x, prop_data.y, prop_data.z, true) < 112.0 then 
                -->(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prop_data.x, prop_data.y, prop_data.z, true))
                local n = actual_number_vivos_animal
                local n2 = actual_number_vivos_peds
                -->(n, n2)
                DrawTxt("Restam "..n .." animais e "..n2.." Pessoas. \n~e~Mate todos para ganhar sua recompensa.",0.50,0.90,0.5,0.5,true,255,255,255,255,true)
                if n <=0 and n2 <=0 then 
                    -- -->("desativando")
                    -- TriggerEvent("xFramework:Notify", "negado", "Mate todos os animais da região primeiro...")
                    p_attack = false 
                end
            end
        end
    end
end)
Citizen.CreateThread(function()
    while true do 
        local W = 500
        -->(p_text, client_object)
        if p_text and client_object then 
            local bx, by, bz = prop_data.x, prop_data.y, prop_data.z
            local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))
            if GetDistanceBetweenCoords(px, py, pz, bx, by, bz, true) < 8 then 
                W = 1
                DrawText3D(bx, by, bz, "Pressione [H] para abrir o tesouro")
                if IsControlJustPressed(0, 0x84543902) then 
                    if actual_number_vivos_animal > 0 then 
                        TriggerEvent("xFramework:Notify", "negado", "Mate todos os animais da região primeiro...")
                        goto continue
                    end
                    if actual_number_vivos_peds > 0 then 
                        TriggerEvent("xFramework:Notify", "negado", "Mate todos os inimigos(humanos) da região primeiro...")
                        goto continue
                    end
                    SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
                    local dict  = "script_common@tailor_shop@camp"
                    local anim = "open_chest"
                    local dict2  = "script_common@tailor_shop@camp"
                    local anim2 = "open_chest_chest"
                    local dict3  = "mech_pickup@loot@pistol_chest@under_bed@da_revolver"
                    local dict4 = "mech_ransack@chest@lrg@close@crouch@b"
                    local anim3 = "enter_rf"
                    local anim4 = "base"
                    local anim5 = "base_chest"
                    RequestAnimDict(dict)
                    RequestAnimDict(dict2)
                    RequestAnimDict(dict3)
                    RequestAnimDict(dict4)
                    SetEntityCoordsNoOffset(PlayerPedId(), Config.Tesouro_Locais[act_rKey].Bau_anim_pos[1], Config.Tesouro_Locais[act_rKey].Bau_anim_pos[2], Config.Tesouro_Locais[act_rKey].Bau_anim_pos[3])
                    SetEntityHeading(PlayerPedId(), Config.Tesouro_Locais[act_rKey].Bau_anim_heading)
                    while not HasAnimDictLoaded(dict)  do Wait(0)  end
                    while not HasAnimDictLoaded(dict4) do Wait(0)  end
                    while not HasAnimDictLoaded(dict3) do Wait(0)  end
                    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
                    PlayEntityAnim(client_object, anim2, dict2, 1, 0, 1, 0, 0, 0);
                    exports["x_progress"]:startUI(3000, "Abrindo baú...")
                    Wait(3050)
                    exports["x_progress"]:startUI(3800, "Coletando tesouro...")
                    TaskPlayAnim(PlayerPedId(), dict3, anim3, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
                    Wait(3850)
                    exports["x_progress"]:startUI(1500, "")
                    TaskPlayAnim(PlayerPedId(), dict4, anim4, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
                    Wait(1500)
                    PlayEntityAnim(client_object, anim5, dict4, 1, 0, 1, 0, 0, 0);
                    -->("--> !Now, give the itens!")
                    for k, v in pairs(cache["item_table_act"]) do 
                        x_tesouroSv.AB2CA677166531D470074AB4324E4BA2(v[1], v[2])
                    end
                    x_tesouroSv.end_()
                    p_text = false 
                    Wait(10000)
                    DeleteObject(client_object)
                    RemoveBlip(blipId)
                    --> "--> Fim Evento"
                    for k, v in pairs(cache["dead_peds"]) do 
                        if v then 
                            DeleteEntity(v)
                        end
                    end
                end
            end
        end 
        ::continue::
        Citizen.Wait(W)
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z + 1.0)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    local str = CreateVarString(10, 'LITERAL_STRING', text, Citizen.ResultAsLong())
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        SetTextCentre(1)
        SetTextDropshadow(1, 0, 0, 0, 255)
        DisplayText(str, _x, _y)
    end
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)

    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end