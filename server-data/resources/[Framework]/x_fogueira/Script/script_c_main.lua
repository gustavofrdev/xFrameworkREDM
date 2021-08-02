RegisterNetEvent("Fogueira:Actions:Spawn")
Config = {}
Config.FogueiraProp = "p_campfirecombined03x"
local i = false

function playAnim(dict,name)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), dict, name, 8.0, 8.0, 2000, 0, 0, true, 0, false, 0, false)  
end

AddEventHandler("Fogueira:Actions:Spawn",function()
  --  print("oi")
local settings = {}
settings.cds = GetEntityCoords(PlayerPedId())
local x = settings.cds.x;local y = settings.cds.y;local z = settings.cds.z;
exports["x_progress"]:startUI(1500 * 5, "Construindo fogueira...")
for _ =1,5 do
    playAnim("mini_games@story@beechers@build_floor@john","hammer_loop_good")
    Citizen.Wait(1500)
end
Net_CreateObjectInCoords(Config.FogueiraProp, {x=x-1,y=y,z=z})
Client_CreateTimer(360,true)
startTimer();i=true
turnDraw3DTextOn({x=x-1,y=y,z=z})
end)

function startTimer()
Citizen.CreateThread(function()
    while i do 
        Citizen.Wait(500+500)
        local tempo = Client_GetTimer("?")
      --  print(tempo)
        if tempo == 0 or tempo == nil  or tempo/60 < 1.0 then 
         --   print("Timer:OFF")
            i=false
            Net_DelObject("?",true,true)
            end
        end
    end)
end
function turnDraw3DTextOn(ct)
Citizen.CreateThread(function()
while i do 
    Citizen.Wait(0)
    local minutos = Client_GetTimer("?")--print(Client_GetTimer("?")/60)
if Client_GetTimer("?")/60 >= 5 then
    minutos = 5 
elseif Client_GetTimer("?")/60 >= 4 then 
    minutos = 4 
    elseif Client_GetTimer("?")/60 >= 3 then 
        minutos = 3 
    elseif Client_GetTimer("?")/60 >= 2 then 
        minutos = 2
    elseif Client_GetTimer("?")/60 >= 1 then 
        minutos = 1
 
    else
        minutos = 0
    end
    DrawText3D(ct.x,ct.y,ct.z, "O fogo acaba em:".. minutos .. " Minutos.")
end 
end)
end

function format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end
