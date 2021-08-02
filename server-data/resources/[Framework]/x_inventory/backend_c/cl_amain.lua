local Tunnel = module("Server/CallBack/Callback_Tunnel")
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tools = module("Server/CallBack/Callback_Tools")

_Tunnel = {}
InventarioSV = Tunnel.getInterface("x_inventory")
InventarioCL = Proxy.getInterface("x_inventory")

FrameworkSV = Tunnel.getInterface("_xFramework")
FrameworkCL = Proxy.getInterface("_xFramework")

Proxy.addInterface("x_inventory",_Tunnel)
Tunnel.bindInterface("x_inventory",_Tunnel)




------------------------------------------------------------------------------------------------------------------------------------------------------
-- Variáveis ( NÃO ALTERAR )
------------------------------------------------------------------------------------------------------------------------------------------------------

isInInventory = false
gridZone      = 0
canOpen       = true

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Threads
------------------------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function() -- Open Inventory (K)
    while true do
        Citizen.Wait(5)
        if IsControlJustPressed(1,0xD8F73058)  then
            openInventory()
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Funções
------------------------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("onResourceStop",function()
	if GetCurrentResourceName() then
        closeInventory()
	end
end)

RegisterNetEvent('debug:nui')
AddEventHandler('debug:nui', function()
    SetNuiFocus(false, false)
end)

-- Functions

function openInventory()
    local weight,data,max = InventarioSV.getInv(gridZone)
    local drop = InventarioSV.getDrop(gridZone)
    SendNUIMessage({ action = "display", type = "drop" })
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "setText", text = InventarioSV.stringName(), weight = weight, max = max })
    SendNUIMessage({ action = "setItems", itemList = data })
    SendNUIMessage({ action = "setSecondText", text = 'drop-' .. gridZone })
    SendNUIMessage({ action = "setSecondItems", itemList_ = drop })
    isInInventory = true
 
end


function updateDrop()
    local drop = InventarioSV.getDrop(gridZone)
    SendNUIMessage({ action = "setSecondText", text = 'drop-' .. gridZone })
    SendNUIMessage({ action = "setSecondItems", itemList_ = drop })
end

function closeInventory()
    isInInventory = false

    SendNUIMessage({ action = "hide" })
    SetNuiFocus(false, false)
    InventarioSV.closeTrunkChests()
    InventarioSV.closeVaults()
    InventarioSV.closeStaticChests()
end

function updateInventory()
    local weight,data,max = InventarioSV.getInv(gridZone)
    SendNUIMessage({ action = "setText", text = InventarioSV.stringName(), weight = weight, max = max })
    SendNUIMessage({ action = "setItems", itemList = data })
end




------------------------------------------------------------------------------------------------------------------------------------------------------
-- Callbacks
------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("NUIFocusOff", function()
    closeInventory()
end)

RegisterNUICallback("SendItem", function(data)
    local near, _, src = FrameworkCL.GetNearestPlayer(3)
    if near > 0 then 
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("x_inventory:sendItem", src, data.data.item, data.number)
            -- TriggerEvent("xFramework:Notify", "sucesso", "enviando para ")
        end
    else 
        TriggerEvent("xFramework:Notify", "negado", "não há nennhum jogador próximo")
    end 
end)
RegisterNUICallback("UseItem", function(data, cb)
    
    
    if string.find(data.data.item, "carta_0x") then 
        TriggerEvent("WriteCard", data.data.item)
        closeInventory()
        return
    end
    InventarioSV.useItem(data.data.item, data.number);
    closeInventory()
end)

function table_to_string(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-1)
    end
    return "{"..result.."}"
end

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Zonas
------------------------------------------------------------------------------------------------------------------------------------------------------

local deltas = {
    vector2(-1, -1),
    vector2(-1, 0),
    vector2(-1, 1),
    vector2(0, -1),
    vector2(1, -1),
    vector2(1, 0),
    vector2(1, 1),
    vector2(0, 1),
}

local function getGridChunk(x)
    return math.floor((x + 8192) / 128)
end

local function toChannel(v)
    return (v.x << 8) | v.y
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local coords = GetEntityCoords(PlayerPedId())
        local gz = vector2(getGridChunk(coords.x), getGridChunk(coords.y))
        gridZone = toChannel(gz)
        
    end
end)
