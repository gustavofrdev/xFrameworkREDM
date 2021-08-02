local serverTimerFreeze =  false
local serverWeatherFreeze= false 
local Memory = {}
local baseTime = 0
local timeOffset = 0
local server_hora = 0
local server_minuto = 0
local timeFreezed = false
local setTimeFreeze=function(f)
    timeFreezed = f
end
RegisterServerEvent("timeFreeze")
AddEventHandler("timeFreeze", setTimeFreeze)
function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        Sync.Time.setHours(server_hora)
        Sync.Time.setMinutes(server_minuto)
        -- if Memory["Clima"] and Memory["Vento"] then 
        --     TriggerClientEvent('w_sync:updateWeather',-1, Memory["Clima"], Memory["Vento"])
        --     -- --("Sync :: Freeze_Status_Weather: Setando",Memory["Clima"], Memory["Vento"])
        -- end
    end
end)
RegisterCommand('time', function(source, args, raw)

    if not args[3] then 
        TriggerClientEvent('chat:addMessage',source, {
            color = {0,255,0 },
            multiline = true,
            args = {  "Falta um argumento! /time <hora> <min> <Freeze? 0 - Nao, 1 - Sim>"}
        })
        return 
    end

   
            if(not args[1] or not args[2] or not args[1] and args[2]) then return end
    local hour  =tonumber(args[1])
    local minute = tonumber(args[2])

    if (hour < 0 or hour > 23) then
      -- --(" ERRO:!")
        return
    elseif (minute < 0 or minute > 59) then
        -- --(" ERRO:!")
        return
    end
  if args[3] == "1" then 
    --("freeze")
    Memory["FreezeTime"] = true 
    Memory["horas"] = hour 
    Memory["minute"] = minute
    timeFreezed = true 
  else 
    Memory["FreezeTime"] = false; timeFreezed = false  end 
    
    Sync.Time.setHours(hour)
    Sync.Time.setMinutes(minute)
    TriggerClientEvent('rdx_sync:updateTime', -1, hour, minute, 0)
    ShiftToHour(hour)
    ShiftToMinute(minute)
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
        print("Sync :: Freeze_Status_Weather: Setando",Memory["Clima"], Memory["Vento"])
    end
end
end )
RegisterServerEvent("syncThings")
AddEventHandler("syncThings",function()
   local source = source 
    if Memory["Clima"] and Memory["Vento"] then 
        TriggerClientEvent('w_sync:updateWeather',source, Memory["Clima"], Memory["Vento"])
        print("Sync :: Freeze_Status_Weather: Setando",Memory["Clima"], Memory["Vento"])
    end
    -- if Memory["horas"] and Memory["minute"]  then 
    --     Sync.Time.setHours(Memory["horas"])
    --     Sync.Time.setMinutes(Memory["minute"])
    -- end
end)
Citizen.CreateThread(function()
    if Memory["horas"] and Memory["minute"] then 
    Sync.Time.setHours(Memory["horas"])
    Sync.Time.setMinutes(Memory["minute"])
    TriggerClientEvent('rdx_sync:updateTime', source, Memory["horas"], Memory["minute"], 0)
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
    if args[1] == nil then return end 

      
        local tipo  = string.upper(args[1] or 'Ensolarado')
        if args[2] == nil then 
            args[2] = 2
  
        if tonumber(args[2]) > 10 then  
            TriggerClientEvent('chat:addMessage',source, {
                color = {0,255,0 },
                multiline = true,
                args = {  "O VENTO NÃO PODE SER MAIOR QUE 10"}
            })
                return 
            end
        
     if args[1] == "tipos" or args[1] == nil then 
       -- --('tipo inexistente!')
   --    -- --("tipos: 'WEATHER_UNKNOWN', 'WEATHER_CLEAR','WEATHER_CLOUDS', 'WEATHER_SMOG','WEATHER_FOGGY', 'WEATHER_OVERCAST','WEATHER_RAINING', 'WEATHER_THUNDER', 'WEATHER_CLEARING','WEATHER_NEUTRAL', 'WEATHER_SNOW'")
       TriggerClientEvent('chat:addMessage',source, {
        color = {0,255,0 },
        multiline = true,
        args = {  "tipos: Nevasca, Fechado, Chuvisco, Nevoeiro, Gelo, Limpo, Furacao, Enevoado, Nublado, Nublado_Escuro, Chuva, Tempestade_Areia, Chuveiro, Granizo, Neve, Neve_Clara, Neve_Clara2, Neve_Clara3, Ensolarado, Tempestade, Tempestade2', o argumento 2 do comando é o vento!"}
          
    })    

        return
   
end
TriggerClientEvent('w_sync:updateWeather',-1, tipo, args[2])
Memory["Clima"] = tipo 
Memory["Vento"] = args[2]  
    TriggerClientEvent('chat:addMessage',source, {
        color = {0,255,0 },
        multiline = true,
        args = {  "trocado para "..tipo}
    })     
    Sync.Weather.changeWeatherType(tipo)
    TriggerClientEvent("rdx_sync:updateWeather",-1, tipo,10.0)
    Sync.Weather.syncWeather()
        end
    end)



Citizen.CreateThread(function()
    Sync.Time.syncTime(source)
    Sync.Weather.syncWeather(source)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        server_hora = math.floor(((baseTime+timeOffset)/60)%24)
        server_minuto = math.floor((baseTime+timeOffset)%60)
        -- print('horario do servidor: ', server_hora,":", server_minuto)
        if timeFreezed then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
    end
end)