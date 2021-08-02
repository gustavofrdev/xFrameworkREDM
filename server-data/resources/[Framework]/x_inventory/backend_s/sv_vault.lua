local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Tools = module('Server/CallBack/Callback_Tools')


Base = {}

Base.Upadate = function()
end

RegisterServerEvent('OpenHouseInventory')
AddEventHandler(
    'OpenHouseInventory',
    function(user_id, items, pesoMaximo, houseId)
        print('exec')
        user_id = tonumber(user_id)
        print(json.encode(items))
        items = items
        local actual = 0.00
        local dat = {}
        local source = Framework.GetUserSource(tonumber(user_id))
        local path_icon = {}
        if items ~= '' then
            for k, v in pairs(items) do
                path_icon[k] = Framework.GetItemPhotoPath(k)
                print(k)
                local itemName = k
                if string.find(itemName, '_0x') then
                    itemName = itemName:match('(.*_0x)')
                end

                v.item = k
                v.weight = Framework.GetItemWeight(k) * tonumber(v.amount)
                v.name = Framework.GetItemLabel(k) .. ' ' .. getItemExtraNameIf(k)
                v.icon = path_icon[k] .. '.png'
                v.desc = Framework.GetItemDesc(k) .. getItemExtraDescIf(k)
                table.insert(dat, v)
            end
            Inventory.OpenHouse(source, dat, pesoMaximo, actual, houseId)
        end
    end
)
