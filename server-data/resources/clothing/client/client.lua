--------------------------------------------------------
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
FrameworkCL = Proxy.getInterface('_xFramework')
FrameworkSV = Tunnel.getInterface('_xFramework')
clothing = Proxy.getInterface('clothing')
clothingSv = Tunnel.getInterface('clothing')
_Tunnel = {}
Tunnel.bindInterface('clothing', _Tunnel)

local confirm = false;
local isInCriacao = false;
local act_store = 0;

local playerClothesData = {

satchels = 1, jewelry_rings_left = 1, gunbelts = 1,          belt_buckles = 1, neckwear = 1,            coats = 1,
armor = 1,    boot_accessories = 1,   holsters_left = 1,     gauntlets = 1,    eyewear = 1,             chaps = 1,
spats = 1,    gloves = 1,cloaks = 1,  jewelry_bracelets = 1, hats = 1,         jewelry_rings_right = 1, masks = 1,
ponchos = 1,  coats_closed = 1,       vests = 1,             shirts_full = 1,  neckties = 1,            suspenders = 1,
belts = 1,    loadouts = 1,           accessories = 1,       boots = 1,        dresses = 1,             pants = 1,
bows = 1,     skirts = 1

}
local cache = {}
local list = {}
local list_f = {}
local legs = nil
local torso = nil
local ComponentNumber = {}
local cam = nil
local c_zoom = 2.8
local c_offset = -0.15



function ShowSkinCreator(enable)
    local _elements = list
    if not IsPedMale(PlayerPedId()) then
        _elements = list_f
    end
    SendNUIMessage(
        {
            openSkinCreator = enable,
            elements = _elements,
            numbers = playerClothesData,
            translation = Config.Label
        }
    )
    SetNuiFocus(enable, enable)
end

function reversedipairsiter(t, i)
    i = i - 1
    if i ~= 0 then
        return i, t[i]
    end
end

function reversedipairs(t)
    return reversedipairsiter, t, #t + 1
end

Citizen.CreateThread(function()
    local _query = clothingSv.pQuery()
    local b
    print(#_query)
    for i = 1, #_query do 
        b = _query[i].storeid
        for _, v in pairs(Config.Zones) do
            if v.Id == b then 
                v.hasOwner = true
            end
        end
    end
end)

function _Tunnel.ClotheStoreNoLongerAvaible(storeId)
    for _, v in pairs(Config.Zones) do
        if v.Id == storeId then 
            print(storeId, " não está mais disponível!")
            v.hasOwner = true
        end
    end
end

Citizen.CreateThread(function()
        for i, v in reversedipairs(cloth_hash_names) do
            if
                v.category_hashname ~= 'BODIES_LOWER' and v.category_hashname ~= 'BODIES_UPPER' and
                    v.category_hashname ~= 'heads' and
                    v.category_hashname ~= 'hair' and
                    v.category_hashname ~= 'teeth' and
                    v.category_hashname ~= 'eyes' and
                    v.category_hashname ~= 'beards_chin' and
                    v.category_hashname ~= 'beards_chops' and
                    v.category_hashname ~= '' and
                    v.category_hashname ~= 'beards_mustache'
             then
                if v.ped_type == 'female' and v.is_multiplayer then
                    ComponentNumber[v.category_hashname] = 1
                    if list_f[v.category_hashname] == nil then
                        list_f[v.category_hashname] = {}
                    end
                    table.insert(list_f[v.category_hashname], v.hash)
                elseif v.ped_type == 'male' and v.is_multiplayer then
                    ComponentNumber[v.category_hashname] = 1
                    if list[v.category_hashname] == nil then
                        list[v.category_hashname] = {}
                    end
                    table.insert(list[v.category_hashname], v.hash)
                end
            end
        end
    end
)

RegisterNUICallback('exit',function()
    TriggerServerEvent('redemrp_skin:loadSkin')
    ShowSkinCreator(false)
    destory()
end)

RegisterNUICallback("closeWithoutBuy", function()
    -->("closeWhitoutBuy")
    playerClothesData = cache;
    TriggerEvent("load::Clothes")
    ShowSkinCreator(false)
    destory();
end)

RegisterNUICallback('saveClothes',function(data)
    ShowSkinCreator(false)
    if act_store <=0 then return end;
        if clothingSv.pay() then  
            clothingSv.AddFunds(Config.PrecoVendaRoupa / Config.Divisao, act_store)
            TriggerEvent('x_copy:set', tostring(json.encode(data)))
            clothingSv.setClothes(json.encode(data))
            for k, v in pairs(data) do
                playerClothesData[k] = v
            end
            act_store = 0

            destory()
            TriggerEvent("Character:Reload")
            Wait(300)
            TriggerEvent('load::Clothes')
            TriggerEvent("xFramework:Notify", "sucesso", "Você comprou novas roupas")
    else 
        act_store = 0
        -->("closeWhitoutBuy")
        playerClothesData = cache;
        TriggerEvent("load::Clothes")
        TriggerEvent("xFramework:Notify", "negado", "Você não possuí dinheiro para comprar novas roupas.")
        destory();
    end 
end)

RegisterNUICallback('updateClothes',function(data)
        for k, v in pairs(data) do
            if ComponentNumber[k] ~= tonumber(v) and v ~= nil then
                ComponentNumber[k] = tonumber(v)
            if IsPedMale(PlayerPedId()) then
                Change(v, list, k)
            else
                Change(v, list_f, k)
            end
        end
    end
end)

function Change(id, t, category)
    local hash = t[category][tonumber(id)]
    if ComponentNumber[category] <= 1 then
        Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), GetHashKey(category), 0)
        if category == 'pants' or category == 'boots' then
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(legs), false, true, true)
        end

        if category == 'shirts_full' then
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(torso), false, true, true)
        end
    else
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), false, true, true)
    end
    Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
    Citizen.InvokeNative(0xAAB86462966168CE, PlayerPedId(), 1)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
end

local headingss = 334.00
RegisterNUICallback('heading',function(data)
        local playerPed = PlayerPedId()
        headingss = headingss + data.value
        SetEntityHeading(playerPed, headingss)
    end
)

RegisterNUICallback('camera',function(data)
        if data.zoom ~= nil then
            if c_zoom + data.zoom < 2.8 and c_zoom + data.zoom > 0.7 then
                c_zoom = c_zoom + data.zoom
            end
        end
        if data.offset ~= nil then
            if c_offset + data.offset < 1.2 and c_offset + data.offset > -1.0 then
                c_offset = c_offset + data.offset
            end
        end
        camera(c_zoom, c_offset)
    end
)

RegisterNUICallback('defcam',function()
        camera(2.8, -0.15)
        c_zoom = 2.8
        c_offset = -0.15
    end
)

function destory()
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 500, true, true)
    DisplayHud(true)
    DisplayRadar(true)
    DestroyAllCams(true)
    cam = nil
end

function camera(zoom, offset)
    DestroyAllCams(true)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = 45.0
    local zoomOffset = zoom
    local camOffset = offset
    local angle = heading * math.pi / 180.0
    local theta = {
        x = math.cos(angle),
        y = math.sin(angle)
    }
    local pos = {
        x = coords.x + (zoomOffset * theta.x),
        y = coords.y + (zoomOffset * theta.y)
    }
    local angleToLook = heading - 140.0
    if angleToLook > 360 then
        angleToLook = angleToLook - 360
    elseif angleToLook < 0 then
        angleToLook = angleToLook + 360
    end
    angleToLook = angleToLook * math.pi / 180.0
    local thetaToLook = {
        x = math.cos(angleToLook),
        y = math.sin(angleToLook)
    }
    local posToLook = {
        x = coords.x + (zoomOffset * thetaToLook.x),
        y = coords.y + (zoomOffset * thetaToLook.y)
    }
    local add = (1.3 * zoom)
    SetEntityHeading(playerPed, headingss)
    cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA',pos.x,pos.y,coords.z + camOffset,300.00,0.00,0.00,40.00,false,0)
    PointCamAtCoord(cam, posToLook.x - add, posToLook.y, coords.z + camOffset)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    DisplayHud(false)
    DisplayRadar(false)
end

Citizen.CreateThread(
    function()
        for _, v in pairs(Config.Zones) do
            local blip = N_0x554d9d53f696d002(1664425300, v.Position)
            SetBlipSprite(blip, Config.BlipSprite, 1)
            SetBlipScale(blip, Config.BlipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipName)
        end
    end
)

local active = false
Citizen.CreateThread(function()
    while true do
        local WaitTime = 500
        for _, v in pairs(Config.Zones) do 
            local dist = Vdist(GetEntityCoords(PlayerPedId()), v.BuyPos)
                if dist < 1 and not v.hasOwner then
                    -->(v.hasOwner, v.Id)
                WaitTime = 1
                Citizen.InvokeNative(0x2A32FAA57B937173,-1795314153, v.BuyPos.x - 0.6,v.BuyPos.y,v.BuyPos.z - 2.0,0,0,0,0,0,0,1.0,1.0,1.5,255,255,0,155,0,0,2,0,0,0,0)
                DrawText3D( v.BuyPos.x - 0.6,v.BuyPos.y,v.BuyPos.z-1, "Pressione ~e~[R]~p~ para comprar esta loja de roupas por ~d~ "..v.Price)
                if IsControlJustPressed(0, 0xE30CD707) then
                    if not confirm then 
                        TriggerEvent("xFramework:Notify", "aviso", "Pressione novamente para confirmar a compra ...")
                        confirm = true 
                    else 
                        clothingSv.buyClotheStore(v.Id, tonumber(v.Price))
                        confirm = false
                    end
                end
            end
        end
        Citizen.Wait(WaitTime) 
    end
end)
Citizen.CreateThread(function()
        while true do
            local Waitt = 500

            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            for _, v in pairs(Config.Zones) do
                local dist = Vdist(coords, v.Position)
                if dist < 3 then
                    Waitt = 1
                    Citizen.InvokeNative(0x2A32FAA57B937173,-1795314153, v.Position.x - 0.6,v.Position.y,v.Position.z - 2.0,0,0,0,0,0,0,1.0,1.0,1.5,255,255,0,155,0,0,2,0,0,0,0)
                    DrawText3D(  v.Position.x - 0.6,v.Position.y,v.Position.z-1, "Pressione ~e~[Espaço]~p~ para acessar a loja de roupas")
                    if dist < 2 then     
                        Waitt = 1 
                        if IsControlJustReleased(0, Config.OpenKey) then
                            if GetEntityModel(PlayerPedId()) ~= -171876066 and GetEntityModel(PlayerPedId()) ~= -1481695040 then TriggerEvent("xFramework:Notify", "negado", "Não é possível utilizar um ped que não seja os padrões 'mp' aqui.") goto continue end
                            camera(2.1, -0.15)
                            c_zoom = 2.1
                            c_offset = -0.15
                            ShowSkinCreator(true)
                            cache = playerClothesData
                            active = true 
                            act_store = v.Id;
                            ::continue::
                    end
                end
            end
        end
        Citizen.Wait(Waitt)
    end
end)

function GetClothesComponents()
    return {list, list_f}
end
RegisterNetEvent('incriacaostatuts')
AddEventHandler('incriacaostatuts',function(stts)
isInCriacao = stts 
end)


RegisterNetEvent('load::Clothes')
AddEventHandler('load::Clothes',function()
    print(GetEntityModel(PlayerPedId()))
    if GetEntityModel(PlayerPedId()) == -171876066 or GetEntityModel(PlayerPedId()) == -1481695040 then 
        local _playerClothesData = clothingSv.getClothes()
        _playerClothesData = json.decode(_playerClothesData)
        for k, v in pairs(_playerClothesData) do
            playerClothesData[k] = v
        end
        local t
        Wait(1000)
        if IsPedMale(PlayerPedId()) then
            t = list
        else
            t = list_f
        end
        if playerClothesData.name then
            playerClothesData.name = nil
        end
        if t == list_f then
            playerClothesData.dresses = nil
        else
            playerClothesData.skirts = nil
            playerClothesData.bows = nil
        end
        --(json.encode(playerClothesData))

        for k, v in pairs(playerClothesData) do
            if isInCriacao then break end;
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), t['gloves'][2], false, true, true)
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), GetHashKey('gloves'), 0)
            local id = v
            local category = k
            id = tonumber(id)
   
            if not t[category] then
                error('reporte: not catched error in(n out): ' .. category)
            else
                local hash = t[category][tonumber(id)]

                if id <= 1 then
                    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), GetHashKey(category), 0)
                    if category == 'pants' or category == 'boots' then
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(legs), false, true, true)
                    end

                    if category == 'shirts_full' then
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(torso), false, true, true)
                    end
                else
                    Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), tonumber(hash), false, true, true)
                end
                Citizen.InvokeNative(0x704C908E9C405136, PlayerPedId())
                Citizen.InvokeNative(0xAAB86462966168CE, PlayerPedId(), 1)
                Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            end
        end
    end
end)


RegisterCommand("reloadcloths", function()
    TriggerEvent("load::Clothes")
end)

function _Tunnel.inRegion()
    local resposta = false 
    local selectdIndex = 0;
    for _, v in pairs(Config.Zones) do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distancia = Vdist(v.commandLocation, playerCoords)
        print(distancia)
        -->(distancia)
        if distancia < 3 then 
            local selectdIndex = v.Id
            if clothingSv.own(v.Id) then 

                resposta = true 
                break
            else
                TriggerEvent("xFramework:Notify", "negado", "Esta loja não é sua <0x5>")
                resposta = false
                break;
            end
        else 
            TriggerEvent("xFramework:Notify", "negado", "Vá para o local do comando. <0x6>")
            resposta = false 
        end
    end 
    return resposta, selectdIndex
end

function _Tunnel.nearId()
    local resposta = false;
    for _, v in pairs(Config.Zones) do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distancia = Vdist(v.commandLocation, playerCoords)
        -->(distancia)
        if distancia < 3 then 
            if clothingSv.own(v.Id) then
                resposta = v.Id
            end
        end
    end
    return resposta;
end


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