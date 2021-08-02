local serverTimerFreeze =  false
local serverWeatherFreeze= false 
local Memory = {}
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkSV = Proxy.getInterface("_xFramework")
FrameworkCL = Tunnel.getInterface("_xFramework")

RegisterCommand('time', function(source, args, raw)
    local id = FrameworkSV.GetUserId(source) 
    if FrameworkSV.HasPermission(id, "controlar.clima") then 
    if not args[3] then 

        TriggerClientEvent('xFramework:Notify',source,"negado",' Faltam argumentos:  /time <hora> <min> <Freeze? 0 - Nao, 1 - Sim> ',10000)
        return 
    end

   
            if(not args[1] or not args[2] or not args[1] and args[2]) then return end

    local hour  =tonumber(args[1])
    local minute = tonumber(args[2])
    

    if (hour < 0 or hour > 23) then
        TriggerClientEvent('xFramework:Notify',source,"negado",' Erro[26]: 0x26g code ',10000)
        return
    elseif (minute < 0 or minute > 59) then
        TriggerClientEvent('xFramework:Notify',source,"negado",' Erro[29]: 0x29h code ',10000)
        return
    end

    Sync.Time.setHours(hour)
    Sync.Time.setMinutes(minute)
    TriggerClientEvent('rdx_sync:updateTime', -1, hour, minute, 0)
    TriggerClientEvent('xFramework:Notify',source,"sucesso",' Tempo atualizado com sucesso - '..args[1] ..':' ..args[2].. " FREEZE: "..args[3],10000)
  if args[3] == 1 then 
    Memory["FreezeTime"] = true 
    Memory["horas"] = hour 
    Memory["minute"] = minute
  else 
    Memory["FreezeTime"] = false end 
  else 
    TriggerClientEvent('xFramework:Notify',source,"negado",' Você não pode usar este comando')
            end
        end)

local a = {
 
}
Citizen.CreateThread(function()
    local source = source 
    Wait(10000)
  
    while true do 
        Citizen.Wait(300000)
        if Memory["Clima"] and Memory["Vento"] then 
        TriggerClientEvent('w_sync:updateWeather',-1, Memory["Clima"], Memory["Vento"])
        --("Sync :: Freeze_Status_Weather: Setando",Memory["Clima"], Memory["Vento"])
    end
end
end )
RegisterServerEvent("syncThings")
AddEventHandler("syncThings",function()
   local source = source 
    if Memory["Clima"] and Memory["Vento"] then 
        TriggerClientEvent('w_sync:updateWeather',source, Memory["Clima"], Memory["Vento"])
        --("Sync :: Freeze_Status_Weather: Setando",Memory["Clima"], Memory["Vento"])
    end
    if Memory["horas"] and Memory["minute"]  then 
        Sync.Time.setHours(Memory["horas"])
        Sync.Time.setMinutes(Memory["minute"])
    end
end)
Citizen.CreateThread(function()
    if Memory["horas"] and Memory["minute"] then 
    Sync.Time.setHours(Memory["horas"])
    Sync.Time.setMinutes(Memory["minute"])
    end
    while true do 
        Citizen.Wait(60000)
        if Memory["horas"] and Memory["minute"] and  Memory["FreezeTime"] == true then 
    Sync.Time.setHours(Memory["horas"])
    Sync.Time.setMinutes(Memory["minute"])
        end
    end
end)

RegisterCommand('weather', function(source, args, raw)
    local id = FrameworkSV.GetUserId(source) 
    if FrameworkSV.HasPermission(id, "controlar.clima") then 
    if args[1] == nil then return end 

      
        local tipo  = string.upper(args[1] or 'Ensolarado')
        if args[2] == nil then 
            args[2] = 2
  
        if tonumber(args[2]) > 10 then  
    
            TriggerClientEvent('xFramework:Notify',source,"negado",' O vento não pode passar de 10 km/h',10000)
                return 
            end
        
     if args[1] == "tipos" or args[1] == nil then 
       --('tipo inexistente!')
   --    --("tipos: 'WEATHER_UNKNOWN', 'WEATHER_CLEAR','WEATHER_CLOUDS', 'WEATHER_SMOG','WEATHER_FOGGY', 'WEATHER_OVERCAST','WEATHER_RAINING', 'WEATHER_THUNDER', 'WEATHER_CLEARING','WEATHER_NEUTRAL', 'WEATHER_SNOW'")
       TriggerClientEvent('chat:addMessage',source, {
        color = {0,255,0 },
        multiline = true,
        args = {  "tipos: Nevasca, Fechado, Chuvisco, Nevoeiro, Gelo, Limpo, Furacao, Enevoado, Nublado, Nublado_Escuro, Chuva, Tempestade_Areia, Chuveiro, Granizo, Neve, Neve_Clara, Neve_Clara2, Neve_Clara3, Ensolarado, Tempestade, Tempestade2', o argumento 2 do comando é o vento!"}
          
    })   
     

        return

    end
   
end
TriggerClientEvent('w_sync:updateWeather',-1, tipo, args[2])
Memory["Clima"] = tipo 
Memory["Vento"] = args[2]  
    TriggerClientEvent('chat:addMessage',source, {
        color = {0,255,0 },
        multiline = true,
        args = {  "trocado para "..tipo}
    })     
    TriggerClientEvent('xFramework:Notify',source,"sucesso",' O clima foi alterado para '..string.upper(tipo).."["..args[2].."]",10000)
    Sync.Weather.changeWeatherType(tipo)
    TriggerClientEvent("rdx_sync:updateWeather",-1, tipo,10.0)
    Sync.Weather.syncWeather()
else 
    TriggerClientEvent('xFramework:Notify',source,"negado",' Você não pode usar este comando')
        end
    end)



Citizen.CreateThread(function()
    Sync.Time.syncTime(source)
    Sync.Weather.syncWeather(source)
end)