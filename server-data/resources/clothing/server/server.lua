--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")
clothing = Tunnel.getInterface("clothing")
clothingSv = Proxy.getInterface("clothing")
_Tunnel = {}
Tunnel.bindInterface("clothing", _Tunnel)

function format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end
function _Tunnel.getClothes()
    local user_id = FrameworkSV.GetUserId(source)
    local clothes = FrameworkSV.SQLExecute("SELECT clothedata FROM xframework_personagens WHERE id = @id", {["@id"] = tonumber(user_id)})
    return clothes[1].clothedata
end

function _Tunnel.setClothes(json_)
    local user_id = FrameworkSV.GetUserId(source)
    FrameworkSV.SQLExecute("UPDATE xframework_personagens SET clothedata = @cl WHERE id = @user_id", {["@cl"] = json_, ["@user_id"] = user_id})
end

function _Tunnel.pay()
    local source = source 
    local user_id = FrameworkSV.GetUserId(source);
    local value = Config.PrecoVendaRoupa
    if FrameworkSV.TryPayment(user_id, value) then 
        return true 
    else
        return false 
    end
end

function _Tunnel.buyClotheStore(storeId, storeValue)
    local source = source 
    local user_id = FrameworkSV.GetUserId(source);
    if userAlreadyAnyOwnClotheStore(user_id) then TriggerClientEvent("xFramework:Notify", source, "negado", "Você já tem"
        .. " uma loja de roupas em seu nome.") return end
    if FrameworkSV.TryPayment(user_id, storeValue) then 
        print(tonumber(storeId))
        -- INSERT INTO xframework_clothestore(storeid, owner) VALUES(@storeId, @owner)
        FrameworkSV.SQLExecute("INSERT INTO xframework_clothestore(storeid, owner) VALUES(@storeId, @owner)",{['@storeId'] = tonumber(storeId), ["@owner"] = tonumber(user_id)})
        TriggerClientEvent("xFramework:Notify",
            source,
            "sucesso", "Você comprou este estabelecimento por $" ..format(storeValue))
        FrameworkCL.ClotheStoreNoLongerAvaible(-1, storeId);
    else 
        TriggerClientEvent("xFramework:Notify", source, "negado", "Você não tem $" ..format(storeValue))
    end
end

function _Tunnel.AddFunds(value, storeId)
    local myClotheStore = FrameworkSV.SQLExecute("SELECT * FROM xframework_clothestore WHERE storeid = @id", {["@id"] = tonumber(storeId)})
    if json.encode(myClotheStore) == '[]' then return end
    local data = json.decode(myClotheStore[1].storedata)
    if not data or json.encode(data) == "[]" then 
        local new = {}
        new["dinheiro"] = value 
        new["number_uses"] = 1
        FrameworkSV.SQLExecute("UPDATE xframework_clothestore SET storedata = @data WHERE storeid = @id", {["@data"] = json.encode(new), ["@id"] =tonumber(storeId)})
    else
        data["dinheiro"] = data["dinheiro"] + value
        data["number_uses"] = data["number_uses"] + 1
        FrameworkSV.SQLExecute("UPDATE xframework_clothestore SET storedata = @data WHERE storeid = @id", {["@data"] = json.encode(data), ["@id"] = tonumber(storeId)})
    end
end

function _Tunnel.removeFunds(value, source)
    local source = source
    local myClotheStore = FrameworkSV.SQLExecute("SELECT * FROM xframework_clothestore WHERE owner = @id", {["@id"] = FrameworkSV.GetUserId(source)})
    local data = json.decode(myClotheStore[1].storedata)
    if not data or json.encode(data) == "[]" then 
       TriggerClientEvent("xFramework:Notify",
            source,
            "negado", "Sua loja não tem nenhuma informação, portanto, ainda não foi usada.")
       return false
    else
        if data["dinheiro"] - value < 0 then 
            TriggerClientEvent("xFramework:Notify",
                source,
                "negado", "Você não pôde resgatar esse valor: O valor que você"
            .. "requisitou é maior do que o valor que você tem no estabelecimento.")
            return false  
        elseif data["number_uses"] - 1  < 0  then  
            data["number_uses"] = 1
        end
        data["dinheiro"] = data["dinheiro"] - value
        data["number_uses"] = 0
        FrameworkSV.SQLExecute("UPDATE xframework_clothestore SET storedata = @data WHERE owner = @id", {["@data"] = json.encode(data), ["@id"] = FrameworkSV.GetUserId(source)})
        TriggerClientEvent("xFramework:Notify", source, "sucesso", "Valor adicionado em sua conta bancária!")
        FrameworkSV.AddBankMoneyToUser(FrameworkSV.GetUserId(source), value)
        return true  
    end
end

function userAlreadyAnyOwnClotheStore(user_id)
    local resposta = false
    local allClothes = FrameworkSV.SQLExecute("SELECT owner FROM xframework_clothestore", {})
    for i = 1, #allClothes do
        local b = allClothes[i].owner
        if user_id == b then
            resposta = true
        end
    end
    return resposta
end
function sOwner(storeId, source)
    local source = source
    local myClotheStore = FrameworkSV.SQLExecute("SELECT * FROM xframework_clothestore WHERE owner = @id AND storeid = @storeId", {["@id"] = FrameworkSV.GetUserId(source), ["@storeId"] = tonumber(storeId)})
    local data = json.decode(myClotheStore[1].storedata)
    if not data or data == "" or json.encode(data) == "null" then  
        return false  
    end
    return true
end
function _Tunnel.own(storeId)  
    local source = source
    local myClotheStore = FrameworkSV.SQLExecute("SELECT * FROM xframework_clothestore WHERE owner = @id AND storeid = @storeId", {["@id"] = FrameworkSV.GetUserId(source), ["@storeId"] = tonumber(storeId)})
    if not myClotheStore[1] then return false end;
    local data = json.decode(myClotheStore[1].storedata)
    if not data or data == "" or json.encode(data) == "null" then  
        return false  
    end
    return true
end

function clotheStoreData(source)
    local source = source
    local myClotheStore = FrameworkSV.SQLExecute("SELECT * FROM xframework_clothestore WHERE owner = @id", {["@id"] = FrameworkSV.GetUserId(source)})
    local data = json.decode(myClotheStore[1].storedata)
    return
    {
        Dinheiro = data.dinheiro,
        UseNumber = data.number_uses
    }
end

function transferClotheStore(source, newOwner)
    local source = source
    FrameworkSV.SQLExecute("UPDATE xframework_clothestore SET owner = @newOwner WHERE owner = @owner",{["@newOwner"] = tonumber(newOwner), ["@owner"] = FrameworkSV.GetUserId(source)})
    TriggerClientEvent("xFramework:Notify", source, "sucesso", "Operação concluída com sucesso!")
end

local trans_confirmation = {}
RegisterCommand("roupa", function(source, args)
    if clothing.inRegion(source) then  
        if not args[1] then
            TriggerClientEvent("chat:addMessage", source,  
            {
                color = {255, 0, 0},
                multiline = true,
                        args = {'Ajuda',"Você precisa específicar uma ação. Ela pode ser /roupa dados | /roupa resgatar <valor>"
                .. "| /roupa transfeir <id>"}
            })
        end
        if args[1] == "dados" then  
            local data = clotheStoreData(source)
            TriggerClientEvent("chat:addMessage", source,  
            {
                color = {68, 85, 90},
                multiline = true,  
                args = {"Dados", "Acumulado: $"..format(data.Dinheiro)}
            })
            TriggerClientEvent("chat:addMessage", source,  
            {
                color = {68, 85, 90},
                multiline = true,  
                args = {"Dados", "Utilização:"..format(data.UseNumber) .. " vezes"}
            })
        end

            if not args[2] then 
                TriggerClientEvent("chat:addMessage", source, 
                {
                    color = {255, 0, 0},
                    multiline = true, 
                    args = {"Ajuda", "Você precisa específicar o valor que quer retirar. Confira em | /roupa dados | o valor que você tem disponível para saque!"}
                })
            else
                _Tunnel.removeFunds(tonumber(args[2]), source)
            end
        end
        if args[1] == "transferir" then 
            if not args[2] then
                TriggerClientEvent("chat:addMessage", source, 
                {
                    color = {255, 0, 0},
                    multiline = true, 
                    args = {"Ajuda", "Você precisa específicar o jogador-alvo da operação."}
                })
            else
                if not trans_confirmation[source] then 
                    TriggerClientEvent("xFramework:Notify", source, "negado", "Você tem certeza que deseja transferir sua" 
                    .."loja de roupas para " ..args[2].. "? Digite o comando novamente para confirmar!")
                    trans_confirmation[source] = true
                else
                    transferClotheStore(source, args[2])
                    trans_confirmation[source] = nil
            end
        end
    end 
end)

AddEventHandler("xFramework:PlayerLogin", function(source, user_id)
    Wait(5000)
    TriggerClientEvent('load::Clothes', source)
    for _ = 0, 2 do 
        TriggerClientEvent('load::Clothes', source)
    end
end)

function _Tunnel.pQuery()
    return FrameworkSV.SQLExecute("SELECT storeid FROM xframework_clothestore", {})
end
-- Query Estabelecimentos. Colocar todos os que tem dono e setar adequeadamente no config.lua

