
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
FrameworkCL = Proxy.getInterface('_xFramework')
FrameworkSV = Tunnel.getInterface('_xFramework')
x_ped_outfit_selector = Proxy.getInterface('x_ped_outfit_selector')
x_ped_outfit_selectorSv = Tunnel.getInterface('x_ped_outfit_selector')
_Tunnel = {}
Tunnel.bindInterface('x_ped_outfit_selector', _Tunnel)

MenuData = {}

local active = false

local selected = 0
RegisterNetEvent("select-selected-ped_outfit_selector")
AddEventHandler("select-selected-ped_outfit_selector", function(i)
    selected = i 
end)

TriggerEvent("handler<function menuData>",function(call)
    MenuData = call
end)

function openMenu()
    local selected = selected
    MenuData.CloseAll()
    local elements = {
        {label = "Confirmar", cat = "confirm", desc = "Pressione para comprar tudo!"},
        {label = "Variação", cat = "change", value = selected, type = 'slider', min = 0, max = 100, desc = "Choose your beardstyle"},
    }
	MenuData.Open('default', GetCurrentResourceName(), 'outfit_men',{
		title    = "outfits",	
		subtext  = 'Choose',
		align    = 'top-right',
		elements = elements,
	},
    function(data, menu)
        if data.current.cat == "confirm" then
            print(json.encode(data.current))
            SetPedOutfitPreset(PlayerPedId(),selected, 0)
            x_ped_outfit_selectorSv.UpdateDb(tonumber(selected))
            TriggerEvent('xFramework:Notify', "sucesso", "variação: " ..selected)
            menu.close()
            TriggerEvent("Character:Reload")
            TriggerEvent('load::Clothes')
            active = false
        end
    end,
	function(_, menu)
		menu.close()
        active = false
        TriggerEvent("Character:Reload")
        TriggerEvent('load::Clothes')
	end,
	function(data)
        if data.current.value ~= nil then 
        selected = data.current.value
        SetPedOutfitPreset(PlayerPedId(),data.current.value,0)
        end
	end)
end


Citizen.CreateThread(function()
	while true do
        local W = 500
        for k, v in pairs(Config.Locais) do 
            if GetDistanceBetweenCoords(v.blip.x, v.blip.y, v.blip.z, GetEntityCoords(PlayerPedId()), true) < 4 then
                W = 1
                if not active then 
                    DrawText3D(v.blip.x, v.blip.y, v.blip.z-1, "Pressione ~e~[R]~p~ para selecionar a variação do ped")
                end
                if IsControlJustPressed(0, 0xE30CD707) then 
                    active = true 
                    openMenu()
                end
            end
        end
        Citizen.Wait(W)
    end
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

RegisterNetEvent("load_ped_outfit")
AddEventHandler("load_ped_outfit", function (i)
    SetPedOutfitPreset(PlayerPedId(),i, 0)
    selected = i
end)           
                -->>(v.Hash)

