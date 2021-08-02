local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')

x_jornalSV = Tunnel.getInterface('x_jornal')
x_jornalCL = Proxy.getInterface('x_jornal')
FrameworkSV = Tunnel.getInterface('_xFramework')
FrameworkCL = Proxy.getInterface('_xFramework')

Function = {}
Proxy.addInterface('x_jornal', Function)
Tunnel.bindInterface('x_jornal', Function)

local open = false 
local html, thumb, title

RegisterCommand("jornal", function(source, args)
    if args[1] == "escrever" then 
        if x_jornalSV.perm() then 
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = "writerEvent",
                param = {title = "Escreva sua reportagem, reporter.", cb = "newsHtmlString"}
            })
        else
            print "não tem perms."
        end
    elseif args[1] == "remover" then 
        if not args[2] then return end;
        if x_jornalSV.perm() then 
            x_jornalSV.removeNews(tonumber(args[2]))
        end
    
    elseif not args[1] then 
        open=not open;
        local news, newsLength = x_jornalSV.retrieveAllNews()
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "readOnly",
            param = {news = news, newsLength = newsLength}
        })
    end

end )
local MenuOuvert = false

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerPed = PlayerPedId()
		if open and not MenuOuvert then
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			MenuOuvert = true
			SortirMap()
			Wait(2000)
			local player = PlayerPedId()
            local coords = GetEntityCoords(player) 
            local props = CreateObject(GetHashKey("s_twofoldmap01x_us"), coords.x, coords.y, coords.z, 1, 0, 1)
            prop = props
            SetEntityAsMissionEntity(prop,true,true)
            RequestAnimDict("mech_carry_box")
            while not HasAnimDictLoaded("mech_carry_box") do
            Citizen.Wait(100)
            end
                Citizen.InvokeNative(0xEA47FE3719165B94, player,"mech_carry_box", "idle", 1.0, 8.0, -1, 31, 0, 0, 0, 0)
                Citizen.InvokeNative(0x6B9BBD38AB0796DF, prop,player,GetEntityBoneIndexByName(player,"SKEL_L_Finger12"), 0.20, 0.00, -0.15, 180.0, 190.0, 0.0, true, true, false, true, 1, true)
		end
        if not open and MenuOuvert then
		MenuOuvert = false
        RangerMap()
		ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
     	DetachEntity(prop,false,true)
        ClearPedTasks(player)
        DeleteObject(prop)
		end
	end
end)

function SortirMap()
    local ped = PlayerPedId()
	Animation(ped, "mech_inspection@mini_map@satchel", "enter")
end

function RangerMap()
    local ped = PlayerPedId()
	Animation(ped, "mech_inspection@two_fold_map@satchel", "exit_satchel")
end

function Animation(ped, dict, name)
    if not DoesAnimDictExist(dict) then
      return
    end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, name, -1.0, -0.5, 2000, 1, 0, true, 0, false, 0, false)
    RemoveAnimDict(dict)
end

function requestThumbUrl()
    SendNUIMessage({
        action = "promptEvent",
        param = {title = "Agora, insira a url da Thumbnail da reportagem", cb = "thumbUrl"}
    })
    Wait(50)
    SetNuiFocus(true, true)
end
function requestNewsTitle()
    SendNUIMessage({
        action = "promptEvent",
        param = {title = "Agora, digite o título da sua reportagem", cb = "titleRep"}
    })
    Wait(50)
    SetNuiFocus(true, true)
end

RegisterNUICallback("action", function(data)
    local action = data.action 
    if action == "closeAll" then 
        open = false 
        SetNuiFocus(false, false)
    elseif action == "writerCb" then 
        if data.type == "newsHtmlString" then 
            html = data.content
            requestThumbUrl()
        elseif data.type == "thumbUrl" then
            thumb = data.content
            requestNewsTitle()
        elseif data.type == "titleRep" then 
            title = data.content
            x_jornalSV.sendNews(html, thumb, title)
            print("request complete!")
        end
    end
end)
