
--------------------------------------------------------
local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Proxy.getInterface("_xFramework")
FrameworkSV = Tunnel.getInterface("_xFramework")
MultiCharacter = Tunnel.getInterface("nativeui_garimpo")
nativeui_garimpo = Proxy.getInterface("nativeui_garimpo")
nativeui_garimpoSv = Tunnel.getInterface("nativeui_garimpo")
_Tunnel = {}
Tunnel.bindInterface("nativeui_garimpo", _Tunnel)
--------------------------------------------------------
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

local menuactive = false

function ToggleActionMenu()
	menuactive = not menuactive
	onmenu = true
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true, money =200 })
	else
		SetNuiFocus(false)
		-- TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
RegisterNUICallback('ButtonClick',function(data, cb)
       
        if data == 'fechar' then
			ToggleActionMenu()
			onmenu = false
			menuactive = false
        else 
            nativeui_garimpoSv.vender(data)
        end
    end
)
local blip = {}

local local_venda = {
    {x = -3665.99, y = -2626.49, z = -13.48}, -- MUDAR A LOC AQUI
}

Citizen.CreateThread(function()
    for k,v in pairs(local_venda) do
        -->(v[1], v[2], v[3])
        blip[k] = Citizen.InvokeNative(0x554d9d53f696d002, 2033377404, v.x, v.y, v.z)
        SetBlipSprite(blip[k], -861219276	, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip[k], 'Venda de metais')
    end
end)

Citizen.CreateThread(function()
	while true do
		local W = 500
		

		for k,v in pairs(local_venda) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(v.x,v.y,z,x,y,z,true)
			local local_venda = local_venda[k]
			local idBancada = local_venda[id]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), local_venda.x, local_venda.y, local_venda.z, true ) <= 1 and not onmenu then
				W = 1
				
				_DrawText3D( local_venda.x, local_venda.y, local_venda.z-1, "Pressione ~e~[R]~p~ para abrir o menu de venda")
			end
			if distance <= 15 then
				-- DrawMarker(23, local_venda.x, local_venda.y, local_venda.z-0.97,0,0,0,0,0,0,0.7,0.7,0.5,214,29,0,100,0,0,0,0)
				if distance <= 1.2 then
					if IsControlJustPressed(0,0xE30CD707) then
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(W)
	end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.005 + factor, 0.03, 41, 11, 41, 68)
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