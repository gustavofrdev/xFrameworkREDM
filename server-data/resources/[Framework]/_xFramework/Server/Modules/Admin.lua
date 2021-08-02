local API = {}
local tpback = {}

function NewCMD(name, namef)
    RegisterCommand(name, namef)
end
local function wbh(m)
    TriggerEvent("_xFramework:Discord", "https://discord.com/api/webhooks/866422475059757116/BEvME6brHLQEZdYv6bvAn6rPBS9WKEuInSGQkUKgk4vZ7ydIpXtPELyQCRMFU9pz25Fb", m)
end
function reduzirNumero(numero)
    return math.ceil(numero*100)/100
end
NewCMD("nc", function(source, args, rawCommand)
    if _Framework.HasPermission(_Framework.GetUserId(source),"comando.nc") then
        _Frameworkclient.ToggleNoclip(source)
        TriggerClientEvent("xFramework:Notify", source, "sucesso", " Noclip ativado/desativado",10000)
        wbh(_Framework.GetUserId(source).. " Ativou/Desativou o Noclip")
    else
        TriggerClientEvent("xFramework:Notify", source,"negado","Você não tem permissão para usar o noclip",10000)
    end
end)
NewCMD("group", function(source, args)
    local user_id = tonumber(args[1])
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.group") then
        if args[2] == "Bruxas1" or args[2] == "Bruxas2" or args[2] == "Bruxas3" then -- ...
            print("other :cfg: ==>") 
            print(" Set grupo => Bruxas <= :: Realizando ações adicionais", _Framework.GetUserSource(user_id))
            TriggerClientEvent("elixirblips", _Framework.GetUserSource(user_id))
            TriggerClientEvent("elixirblips2", _Framework.GetUserSource(user_id))
        end
        wbh(_Framework.GetUserId(source).. " Setou "..user_id.. " em "..args[2])
        _Framework.SetUserGroup(tonumber(user_id), args[2])
    else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode usar esse comando ",10000)
    end
end)

NewCMD("setvip", function(source, args)
    if _Framework.HasPermission(_Framework.GetUserId(source),"comando.setvip") then
        if args[1] and args[2] then 
            local id = tonumber(args[2])
            _Framework.addVip(args[1], id, source)
            wbh(_Framework.GetUserId(source).. " Setou vip "..args[1].. " em "..args[2])
        end
    end
end)
NewCMD("removevip", function(source, args)
    if _Framework.HasPermission(_Framework.GetUserId(source),"comando.removevip") then
        if args[1] and args[2] then 
            local id = tonumber(args[2])
            _Framework.removeVip(args[1], id, source)
            wbh(_Framework.GetUserId(source).. " Removeu vip "..args[1].. " em "..args[2])
        end
    end
end)
NewCMD("prender", function(source, args)
    local user_id = tonumber(args[1])
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "policia.permissao") then
        if _Framework.IsPlayerOnline(tonumber(args[1])) then
            _Frameworkclient.Prender(tonumber(_Framework.GetUserSource(tonumber(args[1]))), args[2])
            wbh(_Framework.GetUserId(source).. " Prendeu "..args[1].. " por "..args[2].. "m")
        end
    else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode usar esse comando ",10000)
    end
end)

NewCMD("ungroup", function(source, args)
    local Personagem = _Framework
    local Grupos = _Framework
    local user_id = tonumber(args[1])
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.ungroup") then
        _Framework.RemoveUserGroup(tonumber(user_id), args[2])
        wbh(_Framework.GetUserId(source).. " Removeu "..user_id.. " de "..args[2])
    else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode usar esse comando ",10000)
    end
end )
NewCMD("cds", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.cds") then
        if tonumber(args[1]) == tonumber(1)  then
            local cds = _Frameworkclient.GetPosition(source)
            local string = reduzirNumero(cds.x) .." "..reduzirNumero(cds.y).." "..reduzirNumero(cds.z)
            local cds = _Frameworkclient.GetPosition(source)
            tpback[user_id] = {x= reduzirNumero(cds.x), y = reduzirNumero(cds.y), z = reduzirNumero(cds.z)}
            TriggerClientEvent('x_copy:set', source, string)
            TriggerClientEvent("xFramework:Notify", source,"sucesso"," Cordenadas "..string.. " copiadas automáticamente no seu clipboard [Maneira 1]",10000)
        elseif tonumber(args[1]) == tonumber(2) then
            local cds = _Frameworkclient.GetPosition(source)
            local string = reduzirNumero(cds.x) ..", "..reduzirNumero(cds.y)..", "..reduzirNumero(cds.z)
            local cds = _Frameworkclient.GetPosition(source)
            tpback[user_id] = {x= reduzirNumero(cds.x), y = reduzirNumero(cds.y), z = reduzirNumero(cds.z)}
            TriggerClientEvent('x_copy:set', source, string)
            TriggerClientEvent("xFramework:Notify", source,"sucesso"," Cordenadas "..string.. " copiadas automáticamente no seu clipboard [Maneira 2]",10000)
        elseif tonumber(args[1]) == tonumber(3) then
            local cds = _Frameworkclient.GetPosition(source)
            local string = "x = ".. reduzirNumero(cds.x) ..", y = "..reduzirNumero(cds.y)..", z = "..reduzirNumero(cds.z)
            local cds = _Frameworkclient.GetPosition(source)
            tpback[user_id] = {x= reduzirNumero(cds.x), y = reduzirNumero(cds.y), z = reduzirNumero(cds.z)}
            TriggerClientEvent('x_copy:set', source, string)
            TriggerClientEvent("xFramework:Notify", source,"sucesso"," Cordenadas "..string.. " copiadas automáticamente no seu clipboard [Maneira 3]",10000)
        else
            local cds = _Frameworkclient.GetPosition(source)
            local string = reduzirNumero(cds.x) .." "..reduzirNumero(cds.y).." "..reduzirNumero(cds.z)
            local cds = _Frameworkclient.GetPosition(source)
            tpback[user_id] = {x= reduzirNumero(cds.x), y = reduzirNumero(cds.y), z = reduzirNumero(cds.z)}
            TriggerClientEvent('x_copy:set', source, string)
            TriggerClientEvent("xFramework:Notify", source,"sucesso"," Cordenadas "..string.. " copiadas automáticamente no seu clipboard [Maneira 1]",10000)
        end
    else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode usar esse comando ",10000)
    end
end)
NewCMD("tpcds", function(source,args)
    local user_id = _Framework.GetUserId(source)
    local cordenadas = {}
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.tpcds") and args[1] and args[2] and args[3] then

        cordenadas.x = tonumber(args[1])
        cordenadas.y = tonumber(args[2])
        cordenadas.z = tonumber(args[3])
        print(json.encode(cordenadas))
        local cds = _Frameworkclient.GetPosition(source)
        tpback[user_id] = {x= reduzirNumero(cds.x), y = reduzirNumero(cds.y), z = reduzirNumero(cds.z)}
        _Frameworkclient.TeleportPlayer(source, cordenadas.x, cordenadas.y, cordenadas.z)
        TriggerClientEvent("xFramework:Notify", source,"sucesso"," Cordenadas "..string.. " Você foi teleportado",10000)
        
    else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode usar esse comando ou faltam argumentos ",10000)
    end
end)
NewCMD("tpway", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.tpway") then
        local cds = _Frameworkclient.GetPosition(source)
        tpback[user_id] = {x= reduzirNumero(cds.x), y = reduzirNumero(cds.y), z = reduzirNumero(cds.z)}
        _Frameworkclient.TeleportPlayerToWaypoint(source)
        TriggerClientEvent("xFramework:Notify", source,"sucesso"," Cordenadas "..string.. " Você foi teleportado",10000)
    else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode usar esse comando ",10000)
    end
end )

NewCMD("tpback", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.tpback") then
        if tpback[user_id] ~= nil then
            _Frameworkclient._TeleportPlayer(source, tpback[user_id].x, tpback[user_id].y, tpback[user_id].z)
            TriggerClientEvent("xFramework:Notify", source,"sucesso"," Você foi teleportado",10000)
            Wait(100)
            TriggerClientEvent("xFramework:Notify", source,"aviso","AVISO: Sua tabela 'tpback' foi deletada do sistema",10000)
            tpback[user_id] = nil
        else
            TriggerClientEvent("xFramework:Notify", source,"negado"," Você não se teleportou em nenhum lugar recentemente ",10000)
        end
    else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode usar esse comando ",10000)
    end
end)
NewCMD("tpto", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.tpto") and args[1] then
        if _Framework.IsPlayerOnline(tonumber(args[1])) then
            local otherPlayer = tonumber(args[1])
            local otherPlayerSRC = _Framework.GetUserSource(otherPlayer)
            local otherPlayerCDS = _Frameworkclient.GetPosition(otherPlayerSRC)
            local cordenadas = {}
            cordenadas.x = tonumber(otherPlayerCDS.x)
            cordenadas.y = tonumber(otherPlayerCDS.y)
            cordenadas.z = tonumber(otherPlayerCDS.z)
            local cds = _Frameworkclient.GetPosition(source)
            tpback[user_id] = {x= reduzirNumero(cds.x), y = reduzirNumero(cds.y), z = reduzirNumero(cds.z)}
            _Frameworkclient.TeleportPlayer(source, cordenadas.x, cordenadas.y, cordenadas.z)
            TriggerClientEvent("xFramework:Notify", source,"sucesso"," Você foi até o user_id "..otherPlayer.. "["..otherPlayerSRC.."]",10000)
        else
            TriggerClientEvent("xFramework:Notify", source,"negado"," Jogador inexistente e/ou não online",10000)
        end
    else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode usar esse comando ",10000)
    end
end )
NewCMD('players', function(source)
    if _Framework.HasPermission(_Framework.GetUserId(source), "comando.players") then
        local NumberOnlines = _Framework.NumberOnline()
        local IDSOnline = _Framework.IDSOnline()
        TriggerClientEvent("xFramework:Notify", source,"aviso","Nesse momento, temos "..NumberOnlines.. " Jogadores no servidor",10000)
        TriggerClientEvent("xFramework:Notify", source,"aviso","Os IDs online são: "..IDSOnline,20000)
    end
end)

NewCMD('item', function(source, args)
    local Grupos = _Framework
    local Personagem = _Framework
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.item") and args[1] and args[2] then
        local itemName = args[1]
        local itemQNT  = tonumber(args[2])
        local user_id = _Framework.GetUserId(source)
        print(user_id)
        -- _Framework.SetInventoryMaxWeight(tonumber(user_id), 200)
        _Framework.GiveInventoryItem(tonumber(user_id), itemName, itemQNT, 120)
        wbh(_Framework.GetUserId(source).. " Pegou o item "..args[1].. " quantidade= "..args[2])
    else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode usar esse comando ou faltam argumentos ",10000)
    end
end)

NewCMD("money", function(source, args)
    local Grupos = _Framework
    local id     = _Framework.GetUserId(source)
    local condition = _Framework.HasPermission(tonumber(id), "comando.money")
    if condition then
        wbh(_Framework.GetUserId(source).. " Pegou $ "..args[1].. "[/money]")
        _Framework.GiveInventoryItem(tonumber(id), "dinheiro", tonumber(args[1]))
    end
end)
NewCMD("god", function(source, args)
    local id = _Framework.GetUserId(source)
    local condition = _Framework.HasPermission(tonumber(id), "comando.god")
    if(condition)then
        if args[1] then
            wbh(_Framework.GetUserId(source).. " Reviveu "..args[1])
            _Frameworkclient.ReviveGod(_Framework.GetUserSource(tonumber(args[1])))
        else
            wbh(_Framework.GetUserId(source).. " Reviveu a si propio")
            _Frameworkclient.ReviveGod(source)
        end
    end
end)
NewCMD("kill", function(source, args)
    local id = _Framework.GetUserId(source)
    local condition = _Framework.HasPermission(tonumber(id), "comando.kill")
    if(condition)then
        if(args[1]) then
            wbh(_Framework.GetUserId(source).. " matou " ..args[1])
            _Frameworkclient.Kill(_Framework.GetUserSource(tonumber(args[1])))
        end
    end
end)

NewCMD("tptome", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.tptome") and args[1] then
        if _Framework.IsPlayerOnline(tonumber(args[1])) then
            local otherPlayer = tonumber(args[1])
            local otherPlayerSRC = _Framework.GetUserSource(otherPlayer)

            local otherPlayerCDS = _Frameworkclient.GetPosition(source)
            local cordenadas = {}
            cordenadas.x = tonumber(otherPlayerCDS.x)
            cordenadas.y = tonumber(otherPlayerCDS.y)
            cordenadas.z = tonumber(otherPlayerCDS.z)
            local cds = _Frameworkclient.GetPosition(source)
            tpback[user_id] = {x= reduzirNumero(cds.x), y = reduzirNumero(cds.y), z = reduzirNumero(cds.z)}
            _Frameworkclient.TeleportPlayer(otherPlayerSRC, cordenadas.x, cordenadas.y, cordenadas.z)
            TriggerClientEvent("xFramework:Notify", otherPlayerSRC,"sucesso"," Você foi até o user_id "..source.. "["..user_id.."]",10000)
            TriggerClientEvent("xFramework:Notify", source,"sucesso"," Trouxe:"..otherPlayer.. "["..otherPlayer.."]",10000)
        else
            TriggerClientEvent("xFramework:Notify", source,"negado"," Jogador inexistente e/ou não online",10000)
        end
    else
        TriggerClientEvent("xFramework:Notify", source,"negado"," Você não pode usar esse comando ",10000)
    end
end)

NewCMD("ban", function(source, args)
    local user_id = _Framework.GetUserId(source)
    print(_Framework.HasPermission(user_id, "comando.ban") and args[1])
    if _Framework.HasPermission(user_id, "comando.ban") and args[1] then
        _Framework.Ban(tonumber(args[1]), true, source)
        wbh(_Framework.GetUserId(source).. " baniu " ..args[1])
    end
end)

NewCMD("unban", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(user_id, "comando.unban") and args[1] then 
        _Framework.Ban(tonumber(args[1]), false, source)
        wbh(_Framework.GetUserId(source).. " desbaniu " ..args[1])
    end
end)

NewCMD("kick", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(user_id, "comando.kick") and args[1] then
        if _Framework.IsPlayerOnline(tonumber(args[1])) then
            DropPlayer(_Framework.GetUserSource(tonumber(args[1])), "Você foi kickado do servidor por ".._Framework.GetUserName(user_id).."["..user_id.. "].")
            TriggerClientEvent("xFramework:Notify", source,"sucesso","Operação efetauda",10000)
            wbh(_Framework.GetUserId(source).. " expulsou " ..args[1])
        end
    end
end)
function t_Framework.addRaio(posx, posy, posz)
    _Frameworkclient.ForceLightningFlashAtCoords_(-1,posx, posy, posz)
end
NewCMD("raio", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(user_id, "comando.raio") then
        _Frameworkclient.startRaio(source)
        wbh(_Framework.GetUserId(source).. " ativou/desativou /raio ")
    end
end)

NewCMD("fogo", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(user_id, "comando.raio") and args[1] then
        if _Framework.IsPlayerOnline(tonumber(args[1])) then
            _Frameworkclient.StartFire(_Framework.GetUserSource(tonumber(args[1])))
            wbh(_Framework.GetUserId(source).. " colocou fogo em  "..args[1])
        end
    end
end)

NewCMD("f", function(source)
    if source == 0 then
        print("fechando o servidor sem salvar")
        Wait(100)
        for i=1, 255 do print ("k: "..i.. "/255") if i == 255 then print 'Kicks concluído' end DropPlayer(i,"[(Only/Internal)ServerSide.Command['f'].quickStop()]") end
        os.exit()
    end
end)

NewCMD("cavalo", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.cavalo") and args[1] then
        _Frameworkclient.spawnHorse(source, args[1])
        wbh(_Framework.GetUserId(source).. " spawnou o cavalo  "..args[1])
    end
end)

NewCMD("wl", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.wl") and args[1] then
        local steam = args[1]
        _Framework.freeWl(steam, source)
        wbh(_Framework.GetUserId(source).. " aprovou  "..steam.. " na Whitelist")
    end
end)
NewCMD("unwl", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.wl") and args[1] then
        local steam = args[1]
        _Framework.unwl(steam, source)
        wbh(_Framework.GetUserId(source).. " removeu  "..steam.. " da Whitelist")
    end
end)

NewCMD("resetar", function(source, args)
    local user_id = _Framework.GetUserId(source)
    if _Framework.HasPermission(tonumber(_Framework.GetUserId(source)), "comando.kick") and args[1] then
        if _Framework.IsPlayerOnline(tonumber(args[1])) then
            TriggerEvent("x_multicharacter:resetPlayer",_Framework.GetUserSource(tonumber(args[1])), tonumber(args[1]))
        end 
    end
end)

NewCMD("closeServer", function(source)
    if source == 0 then
        for i = 1, 255 do
            print()
        end
        for i = 1, 255 do
            TriggerClientEvent("xFramework:Notify", i, "aviso", "CONSOLE/TERMINAL iniciou processo de desligamento/reinício do servidor. Não saia do servidor até ele se desligar sozinho.", 99999999999)
        end
        print("^1!!! procedimento iniciado. ")
        _Framework.ForceSave()
        for i=1, 30 do
            print ('DB(ForceSave)T-'..i.. ', tmax:30')
            _Framework.ForceSave()
            Wait(1)
            if i == 30 then
                print 'DBs concluído...'
            end
            _Framework.ForceSave() end
        Wait(4000/2)
        for i = 1, 255 do
            print()
        end
        print("^5!!! Aguarde, estamos kickando todos os jogadores ")
        for i = 1, 255 do
            TriggerClientEvent("xFramework:Notify", i, "negado", "CONSOLE/TERMINAL fechará o servidor em segundos.", 99999999999)
        end
        Wait(4000/2)
        for i=1, 255 do print ("k: "..i.. "/255") if i == 255 then print 'Kicks concluído' end DropPlayer(i,"-> O servidor está sendo reiniciado/fechado.") end

        Wait(4000/2)
        for i = 1, 255 do
            print()
        end
        print 'Ok!'
        for i = 1, 255 do
            print()
        end
        print("^2 Console será fechado em 3 segundos ")
        Wait (3000)
        os.exit()

    end
end )


-- x_multicharacter:resetPlayer