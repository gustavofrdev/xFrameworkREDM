Sync = {
    CurrentWeather = 'WEATHER_CLEAR',
    WeatherTypes = {
        [-1] = 'WEATHER_UNKNOWN',
        [0] = 'WEATHER_CLEAR',
        [1] = 'WEATHER_CLOUDS',
        [2] = 'WEATHER_SMOG',
        [3] = 'WEATHER_FOGGY',
        [4] = 'WEATHER_OVERCAST',
        [5] = 'WEATHER_RAINING',
        [6] = 'WEATHER_THUNDER',
        [7] = 'WEATHER_CLEARING',
        [8] = 'WEATHER_NEUTRAL',
        [9] = 'WEATHER_SNOW'
    }
}

Sync.GetWeatherType = function(index)
    index = index or -1

    if (type(index) == 'number') then
        return index, Sync.WeatherTypes[index] or Sync.WeatherTypes[-1]
    end

    local weather = string.upper(tostring(index))

    for _, _weather in pairs(Sync.WeatherTypes or {}) do
        if (_weather == weather) then
            return _, _weather
        end
    end

    return -1, Sync.WeatherTypes[-1]
end

Sync.GetCurrentWeatherType = function()
    local index, weather = Sync.GetWeatherType(Sync.CurrentWeather)

    return index
end

RegisterNetEvent('rdx_sync:updateTime')
AddEventHandler(
    'rdx_sync:updateTime',
    function(hour, minute)
        hour = math.floor(hour or 0)
        minute = math.floor(minute or 0)

        SetClockTime(hour, minute, 0)
        AdvanceClockTimeTo(hour, minute, 0)
        NetworkClockTimeOverride(hour, minute, 0, 0, true)
        NetworkClockTimeOverride_2(hour, minute, 0, 0, true, true)
    end
)

RegisterNetEvent('w_sync:updateWeather')
AddEventHandler('w_sync:updateWeather',function(weather, windSpeed)
	if weather == nil then 
		return 
	end
        weather = weather

        local _index, _weather = Sync.GetWeatherType(weather)
		-- print(_index)
		local hash = {
			["NEVASCA"] = 0x27EA2814,
			["FECHADO"] = 0x30FDAF5C,
			["CHUVISCO"]= 0x995C7F44,
			["NEVOEIRO"]= 0xD61BDE01,
			["GELO"]  = 0x75A9E268,
			["LIMPO"] = 0xF5A87B65,
			["FURACAO"] = 0x320D0951,
			["ENEVOADO"] = 0x5974E8E5,
			["NUBLADO"] =   0xBB898D2D,
			["NUBLADO_ESCURO"] = 0x19D4F1D9,
			["CHUVA"] = 0x54A69840,
			["TEMPESTADE_AREIA"] = 0xB17F6111,
			["CHUVEIRO"] = 0xE72679D5,
			["GRANIZO"] = 0xCA71D7C,
			["NEVE"] = 0xEFB6EFF6,
			["NEVE_CLARA"] = 0x641DFC11,
			["NEVE_CLARA2"] = 0x23FB812B,
			["NEVE_CLARA3"] = 0x23FB812B,
			["ENSOLARADO"] = 0x614A1F91,
			["TEMPESTADE"] = 0xB677829F,
			["TEMPESTADE2"] = 0x7C1C4A13
		}
		-- print(hash[weather])
	--/	Citizen.InvokeNative(0x59174F1AFE095B5A,0x614A1F91, true, true, true, 15.0, true)
        Citizen.InvokeNative(0x59174F1AFE095B5A, hash[weather], true, true, true, 15.0, true)

        SetWindSpeed(windSpeed)
    end
)
Citizen.CreateThread(function()
TriggerServerEvent("syncThings")
end )
