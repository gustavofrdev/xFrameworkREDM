
local _act_house_open = 0
local _act_house_open_maxQ = 0.00
local _act 
function _Tunnel.OpenHouse(itemsChest, maxWeightChest, actual, houseId)
	_act_house_open = houseId
	_act_house_open_maxQ = maxWeightChest 
	_act = actual
	-- ('open_house')
	local weight,data,max = InventarioSV.getInv(gridZone)
	if itemsChest then 
	itemsChest = json.encode(itemsChest)
	end
	local mw = tonumber(maxWeightChest)
    SendNUIMessage({ action = "display", type = "vault" })
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "setText", text = InventarioSV.stringName(), weight = weight, max = max })
    SendNUIMessage({ action = "setItems", itemList = data })
    SendNUIMessage({ action = "setSecondText", text = 'Casa-' .. math.random(0, 9999	), weight = actual, max = mw })
    SendNUIMessage({ action = "setSecondItems", itemList_ = itemsChest })
end

function openChest()
	local weight,data,max = _Tunnel.getInv(gridZone)
	local data2,weight2 = _Tunnel.loadChest(currentChest)
	if data2 then
		isInInventory = true
		SendNUIMessage({ action = "display", type = "chest" })
		SetNuiFocus(true, true)
		local chest = Chest.NearChestDisplayName()
		local nearChestPeso = ChestS.GetBauMaxWeight(chest)
		SendNUIMessage({ action = "setText", text = InventarioSV.stringName(), weight = weight, max = max })
		SendNUIMessage({ action = "setItems", itemList = data })
		
		SendNUIMessage({ action = "setSecondText", text = 'chest-' .. currentChest, weight = weight2, max = nearChestPeso  })
		SendNUIMessage({ action = "setSecondItems", itemList_ = data2 })
	end
end

function updateChest()
	local data2,weight2 = _Tunnel.loadChest(currentChest)
	local chest = Chest.NearChestDisplayName()
	local nearChestPeso = ChestS.GetBauMaxWeight(chest)
	SendNUIMessage({ action = "display", type = "chest" })

    SendNUIMessage({ action = "setSecondText", text = 'chest-' .. currentChest, weight = weight2, max = nearChestPeso })
    SendNUIMessage({ action = "setSecondItems", itemList_ = data2 })
end

RegisterNUICallback("PutIntoVault", function(data, cb)
    if type(data.number) == "number" and math.floor(data.number) == data.number then
		TriggerServerEvent("NNNnnnnJJJnnnKKK:AddItemToInventoryHouseThen",_act_house_open, data.data.item, data.number, _act_house_open_maxQ)
    end
	
    updateInventory()
	TriggerServerEvent("Update__MMMMMMhhhhhhhhhhMMMMMMMMMMMMMhhhhhhh__inventory___casas", _act_house_open)
end)


RegisterNUICallback("TakeFromVault", function(data, cb)
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("NNNnnnnJJJnnnKKK_:RemoveInventoryFromItemThen",_act_house_open, data.data.item, data.number)
    end
	updateInventory()
	TriggerServerEvent("Update__MMMMMMhhhhhhhhhhMMMMMMMMMMMMMhhhhhhh__inventory___casas", _act_house_open)
end)
