local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
local FrameworkCL = Tunnel.getInterface("_xFramework")
local FrameworkSV = Proxy.getInterface("_xFramework")
local MultiCharacter = Tunnel.getInterface("x_tesouro")
local x_tesouro = Tunnel.getInterface("x_tesouro")
local x_tesouroSv = Proxy.getInterface("x_tesouro")
local _Tunnel = {}
Tunnel.bindInterface("x_tesouro", _Tunnel)
local net_peds = {}
local net_animais = {}
local propData = {}
local actualKey = 1;
local actualHostId = 0
local eventoInciadoAgora = false
local actual_number_vivos_animal = 0 
local actual_number_vivos_peds = 0 
RegisterServerEvent("comunicacao")
AddEventHandler("comunicacao", function(_net_type, _net_peds)
    if _net_type == 'animais' then 
        print("command")
        net_animais = _net_peds
        print " informação recebida "
        TriggerClientEvent("x_tesouro:SendSync", -1,"animais", net_animais)
        print("enviando atualização para todos os clients/-1")
    elseif _net_type == "propData" then 

        propData = _net_peds
        TriggerClientEvent("x_tesouro:SendSync", -1,"criar_clientObj", propData,  actualKey)
    else
        print " informação recebida "
        net_peds = _net_peds
        TriggerClientEvent("x_tesouro:SendSync", -1, "peds",net_peds)
        print("enviando atualização para todos os clients/-1")
    end
end)
Citizen.CreateThread(function()
    while true do 
        if eventoInciadoAgora then 
            TriggerClientEvent("x_tesouro:SendSync", -1,"animais", net_animais)
            TriggerClientEvent("x_tesouro:SendSync", -1, "peds",net_peds)
            -- print("Pulso de informação enviado!")
        end
        Wait(100)
    end
end)

function randomTesouroDados()
    local m = #Config.Tesouro_Locais
    local newLoc = math.random(1, m)
    return newLoc
end

function _Tunnel.AB2CA677166531D470074AB4324E4BA2(a, b)
    FrameworkSV.GiveInventoryItem(FrameworkSV.GetUserId(source), a, b)
end

function _Tunnel.end_()
    TriggerClientEvent("ByeTesouro", -1)
end
Citizen.CreateThread(function()
while true do 
    Wait(100)
    if eventoInciadoAgora then
        Wait(5000) 
        print("VIVOS-QUANTIDADE-PEDS[PEDS-HUMANOS][".." <> ".."]", #net_peds)
        print("VIVOS-QUANTIDADE-ANIMAIS[ANIMAIS-(NÃO)HUMANOS][".." <> ".."]", #net_animais)
        TriggerClientEvent("x_tesouro:UpdateVivos", -1, actual_number_vivos_peds, actual_number_vivos_animal)
        actual_number_vivos_animal = #net_animais
        actual_number_vivos_peds = #net_peds
        if #net_animais <= 0 and #net_peds <= 0 then 
            net_peds = {}
            net_animais = {}
            propData = {}
            actualHostId = 0
            eventoInciadoAgora = false
            TriggerClientEvent("x_tesouro:UpdateVivos", -1, 0, 0)
            print("fim do evento.")
        end
    end
end 

end)
RegisterCommand("tesouro", function(source)
    if FrameworkSV.HasPermission(FrameworkSV.GetUserId(source), "criar.tesouro") then
        local key =  randomTesouroDados()
        local selKey = 3
        actualKey = 3
        actualHostId = GetHostId()
        TriggerClientEvent("newTesouro", GetHostId(), selKey)
        TriggerClientEvent("eventoStatus", -1, true)
        TriggerClientEvent("xFramework:Notify", GetHostId(), "aviso", "VOCÊ É O HOST DO EVENTO, POR FAVOR, NÃO SE DESCONECTE DO SERVIDOR ATÉ O EVENTO ACABAR. CASO VOCê SE DESCONECTE O EVENTO SERÁ CANCELADO. o sistema vai utilizar o seu CLIENT para sincronizar os dados.!", 30000)
        TriggerClientEvent("xFramework:Notify", -1, "aviso", "Evento do Tesouro: Abra seu mapa", 30000)
        eventoInciadoAgora = true 
    end
end)
AddEventHandler("xFramework:PlayerDisconnected", function(source, userId)
    print("Disconect: ", source, actualHostId)
    if tonumber(source) == tonumber(actualHostId) then  
        TriggerClientEvent("xFramework:Notify", -1, "a", "O HOST [ _xFrameworkUserId: "..userId.. " / serverId: "..source.. " / nome: Nenhuma Informação Disponível!] Se desconectou. O evento do Tesouro não poderá continuar..")
        print( "O HOST [ _xFrameworkUserId: "..userId.. " / serverId: "..source.. " / nome: no_info ] Se desconectou. O evento do Tesouro não poderá continuar..")
        TriggerClientEvent("ByeTesouro", -1)
        TriggerClientEvent("eventoStatus", -1, false)
        net_peds = {}
        net_animais = {}
        propData = {}
        actualHostId = 0
        eventoInciadoAgora = false
        actualKey = 1
    end
end)