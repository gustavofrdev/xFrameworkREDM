local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
local Tools = module("Server/CallBack/Callback_Tools")

RegisterServerEvent('OpenHorseInventory')
AddEventHandler(
    'OpenHorseInventory',
    function(items, anData, id, pesomax_this, act_act_ped, type)
        --  ('^2 ' , type)
        local actual = 0.00
        dat = {}
        source = tonumber(Framework.GetUserSource(tonumber(id)))
        user_id = id
        local path_icon = {}
        if items ~= '' then
            for k, v in pairs(items) do
                path_icon[k] = Framework.GetItemPhotoPath(k)
                local itemName = k
                if string.find(itemName,"_0x") then
                    itemName = itemName:match("(.*_0x)")
                end
                v.item   = k
                v.weight = Framework.GetItemWeight(k) * tonumber(v.amount)
                v.name   = Framework.GetItemLabel(k).. " ".. getItemExtraNameIf(k)
                v.icon   = path_icon[k] .. ".png"
                v.desc   = Framework.GetItemDesc(k) .. getItemExtraDescIf(k)

                actual = (actual) + (v.weight)

                table.insert(dat, v)
            end
            source = tonumber(Framework.GetUserSource(tonumber(id)))
            Inventory.openHorseC(source, json.encode(dat), json.encode(dat), pesomax_this, actual, act_act_ped, type)
        end
    end
)
RegisterServerEvent('horses:addInventoryItemToThen')
AddEventHandler(
    'horses:addInventoryItemToThen',
    function(_item_name, _item_qnt, act_max_wei, act_horse_name, _act_type, _act_full)
        local source = source
        local user_id = Framework.GetUserId(source)
        local item_w = (Framework.GetItemWeight(_item_name)) * _item_qnt + _act_full
        if _item_qnt > 0 then
            if tonumber(act_max_wei) >= item_w then
                if (Framework.TryGetInventoryItem(user_id, _item_name, tonumber(_item_qnt))) then
                    local _Dump =
                        Framework.SQLExecute(
                        'SELECT * FROM xframework_cavalos WHERE id = @id',
                        {['@id'] = tonumber(user_id)}
                    )
                    local SEL = ''
                    -- print(_act_type == "cavalo")
                    local cond = _act_type == 'cavalo'
                    if cond then
                        -- (act_horse_name)
                        _Dump = json.decode(_Dump[1].horses)
                        SEL = 'horses'
                    elseif not cond then -- (_act_type ~ cavalo)
                        _Dump = json.decode(_Dump[1].vehicles)
                        SEL = 'vehicles'
                    end
                    local m = user_id .. " Adicionou x".._item_qnt.. " de ".._item_name.. " Ao seu cavalo/carroça: "..act_horse_name
                    TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866431772106293249/hfjBKLaORcLqvEjShV_d1dYdZjmfm6R_m_eZUYdhY7Bt9mVeZtLuRI0YLJt19_qFcFpu", m)
                    if (_Dump[act_horse_name].inventario[_item_name]) then
                        _Dump[act_horse_name].inventario[_item_name] = {
                            amount = _Dump[act_horse_name].inventario[_item_name].amount + _item_qnt
                        }
                    else
                        _Dump[act_horse_name].inventario[_item_name] = {amount = _item_qnt}
                    end
                    Framework.SQLExecute(
                        'UPDATE xframework_cavalos SET ' .. SEL .. '  = @horses WHERE id = @id',
                        {['@horses'] = json.encode(_Dump), ['@id'] = tonumber(user_id)}
                    )
                    TriggerClientEvent('trigger:0x1012-012', source)
                else
                    TriggerClientEvent('xFramework:Notify', source, 'negado', 'Você não isso tudo de ' .. _item_name)
                end
            else
                TriggerClientEvent('xFramework:Notify', source, 'negado', 'Não há espaço suficiente para armazenar')
            end
        end
    end
)
RegisterServerEvent('horses:removeHorseItemToThen')
AddEventHandler(
    'horses:removeHorseItemToThen',
    function(_item_name, _item_qnt, act_max_wei, act_horse_name, _act_type, _act_full)
        local source = source
        local user_id = Framework.GetUserId(source)
        local item_w = (Framework.GetItemWeight(_item_name)) * _item_qnt
        local _act_using_maininventory = Framework.GetInventoryUsingWeight(user_id)
        local _act_max_maininventory = Framework.GetInventoryMaxWeight(user_id) - _act_using_maininventory
        if (_act_max_maininventory > item_w) then
            local _Dump =
                Framework.SQLExecute('SELECT * FROM xframework_cavalos WHERE id = @id', {['@id'] = tonumber(user_id)})
            local SEL = ''
            local cond = _act_type == "cavalo"
            if cond then
                -- (act_horse_name)
                _Dump = json.decode(_Dump[1].horses)
                SEL = 'horses'
            elseif not cond then -- (_act_type ~ cavalo)
                _Dump = json.decode(_Dump[1].vehicles)
                SEL = 'vehicles'
            end
            local m = user_id .. " Removeu x".._item_qnt.. " de ".._item_name.. " Ao seu cavalo/carroça: "..act_horse_name
            TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866431772106293249/hfjBKLaORcLqvEjShV_d1dYdZjmfm6R_m_eZUYdhY7Bt9mVeZtLuRI0YLJt19_qFcFpu", m)
            if
                _Dump[act_horse_name].inventario[_item_name] and
                    _Dump[act_horse_name].inventario[_item_name].amount >= _item_qnt
             then
                if (_Dump[act_horse_name].inventario[_item_name].amount == _item_qnt) then
                    _Dump[act_horse_name].inventario[_item_name] = nil
                else
                    _Dump[act_horse_name].inventario[_item_name] = {
                        ['amount'] = _Dump[act_horse_name].inventario[_item_name].amount - _item_qnt
                    }
                end
                local can = Framework.GiveInventoryItem(user_id, _item_name, tonumber(_item_qnt))
                if can and can == "fail" then 
                    TriggerClientEvent("xFramework:Notify", source, "negado", "Os limites do inventário não foram respeitados.")
                    return 
                end
                Framework.SQLExecute(
                    'UPDATE xframework_cavalos SET ' .. SEL .. ' = @horses WHERE id = @id',
                    {['@horses'] = json.encode(_Dump), ['@id'] = tonumber(user_id)}
                )
                TriggerClientEvent('trigger:0x1012-012', source)
            end
        else
            TriggerClientEvent('xFramework:Notify', source, 'negado', 'Não há espaço suficiente para armazenar')
        end
    end
)
