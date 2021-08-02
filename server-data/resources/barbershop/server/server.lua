
local Proxy = module('Server/CallBack/Callback_Proxy')
local Tunnel = module('Server/CallBack/Callback_Tunnel')
FrameworkCL = Tunnel.getInterface('_xFramework')
FrameworkSV = Proxy.getInterface('_xFramework')
barbershop = Tunnel.getInterface('barbershop')
barbershopSv = Proxy.getInterface('barbershop')
_Tunnel = {}

Tunnel.bindInterface('barbershop', _Tunnel)
data = {}

local preco = 3
local conf = {}
function _Tunnel.buy(blush_index, blush_color_index, blush_opacity_index, delineado_opacity_index, delineado_color_index,sombra_opacity_index, sombra_color_index, batom_opacity_index, batom_color_index, hair_index, beard_index)
	local source = source
	if not conf[source] then
		TriggerClientEvent("xFramework:Notify", source, "aviso", "Você tem certeza? Isso custará $" ..preco.. " a você. Clique denovo para confirmar") 
		conf[source] = true 
		return 
	end
	local skindata = FrameworkSV.SQLExecute("SELECT characterdata FROM xframework_personagens WHERE id = @id", {
		["@id"] = FrameworkSV.GetUserId(source)
	})
	print(blush_index, blush_color_index, blush_opacity_index, delineado_opacity_index, delineado_color_index,sombra_opacity_index, sombra_color_index, batom_opacity_index, batom_color_index, hair_index, beard_index)
	if FrameworkSV.TryPayment(FrameworkSV.GetUserId(source), preco) then 
		skindata = json.decode(skindata[1].characterdata)
		skindata["opacidadeblush"] = blush_opacity_index
		skindata["blush"] = blush_index
		skindata["palhetablush"] = blush_color_index
		skindata["opacidadedelineados"] = delineado_opacity_index
		skindata["palhetadelineados"] = delineado_color_index
		skindata["opacidadesombras"] = sombra_opacity_index
		skindata["palhetasombras"] = sombra_color_index
		skindata["opacidadebatom"] = batom_opacity_index
		skindata["palhetabatom"] = batom_color_index
		skindata["CabeloModel"] = hair_index
		skindata["Barba"] = beard_index
		print(json.encode(skindata))
		FrameworkSV.SQLExecute("UPDATE xframework_personagens SET characterdata = @ch WHERE id = @id",{
			["@id"] = FrameworkSV.GetUserId(source),
			["@ch"] = json.encode(skindata)
		})
		conf[source] = nil
	else
		TriggerClientEvent("xFramework:Notify", source, "negado", "Você não tem dinheiro o suficiente") 
	 
	end
end


AddEventHandler("xFramework:PlayerLogin")
AddEventHandler("xFramework:PlayerLogin", function(source)
	local skindata = FrameworkSV.SQLExecute("SELECT characterdata FROM xframework_personagens WHERE id = @id", {
		["@id"] = FrameworkSV.GetUserId(source)
	})
	skindata = json.decode(skindata[1].characterdata)
	if skindata == nil then return end;
	TriggerClientEvent("setAllBarberValues", source, skindata["blush"], skindata["palhetablush"], skindata["opacidadeblush"], skindata["opacidadedelineados"],skindata["palhetadelineados"],skindata["opacidadesombras"], skindata["palhetasombras"],skindata["opacidadebatom"],skindata["palhetabatom"],skindata["CabeloModel"],skindata["Barba"])
end)

