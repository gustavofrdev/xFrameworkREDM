local info = {}
local imHasPermission = false
local canStt = false 
function _Framework.InsertData(source, user_id, stts)
    info[user_id] = {
        source = source,
        player = GetPlayerFromServerId(source)
    }
    imHasPermission = stts
    canStt = true 
end
function _Framework.RemoveData(user_id)
    info[user_id] = nil
end
Citizen.CreateThread(function()
while true do 
    Citizen.Wait(0)
    while not canStt do Wait(0) end
    if IsControlPressed(0, 0x580C4473) then 
        if imHasPermission then
            for k, v in pairs(info) do
                local p = GetPlayerPed(v.player)
                if p ~= PlayerPedId() then 
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(p) , true) < 8 then
                        local x, y, z = table.unpack(GetEntityCoords(p))
                        DrawText3D(x, y, z, tostring(k))
                        end
                    end
                end
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
