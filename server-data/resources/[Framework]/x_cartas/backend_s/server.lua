local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')

x_cartasSV = Proxy.getInterface('x_cartas')
x_cartasCL = Tunnel.getInterface('x_cartas')
FrameworkSV = Proxy.getInterface('_xFramework')
FrameworkCL = Tunnel.getInterface('_xFramework')

Function = {}
Proxy.addInterface('x_cartas', Function)
Tunnel.bindInterface('x_cartas', Function)


function Function.getCartaData(hash)
    local data = FrameworkSV.SQLExecute("SELECT autorID, recebedorID, conteudo, autorNAME, recebedorNAME FROM xframework_cartas WHERE hash = @hash", {["@hash"] = hash})	
		  if data and data[1] then 
			data = data[1]
    local autorID = data.autorID
    local recebedorID = data.recebedorID 
    local conteudo = data.conteudo
    local autorNAME = data.autorNAME
	local recebedorNAME = data.recebedorNAME
    return {
        autorID = autorID,
        recebedorID = recebedorID,
        conteudo = conteudo,
        autorNAME = autorNAME,
        recebedorNAME = recebedorNAME
    }

	else return {
	autorID = 0,
	recebedorID = 0,
	conteudo = "não há",
	autorNAME = "Invalido",
	recebedorNAME = "Invalido"
	}
end
end

function Function.payTax(tax)
	return FrameworkSV.TryPayment(FrameworkSV.GetUserId(source), tonumber(tax))
end

function Function.generateNewCartaHash()

    return hash()
end

function Function.open()
	local id= FrameworkSV.GetUserId(source)
    TriggerEvent("OpenMyLetters", id)
end

function alreadyRegistredHashs()
	local hashs = FrameworkSV.SQLExecute("SELECT hash FROM xframework_cartas",{})
	if  hashs and hashs[1] and hashs[1].hash then 
		return hashs[1].hash
	else 
		return true 
	end
end

function addNewLetterToUserData(hex, id)
	local old_data = FrameworkSV.SQLExecute("SELECT * FROM xframework_cartas_correspondencias WHERE id = @id", {["@id"] = tonumber(id)})
		if old_data and old_data[1] then 
			-- if type(old_data) ~= "table" then
			old_data = old_data[1].data 
			old_data = json.decode(old_data)
			old_data["carta_0x"..hex] = {['amount'] = 1}
			FrameworkSV.SQLExecute("UPDATE xframework_cartas_correspondencias SET data = @data WHERE id = @id",{["@data"] = json.encode(old_data), ["@id"] = tonumber(id)})

		else
		FrameworkSV.SQLExecute("INSERT INTO xframework_cartas_correspondencias(id) VALUES(@id)", {["@id"] = tonumber(id)})
			local new = {}
			new["carta_0x"..hex] = {['amount'] = 1}
			FrameworkSV.SQLExecute("UPDATE xframework_cartas_correspondencias SET data = @data WHERE id = @id",{["@data"] = json.encode(new), ["@id"] = tonumber(id)})
	end
	
end

function Function.sendValuesToDB(hash, autorID, recebedorID, conteudo, autorNAME, recebedorNAME)
	local hashes_already = alreadyRegistredHashs()
-- 	if type(hashes_already) ~= "boolean" then 
-- 		hashes_already = json.decode(hashes_already)
-- 	for k, v in pairs(hashes_already) do
-- 		if k == hash then
-- 			return
-- 		end
-- 	end
-- end

    FrameworkSV.SQLExecute("INSERT INTO xframework_cartas(hash, autorID, recebedorID, conteudo, autorNAME, recebedorNAME) VALUES (@hash, @autorID, @recebedorID, @conteudo, @autorNAME, @recebedorNAME)", 
    {["@hash"] = hash, 
    ["@autorID"] = autorID,
    ["@recebedorID"] = recebedorID,
    ["@conteudo"] = conteudo,
    ["@autorNAME"] = autorNAME,
    ["@recebedorNAME"] = recebedorNAME})
	addNewLetterToUserData(hash, recebedorID)
end

RegisterServerEvent("removeCartaFromUserData")
AddEventHandler("removeCartaFromUserData", function(hex, id)
	local old_data = FrameworkSV.SQLExecute("SELECT * FROM xframework_cartas_correspondencias WHERE id = @id", {["@id"] = tonumber(id)})
	if old_data and old_data[1] then 
		-- if type(old_data) ~= "table" then
		old_data = old_data[1].data 
		old_data = json.decode(old_data)
		if old_data["carta_0x"..hex] then 
			if old_data["carta_0x"..hex].amount - 1 <= 0 then 
				old_data["carta_0x"..hex] = nil
			else 
				old_data["carta_0x"..hex].amount = old_data["carta_0x"..hex].amount - 1
			end
			local can = FrameworkSV.GiveInventoryItem(tonumber(id), "carta_0x"..hex, 1)
			if can and can == "fail" then 
				TriggerClientEvent("xFramework:Notify", source, "negado", "Os limites do inventário não foram respeitados.")
				return 
			end
			FrameworkSV.SQLExecute("UPDATE xframework_cartas_correspondencias SET data = @data WHERE id = @id",{["@data"] = json.encode(old_data), ["@id"] = tonumber(id)})
		end
	end
end)

function Function.myId()
	return FrameworkSV.GetUserId(source)
end

function Function.myLetters()
	local source = source 
	local user_id = FrameworkSV.GetUserId(source)

end

function Function.exists(id)
	return FrameworkSV.PlayerExists(tonumber(id))
end

function Function.getName(id)
	return FrameworkSV.GetUserName(id)
end

-- ! teste



-- ! Teste - ler carta a partir da hash

-- _Framework.RegisterUsableItem("carta_0x", function(hash)

-- end)


-- Esquema para gerar id/hash --

function hash()
    local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local number = ""
	for i=1,#"DDLLLDDD" do
		local char = string.sub("DDLLLDDD",i,i)
    	if char == "D" then number = number..string.char(zbyte+math.random(0,9))
		elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
		else number = number..char end
	end
    return number
end