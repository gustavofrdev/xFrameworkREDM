local dropList = {}


function _Tunnel.remove(zone, id)
	if dropList[zone][tostring(id)] then
		dropList[zone][tostring(id)] = nil
	end
end
function _Tunnel.createForAll(id, zone, marker)
	if not dropList[zone] then dropList[zone] = {} end
	dropList[zone][tostring(id)] = marker
end

local cooldown = false
Citizen.CreateThread(function()
	while true do
		idle = 500

		if dropList[gridZone] then
			idle = 1

			for k,v in pairs(dropList[gridZone]) do
				local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
                -- ('p1: ', x,y,z)
                -- ('p2: ', v.x, v.y, v.z)
				if GetDistanceBetweenCoords(v.x,v.y,v.z, x,y,z, true) <= 3.5 then

                    
                Citizen.InvokeNative(0x2A32FAA57B937173,0x94FDAE17, v.x,v.y,v.z-0.8,0,0,0,0,0,0,0.3,0.3,0.2,0,255,255,155,0,0,2,0,0,0,0)
				end
			end
		end
		
		Citizen.Wait(idle)
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------
-- Drop Callbacks
------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("DropItem", function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end


    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    -- local x, y, z table.unpack(GetEntityCoords(PlayerPedId()))
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        -- TriggerServerEvent("b03461cc:pd-inventory:dropItem", GetEntityCoords(PlayerPedId()), gridZone, data.data.item, data.number)
		InventarioSV.DropItem(x, y, z, gridZone, data.data.item, data.number)
    end
	updateInventory()
	updateDrop()
end)

RegisterNUICallback("PickupItem", function(data, cb)
    
    if type(data.number) == "number" and math.floor(data.number) == data.number then
		InventarioSV.PickUpDroppedItem(GetEntityCoords(PlayerPedId()), gridZone, data.data.item, data.number)
    end
    updateInventory()
    updateDrop()
end)

function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=SetDrawOrigin(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.1*scale, 0.30*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.40)
        SetTextColour(r, g, b, 175)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        ClearDrawOrigin()
    end
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, 'LITERAL_STRING', str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    n(0xADA9255D, 1)
    DisplayText(str, x, y)
end
