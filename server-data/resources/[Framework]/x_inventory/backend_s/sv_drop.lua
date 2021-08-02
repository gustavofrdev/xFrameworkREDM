local items = {}
local zones = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(zones) do
			if v > 0 then
				zones[k] = v - 1
			end
		end
	end
end)
function _Tunnel.PickUpDroppedItem(coords, zone, item, amount )
	local user_id = Framework.GetUserId(source)
	
	local source = source
	if not zones[zone] or zones[zone] == 0 then
		zones[zone] = 1
		if user_id then
			local _,id = getDropList(zone, coords.x, coords.y, coords.z)

			if amount == 0 then
				amount = items[zone][tostring(id)].slots[item].amount
			end
			
			if items[zone][tostring(id)].slots[item].amount >= amount then
				if Framework.GetInventoryUsingWeight(user_id) and amount > 0 then
					local can = Framework.GiveInventoryItem(user_id, item, amount)
					local m = user_id .. " Pegou x"..amount.. " de "..item.. "Que estavam no chão. (DROP): "
                    TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866432381476274177/dqinwXATTdJ0AGoFVxp9ZnKHc9zEdYSl-cariSbnIkLm0TjudYzSM0eJeK1ahLLNagY9", m)
					if can and can == "fail" then 
						TriggerClientEvent("xFramework:Notify", source, "negado", "Os limites do inventário não foram respeitados.")
						return 
					end
					items[zone][tostring(id)].slots[item].amount = items[zone][tostring(id)].slots[item].amount - amount
					
					if items[zone][tostring(id)].slots[item].amount == 0 then
						items[zone][tostring(id)].slots[item] = nil
					end

					if tableTostring(items[zone][tostring(id)].slots) == "{}" then
						
						Inventory.remove(-1, zone, id)
						idgens:free(id)
						items[zone][tostring(id)] = nil
					end
				end
			end
		end
	else
		return
	end
end
function _Tunnel.DropItem(x,y,z, zone, item, amount )

	local source = source
	local user_id = Framework.GetUserId(source)
	

	if user_id then
		if Framework.GetInventoryItemAmount(user_id,item) >= amount and amount >= 0 then
			if amount == 0 then
				amount = Framework.GetInventoryItemAmount(user_id, item)
				dropItem(user_id, zone, x,y,z, item, amount)
				local m = user_id .. " dropou x"..amount.. " de "..item.. " nas cds "..x.. " ".. y .. " ".. z
                    TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866432381476274177/dqinwXATTdJ0AGoFVxp9ZnKHc9zEdYSl-cariSbnIkLm0TjudYzSM0eJeK1ahLLNagY9", m)
			else
				local m = user_id .. " dropou x"..amount.. " de "..item.. " nas cds "..x.. " ".. y .. " ".. z
                    TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866432381476274177/dqinwXATTdJ0AGoFVxp9ZnKHc9zEdYSl-cariSbnIkLm0TjudYzSM0eJeK1ahLLNagY9", m)
				dropItem(user_id, zone, x,y,z, item, amount)
			end
		end
	end
end

function dropItem(user_id, zone, px, py, pz, item, amount)
	local user_id = Framework.GetUserId(source)
	
	-- print("^1", px, py, pz)
	local drop, _id = getDropList(zone, px, py, pz)
	for k,v in pairs(drop) do
		if v then
			local id = _id
			local newList = items[zone]
			
			if newList[tostring(id)].slots[item] then
				newList[tostring(id)].slots[item].amount = newList[tostring(id)].slots[item].amount + amount
				Framework.TryGetInventoryItem(user_id, item, amount)
				local m = user_id .. " dropou x"..amount.. " de "..item.. " nas cds "..px.. " ".. py .. " ".. pz
                    TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866432381476274177/dqinwXATTdJ0AGoFVxp9ZnKHc9zEdYSl-cariSbnIkLm0TjudYzSM0eJeK1ahLLNagY9", m)
				return
			else
				local newItem = { tempo = 900, item = item, amount = amount }
				newList[tostring(id)].slots[item] = newItem
				Inventory.createForAll(-1, id, zone, newList[tostring(id)])
				Framework.TryGetInventoryItem(user_id, item, amount)
				local m = user_id .. " dropou x"..amount.. " de "..item.. " nas cds "..px.. " ".. py .. " ".. pz
                    TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866432381476274177/dqinwXATTdJ0AGoFVxp9ZnKHc9zEdYSl-cariSbnIkLm0TjudYzSM0eJeK1ahLLNagY9", m)
				return
			end
		end
	end

	local id = idgens:gen()
	if not items[zone] then items[zone] = {} end
	local newList = items[zone]

	local newItem = { tempo = 900, item = item, amount = amount }
	newList[tostring(id)] = { id = id, x = px, y = py, z = pz, slots = { [item] = newItem }}
	Inventory.createForAll(-1, id, zone, newList[tostring(id)])
	
	Framework.TryGetInventoryItem(user_id, item, amount)
end




function getDropList(zone, x, y, z)
	local source = source
	if not items[zone] then items[zone] = {} end
	-- print(json.encode(items))
	
	for k,v in pairs(items[zone]) do
		-- print(_Framework.GetDistance(source, v.x, v.y, v.z, x, y, z))
		if _Framework.GetDistance(source, v.x, v.y, v.z, x, y, z) <= 0.5 then
			return v.slots or {}, v.id
		end
	end

	return {}
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(items) do
			for i,j in pairs(items[k]) do
				for a,b in pairs(j.slots) do
					if b.tempo > 0 then
						b.tempo = b.tempo - 1
						if b.tempo <= 0 then
							j.slots[a] = nil
							if tableTostring(j.slots) == "{}" then
								Inventory.remove(-1, k, j.id)
								idgens:free(j.id)
								v[tostring(j.id)] = nil
							end
						end
					end
				end
			end
		end
	end
end)