local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tools = module('Server/CallBack/Callback_Tools')
Function = {}
local Config = {}

x_cavalosCL = Tunnel.getInterface('x_cavalos')
x_cavalosSV = Proxy.getInterface('x_cavalos')

FrameworkCL = Tunnel.getInterface('_xFramework')
FrameworkSV = Proxy.getInterface('_xFramework')

Inventario = Proxy.getInterface('x_inventory')

local Cache = {}
Proxy.addInterface('x_cavalos', Function)
Tunnel.bindInterface('x_cavalos', Function)

function selecionarPeso(tipo, ped)
    local selectedPeso = 0.00
    if tipo == 'cavalo' then
        selectedPeso = tonumber(FrameworkSV.HorseConfig()['Pesos'].Cavalos['Padrao'])
        if (FrameworkSV.HorseConfig()['Pesos'].Cavalos[ped]) then
            selectedPeso = tonumber(FrameworkSV.HorseConfig()['Pesos'].Cavalos[ped])
        end
    else
        selectedPeso = tonumber(FrameworkSV.HorseConfig()['Pesos'].Carrocas['Padrao'])
        if (FrameworkSV.HorseConfig()['Pesos'].Cavalos[ped]) then
            selectedPeso = tonumber(FrameworkSV.HorseConfig()['Pesos'].Carrocas[ped])
        end
    end
    return selectedPeso
end
function Function.SendCFG()
    return FrameworkSV.HorseConfig()
end
function Function.Buy(horseBuyName, horseName, index)
    local source = source
    FrameworkSV.BuyNewHorse(FrameworkSV.GetUserId(source), horseBuyName, horseName, index)
    TriggerClientEvent('x_cavalos:UpdatePlayerHorseTable', source)
end

function Function.Buy2(horseBuyName, horseName, index)
    local source = source
    FrameworkSV.BuyNewVehicle(FrameworkSV.GetUserId(source), horseBuyName, horseName, index)
    TriggerClientEvent('x_cavalos:UpdatePlayerHorseTable', source)
end

function Function.getItem(item, qnt)
    return FrameworkSV.TryGetInventoryItem(FrameworkSV.GetUserId(source), item, tonumber(qnt))
end

function Function.info()
    local Horses =
        FrameworkSV.SQLExecute(
        'SELECT * FROM xframework_cavalos WHERE id = @userID',
        {['@userID'] = tonumber(FrameworkSV.GetUserId(source))}
    )
    if Horses[1] == nil then
        return {}
    end

    return json.decode(Horses[1].horses)
end

function Function.info2()
    local Horses =
        FrameworkSV.SQLExecute(
        'SELECT * FROM xframework_cavalos WHERE id = @userID',
        {['@userID'] = tonumber(FrameworkSV.GetUserId(source))}
    )
    if Horses[1] == nil then
        return {}
    end
    return json.decode(Horses[1].vehicles)
end

function Function.SpawnCavalo(Data)
    local name = Data.Name
    local dados = Data.Dados
    local ped = Data.Ped
    local Spawned = x_cavalosCL.SpawnNewHorse(source, ped, name)
end

function Function.SpawnCarroca(Data)
    local name = Data.Name
    local dados = Data.Dados
    local ped = Data.Ped
    local Spawned = x_cavalosCL.SpawnNewVehicle(source, ped, name)
end
function Function.SendNewUpgrades(upgrades, horse_name)
    local user_id = FrameworkSV.GetUserId(source)
    local userHorseTable =
        FrameworkSV.SQLExecute('SELECT * FROM xframework_cavalos WHERE id = @id', {['@id'] = tonumber(user_id)})
    userHorseTable = json.decode(userHorseTable[1].horses)
    if (userHorseTable) then
        for k, v in pairs(userHorseTable) do
            if v['name'] == horse_name then
                userHorseTable[k]['upgrades'] = upgrades
                FrameworkSV.SQLExecute(
                    'UPDATE xframework_cavalos SET horses = @horses WHERE id = @id',
                    {['@horses'] = json.encode(userHorseTable), ['@id'] = tonumber(user_id)}
                )
            -- print(json.encode(userHorseTable))
            end
        end
    end
end

function int_add_1(var)
    return var + 1
end
function Function.add_time(select, plus)
    local source = source
    local reps = 0.0
    local query =
        FrameworkSV.SQLExecute(
        'SELECT * FROM xframework_cavalos WHERE id = @id ',
        {['@id'] = tonumber(FrameworkSV.GetUserId(source))}
    )
    query = json.decode(query[1].horses)
    if query then
        if query[select]['userStaminaTimes'] + plus <= 100 then 
        query[select]['userStaminaTimes'] = query[select]['userStaminaTimes'] + plus
        else
            TriggerClientEvent("xFramework:Notify", source, "negado", "Passou dos limites: Você não pode mais dar frutas ao seu cavalo, pois a stamina dele já está alta!")
        end
    end
    local sucess =
        FrameworkSV.SQLExecute(
        'UPDATE xframework_cavalos SET horses = @h WHERE id = @id',
        {['@id'] = tonumber(FrameworkSV.GetUserId(source)), ['@h'] = json.encode(query)}
    )
end

function Function.times(nome_selecionado)
    local resp = 0.00
    local _t =
        FrameworkSV.SQLExecute(
        'SELECT * FROM xframework_cavalos WHERE id = @id',
        {['@id'] = tonumber(FrameworkSV.GetUserId(source))}
    )
    _t = json.decode(_t[1].horses)
    if _t then
        print(nome_selecionado)
        resp = tonumber(_t[nome_selecionado]['userStaminaTimes'])
        return resp
    end
    return 0
end
function Function.AtualizarVariaveis(nome_selecionado)
    local source = source
    local user_id = FrameworkSV.GetUserId(source)
    local userHorseTable =
        FrameworkSV.SQLExecute('SELECT * FROM xframework_cavalos WHERE id = @id', {['@id'] = tonumber(user_id)})
    local userHorseTable = json.decode(userHorseTable[1].horses)
    local selectedhorse = ''
    local selectedhorseupgrades = ''
    if (userHorseTable) then
        for k, v in pairs(userHorseTable) do
            if v['name'] == nome_selecionado then
                selectedhorse = k
                selectedhorseupgrades = v['upgrades'] or false
            end
        end
    end
    x_cavalosCL.AtualizarTunningVar(source, selectedhorseupgrades)
end

AddEventHandler(
    'xFramework:PlayerLogin',
    function(source)
        TriggerClientEvent('x_cavalos:UpdatePlayerHorseTable', source)
    end
)

function Function.OpenInventoryTrunks(dataseq, tipo, Index)
    local source = source
    local items
    local pesomax = 0.00
    local user_id = FrameworkSV.GetUserId(source)
    if tipo == 'cavalo' then
        pesomax = selecionarPeso('cavalo', dataseq.Ped)
        local Horses =
            FrameworkSV.SQLExecute(
            'SELECT * FROM xframework_cavalos WHERE id = @userID',
            {['@userID'] = tonumber(FrameworkSV.GetUserId(source))}
        )
        Horses = json.decode(Horses[1].horses)
        items = Horses[dataseq.Ped].inventario
        -- print(json.encode(items))
        if json.encode(items) == '[]' then
            items = {}
        end
        TriggerEvent('OpenHorseInventory', items, user_id, user_id, pesomax, dataseq.Ped, tipo)
    else
        pesomax = selecionarPeso('carroca', dataseq.Ped)
        -- print('^1', pesomax)
        -- print('seq_d:', dataseq.Ped)
        local Horses =
            FrameworkSV.SQLExecute(
            'SELECT * FROM xframework_cavalos WHERE id = @userID',
            {['@userID'] = tonumber(FrameworkSV.GetUserId(source))}
        )
        Horses = json.decode(Horses[1].vehicles)
        items = Horses[dataseq.Ped].inventario
        -- print(json.encode(items))
        if json.encode(items) == '[]' then
            items = {}
        end
        TriggerEvent('OpenHorseInventory', items, user_id, user_id, pesomax, dataseq.Ped, tipo)
    end
end

-- removido
-- refazer: atr horse sv

function art()
    __ar__ = ''
end

--> Itens de aumentar stamina!

RegisterServerEvent('xFramework_ItemFunction:maca')
AddEventHandler(
    'xFramework_ItemFunction:maca',
    function()
        print 'hello world'
    end
)


-- "cavalos.upgrades.stamina", "cavalos.upgrades.limpar"

--[[
feno

maca

escova
]]

--> prefix =======================> xFramework_ItemFunction:

local p = "xFramework_ItemFunction:"

RegisterServerEvent(p.."feno")
AddEventHandler(p.."feno", function(user_id)
    if FrameworkSV.HasPermission(user_id, "cavalos.upgrades.stamina") then 
        local src = FrameworkSV.GetUserSource(user_id)
        x_cavalosCL.moreStaminaEat(src,20)
    end
end)
RegisterServerEvent(p.."maca")
AddEventHandler(p.."maca", function(user_id)
    if FrameworkSV.HasPermission(user_id, "cavalos.upgrades.stamina") then 
        local src = FrameworkSV.GetUserSource(user_id)
        x_cavalosCL.moreStaminaEat(src,40)
    end
end)
RegisterServerEvent(p.."escova")
AddEventHandler(p.."escova", function(user_id)
    if FrameworkSV.HasPermission(user_id, "cavalos.upgrades.limpar") then 
        local src = FrameworkSV.GetUserSource(user_id)
        x_cavalosCL.Limpar(src,40)
    end
end)