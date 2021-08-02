local Tunnel = module("Server/CallBack/Callback_Tunnel")
local CharCreator = Tunnel.getInterface("x_charactercreator")
function ChangePedDb(source, _ped)
    local skindata = _Framework.SQLExecute("SELECT characterdata FROM xframework_personagens WHERE id = @id", {
		["@id"] = _Framework.GetUserId(source)
	})
		skindata = json.decode(skindata[1].characterdata)
        skindata["gender"] = _ped
        --(_ped)
        if not skindata["custom_ped_variation"] then 
            skindata["custom_ped_variation"] = 0
        end
        _Framework.SQLExecute("UPDATE xframework_personagens SET characterdata = @ch WHERE id = @id",{
			["@id"] = _Framework.GetUserId(source),
			["@ch"] = json.encode(skindata)
		})
        CharCreator.SetPersonagem(source, skindata)
end

function t_Framework.changeDbCl(a)
    --("db_c","SETANDO OLD B>: , " , a)
    ChangePedDb(source, a)
end

RegisterCommand("ped", function(source, args)
    local ped = args[1]
    local cfg = _Framework.SkinConfig()
    local old =_Framework.SQLExecute("SELECT characterdata FROM xframework_personagens WHERE id = @id", {
		["@id"] = _Framework.GetUserId(source)
	})
        old = json.decode(old[1].characterdata)
        old = old["gender"]
        --("old", old)
    if type(args[1]) == "string" then 
        if _Framework.HasPermission(_Framework.GetUserId(source),cfg.Permissao) then
           _Frameworkclient.Skin(source, ped, old)
        else
            TriggerClientEvent('xFramework:Notify', source, "negado", "falta < "..cfg.Permissao.. ">")
        end
    else 
        TriggerClientEvent('xFramework:Notify', source, "negado", "O ped do passáro obrigatoriamente é uma string('texto'!) e não " ..tostring(type(args[1])))
    end
end)

RegisterCommand("animal", function(source, args)
    local ped = args[1]
    local cfg = _Framework.SkinConfig()
    if type(args[1]) == "string" then 
            if _Framework.HasPermission(_Framework.GetUserId(source),cfg.Animais.Permissao) then
                _Frameworkclient.Animal(source, ped)
            end
    else 
        TriggerClientEvent('xFramework:Notify', source, "negado", "O ped do passáro obrigatoriamente é uma string('texto'!) e não " ..tostring(type(args[1])))
    end
end)

RegisterNetEvent("xFramework::Animais <attack>")

AddEventHandler("xFramework::Animais <attack>", function(target, entity)
	TriggerClientEvent("xFramework::Animais <attack>(C)", target, source, entity)
end)