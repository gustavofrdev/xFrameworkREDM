local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
local Tools = module("Server/CallBack/Callback_Tools")
idgens = Tools.newIDGenerator()
_Framework = Tunnel.getInterface("_xFramework")
Framework = Proxy.getInterface("_xFramework")
Inventory = Tunnel.getInterface("x_inventory")
Cartas = Proxy.getInterface("x_cartas")
_Tunnel = {}
Tunnel.bindInterface("x_inventory", _Tunnel)


function _Tunnel.stringName()

return Framework.GetUserName(Framework.GetUserId(source))
end
function getItemExtraNameIf(item)
	if string.find(item,"_0x") then
		local item_hash_removed = item:match("(.*_0x)")
		local item_only_hash = item:gsub(item_hash_removed, "")
		local _d = Cartas.getCartaData(item_only_hash)
		
		return "de ".._d.autorNAME
	else
		return ""
	end
end
function getItemExtraDescIf(item)
	if string.find(item,"_0x") then
		local item_hash_removed = item:match("(.*_0x)")
		local item_only_hash = item:gsub(item_hash_removed, "")
		local _d = Cartas.getCartaData(item_only_hash)
		
		return "carta de ".._d.autorNAME.. " para ".._d.recebedorNAME
	else
		return ""
	end
end

function _Tunnel.getInv(zone)
	local source = source
	local user_id = Framework.GetUserId(source)
	local weight = 0.0
	if user_id then
		 local max = Framework.GetInventoryMaxWeight(user_id)

		local inventario = Framework.GetInventory(user_id)
		local path_icon = {}
		local res  = {}
		for k, v in pairs(inventario) do
			print(k, Framework.GetItemPhotoPath(k))
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
			table.insert(res, v)
			weight = weight + ( Framework.GetItemWeight(k) * tonumber(v.amount) )
		end
		return weight,json.encode(res),max
	end
end

function _Tunnel.useItem(item_id, qnt)
	print(item_id)
	Framework.UseInventoryItem(item_id, Framework.GetUserId(source), qnt)
end


function _Tunnel.getDrop(zone)
	local source = source
	local user_id = Framework.GetUserId(source)
	local pCoords = _Framework.GetPosition(source)
	local path_icon = {}
		local drop = getDropList(zone, pCoords.x, pCoords.y, pCoords.z)
		-- print(json.encode(drop))
		local resDrop = {}
		for k,v in pairs(drop) do
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

			table.insert(resDrop, v)
		end
	return json.encode(resDrop)
end

-- function _Tunnel.getIdentity()
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		local identity = vRP.getUserIdentity(user_id)
-- 		local job = vRP.getUserGroupByType(user_id,"job")
-- 		local cash = vRP.getMoney(user_id)
-- 		local bank = vRP.getBankMoney(user_id)
-- 		local tax = json.decode(vRP.getUData(user_id,"vRP:multas")) or 0
-- 		local job = vRP.getUserGroupByType(user_id,"job")
-- 		local vipName = vRP.getUserGroupByType(user_id,"vip")
-- 		local vipTime = 0
-- 		local coins = vRP.getCoins(user_id)

-- 			return identity.name,identity.firstname,user_id,identity.age,identity.registration,identity.phone,vRP.format(parseInt(cash)),vRP.format(parseInt(bank)),vRP.format(parseInt(paypal)),vRP.format(parseInt(tax)),job,vipName,0,vRP.format(parseInt(coins))
		
-- 	end
-- end

function getDayHours(seconds)
	if seconds > 0 then
		local days = math.floor(seconds/86400)
		seconds = seconds - days * 86400
		local hours = math.floor(seconds/3600)

		if days > 0 then
			return string.format("%d Dias e %d Horas",days,hours)
		else
			return string.format("%d Horas",hours)
		end
	else
		return string.format("Nenhum")
	end
end

function tableTostring(tbl)
    local result, done = {}, {}

    local function val_to_str ( v )
        if "string" == type( v ) then
            v = string.gsub( v, "\n", "\\n" )
            
            if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
                return "'" .. v .. "'"
            end
                
            return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
        else
            return "table" == type( v ) and tableTostring( v ) or
            tostring( v )
        end
    end
      
    local function key_to_str ( k )
        if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
            return k
        else
            return "[" .. val_to_str( k ) .. "]"
        end
    end

    for k, v in ipairs( tbl ) do
        table.insert( result, val_to_str( v ) )
        done[ k ] = true
    end

    for k, v in pairs( tbl ) do
      if not done[ k ] then
        table.insert( result, key_to_str( k ) .. "=" .. val_to_str( v ) )
        end
    
    end
    return "{" .. table.concat( result, "," ) .. "}"
end

RegisterServerEvent("x_inventory:sendItem")
AddEventHandler("x_inventory:sendItem", function(nearSource, item, amount)
	local near_id = Framework.GetUserId(nearSource)
	local myId = Framework.GetUserId(source)
	if Framework.TryGetInventoryItem(myId, item, amount) then 
		local can_send = Framework.GiveInventoryItem(near_id, item, amount)
		TriggerClientEvent("xFramework:Notify", source, "sucesso", "Item(s) enviados...")
		if can_send == "fail" then 
			-- ==> Devolver <==
			TriggerClientEvent("xFramework:Notify", source, "sucesso", "Modulo do Inventário retornou falha no envio. Item sendo devolvido para você. Provavelmente o jogador alvo não tem espaço suficiente no inventário para receber esse item com esta quantidade.")
			Framework.GiveInventoryItem(myId, item, amount)
		end
	end
end)