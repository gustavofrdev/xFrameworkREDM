
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
FrameworkCL = Tunnel.getInterface('_xFramework')
FrameworkSV = Proxy.getInterface('_xFramework')
x_ped_outfit_selector = Tunnel.getInterface('x_ped_outfit_selector')
x_ped_outfit_selectorSv = Proxy.getInterface('x_ped_outfit_selector')
_Tunnel = {}
local CharCreator = Tunnel.getInterface("x_charactercreator")

Tunnel.bindInterface('x_ped_outfit_selector', _Tunnel)
data = {}

local preco = 3
local conf = {}

function _Tunnel.UpdateDb(index)
		local source = source 
		local skindata = FrameworkSV.SQLExecute("SELECT characterdata FROM xframework_personagens WHERE id = @id", {
		["@id"] = FrameworkSV.GetUserId(source)
	})
	-- print(blush_index, blush_color_index, blush_opacity_index, delineado_opacity_index, delineado_color_index,sombra_opacity_index, sombra_color_index, batom_opacity_index, batom_color_index, hair_index, beard_index)
		skindata = json.decode(skindata[1].characterdata)
		skindata["custom_ped_variation"] = index
		FrameworkSV.SQLExecute("UPDATE xframework_personagens SET characterdata = @ch WHERE id = @id",{
			["@id"] = FrameworkSV.GetUserId(source),
			["@ch"] = json.encode(skindata)
		})
		CharCreator.SetPersonagem(source, skindata)
end

RegisterServerEvent("load_ped_outfit")
AddEventHandler("load_ped_outfit", function ()
	local cur = FrameworkSV.SQLExecute("SELECT characterdata FROM xframework_personagens WHERE id = @id", {
		["@id"] = FrameworkSV.GetUserId(source)
	})
		cur = json.decode(cur[1].characterdata)
		cur = cur["custom_ped_variation"]
		TriggerClientEvent("load_ped_outfit", source, tonumber(cur))
end)
