local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')
x_bankingSV = Tunnel.getInterface('x_banking')
x_bankingCL = Proxy.getInterface('x_banking')

FrameworkSV = Tunnel.getInterface('_xFramework')
FrameworkCL = Proxy.getInterface('_xFramework')

Function = {}
Proxy.addInterface('x_banking', Function)
Tunnel.bindInterface('x_banking', Function)
function format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end
Citizen.CreateThread(function()
    for k, v in pairs(bank_positions) do
        local blip3 = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip3, 688589278, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip3, 'Banco')
    end
end)

function isNearBank()
    local ped = Ped()
    local pos = GetEntityCoords(ped)
    for k, v in pairs(bank_positions) do
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) < 5.0 then
            DrawText3D( v.x, v.y, v.z-1, "Pressione ~e~[R]~p~ para acessar o banco")
            return true
        end
    end
end
Citizen.CreateThread(function()
    while true do 
        local W = 500
            if isNearBank() then 
                W = 1 
                if IsControlJustPressed(0, 0xE30CD707) then
                    ExecuteCommand("banco")       
            end
        end
        Citizen.Wait(W)
    end
end)
RegisterCommand('banco',function()
        if isNearBank() then
        inMenu = true
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'balanceHUD'})
        TriggerServerEvent('vorp_banco:balance2')
        SendNUIMessage(
            {
                type = 'balanceHUD',
                balance = format(x_bankingSV.getBalance()),
                player = x_bankingSV.GetUserName()
            }
        )
    end
end)

RegisterNUICallback('deposit',function(data)
    if tonumber(data.amount) then 
        if type(tonumber(data.amount)) == "number" then
            x_bankingSV.Deposit(tonumber(data.amount))
        end
        Wait(300)
        SendNUIMessage({
           type =  "updateBalance",
            updateMoney = format(x_bankingSV.getBalance())
        })
    end
end)

RegisterNUICallback('withdrawl',function(data)
    if tonumber(data.amountw) then 
        if type(tonumber(data.amountw)) == "number" then
            
            x_bankingSV.Withdraw(tonumber(data.amountw))
        end
    end
    Wait(300)
        SendNUIMessage({
            type =  "updateBalance",
            updateMoney = format(x_bankingSV.getBalance())
        })
end)

RegisterNUICallback('transfer1',function(data) 
    --(json.encode(data))
    if tonumber(data.amountw)  and tonumber(data.identidade) then 
        if type(tonumber(data.amountw)) == "number" and type(tonumber(data.identidade)) == "number" then
            --(tonumber(data.amountw))
            x_bankingSV.TransferMoney(tonumber(data.amountw), tonumber(data.identidade))
        end
    end
    Wait(300)
        SendNUIMessage({
            type =  "updateBalance",
            updateMoney = format(x_bankingSV.getBalance())
        })
end)


RegisterNUICallback('NUIFocusOff',function()
    inMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, 'LITERAL_STRING', str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 1)
    DisplayText(str, x, y)
end
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



------ coisas gerais para nao ocupar memória da Framework -------

--> Extramina for Player <--

local extramina = 100;
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(500)
        --(GetAttributeCoreValue(PlayerPedId(), 1))
        --(GetEntitySpeed(PlayerPedId()))
        if extramina > 0 then
            --(GetAttributeCoreValue(PlayerPedId(), 1))
            --(GetEntitySpeed(PlayerPedId()))
            if GetAttributeCoreValue(PlayerPedId(), 1) > extramina then 
                Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, extramina)
                --(">>>")
            end
            Wait(500)
            if GetAttributeCoreValue(PlayerPedId(), 1) <= 0 then
                --(GetAttributeCoreValue(PlayerPedId(), 1))
                --(GetEntitySpeed(PlayerPedId()))
                --(Citizen.InvokeNative(0xC5286FFC176F28A2, PlayerPedId()))
                if not Citizen.InvokeNative(0xC5286FFC176F28A2, PlayerPedId()) then
                    -- "go #1"
                    for i = 1, extramina do 
                        while GetEntitySpeed(PlayerPedId()) >= 2 do 
                            Wait(30000) 
                        end 
                        -- ("adding extramina: "..i)
                        Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, i)
                        if GetAttributeCoreValue(PlayerPedId(), 1) > extramina then 
                            break 
                        end
                        Wait(1000)
                    end
                end
            end 
        end
    end
end)
function GetPlayerByEntityID(id)
	for k, v in pairs(GetActivePlayers()) do
        --(k)
		if(GetPlayerPed(k) == id) then 
            return GetPlayerServerId(k)
         end
	end
	return nil
end



ready = true
Citizen.CreateThread(function()
    local SystemRecognizedDeath = false
    local player = PlayerId()
    while true do
        local W = 500
        if ready then 
            local ped = PlayerPedId()
            -- --(IsEntityDead(PlayerPedId()) )
            if NetworkIsPlayerActive(player) then
                if IsEntityDead(PlayerPedId()) and not SystemRecognizedDeath then
                    -- 'esta morto >>>><<<<<<'
                    SystemRecognizedDeath = true 
                    W = 1
                    local killer = GetPedSourceOfDeath(ped)
                    print(killer)
                    if killer and GetPlayerByEntityID(killer) and GetPlayerByEntityID(killer) > 0  then 
                        --(' o source '..GetPlayerByEntityID(killer).. " te matou" )
                        TriggerServerEvent("xF...Logs..Kills2:", GetPlayerByEntityID(killer), GetPlayerServerId(PlayerId()))
                    elseif not GetPlayerByEntityID(killer) then 
                        --(" morreu para animal ")
                        -- print(getLabel(killer))
                        TriggerServerEvent("xF...Logs..Kills3:", "Se matou um morreu para um animal", GetPlayerServerId(PlayerId()))
                    end
                end
                if GetEntityHealth(ped) > 5 then 
                    SystemRecognizedDeath = false 
                end
            end
        end
        Citizen.Wait(W)
    end
end)



