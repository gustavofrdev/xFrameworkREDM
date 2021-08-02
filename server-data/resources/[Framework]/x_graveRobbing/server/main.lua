local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')

x_graveRobbingSV = Tunnel.getInterface('x_graveRobbing')
x_graveRobbingCL = Proxy.getInterface('x_graveRobbing')
FrameworkSV = Proxy.getInterface('_xFramework')
FrameworkCL = Tunnel.getInterface('_xFramework')

Function = {}
Proxy.addInterface('x_graveRobbing', Function)
Tunnel.bindInterface('x_graveRobbing', Function)

local Loot = {
    {item = 'oldbuckle', amountToGive = math.random(4, 8)},
    {item = 'oldwatch', amountToGive = math.random(1, 5)},
    {item = 'rubyring', amountToGive = math.random(1, 2)},
    {item = 'goldtooth', amountToGive = math.random(4, 8)},
}

local LootRare = {
    {item = 'oldbuckle', amountToGive = math.random(2, 4)},
    {item = 'oldwatch', amountToGive = math.random(1, 3)},
    {item = 'rubyring', amountToGive = math.random(1, 3)},
    {item = 'goldtooth', amountToGive = math.random(1, 2)},
    {item = 'piratecoin', amountToGive = math.random(1, 1)}
}
local LootWithout = {
    {item = 'oldbuckle', amountToGive = math.random(2, 4)},
    {item = 'oldwatch', amountToGive = math.random(1, 3)},
    -- {item = 'rubyring', amountToGive = math.random(1, 3)},
    -- {item = 'goldtooth', amountToGive = math.random(1, 2)},
    -- {item = 'piratecoin', amountToGive = math.random(1, 1)}
}
function Function.Final(HR)
    local _source = source
    local FinalLoot,LabelLoot = LootToGive(_source, HR)
        for k, v in pairs(LootRare) do
            if v.item == FinalLoot then
                FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(_source), FinalLoot, v.amountToGive)
                LootsToGiveR = {}
            break
        end
    end
end

function Function.police(x, y, z)
    TriggerClientEvent("xFramework:CallCallback::policia_roubo_progress",-1, x , y, z  )
end

function LootToGive(source, HasRares) -- kek
    local LootsToGive = {}
    local LootsToGiveR = {}
    if HasRares then
        for k, v in pairs(LootRare) do
            table.insert(LootsToGiveR, v.item)
        end
    else
        for k, v in pairs(Loot) do
            table.insert(LootsToGive, v.item)
        end
    end

    if LootsToGive[1] ~= nil then
        local value = math.random(1, #LootsToGive)
        local picked = LootsToGive[value]
        return picked
    elseif LootsToGiveR[1] ~= nil then
        local value = math.random(1, 100)
        local picked;
        if value < 20 then 
            local v = math.random(1, 3)
            if v == 1 then 
                picked = 'goldtooth'
            elseif v == 2 then 
                picked =  'rubyring'
            elseif v == 3 then 
                picked = 'piratecoin'
            end
        else 
            value = math.random(1, #LootRare)
            picked = LootWithout[value]
        end
        local itemLabel = nil 
        
        if picked == "oldbuckle" then itemLabel = "Fivela Velha" 
        elseif picked == "oldwatch" then itemLabel = "Relógio Velho"
        elseif picked == "rubyring" then itemLabel = "Anel de Rúbi"
        elseif picked == "goldtooth" then itemLabel = "Dente de Ouro"
        elseif picked == "piratecoin" then itemLabel = "Moeda Pirata"
        end
        return picked, itemLabel
    end
end
