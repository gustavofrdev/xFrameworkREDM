isInTrunk = false
local act_max_wei = 0.00
local act_horse_name= ""
local act_typ = ""
local _act_full = 0.00
local isK9 = false 
RegisterNetEvent("vrp.inventoryhud:refreshTrunk")
AddEventHandler("vrp.inventoryhud:refreshTrunk", function()
    updateTrunk()
end)

RegisterNetEvent("vrp.inventoryhud:K9OFF")
AddEventHandler("vrp.inventoryhud:K9OFF", function()
    isK9 = false 
end)
-- RegisterCommand("k9open", function(source, args, rawCommand)
-- TriggerEvent("vrp.inventoryhud:OpenTrunkForK9")
-- end )
RegisterNetEvent("vrp.inventoryhud:OpenTrunkForK9")
AddEventHandler("vrp.inventoryhud:OpenTrunkForK9", function()
    openTrunkK9()
end)

RegisterNetEvent("setActType")


function _Tunnel.openHorseC(data2, v, max_weight, actual, ped, _act_type )
    act_typ = _act_type
    local max_weight2 = max_weight
    act_max_wei = max_weight
    act_horse_name = ped
    _act_full = actual
    -- (act_typ)
    local c=json.decode(data2)
    local weight,data,max = InventarioSV.getInv(gridZone)
    isInInventory = true
    SendNUIMessage({ action = "display", type = "trunk" })
    SetNuiFocus(true, true)
            
    SendNUIMessage({ action = "setText", text = InventarioSV.stringName(), weight = weight, max = max })
    SendNUIMessage({ action = "setItems", itemList = data })
            
    SendNUIMessage({ action = "setSecondText", text = 'cavalo-' .. ped, weight = actual, max = tonumber(max_weight2) })
    SendNUIMessage({ action = "setSecondItems", itemList_ = data2 })
    
end


RegisterNUICallback("PutIntoTrunk", function(data, cb)
   
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("horses:addInventoryItemToThen", data.data.item, data.number, act_max_wei, act_horse_name, act_typ, _act_full)
    end
    updateInventory()
end)

RegisterNUICallback("TakeFromTrunk", function(data, cb)
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("horses:removeHorseItemToThen", data.data.item, data.number,  act_max_wei, act_horse_name, act_typ, _act_full)
    end
    updateInventory()
end)

