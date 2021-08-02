
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkSV = Proxy.getInterface("_xFramework")
FrameworkCL = Tunnel.getInterface("x_houses")
MultiCharacter = Tunnel.getInterface("x_houses")
_Tunnel = {}
Tunnel.bindInterface("x_houses", _Tunnel)

data = {}
BoughtHouses = {}

function int(n)
    return tonumber(n)
end
function _Tunnel.myHouse(id)
    local user_id = FrameworkSV.GetUserId(source)
    local houses = FrameworkSV.SQLExecute("SELECT house FROM xframework_personagens WHERE id = @id", {["@id"] = tonumber(user_id)})
    if houses == nil or houses == "null" or houses[1] == nil or houses[1] == "null" or houses[1].house == nil or houses[1].house == "null" then
        return false
    end
    return houses[1].house
end
function _Tunnel.CheckHouses(type)

	local _type = type
	local _source = source

    local result = FrameworkSV.SQLExecute('SELECT * FROM x_houses', {})
        if result ~= nil then
            for k,v in pairs(result) do
                --(v.id)
                table.insert(BoughtHouses, v.id)
            end
		end
			if _type == 'test' then
                FrameworkCL.SetBlips(_source, BoughtHouses)

			else
                FrameworkCL.PutBoughtHouses(-1, BoughtHouses)
			end
end

function _Tunnel.BuyHouse(price, id)
local _source = source
local _price = price
local _id = id
local user = FrameworkSV.GetUserId(_source )
	local user_money = FrameworkSV.GetUserMoney(tonumber(user))
       if user_money >= _price then

        FrameworkSV.TryPayment(user, tonumber(_price))

            FrameworkSV.SQLExecute("UPDATE xframework_personagens SET `house`='" .. id  .. "' WHERE `id`=@identifier ", {identifier = user})

                FrameworkCL.BoughtHouse(_source, _price, _id )
                _Tunnel.PutHouseOnDB(tonumber(_id))
        else
           TriggerClientEvent("xFramework:Notify", _source, 'negado', "você não tem dinheiro")
        end
    end


    function _Tunnel.PutHouseOnDB(id)
    FrameworkSV.SQLExecute("INSERT INTO x_houses (`id`) VALUES (@id)", {["@id"] = id})

end


local manejarDatabase = {
    ["Dump"] = function(house_number)
        local itens = FrameworkSV.SQLExecute("SELECT bau FROM x_houses WHERE id = @id ", {['@id'] = tonumber(house_number)})
              if json.encode(itens) ~= "[]" then
                itens = {}
                --(json.encode(itens)) -- #path finder
              else
                itens = itens[1].bau
                --(json.encode(itens)) -- #path finder
        end
        return itens
    end,

    ["AddItem"] = function(houseNumber,addItem, addItemQnt, maxPeso)
        local source = source
        -- print("src:", source)
        local user_id = FrameworkSV.GetUserId(source)
        
        local weights = (FrameworkSV.GetItemWeight(addItem))*int(maxPeso)
        local itens = FrameworkSV.SQLExecute("SELECT bau FROM x_houses WHERE id = @id ", {['@id'] = tonumber(houseNumber)})
        itens = itens[1].bau
        
        if int(weights) <= int(maxPeso) then
            if( FrameworkSV.TryGetInventoryItem(user_id, addItem, addItemQnt)) then 
        if json.encode(itens) ~= "[]" then
            itens = json.decode(itens)
            -- print(itens)
        if itens[addItem] then
            itens[addItem] = {amount = itens[addItem].amount + addItemQnt}
        elseif not itens[addItem] then
            itens[addItem] = {amount = addItemQnt}
        end
         __additem__ = FrameworkSV.SQLExecute("UPDATE x_houses SET bau = @newbau WHERE id = @id", {["@newbau"] = json.encode(itens), ["@id"] = houseNumber})
        end
        if json.encode(itens) == '[]' then
            -- print('it')
        local it = {}
        it[addItem] = {amount = addItemQnt}
        __additem__ = FrameworkSV.SQLExecute("UPDATE x_houses SET bau = @newbau WHERE id = @id", {["@newbau"] = json.encode(it), ["@id"] = houseNumber})
        TriggerClientEvent('Eventsss:Update', source)
            end
        end
    end
end,

    ["RemoveItem"] = function(houseNumber, removeItem, removeItemQnt)
        local source = source
        local user_id = FrameworkSV.GetUserId(source)
        local itens = FrameworkSV.SQLExecute("SELECT bau FROM x_houses WHERE id = @id ", {['@id'] = tonumber(houseNumber)})
        itens = itens[1].bau
        local item_w = (FrameworkSV.GetItemWeight(removeItem)) * removeItemQnt
        local _act_using_maininventory = FrameworkSV.GetInventoryUsingWeight(user_id)
	    local _act_max_maininventory = FrameworkSV.GetInventoryMaxWeight(user_id) - _act_using_maininventory
	    if  (_act_max_maininventory > item_w)  then
        if json.encode(itens) ~= "[]" then
            itens = json.decode(itens)
            if itens[removeItem] and itens[removeItem].amount >= removeItemQnt then 
          if itens[removeItem] and itens[removeItem].amount - removeItemQnt < 0 then
              local can = FrameworkSV.GiveInventoryItem(user_id, removeItem, int(removeItemQnt))
              if can and can == "fail" then 
				TriggerClientEvent("xFramework:Notify", source, "negado", "Os limites do inventário não foram respeitados.")
				return 
			end
            return
          end
          if itens[removeItem] and itens[removeItem].amount - removeItemQnt == 0 then
            itens[removeItem] = nil
            local can = FrameworkSV.GiveInventoryItem(user_id, removeItem, int(removeItemQnt))
            if can and can == "fail" then 
				TriggerClientEvent("xFramework:Notify", source, "negado", "Os limites do inventário não foram respeitados.")
				return 
			end
          end
            if itens[removeItem] then
            itens[removeItem] = {amount = itens[removeItem].amount - removeItemQnt}
            local can = FrameworkSV.GiveInventoryItem(user_id, removeItem, int(removeItemQnt))
            if can and can == "fail" then 
				TriggerClientEvent("xFramework:Notify", source, "negado", "Os limites do inventário não foram respeitados.")
				return 
			end
            end
         __additem__ = FrameworkSV.SQLExecute("UPDATE x_houses SET bau = @newbau WHERE id = @id", {["@newbau"] = json.encode(itens), ["@id"] = houseNumber})
         TriggerClientEvent('Eventsss:Update', source)
                end
            end
        end
    end,

    ["OpenBau"] = function(source, houseNumber)
        local source = source
        local user_id = FrameworkSV.GetUserId(source)
        local _key = nil
        local itens = {}
        for key, value in pairs(Config.Houses) do
            if value['number'] == houseNumber then
                _key = key
                break
            end
        end
         local house = Config.Houses[tonumber(_key)]
         local max_weight = house['maxWeight'] -- OK!
          local source = source
        local user_id = FrameworkSV.GetUserId(source)
         itens = FrameworkSV.SQLExecute("SELECT bau FROM x_houses WHERE id = @id ", {['@id'] = tonumber(houseNumber)})
         itens = itens[1].bau
         if json.encode(itens) ~= "[]" then
            itens = json.decode(itens)
         else
           itens = {}
     end
     -- print(user_id)
  
     TriggerEvent("OpenHouseInventory",user_id, itens, max_weight, houseNumber)
    end
    }

local reg = RegisterCommand

function _Tunnel.AbrirBau(bauId)
    manejarDatabase["OpenBau"](source, tonumber(bauId))
end

RegisterServerEvent("Update__MMMMMMhhhhhhhhhhMMMMMMMMMMMMMhhhhhhh__inventory___casas")
AddEventHandler("Update__MMMMMMhhhhhhhhhhMMMMMMMMMMMMMhhhhhhh__inventory___casas", function(hhHHHHHHHHHhhhhHhhHhHhHhHhHhhHhhHhHhHhhHhHhHhHh)
    local source = source 
    -- print('____src>:'..source)
    manejarDatabase["OpenBau"](source, tonumber(hhHHHHHHHHHhhhhHhhHhHhHhHhHhhHhhHhHhHhhHhHhHhHh))
end )

function create_new_event(event_name, event_function)
    RegisterNetEvent(event_name)
    AddEventHandler(event_name, event_function)
end 

create_new_event("NNNnnnnJJJnnnKKK:AddItemToInventoryHouseThen", function(houseNumber,addItem, addItemQnt, maxPeso)
    manejarDatabase["AddItem"](houseNumber,addItem, addItemQnt, maxPeso)
    local m = FrameworkSV.GetUserId(source).. " adicionou x"..addItemQnt.. " de "..addItem.. " a sua casa ["..houseNumber.."]"
    TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866433904482844752/7depqBHDJxHFTTUCJxAFFEzpgZ5-fHkt7TX_M9B0JX9plbqGfHSprL2Edg9tpoZw2k7h", m)
end)
create_new_event("NNNnnnnJJJnnnKKK_:RemoveInventoryFromItemThen", function(houseNumber, removeItem, removeItemQnt)
    manejarDatabase["RemoveItem"](houseNumber, removeItem, removeItemQnt)
    local m = FrameworkSV.GetUserId(source).. " Removeu x"..removeItem.. " de "..removeItemQnt.. " da sua casa ["..houseNumber.."]"
    TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866433904482844752/7depqBHDJxHFTTUCJxAFFEzpgZ5-fHkt7TX_M9B0JX9plbqGfHSprL2Edg9tpoZw2k7h", m)
end)

