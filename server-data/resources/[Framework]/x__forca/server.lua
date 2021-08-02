local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')

x__forcaSV = Proxy.getInterface('x__forca')
x__forcaCL = Tunnel.getInterface('x__forca')
dev = Proxy.getInterface('_xFramework')
FrameworkCL = Tunnel.getInterface('_xFramework')

Function = {}
Proxy.addInterface('x__forca', Function)
Tunnel.bindInterface('x__forca', Function)


RegisterServerEvent("forca:police")
AddEventHandler("forca:police", function(target_id, values)
    local source = source
    local can = dev.HasPermission(dev.GetUserId(source), "policia.permissao")
    if can then
        TriggerClientEvent('forca:AnimLevier', target_id)
        TriggerClientEvent('forca:go', source, target_id, values)
    end
end)

RegisterServerEvent("forca:pendre")
AddEventHandler("forca:pendre", function(target_id, values )
    TriggerClientEvent("forca:joueur", target_id, values)
end)

RegisterServerEvent("forca:tuer")
AddEventHandler("forca:tuer", function(target_id)
    TriggerClientEvent("forca:gotuer", target_id)
end)