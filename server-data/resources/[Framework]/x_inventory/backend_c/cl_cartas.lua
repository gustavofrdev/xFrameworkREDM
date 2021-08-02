 _ac_id = 0
function _Tunnel.OpenCartas(items, id)
    _ac_id = id
	local weight,data,max = InventarioSV.getInv(gridZone)
	items = json.encode(items)
	local mw = tonumber(maxWeightChest)
    SendNUIMessage({ action = "display", type = "cartas" })
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "setText", text = InventarioSV.stringName(), weight = weight, max = max })
    SendNUIMessage({ action = "setItems", itemList = data })
    SendNUIMessage({ action = "setSecondText", text = 'Cartas_chest-' .. math.random(0, 999), weight = 0, max = 0 })
    SendNUIMessage({ action = "setSecondItems", itemList_ = items })
end

RegisterNUICallback("TakeFromCartas", function(data, cb)
    print("?")
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        print("?")
        local item_hash_removed = data.data.item:match("(.*_0x)")
		local item_only_hash = data.data.item:gsub(item_hash_removed, "")
		TriggerServerEvent("removeCartaFromUserData",item_only_hash, _ac_id)
    end
    updateInventory()
	TriggerServerEvent("OpenMyLetters", _ac_id)
end)
