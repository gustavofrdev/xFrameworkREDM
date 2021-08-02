    local Tunnel = module('Server/CallBack/Callback_Tunnel')
    local Proxy = module('Server/CallBack/Callback_Proxy')
    local Tools = module('Server/CallBack/Callback_Tools')

    Function = {}

    x_hudSV = Tunnel.getInterface('x_hud')
    x_hudCL = Proxy.getInterface('x_hud')

    FrameworkSV = Tunnel.getInterface('_xFramework')
    FrameworkCL = Proxy.getInterface('_xFramework')

    Proxy.addInterface('x_hud', Function)
    Tunnel.bindInterface('x_hud', Function)

    local active = false
    local playerLogin = false

    RegisterNetEvent("x_hud:stts:playerLogin")
    AddEventHandler("x_hud:stts:playerLogin", function()
        playerLogin=true
        Wait(10000) 
        local maxQ = x_hudSV.maxV()
        SetEntityMaxHealth(PlayerPedId(), maxQ)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    
    end)
    local hd_on = false

RegisterNetEvent('anim')
AddEventHandler("anim",function()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_WRITE_NOTEBOOK'), -1, true, false, false, false)
     Wait(3000)
     ClearPedTasks(PlayerPedId())
end)

local try = false 
local Cache = {}
Cache["oldOn"] = false 
    Citizen.CreateThread(function()
        SendNUIMessage({
            hearth = false
        })
        SendNUIMessage({
            showhud = true
        })
        while true do 
        Citizen.Wait(1)
        if playerLogin then 
            if Citizen.InvokeNative(0x826AA586EDB9FEF8, PlayerPedId()) or Citizen.InvokeNative(0x460BC76A0E10655E, PlayerPedId()) then 
                hd_on = true 
                try = false 
            else
                if not try and Cache["oldOn"] == false then 
                    hd_on = false 
                    try = true 
                end
            end
        if(not hd_on)then 
            DisplayRadar(false)
        else 
            DisplayRadar(true) 
        end 
        if IsControlJustPressed(0, 0x6319DB71) then 
            if(FrameworkCL.HasMap()) then 
          hd_on = not hd_on
          if(hd_on)then 
            Cache["oldOn"]  = true 
  
          else
            Cache["oldOn"]  = false 
            --('add core')
            ClearPedTasks(PlayerPedId())
     
          end
        
            else
                --  TriggerEvent("xFramework:Notify", "negado",  "Você precisa de um mapa!")
            end 
                end
            end
        end
        end)

        Citizen.CreateThread(function()
            while true do
                Wait(150)
                        active = true
                        SendNUIMessage({    
                     showhud = true
                 })
            end
        end)
Citizen.CreateThread(function()

    while true do
        Citizen.Wait(3000) -- 5 sec
    if playerLogin then 
    local fome, sede = x_hudSV.Fome(), x_hudSV.Sede()
    if fome >=90 then 
        local old = GetEntityHealth(PlayerPedId())
        SetEntityHealth(PlayerPedId(), old-1)
    end
    if sede >= 90 then 
        local old = GetEntityHealth(PlayerPedId())
        SetEntityHealth(PlayerPedId(), old-1)
    end
        SendNUIMessage({
            sede = fome,
            fome = sede,
            temp = GetCurrentTemperature(), 
            healthValue = GetEntityHealth(PlayerPedId())})        
        end
    end 
end)

function GetCurrentTemperature()
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
    ShouldUseMetricTemperature()
    return round(GetTemperatureAtCoords(coords.x, coords.y, coords.z), 1)
end

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end
