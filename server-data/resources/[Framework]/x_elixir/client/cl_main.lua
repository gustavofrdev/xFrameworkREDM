--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("x_elixir")
FrameworkSV = Tunnel.getInterface("x_elixir")
MultiCharacter = Tunnel.getInterface("x_elixir")
Elixir = Tunnel.getInterface("x_elixir")
--------------------------------------------------------
_Tunnel = {}
Tunnel.bindInterface("x_elixir", _Tunnel)
-- colheita


function DrawText3D(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
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

local colheita = {
	{
		hasFruto = true,
		chance = 10,
		local_ = {1078.78, -277.8, 97.28},
		chanceDb = {[1] = {item = "camelia", chance = 100 },}
		
	},
	{
		hasFruto = true,
		chance = 10,
		local_ = {2378.63, 987.56, 74.19},
        especial = true,
		chanceDb = {[1] = {item = "gardenia", chance = 100 },}
		
	},
	{
		hasFruto = true,
		chance = 10,
		local_ = {1096.85, 1650.88, 374.66},
		chanceDb = {[1] = {item = "bloodmary", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {3068.21, 2946.18, 235.51},
		chanceDb = {[1] = {item = "corpuscularia", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {953.86, -232.72, 86.65 },
		chanceDb = {[1] = {item = "dalia", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {2807.69, 2355.48, 157.8 },
		chanceDb = {[1] = {item = "galantus", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {-4491.83, -2182.47, 78.25 },
		chanceDb = {[1] = {item = "gerbera", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {1213.75, 1914.41, 307.51 },
		chanceDb = {[1] = {item = "girassol", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {-3208.04, 1664.5, 413.92 },
		chanceDb = {[1] = {item = "heleboro", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {3494.31, 997.63, 64.2  },
		chanceDb = {[1] = {item = "primola", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {1847.01, -906.38, 41.93  },
		chanceDb = {[1] = {item = "viburno", chance = 100 },}
		
	},
    {
		hasFruto = true,
		chance = 10,
		local_ = {-2485.05, 568.34, 134.74  },
		chanceDb = {[1] = {item = "violetta", chance = 100 },}
		
	},
}

local blip = {}
RegisterNetEvent("elixirblips")
AddEventHandler("elixirblips", function() _Tunnel.blip()
end)
function _Tunnel.blip()
	Wait(5000)
		for k,v in pairs(colheita) do
		if Elixir.isBruxa() then 
    		blip[k] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v.local_[1], v.local_[2], v.local_[3])
    		SetBlipSprite(blip[k], 	-1018697504	, 1)
    		Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], v.chanceDb[1].item:gsub("^%l", string.upper))
		end
	end
end


local lowestIndex = 0;
local lowestValue = false;
local hIndex = 0
local hValue = false 
function selectMostProximityValueByInt(t, base)
	for k, v in ipairs(t) do
		if not lowestValue or v < lowestValue then
			lowestIndex = k;
			lowestValue = v;
		end
	end
	for k, v in pairs(base) do 
		if v.chance == lowestValue then 
			lowestIndex = k 
		end
	end 
	local resps = {lowestIndex, lowestValue}
	lowestValue = false
	lowestIndex = 0
	if resps[2] == false then
		local foo = {}
		for i = 1, #base do 
			table.insert(foo, tonumber(base[i].chance))
		end
		local max_val, key = 0,0
		for k, v in pairs(foo) do
			key = k
			if max_val == 0 then 
				max_val = v 
			end
			if v > max_val then
				max_val, key = v, k
			end
			max = max_val
		end
		for k, v in pairs(base) do 
			if v.chance == max_val then 
				key = k 
			end
		end 
		resps = {key, max}
	end
	return resps[2], resps[1];
end
-- local blip = {}
-- Citizen.CreateThread(function()
--     for k,v in pairs(colheita) do
--         -->(v[1], v[2], v[3])
--         blip[k] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v.local_[1], v.local_[2], v.local_[3])
--         SetBlipSprite(blip[k], 935247438, 1)
--         Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], 'Colheita Ingredientes')
--     end
-- end)
Citizen.CreateThread(function()
while true do 
	local W = 500
	for k, v in pairs(colheita) do 
		local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.local_[1], v.local_[2], v.local_[3])
		if dist < 9.0 then 
			W = 1
			_DrawText3D( v.local_[1], v.local_[2], v.local_[3]-1, "Pressione ~e~[R]~p~ para colher")
			if dist < 2.0 then 
				W = 1 
				if IsControlJustPressed(0,0xE30CD707) then 
					local adaptacao = true
					if adaptacao then 	
                        local plusTime = 0 
                        if k == 4 then 
                            plusTime = 300
                        elseif k == 7 then 
                            plusTime = 300 
                        end 
						local ar_stamp = Elixir.getArbustoStamp(k)
						local cur_stamp = Elixir.currentServerTimeStamp()
                        print(ar_stamp, cur_stamp)
						local ignore = false
                        -- adptação 
                        if ar_stamp == "lock" then 
                            TriggerEvent("xFramework:Notify", "negado", "Não tem nada aqui")
                            goto c 
                        end
                        -- adptação
						if type(ar_stamp) == "number" then 
							if  ( ( (cur_stamp - ar_stamp)/60 ) - 30+plusTime ) * -1 > 30+plusTime then 
								-->("ignore ...>>>", ( ( (cur_stamp - ar_stamp)/60 ) - 30 ) * -1 )
								ignore = true 
							end
						end
						if type(ar_stamp) == "number" then 
							-->("log: "..(cur_stamp - ar_stamp)/60)
						end
                        
						if ignore or not ar_stamp or (cur_stamp - ar_stamp)/60 > 30+plusTime then 
							local itens = v.chanceDb;
							local val = 0.4
							local t_total = 0;
							for _, v2 in pairs(itens) do 
								t_total = t_total + v2.chance
							end
							local ch = math.random(100)%t_total;
							local o = {}
							local cV, cK = false, 0
							local integers = {}
							for k, v in pairs(itens) do 
								if v.chance > ch then 
									o[v.item] = v.chance
									table.insert(integers, v.chance)
								end
							end
							local l, key = selectMostProximityValueByInt(integers, itens)
							for k in pairs(integers) do 
								integers[k] = nil
							end
							TriggerAnim(v.local_[1], v.local_[2], v.local_[3])
							--:>('sel_item ==> '..v.chanceDb[key].item)
							Elixir.giveItem(v.chanceDb[key].item)
							Elixir.set(k)
						else
                            local f = "minutos"
							local rest = ( ( (cur_stamp - ar_stamp)/60 ) - (30 + plusTime) ) * -1
                            if rest >= 60 then
                                f = "hora(s)"
                                rest = ( ( ( (cur_stamp - ar_stamp)/60 ) - (30 + plusTime) ) * -1)/60
                            end
							rest = string.format("%.2f",rest)
							TriggerEvent("xFramework:Notify", "negado", "Este arbusto não têm frutos. Volte daqui "..rest.. " "..f)	  
						end
                    else
                        TriggerEvent("xFramework:Notify", "negado", "Você não é uma bruxa, haha!")	  
					end
				end	
			end
		end
	end
        :: c ::
		Citizen.Wait(W)
	end
end)
function TriggerAnim(x, y, z)
   local dict  = "amb_camp@world_human_wash_dishes@table@right@female_b@drop_spoon@base"
   local anim = "dropspoon_trans_grabdish"
   --:>("trigger<sucess>")
   RequestAnimDict(dict)
   while not HasAnimDictLoaded(dict) do Wait(0) end--:>("loading: try <TRY>>") end
   SetEntityCoordsNoOffset(PlayerPedId(), x, y, z)
   exports["x_progress"]:startUI(4000*3+1000, "Coletando...")
   for i = 1, 3 do 
    	TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
    	Wait(4000)
	end
end
function _DrawText3D(x, y, z, text)
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
