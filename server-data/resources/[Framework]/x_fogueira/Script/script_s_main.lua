local Proxy = module("Server/CallBack/Callback_Proxy")
local Tunnel = module("Server/CallBack/Callback_Tunnel")
FrameworkCL = Tunnel.getInterface("_xFramework")
FrameworkSV = Proxy.getInterface("_xFramework")

local rName = 'script_s_main.lua'
local Vorp = {}
local GodNetwork = {}

RegisterServerEvent("xFramework_ItemFunction:fogueira")
AddEventHandler("xFramework_ItemFunction:fogueira", function(user_id)
	local source = FrameworkSV.GetUserSource(user_id)
    if FrameworkSV.TryGetInventoryItem(user_id, "fogueira", 1 ) then 
    	GodNetwork.Functions['Fogueira => Functions:ExecuteMain:Fogueira_c:DoSpawn'](source)
    	GodNetwork.Functions['Utils:DrawTipInScreen']('Sistema de Fogueira', 'Você usou sua Fogueira', 3, source)
	end
end)

GodNetwork.Functions = {
    ['Fogueira => Functions:ExecuteMain:Fogueira_c:DoSpawn'] = function(source)
        TriggerClientEvent('Fogueira:Actions:Spawn', source)
    end,
    ['Utils:DrawTipInScreen'] = function(Title, Text, Time, source)
        TriggerClientEvent('xFramework:Notify', source, "aviso", Text, 10000)
    end
}
