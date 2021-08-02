local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')

x_cartasSV = Tunnel.getInterface('x_cartas')
x_cartasCL = Proxy.getInterface('x_cartas')
FrameworkSV = Tunnel.getInterface('_xFramework')
FrameworkCL = Proxy.getInterface('_xFramework')

Function = {}
Proxy.addInterface('x_cartas', Function)
Tunnel.bindInterface('x_cartas', Function)

local near_correio = false 

RegisterNetEvent("WriteCard")
AddEventHandler("WriteCard",function(cart)
-- RegisterItemFunction
local item_hash_removed = cart:match("(.*_0x)")
local hash = cart:gsub(item_hash_removed, "")
local valores = x_cartasSV.getCartaData(hash)
SetNuiFocus(true, true)
SendNUIMessage({
  ler = true,
  conteudo = valores.conteudo,
  remetente = valores.autorNAME,
  destinatario = valores.recebedorNAME
})
end)
local blip = {}
Citizen.CreateThread(function()
    for k,v in pairs(Correios) do
        blip[k] = Citizen.InvokeNative(0x554d9d53f696d002, 2033377404, v[1], v[2], v[3])
        SetBlipSprite(blip[k], 1475382911, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], 'Carteiro')
    end
end)
Citizen.CreateThread(function()
    while true do 
        local W = 500
        for k, v in pairs(Correios) do 
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v[1], v[2], v[3]) < 3.0 then 
                near_correio = true 
                W = 1 
                DrawText3D( v[1], v[2], v[3]-0.8, "Pressione ~e~[ESPAÇO]~p~ para escrever uma nova carta")
                DrawText3D( v[1], v[2], v[3]-1, "Pressione ~e~[R]~p~ para ver sua caixa postal")
                if IsControlJustPressed(0, 0x39336A4F) then
                    ExecuteCommand("carta")
                elseif IsControlJustPressed(0, 0xE30CD707) then
                    ExecuteCommand("vercartas")
                end        
            else
                near_correio = false 
            end
        end
        Citizen.Wait(W)
    end
end)

--  Comandos 



RegisterCommand("carta", function(source, args, rawCommand)
--  Criar uma nova carta 
if near_correio then
SetNuiFocus(true, true)
SendNUIMessage({
  escrever = true
})
else
    TriggerEvent("xFramework:Notify","negado","Você precisa estar perto de algum correio")
end
end)

RegisterCommand("vercartas", function(source, args, rawCommand)
    if near_correio then
        x_cartasSV.open()
    else
        TriggerEvent("xFramework:Notify","negado","Você precisa estar perto de algum correio")
    end
end)


-- Nui CB

RegisterNUICallback("submitContent",function(data)
    --(json.encode(data))
    if x_cartasSV.exists(data.targetID) then 
        if x_cartasSV.payTax(taxa) then 
        local hash = x_cartasSV.generateNewCartaHash()
        local item = "carta_0x"..hash
        --(hash, x_cartasSV.myId(), data.targetID, data.content, x_cartasSV.getName(x_cartasSV.myId()), x_cartasSV.getName(data.targetID))
        x_cartasSV.sendValuesToDB(hash, x_cartasSV.myId(), data.targetID, data.content, x_cartasSV.getName(x_cartasSV.myId()), x_cartasSV.getName(data.targetID))
        else 
            TriggerEvent("xFramework:Notify","negado","Você não tem dinheiro para pagar a taxa de envio")
        end 
    else
        TriggerEvent("xFramework:Notify","negado",data.targetID.." Não existe no banco de dados.")
    end
end)

RegisterNUICallback("closeAll",function(data)
    SetNuiFocus(false, false)
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z+1.0)
    local px,py,pz=table.unpack(GetGameplayCamCoord())  
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
        SetTextScale(0.35, 0.35)
      SetTextFontForCurrentCommand(1)
        SetTextColor(255, 255, 255, 215)
        SetTextCentre(1)
        SetTextDropshadow(1, 0, 0, 0, 255)
        DisplayText(str,_x,_y)
    end
end