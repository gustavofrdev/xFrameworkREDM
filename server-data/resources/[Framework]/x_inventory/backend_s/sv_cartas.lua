

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

RegisterServerEvent('OpenMyLetters')
AddEventHandler('OpenMyLetters',function(user_id)
        user_id = tonumber(user_id)
        local __d = Framework.SQLExecute("SELECT data FROM xframework_cartas_correspondencias WHERE id = @id", {["@id"] = user_id})
        local actual = 0.00
        local dat = {}
        local source = Framework.GetUserSource(tonumber(user_id))
        local path_icon = {}
        if __d and __d[1] and __d[1].data then
           local items = json.decode(__d[1].data)
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
                table.insert(dat, v)
            end
        end
        Inventory.OpenCartas(source, dat, tonumber(user_id))
    end
)
